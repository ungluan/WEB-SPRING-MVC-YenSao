package ptithcm.controller.user;

import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import ptithcm.entity.Customer;
import ptithcm.entity.User;

@Controller
@Transactional
@RequestMapping("/userInfo/")
public class UserInfoController {
	@Autowired
	SessionFactory factory;

	@RequestMapping(value = "profile", method = RequestMethod.GET)
	public String info(ModelMap model, HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (user == null || user.getEmail().length() == 0) {
			return "user/login";
		}

		Customer cus = getCustomer(user.getId());
		model.addAttribute("customer", cus);
		model.addAttribute("userLogin", user);
		return "user/userInfor";
	}

	@RequestMapping(value = "profile", method = RequestMethod.POST)
	public String editProfile(ModelMap model, HttpSession session, @ModelAttribute("customer") Customer customer,
			BindingResult errors) {
		User user = (User) session.getAttribute("user");
		model.addAttribute("userLogin", user);
		if (user == null) {
			return "user/login";
		}

		// -- Validate input
		if (customer.getFullname().trim().isEmpty() || customer.getFullname().trim().length() > 100) {
			errors.rejectValue("fullname", "customer", "Vui lòng nhập đúng họ và tên!");
		}
		if (customer.getAddress().trim().isEmpty() || customer.getAddress().trim().length() > 500) {
			errors.rejectValue("address", "customer", "Vui lòng nhập đúng địa chỉ!");
		}
		if (!validateAge(customer.getBirthday())) {
			errors.rejectValue("birthday", "customer", "Khách hàng phải trên 16 tuổi!");
		}

		if (!errors.hasErrors()) {
			int update = updateProfile(customer);
			if (update == 1) {
				model.addAttribute("message", "Cập nhật thông tin thành công!");
				model.addAttribute("customer", getCustomer(user.getId()));
			}
		}else {
			model.addAttribute("customer", customer);
		}

		return "user/userInfor";
	}

	public Customer getCustomer(int userId) {
		Session session = factory.openSession();
		String hql = "FROM Customer where userId = :userId";
		Query query = session.createQuery(hql);
		query.setParameter("userId", userId);
		Customer cus = (Customer) query.list().get(0);
		session.close();
		return cus;
	}

	private int updateProfile(Customer customer) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.update(customer);
			t.commit();
		} catch (Exception e) {
			System.out.println("Error Update Profile: " + e);
			return 0;
		} finally {
			session.close();
			return 1;
		}
	}

	private boolean validateAge(Date birthday) {
		Calendar c1 = Calendar.getInstance();
		c1.setTime(birthday);
		c1.add(Calendar.YEAR, 16);
		if (c1.getTime().after(new Date()))
			return false;
		return true;
	}
}
