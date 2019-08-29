package com.hp.admin.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hp.admin.dao.MemberAdminMapper;
import com.hp.admin.domain.MemberAdminCommand;

@Service("memberAdminService")
public class MemberAdminServiceImpl implements MemberAdminService {
	
	@Resource(name = "memberAdminMapper")
	private MemberAdminMapper memberAdminMapper;

	@Override
	public List<MemberAdminCommand> getAllMember() {
		return memberAdminMapper.getAllMember();
	}

}
