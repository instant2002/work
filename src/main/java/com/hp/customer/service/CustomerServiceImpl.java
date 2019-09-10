package com.hp.customer.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hp.book.domain.BookCommand;
import com.hp.common.domain.Criteria;
import com.hp.customer.dao.CustomerMapper;
import com.hp.customer.domain.CancelCommand;
import com.hp.customer.domain.CustomerCommand;
import com.hp.member.domain.MemberCommand;
import com.hp.order.domain.PaymentCommand;
import com.hp.service.domain.QnaCommand;

@Service("customerService")
public class CustomerServiceImpl implements CustomerService {
	
	@Resource(name="customerMapper")
	private CustomerMapper customerMapper;

	@Override
	public MemberCommand getUserInfo(String user_id) {
		return customerMapper.getUserInfo(user_id);
	}

	@Override
	public void secessionSub(MemberCommand memberCommand) {
		customerMapper.secessionSub(memberCommand);
		customerMapper.secessionSubInfo(memberCommand);
	}

	@Override
	public boolean chkPassword(String user_id, String user_pwd) {
		boolean result = false;
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("user_id", user_id);
		map.put("user_pwd", user_pwd);
		
		int count = customerMapper.chkPassword(map);
		
		if(count == 1) result = true;
		return result;
	}

	@Override
	public void updateUser(MemberCommand memberCommand) {
		customerMapper.updateUser(memberCommand);
	}

	@Override
	public List<BookCommand> getBasketList(String user_id) {
		return customerMapper.getBasketList(user_id);
	}

	@Override
	public void insertBasket(CustomerCommand customerCommand) {
		customerMapper.insertBasket(customerCommand);		
	}

	@Override
	public void basketDelete(HashMap<String, Object> hm) {
		customerMapper.basketDelete(hm);
	}

	@Override
	public void insertWish(CustomerCommand customerCommand) {
		customerMapper.insertWish(customerCommand);
		
	}

	@Override
	public List<BookCommand> getWishList(String user_id) {
		return customerMapper.getWishList(user_id);
	}

	@Override
	public void wishDelete(HashMap<String, Object> hm) {
		customerMapper.wishDelete(hm);
		
	}

	@Override
	public void toBasket(HashMap<String, Object> hm) {
		customerMapper.toBasket(hm);
		customerMapper.wishDelete(hm);
			
	}

	@Override
	public List<QnaCommand> getQnaList(String user_id) {
		return customerMapper.getQnaList(user_id);
		
	}

	@Override
	public QnaCommand getQnaView(QnaCommand qnaCommand) {
		return customerMapper.getQnaView(qnaCommand);
	}

	@Override
	public QnaCommand getQnaAnswer(QnaCommand qnaCommand) {
		return customerMapper.getQnaAnswer(qnaCommand);
	}

	@Override
	public void qnaDelSub(QnaCommand qnaCommand) {
		customerMapper.qnaDelSub(qnaCommand);
	}

	@Override
	public List<PaymentCommand> getOrderList(Criteria criteria) {
		return customerMapper.getOrderList(criteria);
	}

	@Override
	public int getOrderListCount(Criteria criteria) {
		return customerMapper.getOrderListCount(criteria);
	}

	@Override
	public List<PaymentCommand> getOrderDetail(Map<String, String> map) {
		return customerMapper.getOrderDetail(map);
	}

	@Override
	public CancelCommand cancelData(CancelCommand cancelCommand) {
		return customerMapper.cancelData(cancelCommand);
	}

	@Override
	public void insertCancelReq(CancelCommand cancelData) {
		customerMapper.insertCancelReq(cancelData);
		customerMapper.updateCancelBook(cancelData);
	}

	@Override
	public int getCancelOrderListCount(Criteria criteria) {
		return customerMapper.getCancelOrderListCount(criteria);
	}

	@Override
	public List<CancelCommand> getCancelOrderList(Criteria criteria) {
		return customerMapper.getCancelOrderList(criteria);
	}

	@Override
	public List<PaymentCommand> getOrderCancelDetail(Map<String, String> map) {
		return customerMapper.getOrderCancelDetail(map);
	}

	@Override
	public String cancelDataChk(Map<Object, Object> paramMap) {
		return customerMapper.cancelDataChk(paramMap);
	}

	@Override
	public void cancelRetract(Map<Object, Object> paramMap) {
		customerMapper.cancelRetract(paramMap);
		customerMapper.changeRefundOrder(paramMap);
	}

	@Override
	public List<PaymentCommand> getMypageOrderList(String user_id) {
		return customerMapper.getMypageOrderList(user_id);
	}

	@Override
	public List<BookCommand> getMypageBasketList(String user_id) {
		return customerMapper.getMypageBasketList(user_id);
	}

	@Override
	public HashMap<String, Object> getMypageCount(String user_id) {
		return customerMapper.getMypageCount(user_id);
	}

	@Override
	public List<PaymentCommand> getNonmemOrderTracking(Map<String, String> map) {
		return customerMapper.getNonmemOrderTracking(map);
	}

}