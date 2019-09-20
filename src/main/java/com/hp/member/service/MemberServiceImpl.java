package com.hp.member.service;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.hp.member.dao.MemberMapper;
import com.hp.member.domain.MemberCommand;

@Service("memberService")
public class MemberServiceImpl implements MemberService{
	
	@Resource(name="memberMapper")
	private MemberMapper memberMapper;
	
	@Override
	public void insert(MemberCommand memberCommand) {
		memberMapper.insert(memberCommand);
	}

	@Override
	public MemberCommand loginSubmit(MemberCommand memberCommand) {
		return memberMapper.loginSubmit(memberCommand);
	}

	@Override
	public MemberCommand selectMember(String user_id) {
		return memberMapper.selectMember(user_id);
	}

	@Override
	public void insertCooikeBasket(String product_no, String quantity, String user_id) {
		memberMapper.insertCooikeBasket(product_no, quantity, user_id);
	}

}
