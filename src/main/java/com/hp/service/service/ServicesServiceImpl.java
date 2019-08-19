package com.hp.service.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hp.service.dao.ServicesMapper;
import com.hp.service.domain.NoticeFileCommand;
import com.hp.service.domain.QnaCommand;
import com.hp.service.domain.ServiceNoticeCommand;

@Service("servicesService")
public class ServicesServiceImpl implements ServicesService{

	@Resource(name="servicesMapper")
	private ServicesMapper servicesMapper;

	@Override
	public List<ServiceNoticeCommand> getNoticeList() {
		return servicesMapper.getNoticeList();
	}

	@Override
	public void increaseViews(int num) {
		servicesMapper.increaseViews(num);
		
	}

	@Override
	public ServiceNoticeCommand noticeView(int num) {
		return servicesMapper.noticeView(num);
	}

	@Override
	public List<NoticeFileCommand> getNoticeFile(int num) {
		return servicesMapper.getNoticeFile(num);
	}

	@Override
	public void qnaSub(QnaCommand qnaCommand) {
		servicesMapper.qnaSub(qnaCommand);
		
	}

	@Override
	public List<ServiceNoticeCommand> getNoticeSomeList() {
		return servicesMapper.getNoticeSomeList();
	}
}