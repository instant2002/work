package com.hp.admin.domain;

import java.sql.Date;

public class MemberAdminCommand {
	private String user_id;
	private String user_pwd;
	private String user_name;
	private String email;
	private String phonenum1;
	private String phonenum2;
	private String postnum;
	private String address1;
	private String address2;
	private String birth;
	private String gender;
	private String secession;
	private String secession_contents;
	private Date regdate;
	private int secession_num;
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_pwd() {
		return user_pwd;
	}
	public void setUser_pwd(String user_pwd) {
		this.user_pwd = user_pwd;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhonenum1() {
		return phonenum1;
	}
	public void setPhonenum1(String phonenum1) {
		this.phonenum1 = phonenum1;
	}
	public String getPhonenum2() {
		return phonenum2;
	}
	public void setPhonenum2(String phonenum2) {
		this.phonenum2 = phonenum2;
	}
	public String getPostnum() {
		return postnum;
	}
	public void setPostnum(String postnum) {
		this.postnum = postnum;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getSecession() {
		return secession;
	}
	public void setSecession(String secession) {
		this.secession = secession;
	}
	public String getSecession_contents() {
		return secession_contents;
	}
	public void setSecession_contents(String secession_contents) {
		this.secession_contents = secession_contents;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public int getSecession_num() {
		return secession_num;
	}
	public void setSecession_num(int secession_num) {
		this.secession_num = secession_num;
	}
	
	@Override
	public String toString() {
		return "MemberAdminCommand [user_id=" + user_id + ", user_pwd=" + user_pwd + ", user_name=" + user_name
				+ ", email=" + email + ", phonenum1=" + phonenum1 + ", phonenum2=" + phonenum2 + ", postnum=" + postnum
				+ ", address1=" + address1 + ", address2=" + address2 + ", birth=" + birth + ", gender=" + gender
				+ ", secession=" + secession + ", secession_contents=" + secession_contents + ", regdate=" + regdate
				+ ", secession_num=" + secession_num + "]";
	}
}