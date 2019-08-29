package com.hp.order.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.hp.order.domain.OrderCommand;
import com.hp.order.domain.PaymentCommand;
import com.hp.order.domain.PaymentMobileCommand;

@Repository
public interface OrderMapper {

	List<OrderCommand> getOrderBook(List<String> product_no_list);

	void orderComplete(PaymentCommand paymentCommand);

	List<PaymentCommand> getPaymentList(String order_code);

	void orderComplete_m(PaymentMobileCommand paymentMobileCommand);

	List<PaymentMobileCommand> getMobilePaymentList(String order_code);

}
