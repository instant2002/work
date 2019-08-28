package com.hp.admin.domain;

import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class SampleCommand {
	private int idx;
	private String sample_img_title;
	private String sample_calling_name;
	private List<MultipartFile> sample_img;
	private String sample_img_name;
	private String sample_img_storedName;
	private long sample_img_size;
	private Date sample_upload_date;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getSample_img_title() {
		return sample_img_title;
	}
	public void setSample_img_title(String sample_img_title) {
		this.sample_img_title = sample_img_title;
	}
	public String getSample_calling_name() {
		return sample_calling_name;
	}
	public void setSample_calling_name(String sample_calling_name) {
		this.sample_calling_name = sample_calling_name;
	}
	public List<MultipartFile> getSample_img() {
		return sample_img;
	}
	public void setSample_img(List<MultipartFile> sample_img) {
		this.sample_img = sample_img;
	}
	public String getSample_img_name() {
		return sample_img_name;
	}
	public void setSample_img_name(String sample_img_name) {
		this.sample_img_name = sample_img_name;
	}
	public String getSample_img_storedName() {
		return sample_img_storedName;
	}
	public void setSample_img_storedName(String sample_img_storedName) {
		this.sample_img_storedName = sample_img_storedName;
	}
	public long getSample_img_size() {
		return sample_img_size;
	}
	public void setSample_img_size(long sample_img_size) {
		this.sample_img_size = sample_img_size;
	}
	public Date getSample_upload_date() {
		return sample_upload_date;
	}
	public void setSample_upload_date(Date sample_upload_date) {
		this.sample_upload_date = sample_upload_date;
	}
	@Override
	public String toString() {
		return "SampleCommand [idx=" + idx + ", sample_img_title=" + sample_img_title + ", sample_calling_name="
				+ sample_calling_name + ", sample_img=" + sample_img + ", sample_img_name=" + sample_img_name
				+ ", sample_img_storedName=" + sample_img_storedName + ", sample_img_size=" + sample_img_size
				+ ", sample_upload_date=" + sample_upload_date + "]";
	}
}