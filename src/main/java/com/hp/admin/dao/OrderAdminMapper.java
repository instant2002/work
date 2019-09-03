package com.hp.admin.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import com.hp.admin.domain.CourierCommand;
import com.hp.admin.domain.OrderAdminCommand;
import com.hp.common.domain.Criteria;

@Repository
public interface OrderAdminMapper {

	public int getOrderAdminListCount(Criteria criteria);

	public List<OrderAdminCommand> getOrderAdminList(Criteria criteria);

	public List<OrderAdminCommand> getOrderAdminDetail(String order_code);

	public int getCancelOrderAdminListCount(Criteria criteria);

	public List<OrderAdminCommand> getCancelOrderAdminList(Criteria criteria);

	public List<OrderAdminCommand> getOrderCancelAdminDetail(String order_code);

	public void shipProduct(CourierCommand courierCommand);

	@Update("UPDATE order_books SET delivery_status = #{courier_status}, delivery_date = CURRENT_TIMESTAMP WHERE order_code = #{order_code}")
	public void updateOrderTable(CourierCommand courierCommand);

	@Update("UPDATE order_cancel SET delivery_status = #{courier_status}, cancel_success_date = CURRENT_TIMESTAMP WHERE order_code = #{order_code}")
	public void updateCancelTable(CourierCommand courierCommand);

	public CourierCommand getCourierData(String order_code);

}
