package com.hp.admin.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.hp.admin.domain.MemberAdminCommand;

@Repository
public interface MemberAdminMapper {
	
	public List<MemberAdminCommand> getAllMember();

}
