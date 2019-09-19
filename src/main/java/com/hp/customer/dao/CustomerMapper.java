package com.hp.customer.dao;

import java.util.Map;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import com.hp.book.domain.BookCommand;
import com.hp.common.domain.Criteria;
import com.hp.customer.domain.CancelCommand;
import com.hp.customer.domain.CustomerCommand;
import com.hp.member.domain.MemberCommand;
import com.hp.order.domain.PaymentCommand;
import com.hp.service.domain.QnaCommand;

@Repository
public interface CustomerMapper {
	@Select("SELECT * FROM member WHERE user_id = #{user_id}")
	public MemberCommand getUserInfo(String user_id);

	@Delete("DELETE FROM member WHERE user_id = #{user_id}")
	public void secessionSub(MemberCommand memberCommand);

	public void secessionSubInfo(MemberCommand memberCommand);

	public int chkPassword(Map<String, String> map);

	public void updateUser(MemberCommand memberCommand);

	public List<BookCommand> getBasketList(String user_id);

	public void insertBasket(CustomerCommand customerCommand);

	public void basketDelete(HashMap<String, Object> hm);

	public void insertWish(CustomerCommand customerCommand);

	public List<BookCommand> getWishList(String user_id);

	public void wishDelete(HashMap<String, Object> hm);

	public void toBasket(HashMap<String, Object> hm);

	public List<QnaCommand> getQnaList(String user_id);
	
	@Select("SELECT * FROM question WHERE user_id = #{user_id} and idx = #{idx}")
	public QnaCommand getQnaView(QnaCommand qnaCommand);

	@Select("SELECT * FROM answer WHERE ansQuesIdx = #{idx}")
	public QnaCommand getQnaAnswer(QnaCommand qnaCommand);

	public void qnaDelSub(QnaCommand qnaCommand);

	public List<PaymentCommand> getOrderList(Criteria criteria);

	public int getOrderListCount(Criteria criteria);
	
	public List<PaymentCommand> getOrderDetail(Map<String, String> map);

	public CancelCommand ableCancelChk(CancelCommand cancelCommand);

	public CancelCommand cancelData(CancelCommand cancelCommand);

	public void insertCancelReq(CancelCommand cancelData);

	@Update("UPDATE order_books SET refund_status = 'F' WHERE order_code = #{order_code} AND user_id = #{user_id}")
	public void updateCancelBook(CancelCommand cancelData);

	public int getCancelOrderListCount(Criteria criteria);

	public List<CancelCommand> getCancelOrderList(Criteria criteria);

	public List<PaymentCommand> getOrderCancelDetail(Map<String, String> map);

	@Select("SELECT refund_status FROM order_cancel WHERE order_code = #{order_code} AND user_id = #{user_id}")
	public String cancelDataChk(Map<Object, Object> paramMap);

	@Delete("DELETE FROM order_cancel WHERE order_code = #{order_code} AND user_id = #{user_id}")
	public void cancelRetract(Map<Object, Object> paramMap);

	@Update("UPDATE order_books SET refund_status = 'N' WHERE order_code = #{order_code} AND user_id = #{user_id}")
	public void changeRefundOrder(Map<Object, Object> paramMap);

	public List<PaymentCommand> getMypageOrderList(String user_id);

	public List<BookCommand> getMypageBasketList(String user_id);

	public HashMap<String, Object> getMypageCount(String user_id);

	public List<PaymentCommand> getNonmemOrderTracking(Map<String, String> map);

	public List<BookCommand> getBasketCookieList(List<String> product_list);
}
