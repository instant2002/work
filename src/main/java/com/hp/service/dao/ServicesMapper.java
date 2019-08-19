package com.hp.service.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import com.hp.service.domain.NoticeFileCommand;
import com.hp.service.domain.QnaCommand;
import com.hp.service.domain.ServiceNoticeCommand;

@Repository
public interface ServicesMapper {

	public List<ServiceNoticeCommand> getNoticeList();

	@Update("UPDATE notice set views = views+1 WHERE num = #{num}")
	public void increaseViews(int num);

	@Select("SELECT * FROM notice WHERE num = #{num}")
	public ServiceNoticeCommand noticeView(int num);

	public List<NoticeFileCommand> getNoticeFile(int num);

	public void qnaSub(QnaCommand qnaCommand);

	public List<ServiceNoticeCommand> getNoticeSomeList();

}