package com.hp.service.domain;

import java.sql.Date;

public class QnaCommand {
	private int idx;
	private String user_id; 
	private String user_name; 
	private String phone; 
	private String email; 
	private String title;
	private String contents;
	private String isAnswer;
	private Date question_upload_date;
	
	private int ansIdx;
	private int ansQuesIdx;
	private String ansContents;
	private Date answer_upload_date;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
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
	public String getIsAnswer() {
		return isAnswer;
	}
	public void setIsAnswer(String isAnswer) {
		this.isAnswer = isAnswer;
	}
	public Date getQuestion_upload_date() {
		return question_upload_date;
	}
	public void setQuestion_upload_date(Date question_upload_date) {
		this.question_upload_date = question_upload_date;
	}
	public int getAnsIdx() {
		return ansIdx;
	}
	public void setAnsIdx(int ansIdx) {
		this.ansIdx = ansIdx;
	}
	public int getAnsQuesIdx() {
		return ansQuesIdx;
	}
	public void setAnsQuesIdx(int ansQuesIdx) {
		this.ansQuesIdx = ansQuesIdx;
	}
	public String getAnsContents() {
		return ansContents;
	}
	public void setAnsContents(String ansContents) {
		this.ansContents = ansContents;
	}
	public Date getAnswer_upload_date() {
		return answer_upload_date;
	}
	public void setAnswer_upload_date(Date answer_upload_date) {
		this.answer_upload_date = answer_upload_date;
	}
	
	@Override
	public String toString() {
		return "QnaCommand [idx=" + idx + ", user_id=" + user_id + ", user_name=" + user_name + ", phone=" + phone
				+ ", email=" + email + ", title=" + title + ", contents=" + contents + ", isAnswer=" + isAnswer
				+ ", question_upload_date=" + question_upload_date + ", ansIdx=" + ansIdx + ", ansQuesIdx=" + ansQuesIdx
				+ ", ansContents=" + ansContents + ", answer_upload_date=" + answer_upload_date + "]";
	}
}
