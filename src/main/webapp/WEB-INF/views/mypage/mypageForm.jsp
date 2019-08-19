<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="col-md-6">
	<div class="col-md-8 text-left">
		<strong>${user.user_id} 님</strong>
	</div>
	<div class="col-md-4 text-right">
		<a href="/customer/editInfo.do"><font size="2">수정</font></a>
	</div>
	<hr style="width: 100%; margin-bottom: 30px;">
	<div class="col-md-4 text-left">이름</div>
	<div class="col-md-8 text-left">${user.user_name}</div>
	<div class="col-md-4 text-left">이메일</div>
	<div class="col-md-8 text-left">${user.email}</div>
	<div class="col-md-4 text-left">휴대폰 번호</div>
	<div class="col-md-8 text-left">${user.phonenum1}</div>
	<div class="col-md-4 text-left">주소</div>
	<div class="col-md-8 text-left">(${user.postnum}) ${user.address1} ${user.address2}</div>
</div>
<div class="col-md-6">
	<div class="col-md-8 text-left">
		<strong>나의 쇼핑</strong>
	</div>
	<div class="col-md-4 text-left"></div>
	<hr style="width: 100%; margin-bottom: 30px;">
	<div class="col-md-4 text-left">현재 주문</div>
	<div class="col-md-8 text-right"><a href="/customer/orderList.do">${my_count.order_count }개<a></a></div>
	<div class="col-md-4 text-left">취소 / 교환</div>
	<div class="col-md-8 text-right"><a href="/customer/orderCancelList.do">${my_count.cancel_count }개<a></a></div>
	<div class="col-md-4 text-left">장바구니</div>
	<div class="col-md-8 text-right"><a href="/customer/basketList.do">${my_count.basket_count }개<a></a></div>
	<div class="col-md-4 text-left">찜 상품</div>
	<div class="col-md-8 text-right"><a href="/customer/wishList.do">${my_count.wish_count }개<a></a></div>
</div>
<hr style="width: 100%; margin-bottom: 30px;">
<div class="col-xs-12">
	<div class="col-xs-12 text-right">
		<h2 class="text-center">
			<strong>주문 내역</strong>
		</h2>
		<font class="text-right" size="2"><a href="/customer/orderList.do">더보기</a></font>
	</div>
	<table class="table table-hover order_history">
		<colgroup>
			<col width="15%" />
			<col width="60%" />
			<col width="25%" />
		</colgroup>
		<thead style="font-weight: bold; border: solid #ddd; border-width: 2px 0px; background: #f9f9f9;">
			<tr>
				<td class="text-center">날짜</td>
				<td>구매상품</td>
				<td class="text-center">상태</td>
			</tr>
		</thead>
		<c:choose>
			<c:when test="${empty order_list}">
				<td colspan="5" class="text-center">주문하신 상품이 없습니다.</td>
			</c:when>
			<c:otherwise>
				<tbody>
					<c:forEach var="order_list" items="${order_list}" varStatus="status">
						<tr>
							<td class="text-center" style="border-left: none;">${order_list.order_date}</td>
							<td style="border-width: 1px 1px 1px 0px;"><a href="/customer/orderDetail.do?order_code=${order_list.order_code }"> <b>${order_list.book_name}</b> <c:if test="${order_list.group_count > 1}">
							..외 ${order_list.group_count -1}건
						</c:if>
							</a><br> <font style="font-size: 12px;">주문번호 : ${order_list.order_code}<br></font> <font style="font-size: 20px; font-weight: bold;"><fmt:formatNumber value="${order_list.amount_payment}" groupingUsed="true" />원</font></td>
							<td class="text-center"><c:choose>
									<c:when test="${order_list.delivery_status == 'W'}">
										<font style="font-weight: bold; color: #08a61c;">배송 준비중</font>
										<br>
										<c:choose>
											<c:when test="${order_list.payment_status == 'P'}">
												<font style="font-weight: bold; font-size: 13px;">결제 완료</font>
											</c:when>
											<c:otherwise>
												<font style="font-weight: bold; font-size: 13px; color: #f22;">결제 대기</font>
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:when test="${order_list.delivery_status == 'D'}">
										<font style="font-weight: bold; color: #a608a0;">배송중</font>
									</c:when>
									<c:when test="${order_list.delivery_status == 'F'}">
										<font style="font-weight: bold; color: #1b34ee;">배송 완료</font>
									</c:when>
								</c:choose></td>
						</tr>
					</c:forEach>
				</tbody>
			</c:otherwise>
		</c:choose>
	</table>
</div>
<div class="col-xs-12">
	<div class="col-xs-12 text-right">
		<h2 class="text-center">
			<strong>장바구니</strong>
		</h2>
		<font size="2"><a href="/customer/basketList.do">더보기</a></font>
	</div>
	<table class="table">
		<colgroup>
			<col width="50%" />
			<col width="20%" />
			<col width="20%" />
		</colgroup>
		<thead style="font-weight: bold; border: solid #ddd; border-width: 2px 0px; background: #f9f9f9;">
			<tr>
				<td>상품 정보</td>
				<td>상품 금액</td>
				<td>할인 금액</td>
			</tr>
		</thead>
		<c:choose>
			<c:when test="${empty basket}">
				<td colspan="7" class="text-center">장바구니가 비어있습니다.</td>
			</c:when>
			<c:otherwise>
				<tbody>
					<c:forEach var="basket" items="${basket}" varStatus="status">
						<tr>
							<td style="vertical-align: middle;"><a href="/customer/basketList.do">${basket.book_name}</a></td>
							<td id="origin_price_${status.index }" style="vertical-align: middle;"><fmt:formatNumber value="${basket.origin_price*basket.quantity}" groupingUsed="true" />원</td>
							<td id="dc_price_${status.index }" style="vertical-align: middle;"><fmt:formatNumber value="${basket.dc_price*basket.quantity}" groupingUsed="true" />원</td>
						</tr>
					</c:forEach>
				</tbody>
			</c:otherwise>
		</c:choose>
	</table>
</div>
<hr style="width: 100%; margin-bottom: 30px;">
