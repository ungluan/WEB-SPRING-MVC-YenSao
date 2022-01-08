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

import ptithcm.entity.Branch;
import ptithcm.entity.Category;
import ptithcm.entity.Customer;
import ptithcm.entity.User;

@Controller
@Transactional
@RequestMapping("category/")
public class CategoryController {
	@Autowired
	SessionFactory factory;

	@RequestMapping("index")
	public String index(ModelMap model, HttpServletRequest request, @ModelAttribute("cate") Category cate, HttpSession session) {
		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null)	return "user/login";
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer customer = getCustomer(userLogin.getId());
		model.addAttribute("customer",customer);
		
		
		List<Category> categories = getCategories();
		PagedListHolder pagedListHolder = new PagedListHolder(categories);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(5);
		model.addAttribute("btnStatus", "btnAdd");
		model.addAttribute("pagedListHolder", pagedListHolder);
		return "admin/category/category";
	}

	@RequestMapping(value = "index/{id}", params = "linkEdit")
	public String index(ModelMap model, HttpServletRequest request, @ModelAttribute("cate") Category cate,
			@PathVariable("id") int id, HttpSession session) {
		
		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null)	return "user/login";
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer customer = getCustomer(userLogin.getId());
		model.addAttribute("customer",customer);
		
		List<Category> categories = getCategories();
		PagedListHolder pagedListHolder = new PagedListHolder(categories);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(5);
		model.addAttribute("btnStatus", "btnEdit");
		model.addAttribute("cate", getCategory(id));
		model.addAttribute("pagedListHolder", pagedListHolder);
		return "admin/category/category";
	}

	@RequestMapping(value = "index", params = "btnAdd")
	public String addCategory(ModelMap model, HttpServletRequest request, @ModelAttribute("cate") Category cate, HttpSession session) {

		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null)	return "user/login";
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer customer = getCustomer(userLogin.getId());
		model.addAttribute("customer",customer);
		
		int result = addCategory(cate);

		if (result == 1) {
			model.addAttribute("message", "Thêm loại sản phẩm thành công!");
		} else {
			model.addAttribute("message", "Thêm loại sản phẩm thất bại!");
		}


		List<Category> categories = getCategories();
		PagedListHolder pagedListHolder = new PagedListHolder(categories);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(5);
		model.addAttribute("btnStatus", "btnAdd");
		model.addAttribute("cate", new Category());
		model.addAttribute("pagedListHolder", pagedListHolder);
		return "admin/category/category";
	}
	@RequestMapping(value = "index/{id}", method=RequestMethod.POST,params = "btnEdit")
	public String addCategory(
			ModelMap model, HttpServletRequest request, 
			@ModelAttribute("cate") Category cate, @PathVariable("id") int id, HttpSession session) {

		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null)	return "user/login";
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer customer = getCustomer(userLogin.getId());
		model.addAttribute("customer",customer);
		
		int result = editCategory(cate);

		if (result == 1) {
			model.addAttribute("message", "Chỉnh sửa loại sản phẩm thành công!");
		} else {
			model.addAttribute("message", "Chỉnh sửa loại sản phẩm thất bại!");
		}

		List<Category> categories = getCategories();
		PagedListHolder pagedListHolder = new PagedListHolder(categories);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(5);
		model.addAttribute("btnStatus", "btnAdd");
		model.addAttribute("cate", new Category());
		model.addAttribute("pagedListHolder", pagedListHolder);
		return "admin/category/category";
	}
	@RequestMapping(value="index/{id}", params="linkDelete")
	public String deleteCategory(HttpServletRequest request, ModelMap model, @PathVariable("id") int id,HttpSession session) {
		
//		int result = deleteCate(getCategory(id));

		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null)	return "user/login";
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer customer = getCustomer(userLogin.getId());
		model.addAttribute("customer",customer);
		
		Category c = getCategory(id);
		
		int result = deleteCate(c);
		
		if(result==1) {
			model.addAttribute("message","Xóa loại sản phẩm thành công!");
		}else {
			model.addAttribute("message","Xóa loại sản phẩm thất bại!");
		}
		
		List<Category> categories = getCategories();
		PagedListHolder pagedListHolder = new PagedListHolder(categories);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(5);
		model.addAttribute("btnStatus", "btnAdd");
		model.addAttribute("cate", new Category());
		model.addAttribute("pagedListHolder", pagedListHolder);
		
		return "admin/category/category";
	}
	@RequestMapping(value="index", params="btnSearch")
	public String search(ModelMap model, HttpServletRequest request, @ModelAttribute("cate") Category cate, HttpSession session) {
		
		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null)	return "user/login";
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer customer = getCustomer(userLogin.getId());
		model.addAttribute("customer",customer);
		
		List<Category> categories = searchCategories(request.getParameter("searchInput"));
		
		PagedListHolder pagedListHolder = new PagedListHolder(categories);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(5);
		model.addAttribute("btnStatus", "btnAdd");
		model.addAttribute("cate", new Category());
		model.addAttribute("pagedListHolder", pagedListHolder);
		
		return "admin/category/category";
	}
	private List<Category> getCategories() {
		Session session = factory.getCurrentSession();
		String hql = "FROM Category";
		Query query = session.createQuery(hql);
		return query.list();
	}
	private List<Category> searchCategories(String str){
		Session session = factory.getCurrentSession();
		String hql = "FROM Category where name LIKE :name or id = :id";
		Query query = session.createQuery(hql);
		int id ;
		try {
			id = Integer.parseInt(str);
		} catch (Exception e) {
			id = - 1;
		}
		query.setParameter("name", "%" +str+"%");
		query.setParameter("id", id);
		return query.list();
	}
	private Category getCategory(int id) {
		Session session = factory.openSession();
		String hql = "FROM Category c where c.id =:id ";
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		Category c = (Category) query.list().get(0);
		session.close();
		return c;
	}

	private int addCategory(Category category) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.save(category);
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
	
	private int editCategory(Category category) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.update(category);
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
	private int deleteCate(Category category) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.delete(category);
			t.commit();
			session.close();
		} catch (Exception e) {
			t.rollback();
			System.out.println(e);
			session.close();
			return 0;
		}
		finally {
//			session.close();
		}
		return 1;
	}
	private int checkCategory(String categoryName) {
		List<Category> list = getCategories();
		for (int i = 0; i < list.size(); i++) {
			if (list.get(i).getName().trim().toLowerCase().equals(categoryName.trim().toLowerCase()))
				return 1;
		}
		return 0;
	}
	private Customer getCustomer(int idUser) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Customer c WHERE c.userId =:idUser";
		Query query = session.createQuery(hql);
		query.setParameter("idUser", idUser);
		return (Customer) query.list().get(0);
	}
}
