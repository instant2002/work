package com.hp.service.domain;

public class NoticeFileCommand {
	private int notice_idx;
	private String notice_file_name;
	private String notice_file_storedName;
	private long notice_file_size;
	private String notice_attFile_name;
	private String notice_attFile_storedName;
	private long notice_attFile_size;
	
	public int getNotice_idx() {
		return notice_idx;
	}
	public void setNotice_idx(int notice_idx) {
		this.notice_idx = notice_idx;
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
	
	@Override
	public String toString() {
		return "NoticeFileCommand [notice_idx=" + notice_idx + ", notice_file_name=" + notice_file_name
				+ ", notice_file_storedName=" + notice_file_storedName + ", notice_file_size=" + notice_file_size
				+ ", notice_attFile_name=" + notice_attFile_name + ", notice_attFile_storedName="
				+ notice_attFile_storedName + ", notice_attFile_size=" + notice_attFile_size + "]";
	}
}
