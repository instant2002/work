<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="col-xs-12">
	<div class="col-xs-12 text-center" style="border: 1px solid #ddd; border-width: 2px 0px;">
		<h2><strong>주문 내역</strong></h2>
	</div>
	<div class="col-xs-12">
		<form action="/customer/orderList.do" id="orderingForm">
			<input type="hidden" name="keyword" value="">
			<div class="cat-view-options" style="border: none; margin: 15px 0 0 0;">
				<div class="row">
					<div class="col-md-6"></div>
					<div class="col-md-2">
						<div class="row no-gutter form-group">
							<div class="col-md-12">
								<select class="form-control cvo-control s-styled hasCustomSelect" name="delivery_status" style="cursor: pointer;">
									<option value="">배송 전체</option>
									<option value="W">배송 준비중</option>
									<option value="D">배송중</option>
									<option value="F">배송 완료</option>
								</select>
							</div>
						</div>
					</div>
					<div class="col-md-2 cvo-availability-col">
						<div class="form-group">
							<select class="form-control cvo-control s-styled hasCustomSelect" name="isPayment" style="cursor: pointer;">
								<option value="">결제 전체</option>
								<option value="Y">결제 완료</option>
								<option value="N">미결제</option>
							</select>
						</div>
					</div>
					<div class="col-md-2 filter_btn">
						<button class="btn btn-yet-col" type="button" onclick="document.getElementById('orderingForm').submit();" style="font-size: 12px; padding: 2px 10px; font-family: -webkit-body;">적용</button>
						<button class="btn btn-yet-col" type="button" onclick="location.href='/customer/orderList.do?page=${pageMaker.page}'" style="font-size: 12px; padding: 2px 10px; font-family: -webkit-body;">초기화</button>
					</div>
				</div>
			</div>
		</form>
	</div>
	<table class="table order_history" style="table-layout: fixed;">
			<colgroup>
				<col width="30" class="hidden-sm hidden-md hidden-lg">
				<col width="70" class="hidden-sm hidden-md hidden-lg">
				<col width="13" class="hidden-xs">
				<col width="10" class="hidden-xs">
				<col width="47" class="hidden-xs">
				<col width="15" class="hidden-xs">
				<col width="15" class="hidden-xs">
			</colgroup>
			<thead class="hidden-xs" class="text-center" style="font-weight: bold; border: solid #ddd; border-width: 2px 0px; background: #f9f9f9;">
				<tr>
					<td>날짜</td>
					<td></td>
					<td>구매 상품</td>
					<td>상태</td>
					<td></td>
				</tr>
			</thead>
	<c:choose>
	<c:when test="${empty order_list}">
		<td colspan="5" class="text-center">주문하신 상품이 없습니다.</td>
	</c:when>
	<c:otherwise>
			<tbody>
				<c:forEach var="order_list" items="${order_list}">
				<tr>
					<td class="text-center hidden-xs" style="border-left: none;">${order_list.order_date}</td>
					<td style="border-right: none; border-left: none;"><img src="${pageContext.request.contextPath}${order_list.book_img_storedName}"></td> 
					<td style="border-width: 1px 0px;">
						<div class="hidden-xs">
							<a href="/customer/orderDetail.do?order_code=${order_list.order_code }">
							<b>${order_list.book_name}</b>
							<c:if test="${order_list.group_count > 1}">
								..외 ${order_list.group_count -1}건
							</c:if>
							</a><br>
							<font style="font-size: 12px;">주문번호 : ${order_list.order_code}<br></font>
							<font style="font-size: 20px; font-weight: bold;"><fmt:formatNumber value="${order_list.amount_payment}" groupingUsed="true"/>원</font>  
						</div>
						
						<div class="hidden-sm hidden-md hidden-lg">
						<a href="/customer/orderDetail.do?order_code=${order_list.order_code }">
						<b>${order_list.book_name}</b>
						<c:if test="${order_list.group_count > 1}">
							..외 ${order_list.group_count -1}건
						</c:if>
						</a><br>
						<font class="mobile_price_text">주문번호 : ${order_list.order_code}</font><br>
						<font class="mobile_price_text">${order_list.order_date}</font><br>
						<font class="mobile_total_price_text"><fmt:formatNumber value="${order_list.amount_payment}" groupingUsed="true"/>원 </font> /
						<c:choose>
							<c:when test="${order_list.delivery_status == 'W'}">
								<font class="mobile_price_text" style="font-weight: bold; color: #08a61c">배송 준비중</font>
								<c:choose>
									<c:when test="${order_list.payment_status == 'P'}">
										<font class="mobile_price_text" style="font-weight: bold; color: #08a61c">(결제 완료)</font>
									</c:when>
									<c:otherwise>
										<font class="mobile_price_text" style="font-weight: bold; color: #08a61c">(결제 대기)</font>
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:when test="${order_list.delivery_status == 'D'}">
								<font class="mobile_price_text" style="font-weight: bold; color: #a608a0">배송중</font>
							</c:when>
							<c:when test="${order_list.delivery_status == 'F'}">
								<font class="mobile_price_text" style="font-weight: bold; color: #1b34ee">배송 완료</font>
							</c:when>
						</c:choose> 
						<br><button class="btn btn-buy-col" onclick="location.href='/customer/orderDetail.do?order_code=${order_list.order_code }'" style="width: 50%; height: 30px; padding: 0;">
							상세보기
						</button>
						</div>
					</td>
					<td class="text-center hidden-xs">
						<c:choose>
							<c:when test="${order_list.delivery_status == 'W'}">
								<font style="font-weight: bold; color: #08a61c;">배송 준비중</font><br>
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
								<button type="button" class="btn btn-yet-col btn-sm" onclick="DelivTracking(${order_list.courier_number})" style="margin-left: 3px; border: 1px solid #acc; height: 23px; padding: 0;">
									배송 조회
								</button>
							</c:when>
							<c:when test="${order_list.delivery_status == 'F'}">
								<font style="font-weight: bold; color: #1b34ee;">배송 완료</font>
								<button type="button" class="btn btn-yet-col btn-sm" onclick="toBasket('all')" style="margin-left: 3px; border: 1px solid #acc; height: 23px; padding: 0;">
									배송 조회
								</button>
							</c:when>
						</c:choose>
					</td>
					<td class="text-center hidden-xs" style="border-right: none;">
						<!-- <button class="btn btn-buy-col pull-left add-cart" onclick="location.href='/customer/cancel.do'" style="width: 100%; height: 30px; padding: 0;"> -->
						<button class="btn btn-buy-col pull-left add-cart" onclick="location.href='/customer/orderDetail.do?order_code=${order_list.order_code }'" style="width: 100%; height: 30px; padding: 0;">
							상세보기
						</button>
					</td>
				</tr>
				</c:forEach>
			</tbody>
	</c:otherwise>
</c:choose>
		</table>
		<c:if test="${pageMaker.endPage > 1 }">
		<div class="cat-pagination">
			<div class="row">
				<div class="col-sm-3"></div>
				<div class="col-sm-6 text-center">
					<ul class="pagination">
						<c:if test="${pageMaker.prev }">
							<li><a href='<c:url value="/customer/orderList.do?page=${pageMaker.startPage-1 }"/>'><i class="fa fa-chevron-left"></i></a></li>
						</c:if>
						<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx" varStatus="status">
							<c:choose>
								<c:when test="${pageMaker.page == status.index }">
									<li class="active">
								</c:when>
								<c:otherwise>
									<li>
								</c:otherwise>
							</c:choose>
							<a href='<c:url value="/customer/orderList.do?page=${idx }"/>'>${idx }</a>
							</li>
						</c:forEach>
						<c:if test="${pageMaker.next && pageMaker.endPage >0 }">
							<li><a href='<c:url value="/customer/orderList.do?page=${pageMaker.endPage+1 }"/>'><i class="fa fa-chevron-right"></i></a></li>
						</c:if>
					</ul>
				</div>
				<div class="col-sm-3"></div>
			</div>
		</div>
	</c:if>
</div>

<script type="text/javascript">
	// 적용된 정렬값 select box에 적용
	$("select[name=delivery_status]  option[value=${ criteria.delivery_status }]").attr("selected", "selected");
	$("select[name=isPayment]  option[value=${ criteria.isPayment }]").attr("selected", "selected");
	
	//배송조회
	function DelivTracking(courier_number){
		var popUrl = "http://www.ilogen.com/iLOGEN.Web.New/TRACE/TraceView.aspx?gubun=slipno&slipno="+courier_number;	//팝업창에 출력될 페이지 URL
		var popOption = "width=750, height=800, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
		window.open(popUrl,"",popOption);
	}
</script>