package com.hp.admin.domain;

import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class CourierCommand {
	private String order_code;
	private String courier_company;
	private String courier_number;
	private String courier_status;
	private Date courier_date;
	public String getOrder_code() {
		return order_code;
	}
	public void setOrder_code(String order_code) {
		this.order_code = order_code;
	}
	public String getCourier_company() {
		return courier_company;
	}
	public void setCourier_company(String courier_company) {
		this.courier_company = courier_company;
	}
	public String getCourier_number() {
		return courier_number;
	}
	public void setCourier_number(String courier_number) {
		this.courier_number = courier_number;
	}
	public String getCourier_status() {
		return courier_status;
	}
	public void setCourier_status(String courier_status) {
		this.courier_status = courier_status;
	}
	public Date getCourier_date() {
		return courier_date;
	}
	public void setCourier_date(Date courier_date) {
		this.courier_date = courier_date;
	}
	@Override
	public String toString() {
		return "CourierCommand [order_code=" + order_code + ", courier_company=" + courier_company + ", courier_number="
				+ courier_number + ", courier_status=" + courier_status + ", courier_date=" + courier_date + "]";
	}
	
	
}