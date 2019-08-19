package com.hp.admin.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.hp.admin.domain.CourierCommand;
import com.hp.admin.domain.OrderAdminCommand;
import com.hp.common.domain.Criteria;

public interface OrderAdminService {

	public int getOrderAdminListCount(Criteria criteria);

	public List<OrderAdminCommand> getOrderAdminList(Criteria criteria);

	public List<OrderAdminCommand> getOrderAdminDetail(String order_code);

	public int getCancelOrderAdminListCount(Criteria criteria);

	public List<OrderAdminCommand> getCancelOrderAdminList(Criteria criteria);

	public List<OrderAdminCommand> getOrderCancelAdminDetail(String order_code);

	public void shipProduct(CourierCommand courierCommand);

	public void updateOrderTable(CourierCommand courierCommand);

	public void updateCancelTable(CourierCommand courierCommand);

	public CourierCommand getCourierData(String order_code);

}
