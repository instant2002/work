package com.hp.admin.domain;

import java.sql.Date;

public class OrderCancelAdminCommand {
	private String order_code;
	private String tid;
	private String payment_status; //결제 단계를 표시 - N:미결제; W:결제대기; P:결제완료
	private String delivery_status; //배송 상태를 표시 - W:준비중; D:배송중; F:배송완료
	private Date delivery_date; //배송 상태를 표시 - W:준비중; D:배송중; F:배송완료
	private String refund_status; //환불 상태를 표시 - N:안함; R:환불 진행중; F:환불 완료
	private String user_id;
	private String canceler_tel;
	private String canceler_email;
	private String cancel_msg;
	private Date cancel_rquest_date;
	private Date cancel_success_date;
	private String isPayment;
	private String book_name;
	private String book_img_storedName;
	private int group_count;
	private int amount_payment;
	
	public String getOrder_code() {
		return order_code;
	}
	public void setOrder_code(String order_code) {
		this.order_code = order_code;
	}
	public String getTid() {
		return tid;
	}
	public void setTid(String tid) {
		this.tid = tid;
	}
	public String getPayment_status() {
		return payment_status;
	}
	public void setPayment_status(String payment_status) {
		this.payment_status = payment_status;
	}
	public String getDelivery_status() {
		return delivery_status;
	}
	public void setDelivery_status(String delivery_status) {
		this.delivery_status = delivery_status;
	}
	public Date getDelivery_date() {
		return delivery_date;
	}
	public void setDelivery_date(Date delivery_date) {
		this.delivery_date = delivery_date;
	}
	public String getRefund_status() {
		return refund_status;
	}
	public void setRefund_status(String refund_status) {
		this.refund_status = refund_status;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getCanceler_tel() {
		return canceler_tel;
	}
	public void setCanceler_tel(String canceler_tel) {
		this.canceler_tel = canceler_tel;
	}
	public String getCanceler_email() {
		return canceler_email;
	}
	public void setCanceler_email(String canceler_email) {
		this.canceler_email = canceler_email;
	}
	public String getCancel_msg() {
		return cancel_msg;
	}
	public void setCancel_msg(String cancel_msg) {
		this.cancel_msg = cancel_msg;
	}
	public Date getCancel_rquest_date() {
		return cancel_rquest_date;
	}
	public void setCancel_rquest_date(Date cancel_rquest_date) {
		this.cancel_rquest_date = cancel_rquest_date;
	}
	public Date getCancel_success_date() {
		return cancel_success_date;
	}
	public void setCancel_success_date(Date cancel_success_date) {
		this.cancel_success_date = cancel_success_date;
	}
	public String getIsPayment() {
		return isPayment;
	}
	public void setIsPayment(String isPayment) {
		this.isPayment = isPayment;
	}
	public String getBook_name() {
		return book_name;
	}
	public void setBook_name(String book_name) {
		this.book_name = book_name;
	}
	public String getBook_img_storedName() {
		return book_img_storedName;
	}
	public void setBook_img_storedName(String book_img_storedName) {
		this.book_img_storedName = book_img_storedName;
	}
	public int getGroup_count() {
		return group_count;
	}
	public void setGroup_count(int group_count) {
		this.group_count = group_count;
	}
	public int getAmount_payment() {
		return amount_payment;
	}
	public void setAmount_payment(int amount_payment) {
		this.amount_payment = amount_payment;
	}
	
	@Override
	public String toString() {
		return "CancelCommand [order_code=" + order_code + ", tid=" + tid + ", payment_status=" + payment_status
				+ ", delivery_status=" + delivery_status + ", delivery_date=" + delivery_date + ", refund_status="
				+ refund_status + ", user_id=" + user_id + ", canceler_tel=" + canceler_tel + ", canceler_email="
				+ canceler_email + ", cancel_msg=" + cancel_msg + ", cancel_rquest_date=" + cancel_rquest_date
				+ ", cancel_success_date=" + cancel_success_date + ", isPayment=" + isPayment + ", book_name="
				+ book_name + ", book_img_storedName=" + book_img_storedName + ", group_count=" + group_count
				+ ", amount_payment=" + amount_payment + "]";
	}

}
