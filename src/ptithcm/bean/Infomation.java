package ptithcm.bean;

import ptithcm.entity.Customer;
import ptithcm.entity.User;

public class Infomation {
	private User user;
	private Customer customer;
	public User getUser() {
		return user;
	}
	
	
	
	public Infomation() {
		super();
		// TODO Auto-generated constructor stub
	}



	public Infomation(User user, Customer customer) {
		super();
		this.user = user;
		this.customer = customer;
	}



	public void setUser(User user) {
		this.user = user;
	}
	public Customer getCustomer() {
		return customer;
	}
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	
}
