package ptithcm.controller.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Hibernate;
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
import org.springframework.web.servlet.view.RedirectView;

import javassist.expr.NewArray;
import net.sf.ehcache.hibernate.HibernateUtil;
import ptithcm.entity.Branch;
import ptithcm.entity.Customer;
import ptithcm.entity.User;

@Controller
@Transactional
@RequestMapping("branch/")
public class BranchController {
	@Autowired
	SessionFactory factory;

	@RequestMapping("index")
	public String index(HttpServletRequest request, ModelMap model, @ModelAttribute("br") Branch br, HttpSession session ) {
		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null)	return "user/login";
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer customer = getCustomer(userLogin.getId());
		model.addAttribute("customer",customer);
		
		List<Branch> branchs = this.getBranchs();
		PagedListHolder pagedListHolder = new PagedListHolder(branchs);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(5);
		model.addAttribute("btnStatus", "btnAdd");
		model.addAttribute("pagedListHolder", pagedListHolder);
		return "admin/branch/branch";
	}

	@RequestMapping(value = "index/{id}", params = "linkEdit")
	public String index(ModelMap model, HttpServletRequest request,
			@PathVariable("id") int id, @ModelAttribute("br") Branch br, HttpSession session) {

		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null)	return "user/login";
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer customer = getCustomer(userLogin.getId());
		model.addAttribute("customer",customer);
		
		model.addAttribute("br",getBranch(id));	
		List<Branch> branchs = this.getBranchs();
		PagedListHolder pagedListHolder = new PagedListHolder(branchs);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(5);
		model.addAttribute("btnStatus", "btnEdit");
		model.addAttribute("pagedListHolder", pagedListHolder);

		return "admin/branch/branch";
	}
	@RequestMapping(value = "index/{id}", method=RequestMethod.POST, params="btnEdit")
	public String updateBranch(ModelMap model, HttpServletRequest request, 
			@ModelAttribute("br") Branch br, @PathVariable("id") int id, HttpSession session) {
		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null)	return "user/login";
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer customer = getCustomer(userLogin.getId());
		model.addAttribute("customer",customer);
		
		int result = editBranch(br);
		if(result==1) {
			model.addAttribute("message","Sửa tên thương hiệu thành công!");
		}else {
			model.addAttribute("message","Sửa tên thương hiệu thất bại!");
		}
		
		List<Branch> branchs = this.getBranchs();
		PagedListHolder pagedListHolder = new PagedListHolder(branchs);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(5);
		model.addAttribute("br", new Branch());
		model.addAttribute("btnStatus", "btnAdd");
		model.addAttribute("pagedListHolder", pagedListHolder);
		
		return "admin/branch/branch";
	}
	@RequestMapping(value = "index", method=RequestMethod.POST, params="btnAdd")
	public String addBranch(ModelMap model, HttpServletRequest request, 
			@ModelAttribute("br") Branch br, HttpSession session) {
		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null)	return "user/login";
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer customer = getCustomer(userLogin.getId());
		model.addAttribute("customer",customer);
		
		
		if(checkBranch(br.getName())==1) {
			model.addAttribute("message","Tên thương hiệu đã tồn tại!");
			List<Branch> branchs = this.getBranchs();
			PagedListHolder pagedListHolder = new PagedListHolder(branchs);
			int page = ServletRequestUtils.getIntParameter(request, "p", 0);
			pagedListHolder.setPage(page);
			pagedListHolder.setMaxLinkedPages(5);
			pagedListHolder.setPageSize(5);
			model.addAttribute("btnStatus", "btnAdd");
			model.addAttribute("pagedListHolder", pagedListHolder);
			return "admin/branch/branch";
		}
		
		int result = addBranch(br);
		if(result==1) {
			model.addAttribute("message","Thêm thương hiệu thành công!");
		}else {
			model.addAttribute("message","Thêm thương hiệu thất bại!");
		}
		
		List<Branch> branchs = this.getBranchs();
		PagedListHolder pagedListHolder = new PagedListHolder(branchs);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(5);
		model.addAttribute("br", new Branch());
		model.addAttribute("btnStatus","btnAdd");
		model.addAttribute("pagedListHolder", pagedListHolder);
		
		
		return  "admin/branch/branch";
	}
	@RequestMapping(value = "index/{id}", params = "linkDelete")
	public String deleteBranch(ModelMap model, HttpServletRequest request,
			@PathVariable("id") int id, @ModelAttribute("br") Branch br, HttpSession session) {
		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null)	return "user/login";
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer customer = getCustomer(userLogin.getId());
		model.addAttribute("customer",customer);
		
		int result  = deleteBranch(br);
		if(result==1) {
			model.addAttribute("message","Xóa thương hiệu thành công!");
		}else {
			model.addAttribute("message","Xóa thương hiệu thất bại!");
		}
		List<Branch> branchs = this.getBranchs();
		PagedListHolder pagedListHolder = new PagedListHolder(branchs);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(5);
		model.addAttribute("btnStatus", "btnAdd");
		model.addAttribute("pagedListHolder", pagedListHolder);
 
		return "admin/branch/branch";
	}
	@RequestMapping(value="index", params="btnSearch")
	public String searchUsers(HttpServletRequest request, ModelMap model, @ModelAttribute("br") Branch br, HttpSession session) {
		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null)	return "user/login";
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer customer = getCustomer(userLogin.getId());
		model.addAttribute("customer",customer);
		
		List<Branch> branchs = searchBranchs(request.getParameter("searchInput"));
		PagedListHolder pagedListHolder = new PagedListHolder(branchs);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(5);
		pagedListHolder.setPageSize(5);
		model.addAttribute("btnStatus", "btnAdd");
		model.addAttribute("pagedListHolder", pagedListHolder);
		return "admin/branch/branch";
	}
	private List<Branch> getBranchs() {
		Session session = factory.getCurrentSession();
		String hql = "FROM Branch";
		Query query = session.createQuery(hql);
		return query.list();
	}

	private int editBranch(Branch branch) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.update(branch);
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
	private int addBranch(Branch branch) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.save(branch);
			t.commit();
		} catch (Exception e) {
			t.rollback();
			return 0;
		} finally {
			session.close();
		}
		return 1;
	}
	private int deleteBranch(Branch branch) {
		
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();

		try {
			session.delete(branch);
			t.commit();
		} catch (Exception e) {
			t.rollback();
			return 0;
		} finally {
			session.close();
		}
		return 1;
	}
	private int checkBranch(String name) {
		List<Branch> list = getBranchs();
		for(int i=0; i<list.size(); i++) {
			if(list.get(i).getName().toLowerCase().trim().equals(name.toLowerCase().trim())) return 1;
		}
		return 0;
	}
	private Branch getBranch(int id) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Branch b where b.id = :id";
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		return (Branch) query.list().get(0);
	}
	private List<Branch> searchBranchs(String str){
		Session session = factory.getCurrentSession();
		String hql = "FROM Branch WHERE name LIKE :branchName or id = :id ";
		Query query = session.createQuery(hql);
		int id ;
		try {
			id = Integer.parseInt(str);
		} catch (Exception e) {
			id = -1;
		}
		query.setParameter("branchName", "%"+str+"%");
		query.setParameter("id", id);
		return query.list();
	}
	private Customer getCustomer(int idUser) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Customer c WHERE c.userId =:idUser";
		Query query = session.createQuery(hql);
		query.setParameter("idUser", idUser);
		return (Customer) query.list().get(0);
	}
}
