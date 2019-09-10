package com.hp.customer.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hp.book.domain.BookCommand;
import com.hp.common.domain.Criteria;
import com.hp.customer.domain.CancelCommand;
import com.hp.customer.domain.CustomerCommand;
import com.hp.member.domain.MemberCommand;
import com.hp.order.domain.PaymentCommand;
import com.hp.service.domain.QnaCommand;

public interface CustomerService {

	public MemberCommand getUserInfo(String user_id);

	public void secessionSub(MemberCommand memberCommand);

	public boolean chkPassword(String user_id, String user_pwd);

	public void updateUser(MemberCommand memberCommand);

	public List<BookCommand> getBasketList(String user_id);

	public void insertBasket(CustomerCommand customerCommand);

	public void basketDelete(HashMap<String, Object> hm);

	public void insertWish(CustomerCommand customerCommand);

	public List<BookCommand> getWishList(String user_id);

	public void wishDelete(HashMap<String, Object> hm);

	public void toBasket(HashMap<String, Object> hm);

	public List<QnaCommand> getQnaList(String user_id);

	public QnaCommand getQnaView(QnaCommand qnaCommand);

	public QnaCommand getQnaAnswer(QnaCommand qnaCommand);

	public void qnaDelSub(QnaCommand qnaCommand);

	public List<PaymentCommand> getOrderList(Criteria criteria);

	public int getOrderListCount(Criteria criteria);

	public List<PaymentCommand> getOrderDetail(Map<String, String> map);

	public CancelCommand cancelData(CancelCommand cancelCommand);

	public void insertCancelReq(CancelCommand cancelData);

	public int getCancelOrderListCount(Criteria criteria);

	public List<CancelCommand> getCancelOrderList(Criteria criteria);

	public List<PaymentCommand> getOrderCancelDetail(Map<String, String> map);

	public String cancelDataChk(Map<Object, Object> paramMap);

	public void cancelRetract(Map<Object, Object> paramMap);

	public List<PaymentCommand> getMypageOrderList(String user_id);

	public List<BookCommand> getMypageBasketList(String user_id);

	public HashMap<String, Object> getMypageCount(String user_id);

	public List<PaymentCommand> getNonmemOrderTracking(Map<String, String> map);
}
