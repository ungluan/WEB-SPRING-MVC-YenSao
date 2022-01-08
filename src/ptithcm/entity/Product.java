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
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.AccessType;
import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "Products")
public class Product {
	@Id
	@GeneratedValue
	@Column(name = "Id")
	private Integer id;

	@Column(name = "Name")
	private String name;

	@Column(name = "Description")
	private String description;

	@Column(name = "Detail")
	private String detail;

	@Column(name = "Highlight")
	private boolean highlight;

	@Column(name = "NewProduction")
	private boolean newProduction;

	@Column(name = "Sale")
	private Double sale;

	@Column(name = "Price")
	private Double price;

	@Column(name = "Unit")
	private String unit;
	

	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Column(name = "CreatedAt")
	private Date createdAt;

	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Column(name = "UpdatedAt")
	private Date updatedAt;

	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Column(name = "ManufacturingDate")
	private Date manufacturingDate;

	@Column(name = "Expiry")
	private int expiry;

	@ManyToOne
	@JoinColumn(name = "BranchId")
	private Branch branch;

	@ManyToOne
	@JoinColumn(name = "CategoryId")
	private Category category;

	@Column(name = "Weight")
	private Integer weight;

	@Column(name = "Origin")
	private String origin;

	@OneToMany(mappedBy = "product", fetch = FetchType.EAGER)
	private List<Image> images;

	@OneToMany(mappedBy = "product", fetch = FetchType.EAGER)
	private List<OrderDetail> orderDetails;
	
	@ManyToOne
	@JoinColumn(name = "supplierId")
	private Supplier supplier;

//	@OneToMany(mappedBy = "productOrder", fetch = FetchType.EAGER)
//	private List<OrderDetail> orderDetails;

	public List<OrderDetail> getOrderDetails() {
		return orderDetails;
	}


	public void setOrderDetails(List<OrderDetail> orderDetails) {
		this.orderDetails = orderDetails;
	}

	public String getOrigin() {
		return origin;
	}

	public void setOrigin(String origin) {
		this.origin = origin;
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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public boolean isHighlight() {
		return highlight;
	}

	public void setHighlight(boolean highlight) {
		this.highlight = highlight;
	}

	public boolean isNewProduction() {
		return newProduction;
	}

	public void setNewProduction(boolean newProduction) {
		this.newProduction = newProduction;
	}

	public Double getSale() {
		return sale;
	}

	public void setSale(Double sale) {
		this.sale = sale;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}

	public Branch getBranch() {
		return branch;
	}

	public void setBranch(Branch branch) {
		this.branch = branch;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public Integer getWeight() {
		return weight;
	}

	public void setWeight(Integer weight) {
		this.weight = weight;
	}

	public List<Image> getImages() {
		return images;
	}

	public void setImages(List<Image> images) {
		this.images = images;
	}
	
	
	

	public Product(Integer id, String name, String description, String detail, boolean highlight, boolean newProduction,
			Double sale, Double price, String unit, Date createdAt, Date updatedAt, Date manufacturingDate, int expiry,
			Branch branch, Category category, Integer weight, String origin, List<Image> images,
			List<OrderDetail> orderDetails, Supplier supplier) {
		super();
		this.id = id;
		this.name = name;
		this.description = description;
		this.detail = detail;
		this.highlight = highlight;
		this.newProduction = newProduction;
		this.sale = sale;
		this.price = price;
		this.unit = unit;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
		this.manufacturingDate = manufacturingDate;
		this.expiry = expiry;
		this.branch = branch;
		this.category = category;
		this.weight = weight;
		this.origin = origin;
		this.images = images;
		this.orderDetails = orderDetails;
		this.supplier = supplier;
	}


	public Supplier getSupplier() {
		return supplier;
	}


	public void setSupplier(Supplier supplier) {
		this.supplier = supplier;
	}


	public Date getManufacturingDate() {
		return manufacturingDate;
	}

	public void setManufacturingDate(Date manufacturingDate) {
		this.manufacturingDate = manufacturingDate;
	}

	public int getExpiry() {
		return expiry;
	}

	public void setExpiry(int expiry) {
		this.expiry = expiry;
	}

	public Product() {
		super();
	}

	public String getFirstImagePath() {
		Image img = getImages().get(0);
		if (img == null)
			return "";
		return img.getUrl().trim();
	}
}
