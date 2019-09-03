<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="col-xs-12 text-center">
	<h2>
		<strong>주문 내역</strong>
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
		<table class="table" style="table-layout: fixed;">
			<colgroup>
				<col width="40%" class="hidden-sm hidden-md hidden-lg">
				<col width="60%" class="hidden-sm hidden-md hidden-lg" >
				<col width="15%" class="hidden-xs">
				<col width="35%" class="hidden-xs">
				<col width="10%" class="hidden-xs">
				<col width="10%" class="hidden-xs">
				<col width="10%" class="hidden-xs">
				<col width="10%" class="hidden-xs">
				<col width="10%" class="hidden-xs">
			</colgroup>
			<thead class="hidden-xs" style="font-weight: bold; border: solid #ddd; border-width: 2px 0px;">
				<tr>
					<td></td>
					<td>상품 정보</td>
					<td>수량</td>
					<td>상품 금액</td>
					<td>할인 금액</td>
					<td>합계 금액</td>
					<td>배송비</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="order_view" items="${order_view}" varStatus="status">
					<tr>
						<td><img src="${pageContext.request.contextPath}${order_view.book_img_storedName}"></td>
						<td style="vertical-align: middle;">
							<font class="mobile_product_text"><a href="/book/detailView.do?product_no=${order_view.product_no }"><b>${order_view.book_name}</b></a></font>
							<div class="hidden-sm hidden-md hidden-lg">
								<font class="mobile_price_text">상품 금액 : </font>&nbsp;<font class="mobile_price_text"><fmt:formatNumber value="${order_view.origin_price}" groupingUsed="true"/>원</font>
								<br><font class="mobile_price_text">할인 금액 : </font>&nbsp;<font class="mobile_price_text"><fmt:formatNumber value="${order_view.dc_price}" groupingUsed="true"/>원</font>
								<br><font class="mobile_total_price_text">합계 금액 : </font>&nbsp;<font class="mobile_total_price_text"><fmt:formatNumber value="${(order_view.origin_price*order_view.quantity)-(order_view.dc_price*order_view.quantity)}" groupingUsed="true"/>원</font>
								<br><font class="mobile_price_text">${order_view.quantity}개 / 기본 배송비</font>
							</div>
						</td>
						<td class="hidden-xs" style="vertical-align: middle;">${order_view.quantity}</td>
						<td class="hidden-xs" style="vertical-align: middle;"><fmt:formatNumber value="${order_view.origin_price}" groupingUsed="true" />원</td>
						<td class="hidden-xs" style="vertical-align: middle;"><fmt:formatNumber value="${order_view.dc_price}" groupingUsed="true" />원</td>
						<td class="hidden-xs" class="hidden-xs" style="vertical-align: middle;"><fmt:formatNumber value="${(order_view.origin_price*order_view.quantity)-(order_view.dc_price*order_view.quantity)}" groupingUsed="true"/>원</td>
						<td class="hidden-xs" style="vertical-align: middle;">기본 배송비</td>
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
		
		<c:choose>
			<c:when test="${total_price < 30000 }">
				<c:set var="shipping_fee" value="3000"/>
			</c:when>
			<c:otherwise>
				<c:set var="shipping_fee" value="0"/>
			</c:otherwise>
		</c:choose>

		<table class="table payInfo-table text-center" style="margin-top: 50px;">
			<tr>
				<td colspan="4" class="delivery-head" style="vertical-align: middle;"><c:choose>
						<c:when test="${order_view[0].delivery_status == 'D' }">
							<font style="color: #a608a0c2;">상품을 배송중입니다.</font>
						</c:when>
						<c:when test="${order_view[0].delivery_status == 'F' }">
							<font style="color: #1b34eebd;"> ${order_view[0].delivery_date}(<fmt:formatDate value="${order_view[0].delivery_date}" pattern="E" />) 배송 완료<br> 고객님이 주문하신 상품이 배송완료 되었습니다.
							</font>
						</c:when>
						<c:otherwise>
							<font style="color: #08a61c99;">상품을 준비중입니다. <br>신속하게 배송해 드리겠습니다.
							</font>
						</c:otherwise>
					</c:choose></td>
			</tr>
			<c:if test="${order_view[0].delivery_status != 'W' }">
				<colgroup>
					<col class="hidden-xs" style="width: 20%">
					<col class="hidden-xs" style="width: 20%">
					<col class="hidden-xs" style="width: 20%">
					<col class="hidden-xs" style="width: 20%">
					<col class="hidden-sm hidden-md hidden-lg" style="width: 35%">
					<col class="hidden-sm hidden-md hidden-lg" style="width: 65%">
				</colgroup>
				<tr class="hidden-xs">
						<td><b>택배사</b></td>
						<td><b>송장번호</b></td>
						<td><b>배송 시작일</b></td>
						<td><b>주문 조회</b></td>
				</tr>
				<tr class="hidden-xs">
					<td><c:choose>
							<c:when test="${order_view[0].courier_company == 'logen'}">
							로젠 택배
						</c:when>
							<c:otherwise>
							${order_view[0].courier_company}
						</c:otherwise>
						</c:choose></td>
					<td>${order_view[0].courier_number}</td>
					<td>${order_view[0].courier_date}</td>
					<td class="text-center">
						<button type="button" class="btn btn-yet-col btn-sm" onclick="DelivTracking(${order_view[0].courier_number})" style="border: 1px solid #acc; height: 23px; padding: 0;">배송 조회</button>
					</td>
				</tr>
				<tr class="hidden-sm hidden-md hidden-lg">
					<td>택배사</td>
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
				</tr>
				<tr class="hidden-sm hidden-md hidden-lg">
					<td>송장번호</td>
					<td>${order_view[0].courier_number}</td>
				</tr>
				<tr class="hidden-sm hidden-md hidden-lg">
					<td>배송 시작일</td>
					<td>${order_view[0].courier_date}</td>
				</tr>
				<tr class="hidden-sm hidden-md hidden-lg">
					<td>주문 조회</td>
					<td>
						<button type="button" class="btn btn-yet-col btn-sm" onclick="DelivTracking(${order_view[0].courier_number})" style="border: 1px solid #acc; height: 23px; padding: 0;">배송 조회</button>
					</td>
				</tr>
			</c:if>
		</table>

		<table class="table total-table text-center" style="margin-top: 50px;">
			<colgroup>
				<col class="hidden-xs" style="width: 25%">
				<col class="hidden-xs" style="width: 25%">
				<col class="hidden-xs" style="width: 25%">
				<col class="hidden-xs" style="width: 25%">
				<col class="hidden-xs" style="width: 25%">
				<col class="hidden-sm hidden-md hidden-lg" style="width: 50%">
				<col class="hidden-sm hidden-md hidden-lg" style="width: 50%">
			</colgroup>
			<tr>
				<td colspan="4" class="total-head hidden-xs">Total</td>
				<td colspan="2" class="total-head hidden-sm hidden-md hidden-lg">Total</td>
			</tr>
			<tr class="hidden-xs">
				<td>상품 금액 / <font id="total_num">${fn:length(order_view)}종</font> <font id="total_quantity">(${quantity_sum }개)</font> </td>
				<td>할인 금액</td>
				<td>배송비</td>
				<td>결제 금액</td>
			</tr>
			<tr class="hidden-xs">
				<td id="price_sum"><fmt:formatNumber value="${price_sum}" groupingUsed="true"/>원</td>
				<td id="dc_price_sum"><fmt:formatNumber value="${dc_price_sum}" groupingUsed="true"/>원</td>
				<td id="shipping_fee"><fmt:formatNumber value="${shipping_fee}" groupingUsed="true"/>원</td>
				<td id="total_price"><fmt:formatNumber value="${total_price+shipping_fee }" groupingUsed="true"/>원</td>
			</tr>
			<tr class="hidden-sm hidden-md hidden-lg">
				<td>상품 금액 / <font class="total_num">${fn:length(order_view)}종</font> <font class="total_quantity">(${quantity_sum }개)</font></td>
				</td>
				<td class="price_sum"><fmt:formatNumber value="${price_sum}" groupingUsed="true"/>원</td>
			</tr>	
			<tr class="hidden-sm hidden-md hidden-lg">
				<td>할인 금액</td>
				<td class="dc_price_sum"><fmt:formatNumber value="${dc_price_sum}" groupingUsed="true"/>원</td>
			</tr>	
			<tr class="hidden-sm hidden-md hidden-lg">
				<td>배송비</td>
				<td class="shipping_fee"><fmt:formatNumber value="${shipping_fee}" groupingUsed="true"/>원</td>
			</tr>	
			<tr class="hidden-sm hidden-md hidden-lg">
				<td><b>합계 금액</b></td>
				<td class="sum_price"><b><fmt:formatNumber value="${total_price+shipping_fee }" groupingUsed="true"/>원</b></td>
			</tr>	
		</table>
		
		<table class="table payInfo-table text-center" style="margin-top: 50px;">
			<tr>
				<td colspan="4" class="total-head hidden-xs">결제 정보</td>
				<td colspan="2" class="total-head hidden-sm hidden-md hidden-lg">결제 정보</td>
			</tr>
			<colgroup>
				<col class="hidden-xs" style="width: 20%">
				<col class="hidden-xs" style="width: 20%">
				<col class="hidden-xs" style="width: 20%">
				<col class="hidden-xs" style="width: 20%">
				<col class="hidden-xs" style="width: 20%">
				<col class="hidden-sm hidden-md hidden-lg" style="width: 50%">
				<col class="hidden-sm hidden-md hidden-lg" style="width: 50%">
			</colgroup>
			<tr class="hidden-xs">
				<td><b>결제 수단</b></td>
				<td><b>카드번호</b></td>
				<td><b>할부기간</b></td>
				<td><b>주문 번호</b></td>
			</tr>
			<tr class="hidden-xs">
				<td>
				<c:choose>
					<c:when test="${order_view[0].payMethod == 'VCard' || order_view[0].payMethod == 'Card'}">
						카드				
					</c:when>
					<c:otherwise>
						${order_view[0].payMethod}
					</c:otherwise>
				</c:choose>
				</td>
				<td>${order_view[0].cardNum }</td>
				<td>
					<c:choose>
						<c:when test="${order_view[0].cardQuota != null}">
							${order_view[0].cardQuota}개월
						</c:when>
						<c:otherwise>
							00개월
						</c:otherwise>
					</c:choose>
				</td>
				<td>${order_view[0].order_code }</td>
			</tr>
			<tr class="hidden-sm hidden-md hidden-lg">
				<td>결제 수단</td>
				<td>
				<c:choose>
					<c:when test="${order_view[0].payMethod == 'VCard' || order_view[0].payMethod == 'CARD'}">
						카드				
					</c:when>
					<c:otherwise>
						${order_view[0].payMethod}
					</c:otherwise>
				</c:choose>
				</td>
			</tr>
			<tr class="hidden-sm hidden-md hidden-lg">
				<td>카드번호</td>
				<td>${order_view[0].cardNum }</td>
			</tr>
			<tr class="hidden-sm hidden-md hidden-lg">
				<td>할부기간</td>
				<td>
				<c:choose>
					<c:when test="${order_view[0].cardQuota != null}">
						${order_view[0].cardQuota}개월
					</c:when>
					<c:otherwise>
						00개월
					</c:otherwise>
				</c:choose>
				</td>
			</tr>
			<tr class="hidden-sm hidden-md hidden-lg">
				<td>주문 번호</td>
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
				<col class="hidden-xs" style="width: 20%">
				<col class="hidden-xs" style="width: 80%">
				<col class="hidden-sm hidden-md hidden-lg" style="width: 30%">
				<col class="hidden-sm hidden-md hidden-lg" style="width: 70%">
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

		<div class="modal fade" id="orderCancelModal">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">×</button>
						<h4 class="modal-title text-center"><b>주문 취소</b></h4>
					</div>
					<div class="modal-body text-center" style="margin-top: 20px;">
						<form id="orderCancelForm">
							<table class="table qna_table" style="width: 80%; margin: 0 auto;">
								<colgroup>
									<col class="hidden-xs" width="30%">
									<col class="hidden-xs" width="70%">
									<col class="hidden-sm hidden-md hidden-lg" width="100%">
								</colgroup>
								<tbody style="border-bottom: 1px solid #ddd;">
									<tr class="hidden-sm hidden-md hidden-lg">
										<td class="text-center"><b>휴대폰</b></td>
									</tr>
									<tr>
										<td class="text-center hidden-xs"><b>휴대폰</b></td>
										<td>
											<div class="col-md-9">
												<input id="canceler_tel" name="canceler_tel" type="text" class="form-control" value="${order_view[0].buyertel }" maxlength="30">
											</div>
										</td>
									</tr>
									<tr class="hidden-sm hidden-md hidden-lg" style="margin-top: 20px;">
										<td class="text-center"><b>이메일</b></td>
									</tr>
									<tr>
										<td class="text-center hidden-xs"><b>이메일</b></td>
										<td>
											<div class="col-md-9">
												<input id="canceler_email" name="canceler_email" type="text" class="form-control" value="${order_view[0].buyeremail }" maxlength="70">
											</div>
										</td>
									</tr>
									<tr class="hidden-sm hidden-md hidden-lg" style="margin-top: 20px;">
										<td class="text-center"><b>취소 메세지</b></td>
									</tr>
									<tr>
										<td class="text-center hidden-xs"><b>취소 메세지</b></td>
										<td>
											<div class="col-md-9">
													<textarea class="form-control" id="cancel_msg" name="cancel_msg" rows="10" maxlength="90"></textarea>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</form>
						<div class="col-md-12" style="margin-top: 10px;">
							<button type="button" class="btn btn-buy-col" onclick="orderCancelFunc();">전송</button>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
		
		
		
		
		<div style="display: table; margin: 0 auto; margin-bottom: 100px;">
			<button class="btn btn-buy-col pull-left add-cart" onclick="location.href='/customer/orderList.do'">목록으로</button>
			<button class="btn btn-buy-col pull-left add-cart" onclick="$('#orderCancelModal').modal();" style="margin-left: 10px;">주문취소</button>
		</div>

		<script type="text/javascript">
		//휴대폰 번호 자동 하이픈
		var cellPhone = document.getElementById('canceler_tel');
			cellPhone.onkeyup = function(event) {
			event = event || window.event;
			var _val = this.value.trim();
			this.value = autoHypenPhone(_val);
		};
		
		function autoHypenPhone(str) {
			str = str.replace(/[^0-9]/g, '');
			var tmp = '';
			if (str.length < 4) {
				return str;
			} else if (str.length < 7) {
				tmp += str.substr(0, 3);
				tmp += '-';
				tmp += str.substr(3);
				return tmp;
			} else if (str.length < 11) {
				tmp += str.substr(0, 3);
				tmp += '-';
				tmp += str.substr(3, 3);
				tmp += '-';
				tmp += str.substr(6);
				return tmp;
			} else {
				tmp += str.substr(0, 3);
				tmp += '-';
				tmp += str.substr(3, 4);
				tmp += '-';
				tmp += str.substr(7);
				return tmp;
			}
			return str;
		}
		
		function orderCancelFunc(){
			if(confirm("해당 상품의 주문을 취소하시겠습니까?")){
				$.ajax({
					url:'/customer/orderCancelReqSub.do',
					type:'POST',
					data:{
						order_code:'${order_view[0].order_code }',
						tid:'${order_view[0].tid }',
						canceler_tel:$("#canceler_tel").val(),
						canceler_email:$("#canceler_email").val(),
						cancel_msg:$("#cancel_msg").val(),
						},
					dataType:'json',
					async: true,
					cache:false,
					timeout:30000,
					success:function(data){
						if(data){
							if(data.able){
								alert(data.msg);
								location.href='/customer/orderCancelList.do';
							}else{
								alert(data.msg);
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