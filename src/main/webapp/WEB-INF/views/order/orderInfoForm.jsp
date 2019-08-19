<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<form id="orderInfo">
<input type="hidden" name="order_code" value="${order_code }">
<input type="hidden" name="amount_payment" value="${inipay.price }">

<div class="col-xs-12">
<c:choose>
	<c:when test="${empty order}">
		<div class="text-center">결제할 상품이 없습니다. </div>
	</c:when>
	<c:otherwise>
	<div class="col-xs-12 text-center">
		<h2><strong>주문/결제</strong></h2>
	</div>
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
		<c:forEach var="order" items="${order}" varStatus="status">
			<tr>
			<input type="hidden" name="payment_list[${status.index}].product_no" value="${order.product_no }">
			<input type="hidden" name="payment_list[${status.index}].quantity" value="${quantity[status.index]}">
			<input type="hidden" name="payment_list[${status.index}].origin_price" value="${order.origin_price }">
			<input type="hidden" name="payment_list[${status.index}].dc_price" value="${order.dc_price }">
			
				<td><img src="${pageContext.request.contextPath}${order.book_img_storedName}" style="width: 80px;"></td>
				<td style="vertical-align: middle;">
					<a href="/book/detailView.do?product_no=${order.product_no }">${order.book_name}</a>
				</td>
				<td style="vertical-align: middle;">${quantity[status.index]}</td>
				<td id="origin_price_${status.index }" style="vertical-align: middle;"><fmt:formatNumber value="${order.origin_price*quantity[status.index]}" groupingUsed="true"/>원</td>
				<td id="dc_price_${status.index }" style="vertical-align: middle;"><fmt:formatNumber value="${order.dc_price*quantity[status.index]}" groupingUsed="true"/>원</td>
				<td style="vertical-align: middle;">기본 배송비</td>
			</tr>
			<c:set var="price_sum" value="${price_sum+(order.origin_price*quantity[status.index]) }"/>
			<c:set var="dc_price_sum" value="${dc_price_sum+(order.dc_price*quantity[status.index]) }"/>
			<c:set var="quantity_sum" value="${quantity_sum+quantity[status.index] }"/>
			<c:set var="total_price" value="${total_price+((order.origin_price-order.dc_price)*quantity[status.index]) }"/>
			<c:set var="goodsname" value="${goodsname}${order.book_name}${status.first ? '' : ','}"/> 
		</c:forEach>
			<tr style="background: #d7d9db;">
			<td colspan="7" style="text-align: right;">(30,000원 이상 결제시 배송비 무료) 기본 배송비 : 3,000원</td>
			</tr>
		</tbody>
	</table>
</c:otherwise>
</c:choose>
</div>
<c:choose>
	<c:when test="${total_price < 30000 }">
		<c:set var="shipping_fee" value="3000"/>
	</c:when>
	<c:otherwise>
		<c:set var="shipping_fee" value="0"/>
	</c:otherwise>
</c:choose>


<div class="col-xs-12" style="margin: 50px 0px; background: #f0f0f02e;">
<div class="col-md-6 cat-content">
<fieldset>
<div><legend>주문자 정보</legend></div>

<div class="form-group_height">
  <label class="col-md-3 control-label" for="textinput">주문자</label>  
  <div class="col-md-4">
  <input id="buyername" name="buyername" type="text" class="form-control input-md" value="${user.user_name }" maxlength="40">
  </div>
</div>

<div class="form-group_height">
  <label class="col-md-3 control-label" for="textinput">이메일</label>  
  <div class="col-md-5">
  <input id="buyeremail" name="buyeremail" type="text" class="form-control input-md" value="${user.email }" maxlength="50">
  </div>
</div>

<div class="form-group_height">
  <label class="col-md-3 control-label" for="textinput">휴대폰 번호</label>  
  <div class="col-md-4">
  <input id="buyertel" name="buyertel" type="text" class="form-control input-md" value="${user.phonenum1}" maxlength="25">
  </div>
</div>

<div class="form-group_height">
  <label class="col-md-3 control-label" for="textinput">전화번호</label>  
  <div class="col-md-4">
  <input id="buyertel2" name="buyertel2" type="text" class="form-control input-md" value="${user.phonenum2}" maxlength="25">
  </div>
</div>

</fieldset>
</div>
<div class="col-md-6 cat-content">
<fieldset>
<div><legend>배송 정보</legend></div>

<div class="form-group_height">
  <label class="col-md-3 control-label" for="textinput">받는분</label>  
  <div class="col-md-4">
  <input id="recipientname" name="recipientname" type="text" class="form-control input-md" value=""  maxlength="40">
  </div> 
  <div class="col-md-4" style="height: 40px; padding-top: 6px;">
  <label class="checkbox-inline">
 	 <input type="checkbox" id="same_info_chkbox"> <font>주문자 정보와 동일</font>
  </label>
  </div>
</div>

<div class="form-group_height">
  <label class="col-md-3 control-label" for="textinput">이메일</label>  
  <div class="col-md-5">
  <input id="recipientemail" name="recipientemail" type="text" class="form-control input-md" value=""  maxlength="50">
  </div>
</div>

<div class="form-group_height">
  <label class="col-md-3 control-label" for="textinput">휴대폰 번호</label>  
  <div class="col-md-4">
  <input id="recipienttel" name="recipienttel" type="text" class="form-control input-md" value=""  maxlength="25">
  </div>
</div>

<div class="form-group_height">
  <label class="col-md-3 control-label" for="textinput">전화번호</label>  
  <div class="col-md-4">
  <input id="recipienttel2" name="recipienttel2" type="text" class="form-control input-md" value=""  maxlength="25">
  </div>
</div>

<div class="form-address-group_height">
  <label class="col-md-3 control-label" for="textinput">주소</label>  
  <div class="col-md-8">
  <input id="recipient_postnum" name="recipient_postnum" type="text" class="form-control input-md" placeholder="우편 번호" readonly="readonly" value="${user.postnum}" style="width: 120px; float: left;">
  <button type="button" class="btn btn-secondary" onclick="execPostCode();">검색</button>
  <input id="recipient_address1" name="recipient_address1" class="form-control input-md" placeholder="기본 주소" readonly="readonly" value="${user.address1 }">
  <input id="recipient_address2" name="recipient_address2" class="form-control input-md" placeholder="나머지 주소" value="${user.address2 }"  maxlength="120">
  </div>
</div>

<div class="form-group_height">
  <label class="col-md-3 control-label" for="textinput">배송 메모</label>  
  <div class="col-md-8">
  <input id="buyer_memo" name="buyer_memo" type="text" class="form-control input-md" placeholder="이곳은 택배 기사님이 확인하는 메세지란입니다." maxlength="90">
  </div>
</div>
</fieldset>
</div>
</form>
</div>

<table class="table total-table" style="margin-top: 50px;">
	<tr>
		<td colspan="4" class="total-head">Total</td>
	</tr>
	<tr>
		<td>상품 금액 / <font id="total_num">${fn:length(order)}종</font> <font id="total_quantity">(${quantity_sum }개)</font> </td>
		<td>할인 금액</td>
		<td>배송비</td>
		<td>최종 금액</td>
	</tr>
	<tr>
		<td id="price_sum"><fmt:formatNumber value="${price_sum}" groupingUsed="true"/>원</td>
		<td id="dc_price_sum"><fmt:formatNumber value="${dc_price_sum}" groupingUsed="true"/>원</td>
		<td id="shipping_fee"><fmt:formatNumber value="${shipping_fee}" groupingUsed="true"/>원</td>
		<td id="total_price"><fmt:formatNumber value="${total_price+shipping_fee }" groupingUsed="true"/>원</td>
	</tr>
</table>
<div class="col-xs-12">
<div class="col-md-5"></div>
	<div class="col-md-2">
		<!-- <button class="btn btn-buy-col pull-left add-cart" onclick="document.getElementById('orderInfoSubForm').submit();" style="width: 100%; margin-bottom: 100px;"> -->
		<button type="button" class="btn btn-buy-col pull-left add-cart" onclick="orderSubFunc(); return false;" style="width: 100%; margin-bottom: 100px;">
			<i class="icon-bag"></i>&nbsp;&nbsp;결제하기
		</button>
	</div>
	<div class="col-md-5"></div>
</div>

<!-- 상용 JS(가맹점 MID 변경 시 주석 해제, 테스트용 JS 주석 처리 필수!) -->
<!--script language="javascript" type="text/javascript" src="https://stdpay.inicis.com/stdjs/INIStdPay.js" charset="UTF-8"></script-->
<form id="SendPayForm" method="POST" action="https://stdpay.inicis.com/payMain/pay" accept-charset="UTF-8">
<!-- 이니페이 테스트 -->
	<input type="hidden" name="version" value="1.0">
	<input type="hidden" name="goodname" value="${goodsname}"/>
	<%-- <input type="hidden" name="price" value="${total_price+shipping_fee }"/> --%>
	<input type="hidden" name="price" value="${total_price+shipping_fee }"/>
	<input type="hidden" name="currency" value="WON">
	<input type="hidden" name="gopaymethod" value="Card"/><!-- 카드로 -->
	<input type="hidden" name="mid" value="${inipay.mid }">
	<input type="hidden" name="oid" value="${order_code }">
	<input type="hidden" name="timestamp" value="${inipay.timestamp }">
	<input type="hidden" name="signature" value="${inipay.signature }">
	<input type="hidden" name="mKey" value="${inipay.mKey }">
	<input type="hidden" name="returnUrl" value="http://localhost:8080/order/paymentResult.do">
	<input type="hidden" name="closeUrl" value="http://localhost:8080/order/close.do">
	<input type="hidden" name="popupUrl" value="http://localhost:8080/order/popup.do">
	<!-- <input type="hidden" name="returnUrl" value="http://unionbooks.kr/order/paymentResult.do"> 변경!
	<input type="hidden" name="closeUrl" value="http://unionbooks.kr/order/close.do">
	<input type="hidden" name="popupUrl" value="http://unionbooks.kr/order/popup.do"> -->
	
	<input type="hidden" name="buyername" id="buyername_form" value="">
	<input type="hidden" name="buyeremail" id="buyeremail_form" value="">
	<input type="hidden" name="buyertel" id="buyertel_form" value="">
	<input type="hidden" name="merchantData" id="merchantData_form" value="">
	
</form>
<script language="javascript" type="text/javascript" src="https://stgstdpay.inicis.com/stdjs/INIStdPay.js" charset="UTF-8"></script>

<!-- /이니페이 테스트 -->
<script type="text/javascript">
//이니페이 결제 모듈 콜
function callInipay(){
	$("#buyername_form").val($("#buyername").val());
	$("#buyeremail_form").val($("#buyeremail").val());
	$("#buyertel_form").val($("#buyertel").val());
	$("#merchantData_form").val($("#orderInfo").serialize());
	
	INIStdPay.pay('SendPayForm');
}

//다음 우편번호 검색 함수
	function execPostCode() {
		new daum.Postcode({
			oncomplete : function(data) {
				var fullRoadAddr = data.roadAddress;
				var extraRoadAddr = '';

				if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
					extraRoadAddr += data.bname;
				}
				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraRoadAddr += (extraRoadAddr !== '' ? ', '
							+ data.buildingName : data.buildingName);
				}
				if (extraRoadAddr !== '') {
					extraRoadAddr = ' (' + extraRoadAddr + ')';
				}
				if (fullRoadAddr !== '') {
					fullRoadAddr += extraRoadAddr;
				}

				$("[name=recipient_postnum]").val(data.zonecode);
				$("[name=recipient_address1]").val(fullRoadAddr);
			}
		}).open();
	}
	
	//휴대폰 번호 자동 하이픈
	var cellPhone = document.getElementById('recipienttel');
		cellPhone.onkeyup = function(event) {
		event = event || window.event;
		var _val = this.value.trim();
		this.value = autoHypenPhone(_val);
	};
	
	//전화번호 자동 하이픈
	var cellPhone = document.getElementById('recipienttel2');
		cellPhone.onkeyup = function(event) {
		event = event || window.event;
		var _val = this.value.trim();
		this.value = autoHypenPhone(_val);
	};
	
	//휴대폰 번호 자동 하이픈
	var cellPhone = document.getElementById('buyertel');
		cellPhone.onkeyup = function(event) {
		event = event || window.event;
		var _val = this.value.trim();
		this.value = autoHypenPhone(_val);
	};
	
	//전화번호 자동 하이픈
	var cellPhone = document.getElementById('buyertel2');
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
	
	 $("#same_info_chkbox").click(function(){
		var isChecked = $(this).is(":checked");
		if(isChecked){
		$("#recipientname").val($("#buyername").val());
		$("#recipientemail").val($("#buyeremail").val());
		$("#recipienttel").val($("#buyertel").val());
		$("#recipienttel2").val($("#buyertel2").val());
		}else{
		$("#recipientname").val("");
		$("#recipientemail").val("");
		$("#recipienttel").val("");
		$("#recipienttel2").val("");
		}
	 });
</script>
<script src="${pageContext.request.contextPath}/js/availability_order.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script><script charset="UTF-8" type="text/javascript" src="http://t1.daumcdn.net/postcode/api/core/190722/1563776399461/190722.js"></script>



