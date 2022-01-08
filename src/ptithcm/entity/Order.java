package ptithcm.entity;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "Orders")
public class Order {
	@Id
	@GeneratedValue
	@Column(name = "Id")
	private int id;
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Column(name = "Date")
	private Date date;
	@Column(name = "CustomerId")
	private int customerId;
	@Column(name = "Total")
	private float total;
	@Column(name = "Address")
	private String address;
	@Column(name = "Name")
	private String name;
	@Column(name = "NumberPhone")
	private String numberPhone;

	@ManyToOne
	@JoinColumn(name = "OrderStatusId")
	private OrderStatus orderStatus;

	@OneToMany(mappedBy = "order", fetch = FetchType.EAGER)
	private List<OrderDetail> orderDetails;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public int getCustomerId() {
		return customerId;
	}

	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}

	public OrderStatus getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(OrderStatus orderStatus) {
		this.orderStatus = orderStatus;
	}

	public float getTotal() {
		return total;
	}

	public void setTotal(float total) {
		this.total = total;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNumberPhone() {
		return numberPhone;
	}

	public void setNumberPhone(String numberPhone) {
		this.numberPhone = numberPhone;
	}

	public List<OrderDetail> getOrderDetails() {
		return orderDetails;
	}

	public void setOrderDetails(List<OrderDetail> orderDetails) {
		this.orderDetails = orderDetails;
	}

	public Order(int id, Date date, int customerId, float total, String address, String name, String numberPhone,
			OrderStatus orderStatus, List<OrderDetail> orderDetails) {
		super();
		this.id = id;
		this.date = date;
		this.customerId = customerId;
		this.total = total;
		this.address = address;
		this.name = name;
		this.numberPhone = numberPhone;
		this.orderStatus = orderStatus;
		this.orderDetails = orderDetails;
	}

	public Order() {
		super();
	}

	public Order(OrderStatus orderStatus) {
		super();
		this.orderStatus = orderStatus;
	}

}
