<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="col-xs-12 text-center">
	<h2>
		<strong>고객 주문 취소 내역</strong>
	</h2>
</div>
<c:choose>
	<c:when test="${empty cancel_view}">
		<div class="text-center" style="margin-bottom: 100px;">
			<h2>
				조회하신 고객 주문 취소 내역이 없습니다.<br>다시 시도해주시기 바랍니다.
			</h2>
		</div>
	</c:when>
	<c:otherwise>

		<table class="table table-striped">
			<thead style="font-weight: bold; border: solid #ddd; border-width: 2px 0px;">
				<tr>
					<td style="width: 80px;"></td>
					<td>상품 정보</td>
					<td>수량</td>
					<td>상품 금액</td>
					<td>할인 금액</td>
					<td>배송비</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="cancel_view" items="${cancel_view}" varStatus="status">
					<tr>
						<td><img src="${pageContext.request.contextPath}${cancel_view.book_img_storedName}" style="width: 80px;"></td>
						<td style="vertical-align: middle;"><a href="/book/detailView.do?product_no=${cancel_view.product_no }">${cancel_view.book_name}</a></td>
						<td style="vertical-align: middle;">${cancel_view.quantity}</td>
						<td style="vertical-align: middle;"><fmt:formatNumber value="${cancel_view.origin_price*cancel_view.quantity}" groupingUsed="true" />원</td>
						<td style="vertical-align: middle;"><fmt:formatNumber value="${cancel_view.dc_price*cancel_view.quantity}" groupingUsed="true" />원</td>
						<td style="vertical-align: middle;">기본 배송비</td>
					</tr>

					<c:set var="price_sum" value="${price_sum+(cancel_view.origin_price*cancel_view.quantity) }" />
					<c:set var="dc_price_sum" value="${dc_price_sum+(cancel_view.dc_price*cancel_view.quantity) }" />
					<c:set var="quantity_sum" value="${quantity_sum+cancel_view.quantity }" />
					<c:set var="total_price" value="${total_price+((cancel_view.origin_price-cancel_view.dc_price)*cancel_view.quantity) }" />
				</c:forEach>
				<tr style="background: #d7d9db;">
					<td colspan="7" style="text-align: right;">기본 배송비 : 2,500원</td>
				</tr>
			</tbody>
		</table>

		<table class="table" style="margin-top: 50px;">
			<tr>
				<td class="delivery-head" style="vertical-align: middle;"><c:choose>
						<c:when test="${cancel_view[0].refund_status == 'F' }">
							<font style="color: #08a61c99;">주문이 취소되었습니다. <br>감사합니다.</font>
						</c:when>
						<c:otherwise>
							<font style="color: #a608a0c2;">주문을 취소 처리중입니다. <br>신속히 해결해 드리겠습니다.</font>
						</c:otherwise>
					</c:choose></td>
			</tr>
		</table>

		<table class="table total-table" style="margin-top: 50px;">
			<tr>
				<td colspan="4" class="total-head">결제 내역</td>
			</tr>
			<tr>
				<td>상품 금액 / <font id="total_num">${fn:length(cancel_view)}종</font> <font id="total_quantity">(${quantity_sum }개)</font>
				</td>
				<td>할인 금액</td>
				<td>배송비</td>
				<td>결제 금액</td>
			</tr>
			<tr>
				<td id="price_sum"><fmt:formatNumber value="${price_sum}" groupingUsed="true" />원</td>
				<td id="dc_price_sum"><fmt:formatNumber value="${dc_price_sum}" groupingUsed="true" />원</td>
				<td id="shipping_fee">2,500원</td>
				<td id="total_price"><fmt:formatNumber value="${total_price+2500 }" groupingUsed="true" />원</td>
			</tr>
		</table>

		<table class="table payInfo-table" style="margin-top: 50px; text-align: center;">
			<tr>
				<td colspan="4" class="total-head">결제 정보</td>
			</tr>
			<colgroup>
				<col style="width: 20%">
				<col style="width: 20%">
				<col style="width: 20%">
				<col style="width: 20%">
				<col style="width: 20%">
			</colgroup>
			<tr>
				<td><b>결제 수단</b></td>
				<td><b>카드번호</b></td>
				<td><b>할부기간</b></td>
				<td><b>주문 번호</b></td>
			</tr>
			<tr>
				<td><c:choose>
						<c:when test="${cancel_view[0].payMethod == 'VCard'}">
				카드				
			</c:when>
						<c:otherwise>
				${cancel_view[0].payMethod}
			</c:otherwise>
					</c:choose></td>
				<td>${cancel_view[0].cardNum }</td>
				<td>${cancel_view[0].cardQuota }개월</td>
				<td>${cancel_view[0].order_code }</td>

			</tr>
		</table>

		<table class="table deliveryInfo-table" style="margin: 50px 0px;">
			<thead>
				<tr>
					<td colspan="5" class="total-head">배송 정보</td>
				</tr>
			</thead>
			<colgroup>
				<col style="width: 20%">
				<col style="width: 80%">
			</colgroup>
			<tbody style="border-bottom: 1px solid #ddd;">
				<tr>
					<th class="text-center"><b>성함</b></th>
					<td>${cancel_view[0].recipientname }</td>
				</tr>
				<tr>
					<th class="text-center"><b>연락처</b></th>
					<td>${cancel_view[0].recipienttel }</td>
				</tr>
				<tr>
					<th class="text-center"><b>주소</b></th>
					<td>(${cancel_view[0].recipient_postnum })${cancel_view[0].recipient_address1 } ${cancel_view[0].recipient_address2 }</td>
				</tr>
				<tr>
					<th class="text-center"><b>배송요청사항</b></th>
					<td>${cancel_view[0].buyer_memo }</td>
				</tr>
			</tbody>
		</table>
		
		<table class="table deliveryInfo-table" style="margin: 50px 0px;">
			<thead>
				<tr>
					<td colspan="5" class="total-head">취소 정보</td>
				</tr>
			</thead>
			<colgroup>
				<col style="width: 20%">
				<col style="width: 80%">
			</colgroup>
			<tbody style="border-bottom: 1px solid #ddd;">
				<tr>
					<th class="text-center"><b>성함</b></th>
					<td>${cancel_view[0].recipientname }</td>
				</tr>
				<tr>
					<th class="text-center"><b>연락처</b></th>
					<td>${cancel_view[0].canceler_tel }</td>
				</tr>
				<tr>
					<th class="text-center"><b>이메일</b></th>
					<td>${cancel_view[0].canceler_email }</td>
				</tr>
				<tr>
					<th class="text-center"><b>취소 메세지</b></th>
					<td>${cancel_view[0].cancel_msg }</td>
				</tr>
			</tbody>
		</table>

		<div class="col-xs-12" style="margin-bottom: 100px;">
			<div class="col-md-5"></div>
			<div class="col-md-2">
				<button class="btn btn-buy-col pull-left add-cart" onclick="location.href='/customer/orderCancelList.do'">목록으로</button>
			</div>
			<div class="col-md-5"></div>
		</div>
	</c:otherwise>
</c:choose>