package ptithcm.controller.admin;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import ptithcm.entity.Branch;
import ptithcm.entity.Category;
import ptithcm.entity.Customer;
import ptithcm.entity.Product;
import ptithcm.entity.Supplier;
import ptithcm.entity.User;
import ptithcm.entity.Image;

@Controller
@Transactional
@RequestMapping("product/")
public class ProductControllerAdmin {
	@Autowired
	SessionFactory factory;

	@Autowired
	ServletContext context;

	@RequestMapping("index")
	public String index(HttpServletRequest request, ModelMap model, @ModelAttribute("product") Product product,
			HttpSession session) {
		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null) return "user/login";
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer cus = getCustomer(userLogin.getId());
		model.addAttribute("customer", cus);
		
		List<Product> products = getProducts();
		PagedListHolder pagedListHolder = new PagedListHolder(products);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(5);
		model.addAttribute("btnStatus", "btnAdd");

		model.addAttribute("branchList", getBranchs());
		model.addAttribute("categoryList", getCategories());
		model.addAttribute("suppliers", getSuppliers() );
		String[] unitList = { "gram", "lọ" };
		model.addAttribute("unitList", unitList);
		
		product.setManufacturingDate(new Date());

		Map<Boolean, String> map = new HashMap<Boolean, String>();
		map.put(false, "Không");
		map.put(true, "Có");
		model.addAttribute("selectList", map);

		model.addAttribute("pagedListHolder", pagedListHolder);
		return "admin/product";
	}
	
	@RequestMapping(value = "index", params = "btnSearch")
	public String searchUsers(HttpServletRequest request, ModelMap model, HttpSession session,@ModelAttribute("product") Product product) {
		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null) return "user/login";
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer cus = getCustomer(userLogin.getId());
		model.addAttribute("customer", cus);
		
		List<Product> products = searchProducts(request.getParameter("searchInput"));
		PagedListHolder pagedListHolder = new PagedListHolder(products);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(5);
		model.addAttribute("btnStatus", "btnAdd");

		model.addAttribute("branchList", getBranchs());
		model.addAttribute("categoryList", getCategories());
		model.addAttribute("suppliers", getSuppliers() );
		String[] unitList = { "gram", "lọ" };
		model.addAttribute("unitList", unitList);
		product.setManufacturingDate(new Date());

		Map<Boolean, String> map = new HashMap<Boolean, String>();
		map.put(false, "Không");
		map.put(true, "Có");
		model.addAttribute("selectList", map);

		model.addAttribute("pagedListHolder", pagedListHolder);
		return "admin/product";
	}

	@RequestMapping(value = "index/{id}", params = "linkEdit")
	public String index(HttpServletRequest request, ModelMap model, @ModelAttribute("product") Product product,
			@PathVariable("id") int id, HttpSession session) throws IllegalStateException, IOException {

		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null) return "user/login";
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer cus = getCustomer(userLogin.getId());
		model.addAttribute("customer", cus);
		model.addAttribute("product", getProduct(id));

		List<Product> products = getProducts();
		PagedListHolder pagedListHolder = new PagedListHolder(products);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(5);
		model.addAttribute("btnStatus", "btnEdit");
		model.addAttribute("branchList", getBranchs());
		model.addAttribute("categoryList", getCategories());
		model.addAttribute("suppliers", getSuppliers() );
		model.addAttribute("image_name", getImage(id).getUrl().trim());
//		request.getSession().setAttribute("urlImage", getImage(id).getUrl().trim());

		String[] unitList = { "gram", "lọ" };
		model.addAttribute("unitList", unitList);

		Map<Boolean, String> map = new HashMap<Boolean, String>();
		map.put(false, "Không");
		map.put(true, "Có");
		model.addAttribute("selectList", map);
		model.addAttribute("pagedListHolder", pagedListHolder);
		return "admin/product";
	}

	@RequestMapping(value = "index", method = RequestMethod.POST, params = "btnAdd")
	public String addProduct(HttpServletRequest request, ModelMap model, @ModelAttribute("product") Product product,
			@RequestParam("image") MultipartFile image, HttpSession session)
			throws IllegalStateException, IOException, InterruptedException {
		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null) return "user/login";
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer cus = getCustomer(userLogin.getId());
		model.addAttribute("customer", cus);
		// AddProduct
		product.setCreatedAt(new Date());
//		int result = addProduct(product);

//		// AddImage
////		Image img = new Image();
//		img.setProduct(product);
////		String date = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyMMddHHmmss-"));
//		img.setUrl(date+image.getOriginalFilename());
//		
//		List<Image> imgs = new ArrayList<Image>();
//		imgs.add(img);
//		product.setImages( imgs );
//		
//		int result2 = addImage(img);

		// Upload Image
//		String preImage = (String) session.getAttribute("urlImage");
//		String photoPath = context.getRealPath("/resources/images/" + date + image.getOriginalFilename());
//		if(preImage==photoPath) {
//			image.transferTo(new File(photoPath));
//		}
//		

		String date = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyMMddHHmmss-"));
		String newImage = date + image.getOriginalFilename();
		Image img = new Image();
		img.setProduct(product);
		img.setUrl(newImage);
		String photoPath = context.getRealPath("/resources/images/" + newImage);
		image.transferTo(new File(photoPath));
		int result = addProduct(product);
		int result2 = addImage(img);

//		int result = editProduct(product);

		if (result == 1 && result2 == 1) {
			model.addAttribute("message", "Thêm sản phẩm thành công!");
		} else {
			model.addAttribute("message", "Thêm sản phẩm thất bại!");
		}

		List<Product> products = getProducts();
		PagedListHolder pagedListHolder = new PagedListHolder(products);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(5);
		model.addAttribute("btnStatus", "btnAdd");
		Product pr = new Product();
		pr.setManufacturingDate(new Date());
		model.addAttribute("product", pr);
		model.addAttribute("branchList", getBranchs());
		model.addAttribute("categoryList", getCategories());
		model.addAttribute("suppliers", getSuppliers() );
		String[] unitList = { "gram", "lọ" };
		model.addAttribute("unitList", unitList);

		Map<Boolean, String> map = new HashMap<Boolean, String>();
		map.put(false, "Không");
		map.put(true, "Có");
		model.addAttribute("selectList", map);

		model.addAttribute("pagedListHolder", pagedListHolder);
		Thread.sleep(2500);
		return "admin/product";
	}

	@RequestMapping(value = "index", params = "btnEdit")
	public String editProduct(HttpServletRequest request, ModelMap model, @ModelAttribute("product") Product product,
			@RequestParam("image") MultipartFile image, HttpSession session)
			throws IllegalStateException, IOException, InterruptedException {
		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null) return "user/login";
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer cus = getCustomer(userLogin.getId());
		model.addAttribute("customer", cus);

		product.setUpdatedAt(new Date());
		// Nếu sửa image thì sửa url của image rồi save image
		// Không sửa thì không save

//		String[] token = session.getAttribute("urlImage").toString().split("-");
//		System.out.println("Token0:"+token[0]+"|Token1:"+token[1]+"|");
//		System.out.println("compare:"+image.getOriginalFilename()+"|");
		if (image.getOriginalFilename().length() != 0) {
			String date = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyMMddHHmmss-"));
			String newImage = date + image.getOriginalFilename();
			Image img = getImage(product.getId());
			img.setUrl(newImage);
			String photoPath = context.getRealPath("/resources/images/" + newImage);
			image.transferTo(new File(photoPath));
			editImage(img);
		}

		int result = editProduct(product);
		if (result == 1) {
			model.addAttribute("message", "Sửa sản phẩm thành công!");
		} else {
			model.addAttribute("message", "Sửa sản phẩm thất bại!");
		}

		List<Product> products = getProducts();
		PagedListHolder pagedListHolder = new PagedListHolder(products);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(5);
		model.addAttribute("btnStatus", "btnAdd");

		Product pr = new Product();
		pr.setManufacturingDate(new Date());
		model.addAttribute("product", pr);

		model.addAttribute("branchList", getBranchs());
		model.addAttribute("categoryList", getCategories());
		String[] unitList = { "gram", "lọ" };
		model.addAttribute("suppliers", getSuppliers() );
		model.addAttribute("unitList", unitList);

		Map<Boolean, String> map = new HashMap<Boolean, String>();
		map.put(false, "Không");
		map.put(true, "Có");
		model.addAttribute("selectList", map);

		model.addAttribute("pagedListHolder", pagedListHolder);

		Thread.sleep(2500);

		return "admin/product";
	}

	@RequestMapping(value = "index/{id}", params = "linkDelete")
	public String deleteProduct(HttpServletRequest request, ModelMap model, @PathVariable("id") int id,
			@ModelAttribute("product") Product product, HttpSession session) {
		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null) return "user/login";
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer cus = getCustomer(userLogin.getId());
		model.addAttribute("customer", cus);
		Image img = getImage(id);
		deleteImage(img);
		product = getProduct(id);
		int result = deleteProduct(product);
		if (result == 1) {
			model.addAttribute("message", "Xóa phẩm thành công!");
		} else {
			model.addAttribute("message", "Xóa sản phẩm thất bại!");
		}

		List<Product> products = getProducts();
		PagedListHolder pagedListHolder = new PagedListHolder(products);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(5);
		model.addAttribute("btnStatus", "btnAdd");
		Product pr = new Product();
		pr.setManufacturingDate(new Date());
		model.addAttribute("product", pr);
		model.addAttribute("branchList", getBranchs());
		model.addAttribute("categoryList", getCategories());
		model.addAttribute("suppliers", getSuppliers() );
		String[] unitList = { "gram", "lọ" };
		model.addAttribute("unitList", unitList);

		Map<Boolean, String> map = new HashMap<Boolean, String>();
		map.put(false, "Không");
		map.put(true, "Có");
		model.addAttribute("selectList", map);

		model.addAttribute("pagedListHolder", pagedListHolder);

		return "admin/product";
	}

	private List<Product> getProducts() {
		Session session = factory.getCurrentSession();
		String hql = "FROM Product";
		Query query = session.createQuery(hql);
		return query.list();
	}

	private Product getProduct(int id) {
		Session session = factory.openSession();
		String hql = "FROM Product where id =:id";
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		Product p = (Product) query.list().get(0);
		session.close();
		return p;
	}

	private List<Branch> getBranchs() {
		Session session = factory.getCurrentSession();
		String hql = "FROM Branch";
		Query query = session.createQuery(hql);
		return query.list();
	}

	private List<Category> getCategories() {
		Session session = factory.getCurrentSession();
		String hql = "FROM Category";
		Query query = session.createQuery(hql);
		return query.list();
	}

	private int addProduct(Product product) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.save(product);
			t.commit();
		} catch (Exception e) {
			t.rollback();
			System.out.println("Error add Product:");
			System.out.println(e);
			return 0;
		} finally {
			session.close();
		}
		return 1;
	}

	private int editProduct(Product product) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.update(product);
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

	private int deleteProduct(Product product) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.delete(product);
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

	private int addImage(Image img) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.save(img);
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

	private int deleteImage(Image img) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.delete(img);
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

	private int editImage(Image img) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.update(img);
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

	private Image getImage(int productId) {
		Session session = factory.openSession();
		String hql = "FROM Image where productId =:productId";
		Query query = session.createQuery(hql);
		query.setParameter("productId", productId);
		Image p = (Image) query.list().get(0);
		session.close();
		return p;
	}

	private Customer getCustomer(int idUser) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Customer c WHERE c.userId =:idUser";
		Query query = session.createQuery(hql);
		query.setParameter("idUser", idUser);
		return (Customer) query.list().get(0);
	}
	private List<Supplier> getSuppliers() {
		Session session = factory.getCurrentSession();
		String hql = "FROM Supplier";
		Query query = session.createQuery(hql);
		return  query.list();
	}
	private List<Product> searchProducts(String str) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Product WHERE name LIKE :str OR id = :id";
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
}
