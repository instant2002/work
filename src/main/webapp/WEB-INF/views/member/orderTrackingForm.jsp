<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="login center-block">
	<div>
		<h6><b>비회원 주문 조회</b></h6>
		<hr>
		<form action="/member/orderTracking.do" class="validation-engine" method="post">
			<p>주문자 성함</p>
			<div class="required form-group">
				<input type="text" name="buyername" id="non_buyername" class="form-control validate[required]" data-prompt-position="topLeft" placeholder="주문자 성함">
			</div>
			<p>주문 번호</p>
			<div class="required form-group">
				<input type="text" name="order_code" id="non_order_code" class="form-control validate[required]" data-prompt-position="topLeft" placeholder="주문 번호">
			</div>
			<p style="color: #aaaaaa;">주문 번호를 잊으신 경우, 고객센터에 문의하여 주시기 바랍니다.</p>
			<input type="submit" class="btn btn-lg btn-prim-col" value="조회" style="width: 100%">
		</form>
	</div>
</div>
<div class="hidden-xs" style="height: 200px;"></div>
