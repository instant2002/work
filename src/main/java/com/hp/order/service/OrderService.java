package com.hp.order.service;

import java.util.List;

import com.hp.order.domain.OrderCommand;
import com.hp.order.domain.PaymentCommand;
import com.hp.order.domain.PaymentMobileCommand;

public interface OrderService {

	public List<OrderCommand> getOrderBook(List<String> product_no_list);

	public void orderComplete(PaymentCommand paymentCommand);

	public List<PaymentCommand> getPaymentList(String order_code);

	public void orderComplete_m(PaymentMobileCommand paymentMobileCommand);

	public List<PaymentMobileCommand> getMobilePaymentList(String string);

}
