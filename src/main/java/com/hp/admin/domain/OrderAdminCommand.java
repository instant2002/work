package com.hp.admin.domain;

import java.sql.Date;
import java.util.List;

import com.hp.order.domain.PaymentCommand;

public class OrderAdminCommand {
	private String product_no;
	private String quantity;
	private String order_code;
	private String tid;
	private String payment_status; //결제 단계를 표시 - N:미결제; W:결제대기; P:결제완료
	private String delivery_status; //배송 상태를 표시 - W:준비중; D:배송중; F:배송완료
	private Date delivery_date; //배송 상태를 표시 - W:준비중; D:배송중; F:배송완료
	private String refund_status; //환불 상태를 표시 - N:안함; R:환불 진행중; F:환불 완료
	private String user_id;
	private String buyername;
	private String buyeremail;
	private String recipientname;
	private String recipientemail;
	private String buyertel;
	private String recipienttel;
	private String buyertel2;
	private String recipienttel2;
	private String recipient_postnum;
	private String recipient_address1;
	private String recipient_address2;
	private String buyer_memo;
	private Date order_date;
	private int amount_payment;
	private String isPayment; //결제 상태를 표시 - Y:결제완료; N:결제안함
	private String merchantData;
	private String payMethod;
	private String cardNum;
	private String cardQuota;
	private String book_name;
	private int origin_price;
	private int dc_price;
	private int group_count;
	private String book_img_storedName;
	private List<PaymentCommand> payment_list;
	private String cancel_msg;
	private Date cancel_rquest_date;
	private String canceler_tel;
	private String canceler_email;
	private String courier_company;
	private String courier_number;
	private String courier_status; //배송 상태를 표시 - W:준비중; D:배송중; F:배송완료;
	private Date courier_date;
	
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
	public String getBuyername() {
		return buyername;
	}
	public void setBuyername(String buyername) {
		this.buyername = buyername;
	}
	public String getBuyeremail() {
		return buyeremail;
	}
	public void setBuyeremail(String buyeremail) {
		this.buyeremail = buyeremail;
	}
	public String getRecipientname() {
		return recipientname;
	}
	public void setRecipientname(String recipientname) {
		this.recipientname = recipientname;
	}
	public String getRecipientemail() {
		return recipientemail;
	}
	public void setRecipientemail(String recipientemail) {
		this.recipientemail = recipientemail;
	}
	public String getBuyertel() {
		return buyertel;
	}
	public void setBuyertel(String buyertel) {
		this.buyertel = buyertel;
	}
	public String getRecipienttel() {
		return recipienttel;
	}
	public void setRecipienttel(String recipienttel) {
		this.recipienttel = recipienttel;
	}
	public String getBuyertel2() {
		return buyertel2;
	}
	public void setBuyertel2(String buyertel2) {
		this.buyertel2 = buyertel2;
	}
	public String getRecipienttel2() {
		return recipienttel2;
	}
	public void setRecipienttel2(String recipienttel2) {
		this.recipienttel2 = recipienttel2;
	}
	public String getRecipient_postnum() {
		return recipient_postnum;
	}
	public void setRecipient_postnum(String recipient_postnum) {
		this.recipient_postnum = recipient_postnum;
	}
	public String getRecipient_address1() {
		return recipient_address1;
	}
	public void setRecipient_address1(String recipient_address1) {
		this.recipient_address1 = recipient_address1;
	}
	public String getRecipient_address2() {
		return recipient_address2;
	}
	public void setRecipient_address2(String recipient_address2) {
		this.recipient_address2 = recipient_address2;
	}
	public String getBuyer_memo() {
		return buyer_memo;
	}
	public void setBuyer_memo(String buyer_memo) {
		this.buyer_memo = buyer_memo;
	}
	public Date getOrder_date() {
		return order_date;
	}
	public void setOrder_date(Date order_date) {
		this.order_date = order_date;
	}
	public int getAmount_payment() {
		return amount_payment;
	}
	public void setAmount_payment(int amount_payment) {
		this.amount_payment = amount_payment;
	}
	public String getIsPayment() {
		return isPayment;
	}
	public void setIsPayment(String isPayment) {
		this.isPayment = isPayment;
	}
	public String getMerchantData() {
		return merchantData;
	}
	public void setMerchantData(String merchantData) {
		this.merchantData = merchantData;
	}
	public String getPayMethod() {
		return payMethod;
	}
	public void setPayMethod(String payMethod) {
		this.payMethod = payMethod;
	}
	public String getCardNum() {
		return cardNum;
	}
	public void setCardNum(String cardNum) {
		this.cardNum = cardNum;
	}
	public String getCardQuota() {
		return cardQuota;
	}
	public void setCardQuota(String cardQuota) {
		this.cardQuota = cardQuota;
	}
	public String getBook_name() {
		return book_name;
	}
	public void setBook_name(String book_name) {
		this.book_name = book_name;
	}
	public int getOrigin_price() {
		return origin_price;
	}
	public void setOrigin_price(int origin_price) {
		this.origin_price = origin_price;
	}
	public int getDc_price() {
		return dc_price;
	}
	public void setDc_price(int dc_price) {
		this.dc_price = dc_price;
	}
	public int getGroup_count() {
		return group_count;
	}
	public void setGroup_count(int group_count) {
		this.group_count = group_count;
	}
	public String getBook_img_storedName() {
		return book_img_storedName;
	}
	public void setBook_img_storedName(String book_img_storedName) {
		this.book_img_storedName = book_img_storedName;
	}
	public List<PaymentCommand> getPayment_list() {
		return payment_list;
	}
	public void setPayment_list(List<PaymentCommand> payment_list) {
		this.payment_list = payment_list;
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
		return "OrderAdminCommand [product_no=" + product_no + ", quantity=" + quantity + ", order_code=" + order_code
				+ ", tid=" + tid + ", payment_status=" + payment_status + ", delivery_status=" + delivery_status
				+ ", delivery_date=" + delivery_date + ", refund_status=" + refund_status + ", user_id=" + user_id
				+ ", buyername=" + buyername + ", buyeremail=" + buyeremail + ", recipientname=" + recipientname
				+ ", recipientemail=" + recipientemail + ", buyertel=" + buyertel + ", recipienttel=" + recipienttel
				+ ", buyertel2=" + buyertel2 + ", recipienttel2=" + recipienttel2 + ", recipient_postnum="
				+ recipient_postnum + ", recipient_address1=" + recipient_address1 + ", recipient_address2="
				+ recipient_address2 + ", buyer_memo=" + buyer_memo + ", order_date=" + order_date + ", amount_payment="
				+ amount_payment + ", isPayment=" + isPayment + ", merchantData=" + merchantData + ", payMethod="
				+ payMethod + ", cardNum=" + cardNum + ", cardQuota=" + cardQuota + ", book_name=" + book_name
				+ ", origin_price=" + origin_price + ", dc_price=" + dc_price + ", group_count=" + group_count
				+ ", book_img_storedName=" + book_img_storedName + ", payment_list=" + payment_list + ", cancel_msg="
				+ cancel_msg + ", cancel_rquest_date=" + cancel_rquest_date + ", canceler_tel=" + canceler_tel
				+ ", canceler_email=" + canceler_email + ", courier_company=" + courier_company + ", courier_number="
				+ courier_number + ", courier_status=" + courier_status + ", courier_date=" + courier_date + "]";
	}
}
