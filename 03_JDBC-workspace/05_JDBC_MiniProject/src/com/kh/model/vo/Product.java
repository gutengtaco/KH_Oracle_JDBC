package com.kh.model.vo;

public class Product {
	
	//필드부
	private String productId;// PRODUCT_ID VARCHAR2(20) PRIMARY KEY,
	private String productName;   // PRODUCT_NAME VARCHAR2(20) NOT NULL,
	private int price;    // PRICE NUMBER NOT NULL,
	private String description;    // DESCRIPTION VARCHAR2(20),
	private int stock;    // STOCK NUMBER NOT NULL
	
	
	// 생성자부
	// 기본생성자
	public Product() {
		super();
	}


	// 매개변수생성자
	public Product(String productId, String productName, int price, String description, int stock) {
		super();
		this.productId = productId;
		this.productName = productName;
		this.price = price;
		this.description = description;
		this.stock = stock;
	}


	// 메소드부
	// getter, setter
	public String getProductId() {
		return productId;
	}


	public void setProductId(String productId) {
		this.productId = productId;
	}


	public String getProductName() {
		return productName;
	}


	public void setProductName(String productName) {
		this.productName = productName;
	}


	public int getPrice() {
		return price;
	}


	public void setPrice(int price) {
		this.price = price;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}


	public int getStock() {
		return stock;
	}


	public void setStock(int stock) {
		this.stock = stock;
	}


	// toString
	@Override
	public String toString() {
		return "Product [productId=" + productId + ", productName=" + productName + ", price=" + price
				+ ", description=" + description + ", stock=" + stock + "]";
	}
	
	
	
}
