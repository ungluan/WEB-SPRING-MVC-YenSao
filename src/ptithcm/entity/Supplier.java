package ptithcm.entity;

import java.util.Collection;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="Suppliers")
public class Supplier {
	
	@GeneratedValue
	@Id
	@Column(name="Id")
	private Integer id;
	@Column(name="Name")
	private String name;
	@Column(name="Address")
	private String address;
	@Column(name="Phone")
	private String phone;
	
	@OneToMany(mappedBy="supplier",fetch=FetchType.EAGER)
	private Collection<Product> products;
	
	public Supplier() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Supplier(Integer id, String name, String address, String phone) {
		super();
		this.id = id;
		this.name = name;
		this.address = address;
		this.phone = phone;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
}