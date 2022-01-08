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
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import ptithcm.entity.Branch;
import ptithcm.entity.Customer;
import ptithcm.entity.Order;
import ptithcm.entity.OrderDetail;
import ptithcm.entity.OrderStatus;
import ptithcm.entity.User;

@Controller
@Transactional
@RequestMapping("cart/")
public class CartController {
	@Autowired
	SessionFactory factory;

	@RequestMapping(value = "checkout")
	public String index(ModelMap model, HttpSession session) {
		// userLogin null => Login
		User user = (User) session.getAttribute("user");
		if (user == null)
			return "user/login";
		// Model User/customer/numberOfProducts
		Customer cus = getCustomer(user.getId());
		// Model productDetails
		model.addAttribute("userLogin", user);
		model.addAttribute("customer", cus);
		model.addAttribute("numberOfProducts", session.getAttribute("numberOfProducts"));
		// Gửi orderDetails , Products
		model.addAttribute("order", getOrder(cus.getId()));
		// Thêm Button đặt hàng khi click thì vào điền thông tin người mua

		return "user/cart";
	}

	@RequestMapping(value = "remove/{id}")
	public String removeOrderDetail(ModelMap model, HttpServletRequest request, HttpSession session,
			@PathVariable("id") int id) throws InterruptedException {

		User user = (User) session.getAttribute("user");
		if (user == null)
			return "user/login";
		String numberstr = session.getAttribute("numberOfProducts").toString();
		long numbers = Long.parseLong(numberstr);
		Customer cus = getCustomer(user.getId());
		// Model productDetails
		model.addAttribute("userLogin", user);
		model.addAttribute("customer", cus);
//		model.addAttribute("numberOfProducts", numbers );
		// remove orderDetail
		OrderDetail orderDetail = getOrderDetail(id);
		int result = deleteOrderDetail(orderDetail);
		Order order = getOrder(cus.getId());
		order.getOrderDetails().remove(orderDetail);
		// Gửi order
		if (order.getOrderDetails().size() == 0) {
			deleteOrder(order);
			model.addAttribute("order", null);
			numbers = 0;
			request.getSession().setAttribute("numberOfProducts", numbers);
			model.addAttribute("numberOfProducts", numbers);
			model.addAttribute("unactive", true);
		} else {
			model.addAttribute("order", order);
			request.getSession().setAttribute("numberOfProducts", numbers - 1);
			model.addAttribute("numberOfProducts", numbers - 1);
		}

		return "user/cart";
	}

	@RequestMapping(value = "confirm")
	public String formBuy(ModelMap model, HttpSession session, HttpServletRequest request) {
		// userLogin null => Login
		User user = (User) session.getAttribute("user");
		String numberstr = session.getAttribute("numberOfProducts").toString();
		long numbers = Long.parseLong(numberstr);
		if (user == null)
			return "user/login";
		// Model User/customer/numberOfProducts
		Customer cus = getCustomer(user.getId());
		model.addAttribute("userLogin", user);
		model.addAttribute("customer", cus);
		if (numbers == 0) {
			model.addAttribute("numberOfProducts", session.getAttribute("numberOfProducts"));
			model.addAttribute("order", getOrder(cus.getId()));
			return "user/cart";
		}
		numbers = 0;
		model.addAttribute("numberOfProducts", numbers);
		// Đề phòng khách hàng không thanh toán mà thoát ra
//		request.getSession().setAttribute("numberOfProducts", numbers);
		Order order = getOrder(cus.getId());
		for(int i=0; i<order.getOrderDetails().size(); i++) {
			int id = order.getOrderDetails().get(i).getProduct().getId();
			String productId = String.valueOf(id);
			int quanitity = Integer.parseInt(request.getParameter( productId  ));			
			order.getOrderDetails().get(i).setNumbers(quanitity);
			updateOrderDetail(order.getOrderDetails().get(i));
		}
		// model : SumTotal, SumPreSale, SumSale
		// Tính tiền để show màn hình confirm
		Double[] prices = caculatePrice(order);

		model.addAttribute("sumPrice", prices[0]);
		model.addAttribute("sumSale", prices[1]);
		
		model.addAttribute("name", cus.getFullname());
		model.addAttribute("phone", cus.getPhone());
		model.addAttribute("address", cus.getAddress());		

//		order.setDate(new Date());
//		order.setAddress(request.getParameter("address").trim());
//		order.setOrdered(true);
//		order.setDelivered(false);
//		order.setFinished(false);
//		order.setOrderStatus(getOrderStatus(1));
		Double price = prices[0] - prices[1];
		String priceStr = price.toString();
		float pricef = Float.parseFloat(priceStr);
		order.setTotal(pricef);
//		UpdateOrder(order);
		return "user/confirm";// form này tự design;
	}

	

	// Set new Total rồi mới update
	// tHay đổi detail sau đó update order nó có chịu không?
	private Customer getCustomer(int userId) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Customer where userId = :userId";
		Query query = session.createQuery(hql);
		query.setParameter("userId", userId);
		return (Customer) query.list().get(0);
	}

	private Order getOrder(int customerId) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Order where customerId = :customerId AND orderStatus.id = :id";
		Query query = session.createQuery(hql);
		query.setParameter("customerId", customerId);
		query.setParameter("id", 6);
		List<Order> list = query.list();
		if (list.size() == 0) {
			return null;
		}
		return list.get(0);
	}

	private OrderDetail getOrderDetail(int id) {
		Session session = factory.getCurrentSession();
		String hql = "FROM OrderDetail where id = :id";
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<OrderDetail> list = query.list();
		return list.get(0);
	}

	private int deleteOrder(Order order) {

		Session session = factory.openSession();
		Transaction t = session.beginTransaction();

		try {
			factory.getCurrentSession().delete(order);
			t.commit();
			System.out.println("Xóa Order thành công!");
		} catch (Exception e) {
			t.rollback();
			System.out.println(e.toString());
			return 0;
		} finally {
			session.close();
		}
		return 1;
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

	private int UpdateOrder(Order order) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();

		try {
			factory.getCurrentSession().merge(order);
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

	private Double[] caculatePrice(Order order) {
		Double sumPrice = 0.0;
		Double sumSale = 0.0;
		for (int i = 0; i < order.getOrderDetails().size(); i++) {
			int numbers = order.getOrderDetails().get(i).getNumbers();
			Double price = order.getOrderDetails().get(i).getProduct().getPrice();
			Double sale = order.getOrderDetails().get(i).getProduct().getSale();
			sumPrice += numbers * price;
			sumSale += numbers * price * sale * 0.01;
		}
		Double[] list = { sumPrice, sumSale };
		return list;
	}

//	private List<Order> getOrders(int customerId) {
//		Session session = factory.getCurrentSession();
//		String hql = "FROM Order where customer.id = :customer.id AND ordered is true";
//		Query query = session.createQuery(hql);
//		query.setParameter("customerId", customerId);
//		return query.list();
//	}
	private int updateOrderDetail(OrderDetail orderDetail) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();

		try {
			session.update(orderDetail);
			t.commit();
			return 1;
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("Update OrderDetail thất bại!");
			System.out.println(e.toString());
			t.rollback();
		} finally {
			session.close();
		}

		return 0;
	}
	private OrderStatus getOrderStatus(int id) {
		Session session = factory.getCurrentSession();
		String hql = "FROM OrderStatus  WHERE id = :id";
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		return (OrderStatus) query.list().get(0); 
	}
}
