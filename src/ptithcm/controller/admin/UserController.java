package ptithcm.controller.admin;

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
import org.springframework.beans.support.PagedListHolder;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import ptithcm.entity.Branch;
import ptithcm.entity.Customer;
import ptithcm.entity.User;

@Transactional
@Controller
@RequestMapping("/admin/")
public class UserController {
	@Autowired
	SessionFactory factory;

	@RequestMapping("index")
	public String index(HttpServletRequest request, ModelMap model, @ModelAttribute("user") User user,
			HttpSession session) {

		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null) return "user/login";
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer cus = getCustomer(userLogin.getId());
		model.addAttribute("customer", cus);
		
		model.addAttribute("userChange", new User());
		model.addAttribute("roles", new String[] { "Admin", "User" });
		List<User> users = this.getUsers();
		PagedListHolder pagedListHolder = new PagedListHolder(users);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(5);
		model.addAttribute("btnStatus", "btnAdd");
		String roles[] = { "ADMIN", "USER" };
		model.addAttribute("roles", roles);
		model.addAttribute("pagedListHolder", pagedListHolder);
		return "admin/index1";
	}

	@RequestMapping(value = "index", params = "btnSearch")
	public String searchUsers(HttpServletRequest request, ModelMap model, HttpSession session) {
		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null) return "user/login";
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer cus = getCustomer(userLogin.getId());
		model.addAttribute("customer", cus);
		
		model.addAttribute("userChange", new User());
		model.addAttribute("roles", new String[] { "Admin", "User" });
		List<User> users = searchUsers(request.getParameter("searchInput"));
		PagedListHolder pagedListHolder = new PagedListHolder(users);

		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(5);
		model.addAttribute("btnStatus", "btnAdd");

//		String roles[] = { "ADMIN", "USER" };
//		model.addAttribute("roles", roles);
		model.addAttribute("pagedListHolder", pagedListHolder);
		return "admin/index1";
	}

//	@RequestMapping(value = "edit-role/{id}", method = RequestMethod.GET)
//	public String editRole(ModelMap model, @PathVariable("id") int id, HttpSession session) {
//		System.out.println("GoHear");
//		/*
//		 * User userLogin = (User) session.getAttribute("user"); if (userLogin == null)
//		 * return "user/login"; Customer customer = getCustomer(userLogin.getId());
//		 * model.addAttribute("customer", customer);
//		 */
//		
//		User user = getUser(id);
//		model.addAttribute("userEdit", user);
//		return "admin/edit-user-role";
//	}

//	@RequestMapping(value = "edit-role/{id}", method = RequestMethod.POST)
//	public String editRole(HttpServletRequest request, @ModelAttribute("user") User user, ModelMap model,
//			@PathVariable("id") int id, HttpSession session) {
//		User userLogin = (User) session.getAttribute("user");
//		if (userLogin == null)
//			return "user/login";
//		Customer customer = getCustomer(userLogin.getId());
//		model.addAttribute("user", userLogin);
//		model.addAttribute("customer", customer);
//		
//		user.setId(id);
//		if (updateUser(user) == 1) {
//			List<User> users = this.getUsers();
//			PagedListHolder pagedListHolder = new PagedListHolder(users);
//			int page = ServletRequestUtils.getIntParameter(request, "p", 0);
//			pagedListHolder.setPage(page);
//			pagedListHolder.setMaxLinkedPages(5);
//			pagedListHolder.setPageSize(5);
//			model.addAttribute("btnStatus", "btnAdd");
//			String roles[] = { "ADMIN", "USER" };
//			model.addAttribute("roles", roles);
//			model.addAttribute("pagedListHolder", pagedListHolder);
//			model.addAttribute("message", "Thay đổi quyền thành công!");
//			return "admin/index1";
//		}
//		model.addAttribute("message", "Thay đổi quyền thất bại!");
//		return "admin/edit-user-role";
//	}

//	@RequestMapping(value = "index/{id}", params="linkEdit", method=RequestMethod.GET )
//	public String editPassword(ModelMap model, @PathVariable("id") int id, 
//			HttpSession session, HttpServletRequest request, @ModelAttribute("userChange") User userChange ) {
//		
//		User userLogin = (User) session.getAttribute("user");
//		if (userLogin == null)
//			return "user/login";
//		
//		Customer customer = getCustomer(userLogin.getId());
//		model.addAttribute("customer", customer);
//		
//		model.addAttribute("userChange", userChange);
//		
//		
//		List<User> users = this.getUsers();
//		PagedListHolder pagedListHolder = new PagedListHolder(users);
//		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
//		pagedListHolder.setPage(page);
//		pagedListHolder.setMaxLinkedPages(5);
//		pagedListHolder.setPageSize(5);
//		model.addAttribute("btnStatus", "btnAdd");
//		String roles[] = { "ADMIN", "USER" };
//		model.addAttribute("roles", roles);
//		model.addAttribute("pagedListHolder", pagedListHolder);
//		
//		return "admin/index1";
//	}

	@RequestMapping(value = "index/{id}", params = "linkEdit")
	public String index(ModelMap model, HttpServletRequest request, @PathVariable("id") int id,
			@ModelAttribute("userChange") User userChange, HttpSession session) {
		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null) return "user/login";
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer cus = getCustomer(userLogin.getId());
		model.addAttribute("customer", cus);
		model.addAttribute("roles", new String[] { "ADMIN", "USER" });
		userChange = getUser(id);
		model.addAttribute("prePass", userChange.getPassword().trim());
//		request.getSession().setAttribute("pP", userChange.getPassword().trim());

		request.getSession().setAttribute("pP", userChange.getPassword().trim());
		model.addAttribute("userChange", userChange);

		List<User> users = this.getUsers();
		PagedListHolder pagedListHolder = new PagedListHolder(users);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(5);
		model.addAttribute("btnStatus", "btnEdit");
		String roles[] = { "ADMIN", "USER" };
		model.addAttribute("roles", roles);
		model.addAttribute("pagedListHolder", pagedListHolder);

		return "admin/index1";
	}

	@RequestMapping(value = "index/{id}", params = "btnEdit", method = RequestMethod.POST)
	public String editPassword(HttpServletRequest request, ModelMap model, @PathVariable("id") int id,
			@ModelAttribute("userChange") User userChange, HttpSession session) {

		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null) return "user/login";
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer cus = getCustomer(userLogin.getId());
		model.addAttribute("customer", cus);
		
		model.addAttribute("userChange", new User());
		String prePass = (String) session.getAttribute("pP");
		if (prePass != userChange.getPassword().trim()) {
			userChange.setPassword(BCrypt.hashpw(userChange.getPassword(), BCrypt.gensalt(12)));
		}
		if (updateUser(userChange) == 1) {
			model.addAttribute("message", "Cập nhật tài khoản thành công!");
		} else
			model.addAttribute("message", "Cập nhật tài khoản thất bại!");
		List<User> users = this.getUsers();
		PagedListHolder pagedListHolder = new PagedListHolder(users);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(5);
		model.addAttribute("btnStatus", "btnAdd");
		String roles[] = { "ADMIN", "USER" };
		model.addAttribute("roles", roles);
		model.addAttribute("pagedListHolder", pagedListHolder);

		return "admin/index1";
	}

	@RequestMapping(value = "index/{id}", params = "linkDelete")
	public String editEnable(HttpServletRequest request, ModelMap model, @PathVariable("id") int id,
			HttpSession session) {
		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null) return "user/login";
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer cus = getCustomer(userLogin.getId());
		model.addAttribute("customer", cus);
		
		User userChange = getUser(id);
		model.addAttribute("userChange", new User());
		// === phan trang
		List<User> users = this.getUsers();
		PagedListHolder pagedListHolder = new PagedListHolder(users);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(5);
		model.addAttribute("btnStatus", "btnAdd");
		String roles[] = { "ADMIN", "USER" };
		model.addAttribute("roles", roles);
		model.addAttribute("pagedListHolder", pagedListHolder);
		// === . ===

		if (userChange == null) {
			return "admin/index";
		}

		userChange.setEnable(!userChange.getEnable());
		if (updateUser(userChange) == 1) {
			if (userChange.getEnable()) {
				model.addAttribute("message", "Khôi phục tài khoản thành công!");
			} else if (!userChange.getEnable()) {
				model.addAttribute("message", "Vô hiệu hóa tài khoản thành công!");
			}
		} else {
			if (userChange.getEnable()) {
				model.addAttribute("message", "Khôi phục tài khoản thất bại!");
			} else if (!userChange.getEnable()) {
				model.addAttribute("message", "Vô hiệu hóa tài khoản thất bại!");
			}
		}
		
		return "admin/index1";
	}

	private List<User> getUsers() {
		Session session = factory.getCurrentSession();
		String hql = "FROM User";
		Query query = session.createQuery(hql);
		return query.list();
	}

	private User getUser(int id) {
		Session session = factory.getCurrentSession();
		String hql = "FROM User u WHERE u.id=:id";
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		return (User) query.list().get(0);
	}

	private int updateUser(User user) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.update(user);
			t.commit();
			session.close();
			return 1;
		} catch (Exception e) {
			// TODO: handle exception
			t.rollback();
			System.out.println(e);
			session.close();
			return 0;
		}
	}

	private List<User> searchUsers(String str) {
		Session session = factory.getCurrentSession();
		String hql = "FROM User WHERE email LIKE :str OR id = :id";
		Query query = session.createQuery(hql);
		query.setParameter("str", "%" + str + "%");
		int id ;
		try {
			id = Integer.parseInt(str);
		} catch (Exception e) {
			id = -1;
		}
		query.setParameter("id", id);
		return query.list();
	}

	private Customer getCustomer(int idUser) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Customer c WHERE c.userId =:idUser";
		Query query = session.createQuery(hql);
		query.setParameter("idUser", idUser);
		return (Customer) query.list().get(0);
	}
}
