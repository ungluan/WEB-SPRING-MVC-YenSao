package ptithcm.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="OrderDetails")
public class OrderDetail {
	@Id
	@GeneratedValue
	@Column(name="Id")
	private int id;
	
	@ManyToOne()
	@JoinColumn(name="orderId")
	private Order order;
	
	
	@ManyToOne()
	@JoinColumn(name="productId")
	private Product product;
	
	@Column(name="Numbers")
	private int numbers;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public int getNumbers() {
		return numbers;
	}

	public void setNumbers(int numbers) {
		this.numbers = numbers;
	}

	public OrderDetail(int id, Order order, Product product, int numbers) {
		super();
		this.id = id;
		this.order = order;
		this.product = product;
		this.numbers = numbers;
	}
	
	public OrderDetail() {
		super();
	}
}
