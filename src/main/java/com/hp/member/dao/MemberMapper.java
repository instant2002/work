package com.hp.member.dao;

import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import com.hp.member.domain.MemberCommand;

@Repository
public interface MemberMapper{
	
	public void insert(MemberCommand member);
	
	@Select("SELECT * FROM member WHERE user_id = #{user_id} AND user_pwd = #{user_pwd}")
	public MemberCommand loginSubmit(MemberCommand member);

	@Select("SELECT * FROM member WHERE user_id = #{user_id}")
	public MemberCommand selectMember(String user_id);

	public void insertCooikeBasket(String product_no, String quantity, String user_id);
}