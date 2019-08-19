package com.hp.service.domain;

public class NoticeFileCommand {
	private int notice_idx;
	private String notice_file_name;
	private String notice_file_storedName;
	
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
	
	@Override
	public String toString() {
		return "NoticeFileCommand [notice_idx=" + notice_idx + ", notice_file_name=" + notice_file_name
				+ ", notice_file_storedName=" + notice_file_storedName + "]";
	}
}
