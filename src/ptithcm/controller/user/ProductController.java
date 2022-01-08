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
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import ptithcm.entity.Category;
import ptithcm.entity.Customer;
import ptithcm.entity.Order;
import ptithcm.entity.OrderDetail;
import ptithcm.entity.OrderStatus;
import ptithcm.entity.Product;
import ptithcm.entity.User;

@Transactional
@Controller
@RequestMapping("/products")
public class ProductController {
	@Autowired
	SessionFactory factory;

	@RequestMapping("/")
	public String index(ModelMap model, HttpSession session, HttpServletRequest request) {
		List<Product> products = getProducts();
		model.addAttribute("categories", getCategories());
		model.addAttribute("products", products);
		model.addAttribute("activeId", 0);

		PagedListHolder pagedListHolder = new PagedListHolder(products);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(12);
		model.addAttribute("pagedListHolder", pagedListHolder);
		model.addAttribute("action", "products/");
		User user = (User) session.getAttribute("user");
		if (user != null) {
			model.addAttribute("userLogin", user);
			model.addAttribute("customer", getCustomer(user.getId()));
		}
		model.addAttribute("numberOfProducts", session.getAttribute("numberOfProducts"));

		return "user/shop";
	}

	@RequestMapping(value = "/{id}", params = "linkCategory")
	public String index(ModelMap model, @PathVariable("id") int id, HttpServletRequest request, HttpSession session) {
		List<Product> products = getProductsByCategoryId(id);
		model.addAttribute("categories", getCategories());
		model.addAttribute("products", products);
		model.addAttribute("activeId", id);
		model.addAttribute("action", "products/category/" + id);
		PagedListHolder pagedListHolder = new PagedListHolder(products);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(12);
		model.addAttribute("pagedListHolder", pagedListHolder);
		User user = (User) session.getAttribute("user");
		if (user != null) {
			model.addAttribute("userLogin", user);
			model.addAttribute("customer", getCustomer(user.getId()));
		}
		model.addAttribute("numberOfProducts", session.getAttribute("numberOfProducts"));

		return "user/shop";
	}

	@RequestMapping(value = "/category/{id}")
	public String categoryProducts(ModelMap model, @PathVariable("id") int id, HttpServletRequest request,
			HttpSession session) {
		List<Product> products = getProductsByCategoryId(id);
		model.addAttribute("categories", getCategories());
		model.addAttribute("products", products);
		model.addAttribute("activeId", id);
		model.addAttribute("action", "products/category/" + id);
		PagedListHolder pagedListHolder = new PagedListHolder(products);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(12);
		model.addAttribute("pagedListHolder", pagedListHolder);

		User user = (User) session.getAttribute("user");
		if (user != null) {
			model.addAttribute("userLogin", user);
			model.addAttribute("customer", getCustomer(user.getId()));
		}
		model.addAttribute("numberOfProducts", session.getAttribute("numberOfProducts"));

		return "user/shop";
	}

	@RequestMapping(value = "product-detail/{id}")
	public String productDetail(ModelMap model, @PathVariable("id") int id, HttpSession session) {
		User userLogin = (User) session.getAttribute("user");
		if (userLogin != null) {
			model.addAttribute("userLogin", userLogin);
			model.addAttribute("customer", getCustomer(userLogin.getId()));
		}

		Product product = getProduct(id);
		model.addAttribute("product", product);
		model.addAttribute("productsRelated", getProductsRelate(product.getId(), product.getCategory().getId()));
		model.addAttribute("quantity", 1);
		model.addAttribute("numberOfProducts", session.getAttribute("numberOfProducts"));
		return "user/product-single";
	}

	@RequestMapping(value = "add-product-highlight/{productId}")
	public String addProductHighlight(ModelMap model, HttpServletRequest request, HttpSession session,
			@PathVariable("productId") int productId) {
		User userLogin = (User) request.getSession().getAttribute("user");
		String numberstr = session.getAttribute("numberOfProducts").toString();
		long numbers = Long.parseLong(numberstr); 
		if (userLogin == null) {
			return "user/login";
		}
		Customer cus = getCustomer(userLogin.getId());
		model.addAttribute("user", userLogin);
		model.addAttribute("products", getHighlightProduct());
		// Chưa có order status false nào đang tồn tại
		if (numbers == 0) {
			Order order = new Order(getOrderStatus(6));
//			order.setOrdered(false);
			order.setCustomerId(cus.getId());

			int resultCreateOrder = this.createOrder(order);
			if (resultCreateOrder == 1) {
				// Tạo 1 Order detail
				OrderDetail orderDetail = new OrderDetail();
				orderDetail.setNumbers(1);
				orderDetail.setOrder(order);
				Product pro = getProduct(productId);
				orderDetail.setProduct(pro);

				// Save orderDetail này
				int resultCreateOrderDetail = createOrderDetail(orderDetail);
				if (resultCreateOrderDetail == 1) {
					order.setDate(new Date());
					float price = (float) (pro.getPrice() * (1 - pro.getSale() / 100));
					order.setTotal(price);
					request.getSession().setAttribute("numberOfProducts", 1);
					UpdateOrder(order);
				} else {
					model.addAttribute("message", "Thêm vào giỏ hàng thất bại!");
				}
			}
		} else {
			// Get Order Hiện có lấy id
			Order order = getOrder(cus.getId());
			// Kiểm tra orderDetail có chứa idOrder này và productId hay không
			OrderDetail orderDetail = getOrderDetail(order.getId(), productId);
			// Nếu không? Tạo orderDetail và tăng numbers lên 1
			if (orderDetail == null) {
				orderDetail = new OrderDetail();
				orderDetail.setNumbers(1);
				orderDetail.setOrder(order);
				Product pro = getProduct(productId);
				orderDetail.setProduct(pro);
				// Save orderDetail này
				int resultCreateOrderDetail = createOrderDetail(orderDetail);
				if (resultCreateOrderDetail == 1) {
					order.setDate(new Date());
					float price = (float) (pro.getPrice() * (1 - pro.getSale() / 100));
					order.setTotal(order.getTotal() + price);
					request.getSession().setAttribute("numberOfProducts", numbers + 1);
					UpdateOrder(order);
				} else {
					model.addAttribute("message", "Thêm vào giỏ hàng thất bại!");
				}
			} else { // Nếu có thì update orderDetail đó
				orderDetail.setNumbers(orderDetail.getNumbers() + 1);
				updateOrderDetail(orderDetail);
				Product pro = getProduct(productId);
				float price = (float) (pro.getPrice() * (1 - pro.getSale() / 100));
				order.setTotal(order.getTotal() + price);
				UpdateOrder(order);
			}

		}
		return "user/index";
	}

	@RequestMapping(value = "add-products/{productId}")
	public String addProduct(ModelMap model, HttpServletRequest request, HttpSession session,
			@PathVariable("productId") int productId) {
		User userLogin = (User) request.getSession().getAttribute("user");

		if (userLogin == null)
			return "user/login";

		String numstr = session.getAttribute("numberOfProducts").toString();
		Long numbers = Long.parseLong(numstr);
		int quantity = Integer.parseInt(request.getParameter("quantity"));
		Customer cus = getCustomer(userLogin.getId());
		Product product = getProduct(productId);
		model.addAttribute("userLogin", userLogin);
		model.addAttribute("product", product);
		model.addAttribute("customer", getCustomer(userLogin.getId()));
		model.addAttribute("productsRelated", getProductsRelate(product.getId(), product.getCategory().getId()));
		model.addAttribute("quantity", 1);

		// Chưa có order status false nào đang tồn tại
		if (numbers == 0) {
			Order order = new Order(getOrderStatus(6));
//			order.setOrdered(false);
			order.setCustomerId(cus.getId());

			int resultCreateOrder = this.createOrder(order);
			if (resultCreateOrder == 1) {
				// Tạo 1 Order detail
				OrderDetail orderDetail = new OrderDetail();
				orderDetail.setNumbers(quantity);
				orderDetail.setOrder(order);
				Product pro = getProduct(productId);
				orderDetail.setProduct(pro);

				// Save orderDetail này
				int resultCreateOrderDetail = createOrderDetail(orderDetail);
				if (resultCreateOrderDetail == 1) {
					order.setDate(new Date());
					float price = (float) (pro.getPrice() * (1 - pro.getSale() / 100));
					order.setTotal(quantity * price);
					request.getSession().setAttribute("numberOfProducts", 1);
					UpdateOrder(order);
				} else {
					model.addAttribute("message", "Thêm vào giỏ hàng thất bại!");
				}
			}
		} else {
			// Get Order Hiện có lấy id
			Order order = getOrder(cus.getId());
			// Kiểm tra orderDetail có chứa idOrder này và productId hay không
			OrderDetail orderDetail = getOrderDetail(order.getId(), productId);
			// Nếu không? Tạo orderDetail và tăng numbers lên 1
			if (orderDetail == null) {
				orderDetail = new OrderDetail();
				orderDetail.setNumbers(quantity);
				orderDetail.setOrder(order);
				Product pro = getProduct(productId);
				orderDetail.setProduct(pro);
				// Save orderDetail này
				int resultCreateOrderDetail = createOrderDetail(orderDetail);
				if (resultCreateOrderDetail == 1) {
					order.setDate(new Date());
					float price = (float) (pro.getPrice() * (1 - pro.getSale() / 100));
					order.setTotal(order.getTotal() + quantity * price);
					request.getSession().setAttribute("numberOfProducts", numbers + 1);
					UpdateOrder(order);
				} else {
					model.addAttribute("message", "Thêm vào giỏ hàng thất bại!");
				}
			} else { // Nếu có thì update orderDetail đó
				orderDetail.setNumbers(orderDetail.getNumbers() + quantity);
				updateOrderDetail(orderDetail);
				Product pro = getProduct(productId);
				float price = (float) (pro.getPrice() * (1 - pro.getSale() / 100));
				order.setTotal(order.getTotal() + quantity * price);
				UpdateOrder(order);
			}

		}

		return "user/product-single";
	}

	@RequestMapping(value = "add-product-relate/{productId}")
	public String addProductRelate(ModelMap model, HttpServletRequest request, HttpSession session,
			@PathVariable("productId") int productId) {
		User userLogin = (User) request.getSession().getAttribute("user");
		long numbers = (Long) session.getAttribute("numberOfProducts");
		if (userLogin == null)
			return "user/login";
		Customer cus = getCustomer(userLogin.getId());
		Product product = getProduct(productId);
		model.addAttribute("userLogin", userLogin);
		model.addAttribute("product", product);
		model.addAttribute("customer", getCustomer(userLogin.getId()));
		model.addAttribute("productsRelated", getProductsRelate(product.getId(), product.getCategory().getId()));
		model.addAttribute("quantity", 1);
		// Chưa có order status false nào đang tồn tại
		if (numbers == 0) {
			Order order = new Order(getOrderStatus(6));
//			order.setOrdered(false);
			order.setCustomerId(cus.getId());

			int resultCreateOrder = this.createOrder(order);
			if (resultCreateOrder == 1) {
				// Tạo 1 Order detail
				OrderDetail orderDetail = new OrderDetail();
				orderDetail.setNumbers(1);
				orderDetail.setOrder(order);
				Product pro = getProduct(productId);
				orderDetail.setProduct(pro);

				// Save orderDetail này
				int resultCreateOrderDetail = createOrderDetail(orderDetail);
				if (resultCreateOrderDetail == 1) {
					order.setDate(new Date());
					float price = (float) (pro.getPrice() * (1 - pro.getSale() / 100));
					order.setTotal(price);
					request.getSession().setAttribute("numberOfProducts", 1);
					UpdateOrder(order);
				} else {
					model.addAttribute("message", "Thêm vào giỏ hàng thất bại!");
				}
			}
		} else {
			// Get Order Hiện có lấy id
			Order order = getOrder(cus.getId());
			// Kiểm tra orderDetail có chứa idOrder này và productId hay không
			OrderDetail orderDetail = getOrderDetail(order.getId(), productId);
			// Nếu không? Tạo orderDetail và tăng numbers lên 1
			if (orderDetail == null) {
				orderDetail = new OrderDetail();
				orderDetail.setNumbers(1);
				orderDetail.setOrder(order);
				Product pro = getProduct(productId);
				orderDetail.setProduct(pro);
				// Save orderDetail này
				int resultCreateOrderDetail = createOrderDetail(orderDetail);
				if (resultCreateOrderDetail == 1) {
					order.setDate(new Date());
					float price = (float) (pro.getPrice() * (1 - pro.getSale() / 100));
					order.setTotal(order.getTotal() + price);
					request.getSession().setAttribute("numberOfProducts", numbers + 1);
					UpdateOrder(order);
				} else {
					model.addAttribute("message", "Thêm vào giỏ hàng thất bại!");
				}
			} else { // Nếu có thì update orderDetail đó
				orderDetail.setNumbers(orderDetail.getNumbers() + 1);
				updateOrderDetail(orderDetail);
				Product pro = getProduct(productId);
				float price = (float) (pro.getPrice() * (1 - pro.getSale() / 100));
				order.setTotal(order.getTotal() + price);
				UpdateOrder(order);
			}

		}
		return "user/product-single";
	}

	@RequestMapping(value = "add-product-cate/{proId_cateId}")
	public String addProductCate(ModelMap model, HttpServletRequest request, HttpSession session,
			@PathVariable("proId_cateId") String proId_cateId) {
		User userLogin = (User) request.getSession().getAttribute("user");
		if (userLogin == null)	return "user/login";
		String[] token = proId_cateId.split("_");
		int productId = Integer.parseInt(token[0]);
		int categoryId = Integer.parseInt(token[1]);
		String numStr = session.getAttribute("numberOfProducts").toString();
		long numbers = Long.parseLong(numStr) ;
		

		Customer cus = getCustomer(userLogin.getId());
		Product product = getProduct(productId);
		model.addAttribute("userLogin", userLogin);
		model.addAttribute("customer", getCustomer(userLogin.getId()));
		// Chưa có order status false nào đang tồn tại
		if (numbers == 0) {
			Order order = new Order(getOrderStatus(6));
//			order.setOrdered(false);
			order.setCustomerId(cus.getId());

			int resultCreateOrder = this.createOrder(order);
			if (resultCreateOrder == 1) {
				// Tạo 1 Order detail
				OrderDetail orderDetail = new OrderDetail();
				orderDetail.setNumbers(1);
				orderDetail.setOrder(order);
				Product pro = getProduct(productId);
				orderDetail.setProduct(pro);

				// Save orderDetail này
				int resultCreateOrderDetail = createOrderDetail(orderDetail);
				if (resultCreateOrderDetail == 1) {
					order.setDate(new Date());
					float price = (float) (pro.getPrice() * (1 - pro.getSale() / 100));
					order.setTotal(price);
					request.getSession().setAttribute("numberOfProducts", 1);
					UpdateOrder(order);
				} else {
					model.addAttribute("message", "Thêm vào giỏ hàng thất bại!");
				}
			}
		} else {
			// Get Order Hiện có lấy id
			Order order = getOrder(cus.getId());
			// Kiểm tra orderDetail có chứa idOrder này và productId hay không
			OrderDetail orderDetail = getOrderDetail(order.getId(), productId);
			// Nếu không? Tạo orderDetail và tăng numbers lên 1
			if (orderDetail == null) {
				orderDetail = new OrderDetail();
				orderDetail.setNumbers(1);
				orderDetail.setOrder(order);
				Product pro = getProduct(productId);
				orderDetail.setProduct(pro);
				// Save orderDetail này
				int resultCreateOrderDetail = createOrderDetail(orderDetail);
				if (resultCreateOrderDetail == 1) {
					order.setDate(new Date());
					float price = (float) (pro.getPrice() * (1 - pro.getSale() / 100));
					order.setTotal(order.getTotal() + price);
					request.getSession().setAttribute("numberOfProducts", numbers + 1);
					UpdateOrder(order);
				} else {
					model.addAttribute("message", "Thêm vào giỏ hàng thất bại!");
				}
			} else { // Nếu có thì update orderDetail đó
				orderDetail.setNumbers(orderDetail.getNumbers() + 1);
				updateOrderDetail(orderDetail);
				Product pro = getProduct(productId);
				float price = (float) (pro.getPrice() * (1 - pro.getSale() / 100));
				order.setTotal(order.getTotal() + price);
				UpdateOrder(order);
			}

		}
		List<Product> products;
		if(categoryId==0) {
			products = getProducts();
		}else {
			products = getProductsByCategoryId(categoryId);
		}
		model.addAttribute("categories", getCategories());
		model.addAttribute("products", products);
		model.addAttribute("activeId", categoryId);
		model.addAttribute("action", "products/category/" + categoryId);
		PagedListHolder pagedListHolder = new PagedListHolder(products);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(12);
		model.addAttribute("pagedListHolder", pagedListHolder);
		
		return "user/shop";
	}

	private List<Category> getCategories() {
		Session session = factory.getCurrentSession();
		String hql = "FROM Category";
		Query query = session.createQuery(hql);
		return query.list();
	}

	private List<Product> getProductsByCategoryId(int id) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Product where categoryId =:id";
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		return query.list();
	}

	private List<Product> getProducts() {
		Session session = factory.getCurrentSession();
		String hql = "FROM Product";
		Query query = session.createQuery(hql);
		return query.list();
	}

	private Product getProduct(int id) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Product where id =:id";
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		return (Product) query.list().get(0);
	}

	private List<Product> getProductsRelate(int id, int categoryId) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Product where categoryId = :categoryId and id != :id ORDER BY RAND()";
		Query query = session.createQuery(hql);
		query.setParameter("categoryId", categoryId);
		query.setParameter("id", id);
		query.setMaxResults(4);
		return query.list();
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

	private OrderDetail getOrderDetail(int orderId, int productId) {
		Session session = factory.getCurrentSession();
		String hql = "FROM OrderDetail o where o.order.id = :orderId AND o.product.id = :productId";
		Query query = session.createQuery(hql);
		query.setParameter("orderId", orderId);
		query.setParameter("productId", productId);
		List<OrderDetail> list = query.list();
		return list.size() == 0 ? null : list.get(0);
	}

	private Customer getCustomer(int userId) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Customer where userId = :userId";
		Query query = session.createQuery(hql);
		query.setParameter("userId", userId);
		return (Customer) query.list().get(0);
	}

	private int createOrder(Order order) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();

		try {
			session.save(order);
			t.commit();
			return 1;
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("Tạo Order thất bại!");
			System.out.println(e.toString());
			t.rollback();
		} finally {
			session.close();
		}
		return 0;
	}

	private int UpdateOrder(Order order) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();

		try {
			factory.getCurrentSession().merge(order);
			t.commit();
			return 1;
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("Cập nhật order thất bại!");
			System.out.println(e.toString());
			t.rollback();
		} finally {
			session.close();
		}

		return 0;
	}

	private int createOrderDetail(OrderDetail orderDetail) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();

		try {
			session.save(orderDetail);
			t.commit();
			return 1;
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("Tạo OrderDetail thất bại!");
			System.out.println(e.toString());
			t.rollback();
		} finally {
			session.close();
		}

		return 0;
	}

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

	private List<Product> getHighlightProduct() {
		Session session = factory.getCurrentSession();
		String hql = "FROM Product p WHERE p.highlight = 1";
		Query query = session.createQuery(hql);
		return query.list();
	}
	private OrderStatus getOrderStatus(int id) {
		Session session = factory.getCurrentSession();
		String hql = "FROM OrderStatus WHERE id = :id";
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		return (OrderStatus) query.list().get(0);
	}
}
