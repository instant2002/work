package com.hp.order.domain;

import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class OrderCommand {
	private String product_no;
	private Date upload_date;
	private String book_name;
	private int origin_price;
	private String discounted;
	private int dc_price;
	private String book_group;
	private String book_cate;
	private String book_priority;
	private int book_order;
	private MultipartFile book_img_file;
	private String book_img_name;
	private String book_img_storedName;
	private int book_img_size;
	private String writer;
	private String translator;
	private int book_page;
	private Date release_date;
	private String book_explanation;
	private String quantity;
	private List<OrderCommand> order_list;
	private List<Integer> quantity_list;
	
	public String getProduct_no() {
		return product_no;
	}
	public void setProduct_no(String product_no) {
		this.product_no = product_no;
	}
	public Date getUpload_date() {
		return upload_date;
	}
	public void setUpload_date(Date upload_date) {
		this.upload_date = upload_date;
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
	public String getDiscounted() {
		return discounted;
	}
	public void setDiscounted(String discounted) {
		this.discounted = discounted;
	}
	public int getDc_price() {
		return dc_price;
	}
	public void setDc_price(int dc_price) {
		this.dc_price = dc_price;
	}
	public String getBook_group() {
		return book_group;
	}
	public void setBook_group(String book_group) {
		this.book_group = book_group;
	}
	public String getBook_cate() {
		return book_cate;
	}
	public void setBook_cate(String book_cate) {
		this.book_cate = book_cate;
	}
	public String getBook_priority() {
		return book_priority;
	}
	public void setBook_priority(String book_priority) {
		this.book_priority = book_priority;
	}
	public int getBook_order() {
		return book_order;
	}
	public void setBook_order(int book_order) {
		this.book_order = book_order;
	}
	public MultipartFile getBook_img_file() {
		return book_img_file;
	}
	public void setBook_img_file(MultipartFile book_img_file) {
		this.book_img_file = book_img_file;
	}
	public String getBook_img_name() {
		return book_img_name;
	}
	public void setBook_img_name(String book_img_name) {
		this.book_img_name = book_img_name;
	}
	public String getBook_img_storedName() {
		return book_img_storedName;
	}
	public void setBook_img_storedName(String book_img_storedName) {
		this.book_img_storedName = book_img_storedName;
	}
	public int getBook_img_size() {
		return book_img_size;
	}
	public void setBook_img_size(int book_img_size) {
		this.book_img_size = book_img_size;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getTranslator() {
		return translator;
	}
	public void setTranslator(String translator) {
		this.translator = translator;
	}
	public int getBook_page() {
		return book_page;
	}
	public void setBook_page(int book_page) {
		this.book_page = book_page;
	}
	public Date getRelease_date() {
		return release_date;
	}
	public void setRelease_date(Date release_date) {
		this.release_date = release_date;
	}
	public String getBook_explanation() {
		return book_explanation;
	}
	public void setBook_explanation(String book_explanation) {
		this.book_explanation = book_explanation;
	}
	public String getQuantity() {
		return quantity;
	}
	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}
	public List<OrderCommand> getOrder_list() {
		return order_list;
	}
	public void setOrder_list(List<OrderCommand> order_list) {
		this.order_list = order_list;
	}
	public List<Integer> getQuantity_list() {
		return quantity_list;
	}
	public void setQuantity_list(List<Integer> quantity_list) {
		this.quantity_list = quantity_list;
	}
	
	@Override
	public String toString() {
		return "OrderCommand [product_no=" + product_no + ", upload_date=" + upload_date + ", book_name=" + book_name
				+ ", origin_price=" + origin_price + ", discounted=" + discounted + ", dc_price=" + dc_price
				+ ", book_group=" + book_group + ", book_cate=" + book_cate + ", book_priority=" + book_priority
				+ ", book_order=" + book_order + ", book_img_file=" + book_img_file + ", book_img_name=" + book_img_name
				+ ", book_img_storedName=" + book_img_storedName + ", book_img_size=" + book_img_size + ", writer="
				+ writer + ", translator=" + translator + ", book_page=" + book_page + ", release_date=" + release_date
				+ ", book_explanation=" + book_explanation + ", quantity=" + quantity + ", order_list=" + order_list
				+ ", quantity_list=" + quantity_list + "]";
	}
}