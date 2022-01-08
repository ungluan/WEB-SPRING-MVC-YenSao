package ptithcm.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="Users")
public class User {
	@Id
	@GeneratedValue
	@Column(name="Id")
	private Integer id;
	@Column(name="Email")
	private String email;
	@Column(name="Password")
	private String password;
	@Column(name="Role")
	private String role;
	@Column(name="Enable")
	private Boolean enable;
	
	public User() {
		super();
		// TODO Auto-generated constructor stub
	}
	public User(Integer id, String email, String password, String role, Boolean enable) {
		super();
		this.id = id;
		this.email = email;
		this.password = password;
		this.role = role;
		this.enable = enable;
	}
	public Boolean getEnable() {
		return enable;
	}
	public void setEnable(Boolean enable) {
		this.enable = enable;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getRole() {
		return role.trim();
	}
	public void setRole(String role) {
		this.role = role;
	}
	
}
