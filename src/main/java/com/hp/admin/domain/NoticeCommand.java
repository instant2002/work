package com.hp.admin.domain;

import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class NoticeCommand {
	private int num;
	private int notice_idx;
	private String user_id;
	private String title;
	private String contents;
	private Date upload_date;
	private MultipartFile notice_img_file;
	private String notice_img_name;
	private String notice_img_storedName;
	private List<MultipartFile> notice_file;
	private String notice_file_name;
	private String notice_file_storedName;
	private long notice_file_size;
	private List<MultipartFile> notice_attFile;
	private String notice_attFile_name;
	private String notice_attFile_storedName;
	private long notice_attFile_size;
	private int views;
	private int notice_order;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getNotice_idx() {
		return notice_idx;
	}
	public void setNotice_idx(int notice_idx) {
		this.notice_idx = notice_idx;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public Date getUpload_date() {
		return upload_date;
	}
	public void setUpload_date(Date upload_date) {
		this.upload_date = upload_date;
	}
	public MultipartFile getNotice_img_file() {
		return notice_img_file;
	}
	public void setNotice_img_file(MultipartFile notice_img_file) {
		this.notice_img_file = notice_img_file;
	}
	public String getNotice_img_name() {
		return notice_img_name;
	}
	public void setNotice_img_name(String notice_img_name) {
		this.notice_img_name = notice_img_name;
	}
	public String getNotice_img_storedName() {
		return notice_img_storedName;
	}
	public void setNotice_img_storedName(String notice_img_storedName) {
		this.notice_img_storedName = notice_img_storedName;
	}
	public List<MultipartFile> getNotice_file() {
		return notice_file;
	}
	public void setNotice_file(List<MultipartFile> notice_file) {
		this.notice_file = notice_file;
	}
	public String getNotice_file_name() {
		return notice_file_name;
	}
	public void setNotice_file_name(String notice_file_name) {
		this.notice_file_name = notice_file_name;
	}
	public String getNotice_file_storedName() {
		return notice_file_storedName;
	}
	public void setNotice_file_storedName(String notice_file_storedName) {
		this.notice_file_storedName = notice_file_storedName;
	}
	public long getNotice_file_size() {
		return notice_file_size;
	}
	public void setNotice_file_size(long notice_file_size) {
		this.notice_file_size = notice_file_size;
	}
	public List<MultipartFile> getNotice_attFile() {
		return notice_attFile;
	}
	public void setNotice_attFile(List<MultipartFile> notice_attFile) {
		this.notice_attFile = notice_attFile;
	}
	public String getNotice_attFile_name() {
		return notice_attFile_name;
	}
	public void setNotice_attFile_name(String notice_attFile_name) {
		this.notice_attFile_name = notice_attFile_name;
	}
	public String getNotice_attFile_storedName() {
		return notice_attFile_storedName;
	}
	public void setNotice_attFile_storedName(String notice_attFile_storedName) {
		this.notice_attFile_storedName = notice_attFile_storedName;
	}
	public long getNotice_attFile_size() {
		return notice_attFile_size;
	}
	public void setNotice_attFile_size(long notice_attFile_size) {
		this.notice_attFile_size = notice_attFile_size;
	}
	public int getViews() {
		return views;
	}
	public void setViews(int views) {
		this.views = views;
	}
	public int getNotice_order() {
		return notice_order;
	}
	public void setNotice_order(int notice_order) {
		this.notice_order = notice_order;
	}
	@Override
	public String toString() {
		return "NoticeCommand [num=" + num + ", notice_idx=" + notice_idx + ", user_id=" + user_id + ", title=" + title
				+ ", contents=" + contents + ", upload_date=" + upload_date + ", notice_img_file=" + notice_img_file
				+ ", notice_img_name=" + notice_img_name + ", notice_img_storedName=" + notice_img_storedName
				+ ", notice_file=" + notice_file + ", notice_file_name=" + notice_file_name
				+ ", notice_file_storedName=" + notice_file_storedName + ", notice_file_size=" + notice_file_size
				+ ", notice_attFile=" + notice_attFile + ", notice_attFile_name=" + notice_attFile_name
				+ ", notice_attFile_storedName=" + notice_attFile_storedName + ", notice_attFile_size="
				+ notice_attFile_size + ", views=" + views + ", notice_order=" + notice_order + "]";
	}
}