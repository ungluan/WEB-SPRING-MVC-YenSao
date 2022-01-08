package ptithcm.controller.admin;

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
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import ptithcm.entity.Branch;
import ptithcm.entity.Customer;
import ptithcm.entity.Order;
import ptithcm.entity.OrderDetail;
import ptithcm.entity.OrderStatus;
import ptithcm.entity.Supplier;
import ptithcm.entity.User;

@Controller
@Transactional
@RequestMapping("admin/order/")
public class OrderControllerAdmin {
	
	@Autowired
	SessionFactory factory;
	
	@RequestMapping("index")
	public String order(ModelMap model, HttpServletRequest request, HttpSession session) {
		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null) return "user/login";
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer cus = getCustomer(userLogin.getId());
		model.addAttribute("customer", cus);

		
		// Show ra danh sách các order đã mua
		List<Order> list = getOrders();

		PagedListHolder pagedListHolder = new PagedListHolder(list);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(10);
		model.addAttribute("pagedListHolder", pagedListHolder);

		return "admin/order";
	}
	
	@RequestMapping(value="index", params="btnSearch")
	public String searchOrder(ModelMap model, HttpServletRequest request, HttpSession session) {
		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null) return "user/login";
		else if(userLogin.getRole().equals("USER")) return "user/index";
		// Model User/customer/numberOfProducts\
		Customer cus = getCustomer(userLogin.getId());
		model.addAttribute("customer", cus);
				
		// Show ra danh sách các order đã mua
		List<Order> list;
		list = searchOrders(request.getParameter("searchInput"));
//		try {
////			int id = Integer.parseInt() ;
//			list = searchOrders(request.getParameter("searchInput"));
//		}catch (Exception e) {
//			// TODO: handle exception
//			list = getOrders();
//		}
		

		PagedListHolder pagedListHolder = new PagedListHolder(list);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(10);
		model.addAttribute("pagedListHolder", pagedListHolder);

		return "admin/order";
	}

	@RequestMapping("cancel/{id}")
	public String cancelOrder(ModelMap model, HttpServletRequest request, HttpSession session,
			@PathVariable("id") int orderId) {

		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null) return "user/login";
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer cus = getCustomer(userLogin.getId());
		model.addAttribute("customer", cus);

		Order order = getOrderById(orderId);
		
		if(order!=null) {
			order.setOrderStatus(getOrderStatus(3));

			int result = updateOrder(order);

			if (result == 1) {
				model.addAttribute("message", "Hủy đơn hàng thành công!");
			} else {
				model.addAttribute("message", "Hủy đơn hàng thất bại!");
			}
		}
		
		// Đổ vào theo list
		List<Order> list = getOrders();

		PagedListHolder pagedListHolder = new PagedListHolder(list);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(10);
		model.addAttribute("pagedListHolder", pagedListHolder);

		return "admin/order";
	}
	
	@RequestMapping("detail/{id}")
	public String detailOrder(ModelMap model, HttpServletRequest request, HttpSession session,
			@PathVariable("id") int orderId) {

		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null) return "user/login";
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer cus = getCustomer(userLogin.getId());
		model.addAttribute("customer", cus);

		Order order = getOrderById(orderId);
		model.addAttribute("orderId",orderId);
		
		PagedListHolder pagedListHolder = new PagedListHolder(order.getOrderDetails());
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(10);
		model.addAttribute("pagedListHolder", pagedListHolder);

		return "admin/order-detail";
	}
	@RequestMapping(value="update-status/{id}")
	public String updateStatus(ModelMap model, HttpServletRequest request, 
			HttpSession session, @PathVariable("id") int orderId) {
		
		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null) return "user/login";
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer cus = getCustomer(userLogin.getId());
		model.addAttribute("customer", cus);
		
		
		Order order = getOrderById(orderId);
		int r = updateStatus(order);
		if(r==1) {
			model.addAttribute("message","Cập nhật trạng thái đơn hàng thành công!");
		}else {
			model.addAttribute("message","Cập nhật trạng thái đơn hàng thất bại!");
		}
		
		PagedListHolder pagedListHolder = new PagedListHolder(getOrders());
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(10);
		model.addAttribute("pagedListHolder", pagedListHolder);
		return "admin/order";
	}
	
	private Customer getCustomer() {
		Session session = this.factory.openSession();
		String hql = "FROM Customer where userId = :userId";
		Query query = session.createQuery(hql);
		Customer cus = (Customer) query.list().get(0);
		session.close();
		return cus;
	}

//	private Order getOrder(int customerId) {
//		Session session = factory.openSession();
//		String hql = "FROM Order where customerId = :customerId AND ordered is false";
//		Query query = session.createQuery(hql);
//		query.setParameter("customerId", customerId);
//		List<Order> list = query.list();
//		session.close();
//		if (list.size() == 0) {
//			return null;
//		}
//		return list.get(0);
//	}

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
	private List<OrderStatus> getListOrderStatus() {
		Session session = factory.getCurrentSession();
		String hql = "FROM OrderStatus";
		Query query = session.createQuery(hql);
		return query.list();
	}

	private int updateOrder(Order order) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.update(order);
			t.commit();
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("Hủy order thất bại!");
			System.out.println(e.toString());
			t.rollback();
			return 0;
		} finally {
			session.close();
		}
		return 1;

	}

	private List<Order> getOrders() {
		Session session = factory.openSession();
		String hql = "FROM Order WHERE orderStatus.id != :id Order By date desc";
		Query query = session.createQuery(hql);
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
	private Customer getCustomer(int userId) {
		Session session = this.factory.openSession();
		String hql = "FROM Customer where userId = :userId";
		Query query = session.createQuery(hql);
		query.setParameter("userId", userId);
		Customer cus = (Customer) query.list().get(0);
		session.close();
		return cus;
	}
	private List<Order> searchOrders(String str){
		Session session = factory.getCurrentSession();
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
		return query.list();
	}
	private OrderStatus getOrderStatus(int id) {
		Session session = factory.getCurrentSession();
		String hql = "FROM OrderStatus  WHERE id = :id";
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		return (OrderStatus) query.list().get(0); 
	}
	private int updateStatus(Order order) {
		if(order.getOrderStatus().getId()==1) {
			order.getOrderStatus().setId(2);
		}
		else if(order.getOrderStatus().getId()==2) {
			order.getOrderStatus().setId(4);
		}
		return updateOrder(order);
	}
}
