package com.hp.service.service;

import java.util.List;

import com.hp.service.domain.NoticeFileCommand;
import com.hp.service.domain.QnaCommand;
import com.hp.service.domain.ServiceNoticeCommand;

public interface ServicesService {

	public List<ServiceNoticeCommand> getNoticeList();

	public void increaseViews(int num);

	public ServiceNoticeCommand noticeView(int num);

	public List<NoticeFileCommand> getNoticeFile(int num);

	public void qnaSub(QnaCommand qnaCommand);

	public List<ServiceNoticeCommand> getNoticeSomeList();

}