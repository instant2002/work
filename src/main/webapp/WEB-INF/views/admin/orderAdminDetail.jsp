<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="col-xs-12 text-center">
	<h2>
		<strong>고객 주문 내역</strong>
	</h2>
</div>
<c:choose>
	<c:when test="${empty order_view}">
		<div class="text-center" style="margin-bottom: 100px;">
			<h2>
				조회하신 주문 내역이 없습니다.<br>다시 시도해주시기 바랍니다.
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
				<c:forEach var="order_view" items="${order_view}" varStatus="status">
					<tr>
						<td><img src="${pageContext.request.contextPath}${order_view.book_img_storedName}" style="width: 80px;"></td>
						<td style="vertical-align: middle;"><a href="/book/detailView.do?product_no=${order_view.product_no }">${order_view.book_name}</a></td>
						<td style="vertical-align: middle;">${order_view.quantity}</td>
						<td style="vertical-align: middle;"><fmt:formatNumber value="${order_view.origin_price*order_view.quantity}" groupingUsed="true" />원</td>
						<td style="vertical-align: middle;"><fmt:formatNumber value="${order_view.dc_price*order_view.quantity}" groupingUsed="true" />원</td>
						<td style="vertical-align: middle;">기본 배송비</td>
					</tr>

					<c:set var="price_sum" value="${price_sum+(order_view.origin_price*order_view.quantity) }" />
					<c:set var="dc_price_sum" value="${dc_price_sum+(order_view.dc_price*order_view.quantity) }" />
					<c:set var="quantity_sum" value="${quantity_sum+order_view.quantity }" />
					<c:set var="total_price" value="${total_price+((order_view.origin_price-order_view.dc_price)*order_view.quantity) }" />
				</c:forEach>
				<tr style="background: #d7d9db;">
					<td class="hidden-xs" colspan="7" style="text-align: right; background: #d7d9db;">(30,000원 이상 결제시 배송비 무료) 기본 배송비 : 3,000원</td>
					<td class="hidden-sm hidden-md hidden-lg" colspan="2" style="text-align: right; background: #d7d9db;">기본 배송비 : 3,000원<br>(30,000원 이상 결제시 배송비 무료)</td>
				</tr>
			</tbody>
		</table>

		<table class="table payInfo-table text-center" style="margin-top: 50px;">
			<tr>
				<td colspan="4" class="delivery-head" style="vertical-align: middle;"><c:choose>
						<c:when test="${order_view[0].delivery_status == 'D' }">
							<font style="color: #a608a0c2;"> 상품이 배송중입니다. </font>
						</c:when>
						<c:when test="${order_view[0].delivery_status == 'F' }">
							<font style="color: #1b34eebd;"> ${order_view[0].delivery_date}(<fmt:formatDate value="${order_view[0].delivery_date}" pattern="E" />) 배송 완료
							</font>
						</c:when>
						<c:otherwise>
							<font style="color: #08a61c99;">상품 배송이 필요한 주문입니다.
							</font>
						</c:otherwise>
					</c:choose></td>
			</tr>
			<c:if test="${order_view[0].delivery_status != 'W' }">
			<colgroup>
					<col style="width: 20%">
					<col style="width: 20%">
					<col style="width: 20%">
					<col style="width: 20%">
			</colgroup>
			<tr>
				<td><b>택배사</b></td>
				<td><b>송장번호</b></td>
				<td><b>배송 시작일</b></td>
				<td><b>주문 번호</b></td>
			</tr>
			<tr>
				<td>
					<c:choose>
						<c:when test="${order_view[0].courier_company == 'logen'}">
							로젠 택배
						</c:when>
						<c:otherwise>
							${order_view[0].courier_company}
						</c:otherwise>
					</c:choose>
				</td>
				<td>${order_view[0].courier_number}</td>
				<td>${order_view[0].courier_date}</td>
				<td class="text-center">
					<button type="button" class="btn btn-yet-col btn-sm" onclick="DelivTracking(${order_view[0].courier_number})" style="border: 1px solid #acc; height: 23px; padding: 0;">
						배송 조회
					</button>
				</td>
			</tr>
		</c:if>
		</table>
		
		<c:choose>
			<c:when test="${total_price < 30000 }">
				<c:set var="shipping_fee" value="3000"/>
			</c:when>
			<c:otherwise>
				<c:set var="shipping_fee" value="0"/>
			</c:otherwise>
		</c:choose>

		<table class="table total-table" style="margin-top: 50px;">
			<tr>
				<td colspan="4" class="total-head">결제 내역</td>
			</tr>
			<tr>
				<td>상품 금액 / <font id="total_num">${fn:length(order_view)}종</font> <font id="total_quantity">(${quantity_sum }개)</font>
				</td>
				<td>할인 금액</td>
				<td>배송비</td>
				<td>결제 금액</td>
			</tr>
			<tr>
				<td id="price_sum"><fmt:formatNumber value="${price_sum}" groupingUsed="true" />원</td>
				<td id="dc_price_sum"><fmt:formatNumber value="${dc_price_sum}" groupingUsed="true" />원</td>
				<td id="shipping_fee"><fmt:formatNumber value="${shipping_fee}" groupingUsed="true"/>원</td>
				<td id="total_price"><fmt:formatNumber value="${total_price+shipping_fee }" groupingUsed="true" />원</td>
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
						<c:when test="${order_view[0].payMethod == 'VCard' || order_view[0].payMethod == 'CARD'}">
				카드				
			</c:when>
						<c:otherwise>
				${order_view[0].payMethod}
			</c:otherwise>
					</c:choose></td>
				<td>${order_view[0].cardNum }</td>
				<td>${order_view[0].cardQuota }개월</td>
				<td>${order_view[0].order_code }</td>

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
					<td>${order_view[0].recipientname }</td>
				</tr>
				<tr>
					<th class="text-center"><b>연락처</b></th>
					<td>${order_view[0].recipienttel }</td>
				</tr>
				<tr>
					<th class="text-center"><b>주소</b></th>
					<td>(${order_view[0].recipient_postnum })${order_view[0].recipient_address1 } ${order_view[0].recipient_address2 }</td>
				</tr>
				<tr>
					<th class="text-center"><b>배송요청사항</b></th>
					<td>${order_view[0].buyer_memo }</td>
				</tr>
			</tbody>
		</table>
		
		<table class="table deliveryInfo-table" style="margin: 50px 0px;">
			<thead>
				<tr>
					<td colspan="5" class="total-head">배송하기</td>
				</tr>
			</thead>
			<colgroup>
				<col style="width: 20%">
				<col style="width: 80%">
			</colgroup>
			<tbody style="border-bottom: 1px solid #ddd;">
				<form action="/customer/deliverySub.do" method="POST">
					<tr>
						<th class="text-center"><b>택배사</b></th>
						<td><select class="" name="courier_company" id="courier_company" style="cursor: pointer; ">
								<option value="logen" selected="selected">로젠</option>
								<option value="logen">차후 추가되면..</option>
							</select></td>
					</tr>
					<tr>
						<th class="text-center"><b>송장번호</b></th>
						<td><input type="text" name="courier_number" id="courier_number" value="${courier.courier_number }"></td>
					</tr>
					<tr>
						<th class="text-center"><b>배송 상태</b></th>
						<td>
							<label class="checkbox-inline" for="courier_status_001"> <input type="radio" name="courier_status" id="courier_status_001" value="W" checked="checked"> 배송전</label>
							<label class="checkbox-inline" for="courier_status_002"> <input type="radio" name="courier_status" id="courier_status_002" value="D"> 배송중</label>
							<label class="checkbox-inline" for="courier_status_003"> <input type="radio" name="courier_status" id="courier_status_003" value="F"> 배송완료</label>
						</td>
					</tr>
				</form>
			</tbody>
		</table>

		<div class="col-xs-12" style="margin-bottom: 100px;">
			<div class="col-md-4"></div>
			<div class="col-md-4">
				<div class="col-md-12">
					<button class="btn btn-buy-col pull-left add-cart" onclick="location.href='/admin/orderList.do'">목록으로</button>
					<button class="btn btn-buy-col pull-left add-cart" onclick="deliveryFunc(); return false;" style="margin-left: 10px;">등록하기</button>
				</div>
			</div>
			<div class="col-md-4"></div>
		</div>
		
	<script type="text/javascript">
	//데이터 받아서 라디오 체크시키기
	$("input:radio[name=courier_status][value=" + '<c:out value="${courier.courier_status }"/>' + "]").attr("checked","checked");
	
	function deliveryFunc(){
		if(confirm("배송 상태를 변경하시겠습니까?")){
			$.ajax({
				url:'/admin/deliverySub.do',
				type:'POST',
				data:{
					courier_company:$("#courier_company").val(),
					order_code:'${order_view[0].order_code}',
					courier_number:$("#courier_number").val(),
					courier_status:$('input[name="courier_status"]:checked').val()
					},
				dataType:'json',
				async: true,
				cache:false,
				timeout:30000,
				success:function(data){
					if(data){
						if(data){
							location.href='/admin/orderDetail.do?order_code=${order_view[0].order_code}';
						}else{
							alert("오류 발생");
						}
					}else{
						alert("처리 중 오류가 발생하였습니다.\n지속적인 오류가 발생될 시 고객센터에 문의해 주시기 바랍니다.");
					}
				},
				error:function(){
					alert("처리 중 오류가 발생하였습니다.\n지속적인 오류가 발생될 시 고객센터에 문의해 주시기 바랍니다.");
				}
			});
		}
	}
	
	//배송조회
	function DelivTracking(courier_number){
		var popUrl = "http://www.ilogen.com/iLOGEN.Web.New/TRACE/TraceView.aspx?gubun=slipno&slipno="+courier_number;	//팝업창에 출력될 페이지 URL
		var popOption = "width=750, height=800, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
		window.open(popUrl,"",popOption);
	}
	</script>
	</c:otherwise>
</c:choose>