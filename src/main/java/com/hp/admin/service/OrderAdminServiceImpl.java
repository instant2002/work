package com.hp.admin.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.hp.admin.dao.OrderAdminMapper;
import com.hp.admin.domain.CourierCommand;
import com.hp.admin.domain.OrderAdminCommand;
import com.hp.common.domain.Criteria;

@Service("orderAdminService")
public class OrderAdminServiceImpl implements OrderAdminService {
	private Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "orderAdminMapper")
	private OrderAdminMapper orderAdminMapper;
	
	@Override
	public int getOrderAdminListCount(Criteria criteria) {
		return orderAdminMapper.getOrderAdminListCount(criteria);
	}

	@Override
	public List<OrderAdminCommand> getOrderAdminList(Criteria criteria) {
		return orderAdminMapper.getOrderAdminList(criteria);
	}

	@Override
	public List<OrderAdminCommand> getOrderAdminDetail(String order_code) {
		return orderAdminMapper.getOrderAdminDetail(order_code);
	}

	@Override
	public int getCancelOrderAdminListCount(Criteria criteria) {
		return orderAdminMapper.getCancelOrderAdminListCount(criteria);
	}

	@Override
	public List<OrderAdminCommand> getCancelOrderAdminList(Criteria criteria) {
		return orderAdminMapper.getCancelOrderAdminList(criteria);
	}

	@Override
	public List<OrderAdminCommand> getOrderCancelAdminDetail(String order_code) {
		return orderAdminMapper.getOrderCancelAdminDetail(order_code);
	}

	@Override
	public void shipProduct(CourierCommand courierCommand) {
		orderAdminMapper.shipProduct(courierCommand);
		
	}

	@Override
	public void updateOrderTable(CourierCommand courierCommand) {
		orderAdminMapper.updateOrderTable(courierCommand);		
	}

	@Override
	public void updateCancelTable(CourierCommand courierCommand) {
		orderAdminMapper.updateCancelTable(courierCommand);		
	}

	@Override
	public CourierCommand getCourierData(String order_code) {
		return orderAdminMapper.getCourierData(order_code);
	}
	
	
}
