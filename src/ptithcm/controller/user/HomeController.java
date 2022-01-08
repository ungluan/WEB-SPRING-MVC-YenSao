package ptithcm.controller.user;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import ptithcm.entity.Category;
import ptithcm.entity.Customer;
import ptithcm.entity.Order;
import ptithcm.entity.Product;
import ptithcm.entity.User;

@Controller
@Transactional
public class HomeController {
	@Autowired
	SessionFactory factory;
	
	@RequestMapping(value= "/", method=RequestMethod.GET)
	public String index(ModelMap model,HttpSession session) {
		long number = 0;
		User user = (User) session.getAttribute("user");
		if(user!=null ) {
			Customer cus  = getCustomer(user.getId());
			model.addAttribute("customer", cus);
			String numberStr = session.getAttribute("numberOfProducts").toString();
			number = Long.parseLong(numberStr) ;
		}
		model.addAttribute("userLogin",user);
		model.addAttribute("products",getHighlightProduct());
		model.addAttribute("numberOfProducts", number);
		return "user/index";
	}

	
	private List<Category> getCategories(){
		Session session = factory.getCurrentSession();
		String hql = "FROM Category";
		Query query = session.createQuery(hql);
		return query.list();
	}
	
	private List<Product> getHighlightProduct(){
		Session session = factory.getCurrentSession();
		String hql = "FROM Product p WHERE p.highlight = 1";
		Query query = session.createQuery(hql);
		return query.list();
	}
	private Customer getCustomer(int userId) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Customer where userId = :userId";
		Query query = session.createQuery(hql);
		query.setParameter("userId", userId);
		return (Customer) query.list().get(0);
	}
	private Order getOrder(int customerId) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Order where customerId = :customerId AND status is false";
		Query query = session.createQuery(hql);
		query.setParameter("customerId", customerId);
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
		System.out.println("Value Of Number: " + numbers+"|");
		return numbers;
	}
}
