package ptithcm.controller.admin;

import java.util.ArrayList;
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
import ptithcm.entity.Supplier;
import ptithcm.entity.User;

@Controller
@Transactional
@RequestMapping("supplier/")
public class SupplierController {

	@Autowired
	SessionFactory factory;

	@RequestMapping("index")
	public String index(ModelMap model, HttpServletRequest request, HttpSession session) {
		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null)	return "user/login";
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer customer = getCustomer(userLogin.getId()); 
		model.addAttribute("customer", customer);

		List<Supplier> suppliers = getSuppliers() ;
		PagedListHolder pagedListHolder = new PagedListHolder(suppliers);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(5);
		model.addAttribute("btnStatus", "btnAdd");
		model.addAttribute("supplier", new Supplier());
		model.addAttribute("pagedListHolder", pagedListHolder);
		return "admin/supplier";
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

		List<Supplier> suppliers = getSuppliers();
		PagedListHolder pagedListHolder = new PagedListHolder(suppliers);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(5);
		model.addAttribute("btnStatus", "btnEdit");
		model.addAttribute("supplier", getSupplier(id));
		model.addAttribute("pagedListHolder", pagedListHolder);
		return "admin/supplier";
	}

	@RequestMapping(value = "index", params = "btnAdd")
	public String addStatus(ModelMap model, HttpServletRequest request, 
			@ModelAttribute("supplier") Supplier supplier, HttpSession session) {

		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null)	return "user/login";
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer customer = getCustomer(userLogin.getId());
		model.addAttribute("customer", customer);

		int result = addSupplier(supplier);

		if (result == 1) {
			model.addAttribute("message", "Thêm nhà cung cấp thành công!");
		} else {
			model.addAttribute("message", "Thêm nhà cung cấp thất bại!");
		}

		List<Supplier> suppliers = getSuppliers();
		PagedListHolder pagedListHolder = new PagedListHolder(suppliers);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(5);
		model.addAttribute("btnStatus", "btnAdd");
		model.addAttribute("supplier", new Supplier());
		model.addAttribute("pagedListHolder", pagedListHolder);
		return "admin/supplier";
	}

	@RequestMapping(value = "index/{id}", method = RequestMethod.POST, params = "btnEdit")
	public String editStatus(ModelMap model, HttpServletRequest request, 
			@ModelAttribute("supplier") Supplier supplier,
			@PathVariable("id") int id, HttpSession session) {

		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null)	return "user/login"; 
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer customer = getCustomer(userLogin.getId());
		model.addAttribute("customer", customer);

		int result = editSupplier(supplier);

		if (result == 1) {
			model.addAttribute("message", "Chỉnh sửa nhà cung cấp đơn hàng thành công!");
		} else {
			model.addAttribute("message", "Chỉnh sửa nhà cung cấp đơn hàng thất bại!");
		}

		List<Supplier> suppliers = getSuppliers();
		PagedListHolder pagedListHolder = new PagedListHolder(suppliers);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(5);
		model.addAttribute("btnStatus", "btnAdd");
		model.addAttribute("supplier", new Supplier());
		model.addAttribute("pagedListHolder", pagedListHolder);
		return "admin/supplier";
	}

	@RequestMapping(value = "index/{id}", params = "linkDelete")
	public String deleteOrder(HttpServletRequest request, ModelMap model, @PathVariable("id") int id,
			HttpSession session) {

		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null)	return "user/login"; 
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer customer = getCustomer(userLogin.getId());
		model.addAttribute("customer", customer);

		Supplier supplier = getSupplier(id);

		int result = deleteSupplier(supplier);
		if (result == 1) {
			model.addAttribute("message", "Xóa nhà cung cấp thành công!");
		} else {
			model.addAttribute("message", "Xóa nhà cung cấp thất bại!");
		}

		List<Supplier> suppliers = getSuppliers();
		PagedListHolder pagedListHolder = new PagedListHolder(suppliers);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(5);
		model.addAttribute("btnStatus", "btnAdd");
		model.addAttribute("supplier", new Supplier());
		model.addAttribute("pagedListHolder", pagedListHolder);

		return "admin/supplier";
	}

	@RequestMapping(value = "index", params = "btnSearch")
	public String search(ModelMap model, HttpServletRequest request, @ModelAttribute("supplier") Supplier supplier,
			HttpSession session) {

		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null)	return "user/login"; 
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer customer = getCustomer(userLogin.getId());
		model.addAttribute("customer", customer);

		List<Supplier> suppliers = searchSuppliers(request.getParameter("searchInput"));

		PagedListHolder pagedListHolder = new PagedListHolder(suppliers);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(5);
		model.addAttribute("btnStatus", "btnAdd");
		model.addAttribute("supplier", new Supplier());
		model.addAttribute("pagedListHolder", pagedListHolder);

		return "admin/supplier";
	}

	private List<Supplier> getSuppliers() {
		Session session = factory.getCurrentSession();
		String hql = "FROM Supplier";
		Query query = session.createQuery(hql);
		return query.list();
	}

	private List<Supplier> searchSuppliers(String str) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Supplier where name LIKE :name OR id =:str ";
		Query query = session.createQuery(hql);
		query.setParameter("name", "%" + str + "%");
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

	private Supplier getSupplier(int id) {
		Session session = factory.openSession();
		String hql = "FROM Supplier where id =:id ";
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		Supplier c = (Supplier) query.list().get(0);
		session.close();
		return c;
	}

	private int addSupplier(Supplier supplier) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.save(supplier);
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

	private int editSupplier(Supplier supplier) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.update(supplier);
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

	private int deleteSupplier(Supplier supplier) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.delete(supplier);
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