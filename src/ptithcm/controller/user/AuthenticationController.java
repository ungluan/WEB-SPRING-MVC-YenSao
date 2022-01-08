package ptithcm.controller.user;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.context.annotation.Bean;
import org.springframework.security.config.authentication.PasswordEncoderParser;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import ptithcm.bean.Infomation;
import ptithcm.entity.Category;
import ptithcm.entity.Customer;
import ptithcm.entity.Order;
import ptithcm.entity.Product;
import ptithcm.entity.User;

@Controller
@Transactional
public class AuthenticationController {
	@Autowired
	SessionFactory factory;

	@RequestMapping("/login")
	public String formLogin(ModelMap model, HttpSession session, HttpServletRequest request) {
		model.addAttribute("user", new User());
		request.getSession().setAttribute("numberOfProducts", 0);
		model.addAttribute("numberOfProducts", session.getAttribute("numberOfProducts"));
		return "user/login";
	}

	@RequestMapping(value = "check-login", method = RequestMethod.POST)
	public String checkLogin(ModelMap model, @ModelAttribute("user") User user,
			HttpServletRequest request, BindingResult errors) {
		// -- Nhập thiếu thông tin thì sao?
		if ( user.getEmail().length() == 0 ) {
			errors.rejectValue("email", "user", "Vui lòng nhập email");
		}
		if (  user.getPassword().trim().length() == 0) {
			errors.rejectValue("password", "user", "Vui lòng nhập mật mật khẩu");
		}
		if ( user.getPassword().trim().length() > 0 && user.getPassword().trim().length() < 6 || user.getPassword().trim().length() > 32 ) {
			errors.rejectValue("password", "user", "Vui lòng nhập đúng mật mật khẩu");
		}
		if(errors.hasErrors()) {
			model.addAttribute("user",user);
			return "user/login";
		}
		// Nhập đủ thông tin => cho đăng nhập
		User userlogin = this.login(user.getEmail(), user.getPassword());
		// Đăng nhập thành công => Đổ userLogin và Customer + highlightProduct
		if (userlogin != null) {
			request.getSession().setAttribute("user", userlogin);
			model.addAttribute("userLogin", userlogin);
			Customer cus =  getCustomer(userlogin.getId());
			model.addAttribute("customer", cus);
			// Add numberOfProduct 
			Order order = getOrder(cus.getId());
			long numbers = 0;
			if(order!=null) numbers = getNumbers(order.getId());
			request.getSession().setAttribute("numberOfProducts", numbers);
			model.addAttribute("numberOfProducts", numbers);
			
			// Add Highlight product
			model.addAttribute("products", getHighlightProduct());
			
			return "user/index";
		}
		request.getSession().setAttribute("numberOfProducts", 0);
		model.addAttribute("numberOfProducts", 0);
		model.addAttribute("message", "Tài khoản hoặc mật khẩu không chính xác!");
		return "user/login";
	}

	@RequestMapping("/register")
	public String formRegister(ModelMap model, HttpServletRequest request, HttpSession session) {
		request.getSession().setAttribute("numberOfProducts", 0);
		model.addAttribute("numberOfProducts", session.getAttribute("numberOfProducts"));
		Infomation info = new Infomation();
		info.setCustomer(new Customer());
		info.setUser(new User());
		info.getCustomer().setBirthday(new Date());
		model.addAttribute("info", info);
		return "user/register";
	}

	@RequestMapping(value = "/create-user", method = RequestMethod.POST)
	public String createUser(@ModelAttribute("info") Infomation info, ModelMap model, BindingResult errors) {
		model.addAttribute("info", info);
		if (info.getCustomer().getFullname().trim().isEmpty()
				|| info.getCustomer().getFullname().trim().length() > 100) {
			errors.rejectValue("customer.fullname", "info", "Vui lòng nhập đúng họ và tên!");
		}
		if (info.getCustomer().getAddress().trim().isEmpty() || info.getCustomer().getAddress().trim().length() > 500) {
			errors.rejectValue("customer.address", "info", "Vui lòng nhập đúng địa chỉ!");
		}
		if (!validatePhone(info.getCustomer().getPhone().trim())) {
			errors.rejectValue("customer.phone", "info", "Vui lòng nhập đúng số điện thoại!");
		}
		if (info.getCustomer().getGender() == null) {
			errors.rejectValue("customer.gender", "info", "Vui lòng chọn giới tính!");
		}
		if (!validateAge(info.getCustomer().getBirthday())) {
			errors.rejectValue("customer.birthday", "info", "Khách hàng phải trên 16 tuổi!");
		}
		if (info.getUser().getEmail().trim().isEmpty()) {
			errors.rejectValue("user.email", "info", "Email không được trống!");
		}
		// -- Check Email Esists tại đây
		if (checkExistsEmail(info.getUser().getEmail())) {
			errors.rejectValue("user.email", "info", "Email đã tồn tại!");
		}
		if (info.getUser().getPassword().length() < 6 || info.getUser().getPassword().length() > 32) {
			errors.rejectValue("user.password", "info", "Mật khẩu phải từ 6-32 ký tự!");
		}
		if (!errors.hasErrors()) {
			// -- Call Create User
			info.getUser().setRole("USER");
			info.getUser().setPassword(BCrypt.hashpw(info.getUser().getPassword(), BCrypt.gensalt(12)));
		
			info.getUser().setEnable(true);
			int idUser = createAccount(info);
			if (idUser != 0) {
				// -- Call Create Customer
				info.getCustomer().setUserId(idUser);
				if (createCustomer(info) == 1)
					return "user/login";
			}
		}
		return "user/register";
	}

	@RequestMapping("/logout")
	public String logout(ModelMap model, HttpServletRequest request, HttpSession session) {
		request.getSession().removeAttribute("user");
		request.getSession().setAttribute("numberOfProducts", 0);
		User user = (User) session.getAttribute("user");
		if(user!=null) {
			model.addAttribute("customer",getCustomer(user.getId()));
		}
		model.addAttribute("userLogin",user);
		model.addAttribute("categories",getCategories());
		model.addAttribute("products",getHighlightProduct());
		
		return "user/index";
	}
	
	@RequestMapping("/forgetpassword")
	public String forgetPass() {
		return "user/forgetpassword";
	}

	private boolean validateAge(Date birthday) {
		Calendar c1 = Calendar.getInstance();
		c1.setTime(birthday);
		c1.add(Calendar.YEAR, 16);
		if (c1.getTime().after(new Date()))
			return false;
		return true;
	}
	private boolean validatePhone(String phone) {
		if(phone.length() == 10 && phone.substring(0, 1).equals("0")) {
			return true;
		}
		return false;
	}
	private int createAccount(Infomation info) {
		User user = info.getUser();
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.save(user);
			t.commit();
			System.out.println("Tạo tài khoản thành công!");
			return user.getId();
		} catch (Exception e) {
			t.rollback();
			System.out.println("Tạo tài khoản thất bại!");
			System.out.println(e.toString());
			// TODO: handle exception
		} finally {
			session.close();
		}
		return 0;
	}

	private int createCustomer(Infomation info) {
		Customer customer = info.getCustomer();
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.save(customer);
			t.commit();
			System.out.println("Tạo Customer thành công!");
			return 1;
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("Tạo Customer thất bại!");
			System.out.println(e.toString());
			t.rollback();
		} finally {
			session.close();
		}
		return 0;
	}

	private boolean checkExistsEmail(String email) {
		Session session = factory.getCurrentSession();
		String hql = "SELECT U.id FROM User U " + "Where U.email = :email ";
		Query query = session.createQuery(hql);
		query.setParameter("email", email);
		List<String> list = query.list();
		if (list.size() == 1)
			return true;
		return false;
	}

	private User login(String email, String password) {
		Session session = factory.openSession();
		String hql = "FROM User where email = :email AND enable is true ";
		Query query = session.createQuery(hql);
		query.setParameter("email", email);
		List<User> users = query.list();

		if (users.size() == 1) {
			if (BCrypt.checkpw(password, users.get(0).getPassword().trim())) {
				return users.get(0);
			}
		}
		return null;
	}

	public Customer getCustomer(int userId) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Customer where userId = :userId";
		Query query = session.createQuery(hql);
		query.setParameter("userId", userId);
		return (Customer) query.list().get(0);
	}
	public List<Category> getCategories(){
		Session session = factory.getCurrentSession();
		String hql = "FROM Category";
		Query query = session.createQuery(hql);
		return query.list();
	}
	
	public List<Product> getHighlightProduct(){
		Session session = factory.getCurrentSession();
		String hql = "FROM Product p WHERE p.highlight = 1";
		Query query = session.createQuery(hql);
		return query.list();
	}
	private Order getOrder(int customerId) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Order where customerId = :customerId AND orderStatus.id = :id ";
		Query query = session.createQuery(hql);
		query.setParameter("customerId", customerId);
		query.setParameter("id", 6);
		List<Order> list = query.list();
		if(list.size()==0) {
			return null;
		}
		return list.get(0);
	}
	
	private long getNumbers(int orderId) {
		Session session = factory.getCurrentSession();
		String hql = "SELECT COUNT(o) FROM OrderDetail o where o.order.id = :orderId";
		Query query = session.createQuery(hql);
		query.setParameter("orderId", orderId);
		long numbers = (Long) query.uniqueResult();
		return numbers;
	}
}
