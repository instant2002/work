package com.hp.customer.domain;

public class CustomerCommand {
	private String product_no;
	private String quantity;
	private String user_id;
	
	public String getProduct_no() {
		return product_no;
	}
	public void setProduct_no(String product_no) {
		this.product_no = product_no;
	}
	public String getQuantity() {
		return quantity;
	}
	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	
	@Override
	public String toString() {
		return "CustomerCommand [product_no=" + product_no + ", quantity=" + quantity + ", user_id=" + user_id + "]";
	}
}
