<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="col-xs-12">
	<div class="col-xs-12 text-center" style="border: 1px solid #ddd; border-width: 2px 0px;">
		<h2>
			<strong>고객 주문 취소 내역</strong>
		</h2>
	</div>
	<form action="/admin/orderCancelList.do" id="orderingForm">
		<div class="col-xs-12" style="margin-top: 20px;">
			<div class="row">
				<div class="col-md-4"></div>
				<div class="col-md-3">
					<div class="row no-gutter form-group">
						<input type="text" name="fromDate" id="fromDate" placeholder="날짜(부터)" style="padding: 0;" value="${criteria.fromDate }">
					</div>
				</div>
				<div class="col-md-3">
					<div class="row no-gutter form-group">
						<input type="text" name="toDate" id="toDate" placeholder="날짜(까지)" style="padding: 0;" value="${criteria.toDate }">
					</div>
				</div>
				<div class="col-md-2">
					<button class="btn btn-yet-col" type="button" onclick="location.href='/admin/orderCancelList.do?page=${pageMaker.page}&order_code=${criteria.order_code}&user_id=${criteria.user_id}&refund_status=${criteria.refund_status}'" style="font-size: 12px; padding: 2px 10px; font-family: -webkit-body;">전체날짜</button>
				</div>
			</div>
		</div>
		<div class="col-xs-12">
			<input type="hidden" name="keyword" value="">
			<div class="cat-view-options" style="border: none; margin: 15px 0 0 0;">
				<div class="row">
					<div class="col-md-1"></div>
					<div class="col-md-3">
						<div class="row no-gutter form-group">
							<input type="text" id="search_order_code" name="order_code" placeholder="주문번호" style="padding: 0;" value="${criteria.order_code }">
						</div>
					</div>
					<div class="col-md-3">
						<div class="row no-gutter form-group">
							<input type="text" id="search_user_id" name="user_id" placeholder="아이디" style="padding: 0;" value="${criteria.user_id }">
						</div>
					</div>
					<div class="col-md-3">
						<div class="row no-gutter form-group">
							<div class="col-md-12">
								<select class="form-control cvo-control s-styled hasCustomSelect" name="refund_status" style="cursor: pointer;">
									<option value="">전체</option>
									<option value="R">취소 처리중</option>
									<option value="F">취소 완료</option>
								</select>
							</div>
						</div>
					</div>
					<div class="col-md-2 text-left">
						<button class="btn btn-yet-col" type="button" onclick="document.getElementById('orderingForm').submit();" style="font-size: 12px; padding: 2px 10px; font-family: -webkit-body;">적용</button>
						<button class="btn btn-yet-col" type="button" onclick="location.href='/admin/orderCancelList.do?page=${pageMaker.page}'" style="font-size: 12px; padding: 2px 10px; font-family: -webkit-body;">초기화</button>
					</div>
				</div>
			</div>
		</div>
	</form>
	<table class="table table-hover order_history" style="table-layout: fixed;">
		<colgroup>
			<col width="13%" />
			<col width="12%" />
			<col width="45%" />
			<col width="15%" />
			<col width="15%" />
		</colgroup>
		<thead class="text-center" style="font-weight: bold; border: solid #ddd; border-width: 2px 0px; background: #f9f9f9;">
			<tr>
				<td>신청 날짜</td>
				<td></td>
				<td>구매 상품</td>
				<td>상태</td>
				<td></td>
			</tr>
		</thead>
		<c:choose>
			<c:when test="${empty cancel_list}">
				<td colspan="5" class="text-center">주문 취소 상품이 없습니다.</td>
			</c:when>
			<c:otherwise>
				<tbody>
					<c:forEach var="cancel_list" items="${cancel_list}">
						<tr>
							<td class="text-center" style="border-left: none;">${cancel_list.cancel_rquest_date}</td>
							<td style="border: none;"><img src="${pageContext.request.contextPath}${cancel_list.book_img_storedName}"></td>
							<td style="border-width: 1px 1px 1px 0px;"><a href="/admin/orderCancelDetail.do?order_code=${cancel_list.order_code }"> <b>${cancel_list.book_name}</b> <c:if test="${cancel_list.group_count > 1}">
							..외 ${cancel_list.group_count -1}건
						</c:if>
							</a><br> <font style="font-size: 12px;">주문번호 : ${cancel_list.order_code}<br></font> <font style="font-size: 12px;">아이디 : ${cancel_list.user_id}<br></font> <font style="font-size: 20px; font-weight: bold;"><fmt:formatNumber value="${cancel_list.amount_payment}" groupingUsed="true" />원</font></td>
							<td class="text-center"><c:choose>
									<c:when test="${cancel_list.refund_status == 'R'}">
										<font style="font-weight: bold; color: #a608a0;">취소 처리중</font>
									</c:when>
									<c:when test="${cancel_list.refund_status == 'F'}">
										<font style="font-weight: bold; color: #08a61c99;">취소 완료</font>
									</c:when>
								</c:choose></td>
							<td class="text-center" style="border-right: none;">
								<!-- <button class="btn btn-buy-col pull-left add-cart" onclick="location.href='/admin/cancel.do'" style="width: 100%; height: 30px; padding: 0;"> -->
								<button type="button" class="btn btn-buy-col pull-left add-cart" onclick="location.href='/admin/orderCancelDetail.do?order_code=${cancel_list.order_code }'" style="width: 100%; height: 30px; padding: 0;">상세보기</button>
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
							<li><a href='<c:url value="/admin/orderCancelList.do?page=${pageMaker.startPage-1 }"/>'><i class="fa fa-chevron-left"></i></a></li>
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
							<a href='<c:url value="/admin/orderCancelList.do?page=${idx }"/>'>${idx }</a>
							</li>
						</c:forEach>
						<c:if test="${pageMaker.next && pageMaker.endPage >0 }">
							<li><a href='<c:url value="/admin/orderCancelList.do?page=${pageMaker.endPage+1 }"/>'><i class="fa fa-chevron-right"></i></a></li>
						</c:if>
					</ul>
				</div>
				<div class="col-sm-3"></div>
			</div>
		</div>
	</c:if>
</div>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="${pageContext.request.contextPath}/js/datepicker-ko.js"></script>
<script type="text/javascript">
	// 적용된 정렬값 select box에 적용
	$("select[name=refund_status]  option[value=${ criteria.refund_status }]").attr("selected", "selected");
	
	$(function() {
        //오늘 날짜를 출력
        $("#today").text(new Date().toLocaleDateString());

        //datepicker 한국어로 사용하기 위한 언어설정
        $.datepicker.setDefaults($.datepicker.regional['ko']); 
        
        // 시작일(fromDate)은 종료일(toDate) 이후 날짜 선택 불가
        // 종료일(toDate)은 시작일(fromDate) 이전 날짜 선택 불가

        //시작일.
        $('#fromDate').datepicker({
            dateFormat: "yy-mm-dd",             // 날짜의 형식
            changeMonth: true,                  // 월을 이동하기 위한 선택상자 표시여부
            //minDate: 0,                       // 선택할수있는 최소날짜, ( 0 : 오늘 이전 날짜 선택 불가)
            onClose: function( selectedDate ) {    
                // 시작일(fromDate) datepicker가 닫힐때
                // 종료일(toDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
                $("#toDate").datepicker( "option", "minDate", selectedDate );
            }                
        });

        //종료일
        $('#toDate').datepicker({
            dateFormat: "yy-mm-dd",
            changeMonth: true,
            //minDate: 0, // 오늘 이전 날짜 선택 불가
            onClose: function( selectedDate ) {
                // 종료일(toDate) datepicker가 닫힐때
                // 시작일(fromDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정 
                $("#fromDate").datepicker( "option", "maxDate", selectedDate );
            }                
        });
    });
</script>