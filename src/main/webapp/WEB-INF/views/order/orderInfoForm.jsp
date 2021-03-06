<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<form id="orderInfo">
<input type="hidden" name="order_code" value="${order_code }">
<input type="hidden" name="amount_payment" value="${inipay.price }">
<input type="hidden" id="nonMem" value="${nonMem }">

<div class="col-xs-12">
<c:choose>
	<c:when test="${empty order}">
		<div class="text-center">결제할 상품이 없습니다.</div>
	</c:when>
	<c:otherwise>
	<div class="col-xs-12 text-center">
		<h2><strong>주문/결제</strong></h2>
	</div>
	<table class="table" style="table-layout: fixed;">
		<colgroup>
			<col width="35%" class="hidden-sm hidden-md hidden-lg" >
			<col width="65%" class="hidden-sm hidden-md hidden-lg" >
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
		<c:forEach var="order" items="${order}" varStatus="status">
			<tr>
			<input type="hidden" name="payment_list[${status.index}].product_no" value="${order.product_no }">
			<input type="hidden" name="payment_list[${status.index}].quantity" value="${quantity[status.index]}">
			<input type="hidden" name="payment_list[${status.index}].origin_price" value="${order.origin_price }">
			<input type="hidden" name="payment_list[${status.index}].dc_price" value="${order.dc_price }">
				<td style="vertical-align: middle;"><img src="${pageContext.request.contextPath}${order.book_img_storedName}"></td>
				<td style="vertical-align: middle;">
					<font class="mobile_product_text"><b><a href="/book/detailView.do?product_no=${order.product_no }">${order.book_name}</a></b></font><br>
					<div class="hidden-sm hidden-md hidden-lg">
						<font class="mobile_price_text">상품 금액 : </font>&nbsp;<font class="origin_price_${status.index } mobile_price_text" ><fmt:formatNumber value="${order.origin_price}" groupingUsed="true"/>원</font>
						<br><font class="mobile_price_text">할인 금액 : </font>&nbsp;<font class="dc_price_${status.index } mobile_price_text" ><fmt:formatNumber value="${order.dc_price}" groupingUsed="true"/>원</font>
						<br><font class="mobile_total_price_text">합계 금액 : </font>&nbsp;<font class="total_price_${status.index } mobile_total_price_text" ><fmt:formatNumber value="${(order.origin_price*quantity[status.index])-(order.dc_price*quantity[status.index])}" groupingUsed="true"/>원</font>
						<br><font class="mobile_price_text">${quantity[status.index]}개 / 기본 배송비</font>
					</div>
				</td>
				<td class="hidden-xs" style="vertical-align: middle;">${quantity[status.index]}개</td>
				<td class="hidden-xs" id="origin_price_${status.index }" style="vertical-align: middle;"><fmt:formatNumber value="${order.origin_price}" groupingUsed="true"/>원</td>
				<td class="hidden-xs" id="dc_price_${status.index }" style="vertical-align: middle;"><fmt:formatNumber value="${order.dc_price}" groupingUsed="true"/>원</td>
				<td class="hidden-xs" style="vertical-align: middle;"><fmt:formatNumber value="${(order.origin_price*quantity[status.index])-(order.dc_price*quantity[status.index])}" groupingUsed="true"/>원</td>
				<td class="hidden-xs" style="vertical-align: middle;">기본 배송비</td>
			</tr>
			<c:set var="price_sum" value="${price_sum+(order.origin_price*quantity[status.index]) }"/>
			<c:set var="dc_price_sum" value="${dc_price_sum+(order.dc_price*quantity[status.index]) }"/>
			<c:set var="quantity_sum" value="${quantity_sum+quantity[status.index] }"/>
			<c:set var="total_price_val" value="${total_price_val+((order.origin_price-order.dc_price)*quantity[status.index]) }"/>
			<c:set var="goodsname" value="${goodsname}${order.book_name}${status.first ? '' : ','}"/> 
		</c:forEach>
			<tr style="background: #d7d9db;">
			<td class="hidden-xs" colspan="8" style="text-align: right; background: #d7d9db;">(30,000원 이상 결제시 배송비 무료) 기본 배송비 : 3,000원</td>
			<td class="hidden-sm hidden-md hidden-lg" colspan="2" style="text-align: right; background: #d7d9db;">기본 배송비 : 3,000원<br>(30,000원 이상 결제시 배송비 무료)</td>
			</tr>
		</tbody>
	</table>
</c:otherwise>
</c:choose>
</div>
<c:if test="${nonMem == 'Y' }">
		<div class="col-xs-12">
			<div id="accordion-order" class="col-xs-12 hidden-sm hidden-md hidden-lg">
				<div class="accordion-group panel">
					<a href="#collapse-1" data-toggle="collapse" class="accordion-header collapsed"><b style="font-size: 11px;">(필수)비회원 개인정보 수집 이용 동의</b></a>
					<div class="collapse" id="collapse-1" style="height: 0px;">
						<div class="accordion-body">
							<div class="row">
								<div class="col-md-12" style="padding-top: 20px;">
									<pre style="white-space: pre-wrap;">- 수집항목: 성명, 이메일, 휴대폰 번호, 주소, 전화번호
- 수집/이용목적: 서비스 제공 및 계약의 이행, 구매 및 대금결제, 물품배송 또는 청구지 발송, 불만처리 등 민원처리, 회원관리 등을 위한 목적
- 이용기간: 원칙적으로 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다.
단, 관계법령의 규정에 의하여 보전할 필요가 있는 경우 일정기간 동안 개인정보를 보관할 수 있습니다.
그 밖의 사항은 (재)천주교서울대교구 가톨릭출판사 개인정보처리방침을 준수합니다.</pre>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="col-xs-12 text-center hidden-xs" style="margin: 40px 0 10px 0">
				<span><b>(필수)비회원 주문에 대한 개인정보 수집 이용 동의</b></span>
			</div>
			<div class="col-xs-12 text-center hidden-xs">
				<textarea rows="5" cols="150">
- 수집항목: 성명, 이메일, 휴대폰 번호, 주소, 전화번호
- 수집/이용목적: 서비스 제공 및 계약의 이행, 구매 및 대금결제, 물품배송 또는 청구지 발송, 불만처리 등 민원처리, 회원관리 등을 위한 목적
- 이용기간: 원칙적으로 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다.
단, 관계법령의 규정에 의하여 보전할 필요가 있는 경우 일정기간 동안 개인정보를 보관할 수 있습니다.
그 밖의 사항은 (재)천주교서울대교구 가톨릭출판사 개인정보처리방침을 준수합니다.</textarea>
			</div>
			<div class="text-center">
				<input id="nonMemAgree" type="checkbox" name="checkbox" class="stl basket_checkbox_all hidden-sm hidden-md hidden-lg"> 
				<label for="nonMemAgree" class="stl"><span></span>비회원 개인정보 수집 이용에 동의합니다.</label>
			</div>
		</div>
	</c:if>
<c:choose>
	<c:when test="${total_price_val < 30000 }">
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
<div class="col-md-4 hidden-sm hidden-md hidden-lg" style="height: 40px; padding-top: 6px;">
	<input id="same_info_chkbox_m" type="checkbox" name="checkbox" value="2" class="stl hidden-sm hidden-md hidden-lg same_info_chkbox">
	<label for="same_info_chkbox_m" class="stl hidden-sm hidden-md hidden-lg" style="margin-left: 15px;"><span></span><b>주문자 정보와 동일</b></label>
  </div>
<div class="form-group_height">
  <label class="col-md-3 control-label" for="textinput">받는분</label>  
  <div class="col-md-4">
  <input id="recipientname" name="recipientname" type="text" class="form-control input-md" value=""  maxlength="40">
  </div> 
  <div class="col-md-4 hidden-xs" style="height: 40px; padding-top: 6px;">
 	<input id="same_info_chkbox_pc" type="checkbox" name="checkbox" value="2" class="stl same_info_chkbox">
	<label for="same_info_chkbox_pc" class="stl hidden-xs" style="margin-left: 15px;"><span></span><b>주문자 정보와 동일</b></label>
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
<div class="col-xs-12">
<table class="table total-table">
	<tr>
		<td colspan="4" class="total-head hidden-xs">Total</td>
		<td colspan="2" class="total-head hidden-sm hidden-md hidden-lg">Total</td>
	</tr>
	<tr class="hidden-xs">
		<td>상품 금액 / <font id="total_num">${fn:length(order)}종</font> <font id="total_quantity">(${quantity_sum}개)</font> </td>
		<td>할인 금액</td>
		<td>배송비</td>
		<td>최종 금액</td>
	</tr>
	<tr class="hidden-xs">
		<td id="price_sum"><fmt:formatNumber value="${price_sum}" groupingUsed="true"/>원</td>
		<td id="dc_price_sum"><fmt:formatNumber value="${dc_price_sum}" groupingUsed="true"/>원</td>
		<td id="shipping_fee"><fmt:formatNumber value="${shipping_fee}" groupingUsed="true"/>원</td>
		<td id="total_price"><fmt:formatNumber value="${total_price_val+shipping_fee }" groupingUsed="true"/>원</td>
	</tr>
	<tr class="hidden-sm hidden-md hidden-lg">
		<td>상품 금액 / <font class="total_num">${fn:length(order)}종</font> <font class="total_quantity">(${quantity_sum }개)</font></td>
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
		<td class="sum_price"><b><fmt:formatNumber value="${total_price_val+shipping_fee }" groupingUsed="true"/>원</b></td>
	</tr>	
</table>
</div>
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


<form id="SendPayForm" method="POST" action="https://stdpay.inicis.com/payMain/pay" accept-charset="UTF-8">
<!-- 이니페이 테스트 -->
	<input type="hidden" name="version" value="1.0">
	<input type="hidden" name="goodname" value="${goodsname}"/>
	<%-- <input type="hidden" name="price" value="${total_price_val+shipping_fee }"/> --%>
	<input type="hidden" name="price" value="${total_price_val+shipping_fee }"/>
	<input type="hidden" name="currency" value="WON">
	<input type="hidden" name="gopaymethod" value="Card"/><!-- 카드로 -->
	<input type="hidden" name="mid" value="${inipay.mid }">
	<input type="hidden" name="oid" value="${order_code }">
	<input type="hidden" name="timestamp" value="${inipay.timestamp }">
	<input type="hidden" name="signature" value="${inipay.signature }">
	<input type="hidden" name="mKey" value="${inipay.mKey }">
	<input type="hidden" name="returnUrl" value="${pageContext.request.scheme}://localhost:8080/order/paymentResult.do">
	<input type="hidden" name="closeUrl" value="${pageContext.request.scheme}://localhost:8080/order/close.do">
	<input type="hidden" name="popupUrl" value="${pageContext.request.scheme}://localhost:8080/order/popup.do">
	<%-- <input type="hidden" name="returnUrl" value="${pageContext.request.scheme}://${pageContext.request.serverName}/order/paymentResult.do"> 변경!
	<input type="hidden" name="closeUrl" value="${pageContext.request.scheme}://${pageContext.request.serverName}/order/close.do">
	<input type="hidden" name="popupUrl" value="${pageContext.request.scheme}://${pageContext.request.serverName}/order/popup.do"> --%>
	
	<input type="hidden" name="buyername" id="buyername_form" value="">
	<input type="hidden" name="buyeremail" id="buyeremail_form" value="">
	<input type="hidden" name="buyertel" id="buyertel_form" value="">
	<input type="hidden" name="merchantData" id="merchantData_form" value="">
</form>

<form id="SendMobilePayForm" method="POST" action="https://mobile.inicis.com/smart/wcard/" target="BTPG_WALLET" accept-charset="EUC-KR">
	<!-- <input type="hidden" name="P_MID" value="INIpayTest">
	<input type="hidden" name="P_AMT" value="1000"/> -->
	<input type="hidden" name="P_MID" value="${inipay.mid }">
	<input type="hidden" name="P_AMT" value="${total_price_val + shipping_fee}"/>
	<input type="hidden" name="P_OID" value="${order_code }">
	<input type="hidden" name="P_UNAME" id="P_UNAME" value="">
	<input type="hidden" name="P_GOODS" id="P_GOODS" value="${goodsname}">
	<%-- <input type="hidden" name="P_NEXT_URL" value="${pageContext.request.scheme}://${pageContext.request.serverName}/order/paymentMobileResult.do"> 변경!
	<input type="hidden" name="P_NOTI_URL" value="${pageContext.request.scheme}://${pageContext.request.serverName}/payment/mobileNoti.do"> --%>
	<input type="hidden" name="P_NEXT_URL" value="${pageContext.request.scheme}://192.168.0.100:8080/order/paymentMobileResult.do">
	<input type="hidden" name="P_NOTI_URL" value="${pageContext.request.scheme}://192.168.0.100:8080/payment/mobileNoti.do">
	<input type="hidden" name="P_RESERVED" value="twotrs_isp=Y&block_isp=Y&twotrs_isp_noti=N&ismart_use_sign=Y&vbank_receipt=Y&bank_receipt=N&apprun_check=Y">
	<input type="hidden" name="P_HPP_METHOD" value="1">
	<input type="hidden" name="P_EMAIL" id="P_EMAIL" value="">
	<input type="hidden" name="P_MOBILE" id="P_MOBILE" value="">
	<input type="hidden" name="P_NOTI" id="P_NOTI" value="">
</form>
<script language="javascript" type="text/javascript" src="https://stdpay.inicis.com/stdjs/INIStdPay.js" charset="UTF-8"></script>
<!-- <script language="javascript" type="text/javascript" src="https://stgstdpay.inicis.com/stdjs/INIStdPay.js" charset="UTF-8"></script> -->

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

function mobile_callInipay(){
	$("#P_UNAME").val($("#buyername").val());
	$("#P_EMAIL").val($("#buyeremail").val());
	$("#P_MOBILE").val($("#buyertel").val());
	$("#P_NOTI").val($("#orderInfo").serialize().replace(/&/gi,"#!"));
	
	
	var width = 330;
	var height = 480;
	var xpos = (screen.width - width) / 2;
	var ypos = (screen.width - height) / 2;
	var position = "top=" + ypos + ",left=" + xpos;
	var features = position + ", width=320, height=440";
	var wallet = window.open("", "BTPG_WALLET", features);
	
	if (wallet == null){
		if((webbrowser.indexOf("Windows NT 5.1")!=-1) && (webbrowser.indexOf("SV1")!=-1)){    // Windows XP Service Pack 2
			alert("팝업이 차단되었습니다. 브라우저의 상단 노란색 [알림 표시줄]을 클릭하신 후 팝업창 허용을 선택하여 주세요.");
		}else{
			alert("팝업이 차단되었습니다.");
		}return false;
	}
	$("#SendMobilePayForm").submit();
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
	
	 $(".same_info_chkbox").click(function(){
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



