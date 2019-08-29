package com.hp.order.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hp.order.dao.OrderMapper;
import com.hp.order.domain.OrderCommand;
import com.hp.order.domain.PaymentCommand;
import com.hp.order.domain.PaymentMobileCommand;

@Service("orderService")
public class OrderServiceImpl implements OrderService{

	@Resource(name = "orderMapper")
	private OrderMapper orderMapper;

	@Override
	public List<OrderCommand> getOrderBook(List<String> product_no_list) {
		return orderMapper.getOrderBook(product_no_list);
	}

	@Override
	public void orderComplete(PaymentCommand paymentCommand) {
		orderMapper.orderComplete(paymentCommand);
	}

	@Override
	public List<PaymentCommand> getPaymentList(String order_code) {
		return orderMapper.getPaymentList(order_code);
	}

	@Override
	public void orderComplete_m(PaymentMobileCommand paymentMobileCommand) {
		orderMapper.orderComplete_m(paymentMobileCommand);
	}

	@Override
	public List<PaymentMobileCommand> getMobilePaymentList(String order_code) {
		return orderMapper.getMobilePaymentList(order_code);
	}



}
