package ptithcm.controller.admin;

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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import ptithcm.entity.Customer;
import ptithcm.entity.OrderStatus;
import ptithcm.entity.User;

@Controller
@Transactional
@RequestMapping("orderstatus/")
public class OrderStatusController {
	@Autowired
	SessionFactory factory;

	@RequestMapping("index")
	public String index(ModelMap model, HttpServletRequest request, HttpSession session) {
		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null)	return "user/login";
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer customer = getCustomer(userLogin.getId());
		model.addAttribute("customer", customer);

		List<OrderStatus> listOrderStatus = getOrderStatusList();
		PagedListHolder pagedListHolder = new PagedListHolder(listOrderStatus);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(5);
		model.addAttribute("btnStatus", "btnAdd");
		model.addAttribute("orderStatus", new OrderStatus());
		model.addAttribute("pagedListHolder", pagedListHolder);
		return "admin/order-status";
	}

	@RequestMapping(value = "index/{id}", params = "linkEdit")
	public String index(ModelMap model, HttpServletRequest request, 
			@ModelAttribute("orderStatus") OrderStatus orderStatus,
			@PathVariable("id") int id, HttpSession session) {

		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null)	return "user/login";
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer customer = getCustomer(userLogin.getId());
		model.addAttribute("customer", customer);

		List<OrderStatus> listOrderStatus = getOrderStatusList();
		PagedListHolder pagedListHolder = new PagedListHolder(listOrderStatus);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(5);
		model.addAttribute("btnStatus", "btnEdit");
		model.addAttribute("orderStatus", getOrderStatus(id));
		model.addAttribute("pagedListHolder", pagedListHolder);
		return "admin/order-status";
	}

	@RequestMapping(value = "index", params = "btnAdd")
	public String addStatus(ModelMap model, HttpServletRequest request, 
			@ModelAttribute("orderStatus") OrderStatus orderStatus, HttpSession session) {

		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null)	return "user/login";
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer customer = getCustomer(userLogin.getId());
		model.addAttribute("customer", customer);

		int result = addOrderStatus(orderStatus);

		if (result == 1) {
			model.addAttribute("message", "Thêm trạng thái đơn hàng thành công!");
		} else {
			model.addAttribute("message", "Thêm trạng thái đơn hàng thất bại!");
		}

		List<OrderStatus> listOrderStatus = getOrderStatusList();
		PagedListHolder pagedListHolder = new PagedListHolder(listOrderStatus);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(5);
		model.addAttribute("btnStatus", "btnAdd");
		model.addAttribute("orderStatus", new OrderStatus());
		model.addAttribute("pagedListHolder", pagedListHolder);
		return "admin/order-status";
	}

	@RequestMapping(value = "index/{id}", method = RequestMethod.POST, params = "btnEdit")
	public String editStatus(ModelMap model, HttpServletRequest request, 
			@ModelAttribute("orderStatus") OrderStatus orderStatus,
			@PathVariable("id") int id, HttpSession session) {

		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null)	return "user/login"; 
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer customer = getCustomer(userLogin.getId());
		model.addAttribute("customer", customer);

		int result = editOrderStatus(orderStatus);

		if (result == 1) {
			model.addAttribute("message", "Chỉnh sửa trạng thái đơn hàng thành công!");
		} else {
			model.addAttribute("message", "Chỉnh sửa trạng thái đơn hàng thất bại!");
		}

		List<OrderStatus> listOrderStatus = getOrderStatusList();
		PagedListHolder pagedListHolder = new PagedListHolder(listOrderStatus);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(5);
		model.addAttribute("btnStatus", "btnAdd");
		model.addAttribute("orderStatus", new OrderStatus());
		model.addAttribute("pagedListHolder", pagedListHolder);
		return "admin/order-status";
	}

	@RequestMapping(value = "index/{id}", params = "linkDelete")
	public String deleteOrder(HttpServletRequest request, ModelMap model, @PathVariable("id") int id,
			HttpSession session) {

		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null)	return "user/login"; 
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer customer = getCustomer(userLogin.getId());
		model.addAttribute("customer", customer);

		OrderStatus order = getOrderStatus(id);

		int result = deleteOrderStatus(order);
		if (result == 1) {
			model.addAttribute("message", "Xóa trạng thái đơn hàng thành công!");
		} else {
			model.addAttribute("message", "Xóa trạng thái đơn hàng thất bại!");
		}

		List<OrderStatus> listOrderStatus = getOrderStatusList();
		PagedListHolder pagedListHolder = new PagedListHolder(listOrderStatus);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(5);
		model.addAttribute("btnStatus", "btnAdd");
		model.addAttribute("orderStatus", new OrderStatus());
		model.addAttribute("pagedListHolder", pagedListHolder);

		return "admin/order-status";
	}

	@RequestMapping(value = "index", params = "btnSearch")
	public String search(ModelMap model, HttpServletRequest request, @ModelAttribute("orderStatus") OrderStatus orderStatus,
			HttpSession session) {

		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null)	return "user/login"; 
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer customer = getCustomer(userLogin.getId());
		model.addAttribute("customer", customer);

		List<OrderStatus> listOrderStatus = searchOrderStatus(request.getParameter("searchInput"));

		PagedListHolder pagedListHolder = new PagedListHolder(listOrderStatus);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(5);
		model.addAttribute("btnStatus", "btnAdd");
		model.addAttribute("orderStatus", new OrderStatus());
		model.addAttribute("pagedListHolder", pagedListHolder);

		return "admin/order-status";
	}

	private List<OrderStatus> getOrderStatusList() {
		Session session = factory.getCurrentSession();
		String hql = "FROM OrderStatus";
		Query query = session.createQuery(hql);
		return query.list();
	}

	private List<OrderStatus> searchOrderStatus(String str) {
		Session session = factory.getCurrentSession();
		String hql = "FROM OrderStatus where status LIKE :status OR id =:str  ";
		Query query = session.createQuery(hql);
		query.setParameter("status", "%" + str + "%");
		int s ; 
		try {
			s = Integer.parseInt(str);
		}
		catch (Exception e) {
			s = -1;
		}
		query.setParameter("str", s );
		return query.list();
	}

	private OrderStatus getOrderStatus(int id) {
		Session session = factory.openSession();
		String hql = "FROM OrderStatus o where o.id =:id ";
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		OrderStatus c = (OrderStatus) query.list().get(0);
		session.close();
		return c;
	}

	private int addOrderStatus(OrderStatus orderStatus) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.save(orderStatus);
			t.commit();
		} catch (Exception e) {
			t.rollback();
			System.out.println(e);
			return 0;
		} finally {
			session.close();
		}
		return 1;
	}

	private int editOrderStatus(OrderStatus orderStatus) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.update(orderStatus);
			t.commit();
		} catch (Exception e) {
			t.rollback();
			System.out.println(e);
			return 0;
		} finally {
			session.close();
		}
		return 1;
	}

	private int deleteOrderStatus(OrderStatus orderStatus) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.delete(orderStatus);
			t.commit();
			session.close();
		} catch (Exception e) {
			t.rollback();
			System.out.println(e);
			session.close();
			return 0;
		} finally {
//				session.close();
		}
		return 1;
	}

	private Customer getCustomer(int idUser) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Customer c WHERE c.userId =:idUser";
		Query query = session.createQuery(hql);
		query.setParameter("idUser", idUser);
		return (Customer) query.list().get(0);
	}
}
