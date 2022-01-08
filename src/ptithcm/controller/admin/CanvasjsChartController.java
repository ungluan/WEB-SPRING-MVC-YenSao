package ptithcm.controller.admin;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import ptithcm.entity.Customer;
import ptithcm.entity.User;

@Controller
@RequestMapping("/admin/")
public class CanvasjsChartController {
	@Autowired
	SessionFactory factory;

	@RequestMapping(value = "home", params = "btnSearch", method = RequestMethod.POST)
	public String chart(ModelMap model, HttpServletRequest request, HttpSession session) {
		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null)	return "user/login";
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer customer = getCustomer(userLogin.getId());
		model.addAttribute("customer",customer);
		
		String yearStr = request.getParameter("searchInput");
		int year;
		try {
			year = Integer.parseInt(yearStr);
		} catch (Exception e) {
			// TODO: handle exception
			year = new Date().getYear() + 1900;
		}
		List<List<Map<Object, Object>>> canvasjsChartData = new ArrayList<List<Map<Object, Object>>>();
		canvasjsChartData = data(year, canvasjsChartData);
		model.addAttribute("dataPointsList", canvasjsChartData);
		model.addAttribute("nam", year);
		model.addAttribute("years", getYears());
		model.addAttribute("total", sumMoney(year));
		return "admin/chart";
	}

	@RequestMapping(value = "home", method = RequestMethod.GET)
	public String chart(ModelMap model, HttpSession session) {
		User userLogin = (User) session.getAttribute("user");
		if (userLogin == null)	return "user/login";
		else if(userLogin.getRole().equals("USER")) return "user/index";
		Customer customer = getCustomer(userLogin.getId());
		model.addAttribute("customer",customer);
		
		int year = new Date().getYear() + 1900;
		List<List<Map<Object, Object>>> canvasjsChartData = new ArrayList<List<Map<Object, Object>>>();
		canvasjsChartData = data(2021, canvasjsChartData);
		model.addAttribute("dataPointsList", canvasjsChartData);
		model.addAttribute("nam", year);
		model.addAttribute("years", getYears());
		model.addAttribute("total", sumMoney(year));
		return "admin/chart";
	}

	private List<List<Map<Object, Object>>> data(int year, List<List<Map<Object, Object>>> canvasjsChartData) {

		Session session = factory.openSession();
		String hql = "Select month(date), SUM(total) FROM Order where year(date) = :year AND orderStatus.id =:id "
				+ "GROUP BY month(date)";
		Query query = session.createQuery(hql);
		query.setParameter("year", year);
		query.setParameter("id", 4);
		List<Object[]> results = (List<Object[]>) query.list();
		List<Map<Object, Object>> dataPoints1 = new ArrayList<Map<Object, Object>>();
		for (Object[] result : results) {
//			Integer t = (Integer) result[0] ;
//			Double m = (Double) result[1];
			Map<Object, Object> map = new HashMap<Object, Object>();
			map.put("x", result[0]);
			map.put("y", result[1]);
			dataPoints1.add(map);
		}
		canvasjsChartData.add(dataPoints1);
		return canvasjsChartData;
	}
	private int[] getYears() {
		int curYear = new Date().getYear();
		int[] list = new int[10];
		for (int i = 0; i < 10; i++) {
			list[i] = curYear - i;
		}
		return list;
	}

	private Double sumMoney(int year) {
		Session session = factory.openSession();
		String hql = "Select year(date), SUM(total) FROM Order where year(date) = :year AND orderStatus.id =:id "
				+ "GROUP BY year(date)";
		Query query = session.createQuery(hql);
		query.setParameter("year", year);
		query.setParameter("id", 4);
		Object[] results = (Object[]) query.uniqueResult();
		Double total ;
		if(results==null) total = 0.0;
		else total = (Double) results[1];
		return total;
	}
	private Customer getCustomer(int idUser) {
		Session session = factory.openSession();
		String hql = "FROM Customer c WHERE c.userId =:idUser";
		Query query = session.createQuery(hql);
		query.setParameter("idUser", idUser);
		Customer cus = (Customer) query.list().get(0);
		session.close();
		return cus;
	}
}
