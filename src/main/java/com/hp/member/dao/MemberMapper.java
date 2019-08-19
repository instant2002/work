package com.hp.member.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import com.hp.member.domain.MemberCommand;

@Repository
public interface MemberMapper{
	
	public void insert(MemberCommand member);
	
	@Select("SELECT * FROM member WHERE user_id = #{user_id} AND user_pwd = #{user_pwd}")
	public MemberCommand loginSubmit(MemberCommand member);

	@Select("SELECT * FROM member WHERE user_id = #{user_id}")
	public MemberCommand selectMember(String user_id);
}