package ptithcm.controller.user;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import ptithcm.entity.Customer;
import ptithcm.entity.Order;
import ptithcm.entity.OrderDetail;
import ptithcm.entity.OrderStatus;
import ptithcm.entity.User;


@Controller
public class CheckoutController {
	@Autowired
	SessionFactory factory;

	@Transactional
	@RequestMapping(value = "cart/orders", method = RequestMethod.POST)
	private String listOrdered(ModelMap model, HttpSession session, HttpServletRequest request) {
		User user = (User) session.getAttribute("user");
		long numbers = 0;
		request.getSession().setAttribute("numberOfProducts", numbers);
		if (user == null)
			return "user/login";
		// Model User/customer/numberOfProducts\
		Customer cus = getCustomer(user.getId());
		model.addAttribute("userLogin", user);
		model.addAttribute("customer", cus);
		model.addAttribute("numberOfProducts", numbers);

		Order order = getOrder(cus.getId());
		order.setDate(new Date());
		order.setOrderStatus(getOrderStatus(1));
//		order.setOrdered(true);
//		order.setDelivered(false);
//		order.setFinished(false);

		order.setAddress(request.getParameter("address"));
		order.setName(request.getParameter("name"));
		order.setNumberPhone(request.getParameter("phone"));
		UpdateOrder(order);
//		 Show ra danh sách các order đã mua
		List<Order> list = getOrders(cus.getId());

		PagedListHolder pagedListHolder = new PagedListHolder(list);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(6);
		model.addAttribute("pagedListHolder", pagedListHolder);

		return "user/orders";
	}

	@RequestMapping("order/cancel/{id}")
	public String cancelOrder(ModelMap model, HttpServletRequest request, HttpSession session,
			@PathVariable("id") int orderId) {

		User user = (User) session.getAttribute("user");
		String numberstr = session.getAttribute("numberOfProducts").toString();
		long numbers = Long.parseLong(numberstr);
		if (user == null)
			return "user/login";
		Customer cus = getCustomer(user.getId());
		model.addAttribute("userLogin", user);
		model.addAttribute("customer", cus);
		model.addAttribute("numberOfProducts", numbers);

		Order order = getOrderById(orderId);
		
		order.setOrderStatus(getOrderStatus(3));
		int result = UpdateOrder(order);
		if (result == 1) {
			model.addAttribute("message", "Hủy đơn hàng thành công!");
		} else {
			model.addAttribute("message", "Hủy đơn hàng thất bại!");
		}
		// Đổ vào theo list
		List<Order> list = getOrders(cus.getId());

		PagedListHolder pagedListHolder = new PagedListHolder(list);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(10);
		model.addAttribute("pagedListHolder", pagedListHolder);

		return "user/orders";
	}

	@RequestMapping("cart/ordered/detail/{id}")
	public String detailOrder(ModelMap model, HttpServletRequest request, HttpSession session,
			@PathVariable("id") int orderId) {

		User user = (User) session.getAttribute("user");
		String numberstr = session.getAttribute("numberOfProducts").toString();
		long numbers = Long.parseLong(numberstr);
		if (user == null)
			return "user/login";
		// Model User/customer/numberOfProducts\

		Customer cus = getCustomer(user.getId());
		model.addAttribute("userLogin", user);
		model.addAttribute("customer", cus);
		model.addAttribute("numberOfProducts", numbers);

		Order order = getOrderById(orderId);
		model.addAttribute("orderId",orderId);
		
		PagedListHolder pagedListHolder = new PagedListHolder(order.getOrderDetails());
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(10);
		model.addAttribute("pagedListHolder", pagedListHolder);

		return "user/order-detail";
	}
	@RequestMapping(value="cart/ordered", params="btnSearch")
	public String searchOrder(ModelMap model, HttpServletRequest request, HttpSession session) {
		User user = (User) session.getAttribute("user");
		String numberstr = session.getAttribute("numberOfProducts").toString();
		long numbers = Long.parseLong(numberstr);
		if (user == null)
			return "user/login";
		// Model User/customer/numberOfProducts\

		Customer cus = getCustomer(user.getId());
		model.addAttribute("userLogin", user);
		model.addAttribute("customer", cus);
		model.addAttribute("numberOfProducts", numbers);
				
		// Show ra danh sách các order đã mua
		List<Order> list= searchOrders(request.getParameter("searchInput"));
//		try {
//			int id = Integer.parseInt(request.getParameter("searchInput")) ;
//			list = searchOrders(id,cus.getId());
//		}catch (Exception e) {
//			// TODO: handle exception
//			list = getOrders(cus.getId());
//		}
		

		PagedListHolder pagedListHolder = new PagedListHolder(list);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(10);
		model.addAttribute("pagedListHolder", pagedListHolder);

		return "user/orders";
	}
	
	@Transactional
	@RequestMapping(value = "cart/ordered", method = RequestMethod.GET)
	private String orders(ModelMap model, HttpSession session, HttpServletRequest request) {
		User user = (User) session.getAttribute("user");
		String numberstr = session.getAttribute("numberOfProducts").toString();
		long numbers = Long.parseLong(numberstr);
		if (user == null)
			return "user/login";
		// Model User/customer/numberOfProducts\

		Customer cus = getCustomer(user.getId());
		model.addAttribute("userLogin", user);
		model.addAttribute("customer", cus);
		model.addAttribute("numberOfProducts", numbers);

//		 Show ra danh sách các order đã mua
		List<Order> list = getOrders(cus.getId());

		PagedListHolder pagedListHolder = new PagedListHolder(list);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(6);
		model.addAttribute("pagedListHolder", pagedListHolder);
		model.addAttribute("orders", list);

		return "user/orders";
	}
	
	
	
	private Customer getCustomer(int userId) {
		Session session = this.factory.openSession();
		String hql = "FROM Customer where userId = :userId";
		Query query = session.createQuery(hql);
		query.setParameter("userId", userId);
		Customer cus = (Customer) query.list().get(0);
		session.close();
		return cus;
	}

	private Order getOrder(int customerId) {
		Session session = factory.openSession();
		String hql = "FROM Order where customerId = :customerId AND orderStatus.id = :id ";
		Query query = session.createQuery(hql);
		query.setParameter("customerId", customerId);
		query.setParameter("id", 6);
		List<Order> list = query.list();
		session.close();
		if (list.size() == 0) {
			return null;
		}
		return list.get(0);
	}

	private int UpdateOrder(Order order) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.update(order);
			t.commit();
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("Cập nhật order thất bại!");
			System.out.println(e.toString());
			t.rollback();
			return 0;
		} finally {
			session.close();
		}
		return 1;

	}

//	private int deleteOrder(Order order) {
//		Session session = factory.openSession();
//		Transaction t = session.beginTransaction();
//		try {
//			session.delete(order);
//			t.commit();
//		} catch (Exception e) {
//			// TODO: handle exception
//			System.out.println("Xóa order thất bại!");
//			System.out.println(e.toString());
//			t.rollback();
//			return 0;
//		} finally {
//			session.close();
//		}
//		return 1;
//
//	}
	private int deleteOrderDetails(Order order) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {		
			session.delete(order);
			t.commit();
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("Xóa order thất bại!");
			System.out.println(e.toString());
			t.rollback();
			return 0;
		} finally {
			session.close();
		}
		return 1;

	}

	private List<Order> getOrders(int customerId) {
		Session session = factory.openSession();
		String hql = "FROM Order where customerId = :customerId AND orderStatus.id != :id Order By date desc";
		Query query = session.createQuery(hql);
		query.setParameter("customerId", customerId);
		query.setParameter("id", 6);
		List<Order> list = query.list();
		session.close();
		return list;
	}

	private Order getOrderById(int id) {
		Session session = factory.openSession();
		String hql = "FROM Order where id = :id";
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<Order> list = query.list();
		session.close();
		return list.get(0);
	}
	private int deleteOrderDetail(OrderDetail orderDetail) {

		Session session = factory.openSession();
		Transaction t = session.beginTransaction();

		try {
			session.delete(orderDetail);
			t.commit();
			System.out.println("Xóa Sản chi tiết thành công!");
		} catch (Exception e) {
			t.rollback();
			return 0;
		} finally {
			session.close();
		}
		return 1;
	}
	private List<Order> searchOrders(int id, int customerId){
		Session session = factory.openSession();
		String hql = "FROM Order where customerId = :customerId AND id = :id";
		Query query = session.createQuery(hql);
		query.setParameter("customerId", customerId);
		query.setParameter("id", id);
		List<Order> list = query.list();
		session.close();
		return list;
	}
	private List<Order> getOrders() {
		Session session = factory.openSession();
		String hql = "FROM Order Order By date desc";
		Query query = session.createQuery(hql);
		List<Order> list = query.list();
		session.close();
		return list;
	}
	private List<Order> searchOrders(String str){
		Session session = factory.openSession();
		String hql = "FROM Order o WHERE o.name LIKE :name OR o.id = :id   Order By date desc";
		Query query = session.createQuery(hql);
		int id ;
		try {
			id = Integer.parseInt(str);
		}catch(Exception e) {
			id = -1;
		}
		query.setParameter("id", id);
		query.setParameter("name", "%"+str+"%");
		List<Order> list = query.list();
		session.close();
		return list;
	}
	private OrderStatus getOrderStatus(int id) {
		Session session = factory.openSession();
		String hql = "FROM OrderStatus  WHERE id = :id";
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		OrderStatus orderStatus = (OrderStatus) query.list().get(0);
		session.close();
		return orderStatus; 
	}

}
