package ptithcm.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="Customers")
public class Customer {
	@Id
	@GeneratedValue
	@Column(name="Id")
	private Integer id;
	@Column(name="Fullname")
	private String fullname;
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern="yyyy-MM-dd")
	@Column(name="Birthday")
	private Date birthday;
	@Column(name="Address")
	private String address;
	@Column(name="Gender")
	private String gender;
	@Column(name="UserId")
	private Integer userId;
	@Column(name="Phone")
	private String phone;
	public Customer() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Customer(Integer id, String fullname, Date birthday, String address, 
			String gender, Integer userId, String phone) {
		super();
		this.id = id;
		this.fullname = fullname;
		this.birthday = birthday;
		this.address = address;
		this.gender = gender;
		this.userId = userId;
		this.phone = phone;
	}
	
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getFullname() {
		return fullname;
	}
	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	public Date getBirthday() {
		return birthday;
	}
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	
	
}
