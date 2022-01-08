package ptithcm.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="Images")
public class Image {
	@Id
	@GeneratedValue
	@Column(name="Id")
	private Integer id;
	
	@Column(name="Url")
	private String url;
	
	@ManyToOne
	@JoinColumn(name="ProductId")
	private Product product;

	public Integer getId() {
		return id;
	}

	public Image() {
		super();
	}

	public Image(Integer id, String url, Product product) {
		super();
		this.id = id;
		this.url = url;
		this.product = product;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}
}