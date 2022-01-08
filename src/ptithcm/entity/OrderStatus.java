package ptithcm.entity;

import java.util.Collection;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="OrderStatus")
public class OrderStatus {
	
	@GeneratedValue
	@Id
	@Column(name="Id")
	private Integer id;
	
	@Column(name="Status")
	private String status;

	@OneToMany(mappedBy="orderStatus",fetch=FetchType.EAGER)
	private Collection<Order> orders;
	
	public OrderStatus() {
		super();
	}

	public OrderStatus(Integer id, String status) {
		super();
		this.id = id;
		this.status = status;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	
}