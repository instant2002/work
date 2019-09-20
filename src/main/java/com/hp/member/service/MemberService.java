package com.hp.member.service;

import com.hp.member.domain.MemberCommand;

public interface MemberService {

	public void insert(MemberCommand member);

	public MemberCommand loginSubmit(MemberCommand memberCommand);

	public MemberCommand selectMember(String user_id);

	public void insertCooikeBasket(String product_no, String quantity, String user_id);

}
