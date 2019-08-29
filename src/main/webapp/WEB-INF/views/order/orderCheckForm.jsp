<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div class="col-xs-12">
	<form action="/order/orderingInfo.do" method="POST" id="orderInfoSubForm">
		<input type="hidden" name="order_list[0].product_no" id="product_no" value="${order[0].product_no}"> <input type="hidden" name="total_price" id="total_price" value="">
		<c:choose>
			<c:when test="${empty order}">
				<div class="text-center">결제할 상품이 없습니다.</div>
			</c:when>
			<c:otherwise>
				<div class="col-xs-12 text-center">
					<h2>
						<strong>주문 상품 확인</strong>
					</h2>
				</div>
				<table class="table table-striped">
					<colgroup>
						<col width="15%" class="hidden-xs">
						<col width="30%" class="hidden-sm hidden-md hidden-lg">
						<col width="45%">
						<col width="10%" class="hidden-xs">
						<col width="10%" class="hidden-xs">
						<col width="10%" class="hidden-xs">
						<col width="10%" class="hidden-xs">
					</colgroup>
					<thead class="hidden-xs" style="font-weight: bold; border: solid #ddd; border-width: 2px 0px;">
						<tr style="background: #f9f9f9;">
							<td></td>
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
								<td style="padding: 8px 0;"><img src="${pageContext.request.contextPath}${order.book_img_storedName}" style="max-width: 180px;"></td>
								<td style="vertical-align: middle;">
									<font class="mobile_product_text"><b><a href="/book/detailView.do?product_no=${order.product_no }">${order.book_name}</a></b></font><br>
									<div class="hidden-sm hidden-md hidden-lg">
										<font class="mobile_price_text">상품 금액 : </font>&nbsp;<font class="origin_price_${status.index } mobile_price_text"><fmt:formatNumber value="${order.origin_price}" groupingUsed="true" />원</font> 
										<br> <font class="mobile_price_text">할인 금액 : </font>&nbsp;<font class="dc_price_${status.index } mobile_price_text"><fmt:formatNumber value="${order.dc_price}" groupingUsed="true" />원</font> 
										<br><font class="mobile_price_text">기본 배송비</font> <br> <br>
										<div class="cart_quantity_button clrfix product-count pull-left">
											<a rel="nofollow" class="btn btn-default btn-minus" href="#" title="Subtract" onclick="edit_quantity_minus();">–</a> <input type="text" size="2" autocomplete="off" class="cart_quantity_input form-control grey count" id="book_quantity" name="order_list[0].quantity" value="${quantity[status.index]}" style="width: 50px; font-size: 16px;" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');"> <a rel="nofollow" class="btn btn-default btn-plus" href="#" title="Add" onclick="edit_quantity_plus();">+</a>
										</div>
									</div></td>
								<td class="hidden-xs" style="vertical-align: middle;"><input type="number" class="count" value="${quantity[status.index]}" min="1" style="width: 50px;" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');"></td>
								<td class="hidden-xs" id="origin_price_${status.index }" style="vertical-align: middle;"><fmt:formatNumber value="${order.origin_price*quantity[status.index]}" groupingUsed="true" />원</td>
								<td class="hidden-xs" id="dc_price_${status.index }" style="vertical-align: middle;"><fmt:formatNumber value="${order.dc_price*quantity[status.index]}" groupingUsed="true" />원</td>
								<td class="hidden-xs" style="vertical-align: middle;">기본 배송비</td>
							</tr>
							<c:set var="price_sum" value="${price_sum+(order.origin_price*quantity[status.index]) }" />
							<c:set var="dc_price_sum" value="${dc_price_sum+(order.dc_price*quantity[status.index]) }" />
							<c:set var="quantity_sum" value="${quantity_sum+quantity[status.index] }" />
							<c:set var="total_price" value="${total_price+((order.origin_price-order.dc_price)*quantity[status.index]) }" />

						</c:forEach>
						<tr style="background: #d7d9db;">
							<td class="hidden-xs" colspan="7" style="text-align: right;">(30,000원 이상 결제시 배송비 무료) 기본 배송비 : 3,000원</td>
							<td class="hidden-sm hidden-md hidden-lg" colspan="3" style="text-align: right;">기본 배송비 : 3,000원<br>(30,000원 이상 결제시 배송비 무료)
							</td>
						</tr>
					</tbody>
				</table>

				<c:choose>
					<c:when test="${total_price < 30000 }">
						<c:set var="shipping_fee" value="3000" />
					</c:when>
					<c:otherwise>
						<c:set var="shipping_fee" value="0" />
					</c:otherwise>

				</c:choose>
				<table class="table total-table" style="margin-top: 50px;">
					<tr>
						<td colspan="4" class="total-head hidden-xs">Total</td>
						<td colspan="2" class="total-head hidden-sm hidden-md hidden-lg">Total</td>
					</tr>
					<tr class="hidden-xs">
						<td><b>상품 금액</b></td>
						<td><b>할인 금액</b></td>
						<td><b>배송비</b></td>
						<td><b>합계 금액</b></td>
					</tr>
					<tr class="hidden-xs">
						<td class="price_sum"><fmt:formatNumber value="${price_sum}" groupingUsed="true" />원</td>
						<td class="dc_price_sum"><fmt:formatNumber value="${dc_price_sum}" groupingUsed="true" />원</td>
						<td class="shipping_fee"><fmt:formatNumber value="${shipping_fee}" groupingUsed="true" />원</td>
						<td class="sum_price" style="font-weight: bold;"><fmt:formatNumber value="${total_price+shipping_fee }" groupingUsed="true" />원</td>
					</tr>
					<tr class="hidden-sm hidden-md hidden-lg">
						<td><b>상품 금액</b></td>
						<td class="price_sum"><b><fmt:formatNumber value="${price_sum}" groupingUsed="true" />원</b></td>
					</tr>
					<tr class="hidden-sm hidden-md hidden-lg">
						<td><b>할인 금액</b></td>
						<td class="dc_price_sum"><b><fmt:formatNumber value="${dc_price_sum}" groupingUsed="true" />원</b></td>
					</tr>
					<tr class="hidden-sm hidden-md hidden-lg">
						<td><b>배송비</b></td>
						<td class="shipping_fee"><b><fmt:formatNumber value="${shipping_fee}" groupingUsed="true" />원</b></td>
					</tr>
					<tr class="hidden-sm hidden-md hidden-lg">
						<td><b>합계 금액</b></td>
						<td class="sum_price" style="font-weight: bold;"><fmt:formatNumber value="${total_price+shipping_fee }" groupingUsed="true" />원</td>
					</tr>
				</table>
			</c:otherwise>
		</c:choose>
	</form>
</div>
<div class="col-xs-12">
	<div class="col-md-5"></div>
	<div class="col-md-2">
		<button class="btn btn-buy-col pull-left add-cart" onclick="orderSubFunc();" style="width: 100%; margin-bottom: 100px;">
			<i class="icon-bag"></i>&nbsp;&nbsp;주문하기
		</button>
	</div>
	<div class="col-md-5"></div>
</div>

<script type="text/javascript">
var oldVal = ""
function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

function orderSubFunc(){
	if($(".count").val() <= 0){
		alert("주문하실 수량이 없습니다.");
		return false;
	}
	var price = $(".sum_price").html().replace(/,/,"");
	price = price.replace("원","");
	
	total_price = (parseInt(price));
	$("#total_price").val(total_price);
	$("#orderInfoSubForm").submit();
}

function edit_quantity_plus() {
	   var currentVal = parseInt($('.count').val(),10);
	   var currentVal = currentVal + 1; 
	   var price = (${order[0].origin_price} * currentVal);
	   var dc_price = (${order[0].dc_price} * currentVal);
	   var total_price = (price - dc_price);
	   
	   if(total_price < 30000){
			shipping_fee = 3000;
		}else{
			shipping_fee = 0;
		}
	   $(".price_sum").html("<b>"+comma(price)+"원</b>");
	   $(".dc_price_sum").html("<b>"+comma(dc_price)+"원</b>");
	   $(".shipping_fee").html("<b>"+comma(shipping_fee)+"원</b>");
	   $(".sum_price").html(comma(total_price+shipping_fee)+"원");
}

function edit_quantity_minus() {
	   var currentVal = parseInt($('.count').val(),10);
	   var currentVal = currentVal - 1;
	   
	   if(currentVal >= 0){
		   if(!isNaN(total_price)){
			   total_price = 0;
		   }
		   var price = (${order[0].origin_price} * currentVal);
		   var dc_price = (${order[0].dc_price} * currentVal);
		   var total_price = (price - dc_price);
		   
		   if(total_price < 30000){
				shipping_fee = 3000;
			}else{
				shipping_fee = 0;
			}
		   $(".price_sum").html("<b>"+comma(price)+"원</b>");
		   $(".dc_price_sum").html("<b>"+comma(dc_price)+"원</b>");
		   $(".shipping_fee").html("<b>"+comma(shipping_fee)+"원</b>");
		   $(".sum_price").html(comma(total_price+shipping_fee)+"원");
		}
}

$(".count").on("propertychange change keyup paste input", function() {
	    var currentVal = $(this).val();
	    if(currentVal == "") $('.count').val("1");
	    if(currentVal == oldVal) {
	        return;
	    }
	    oldVal = currentVal;
	    
	    var price = (${order[0].origin_price} * currentVal);
	    var dc_price = (${order[0].dc_price} * currentVal);
	    var total_price = (price - dc_price);
	    
	    if(total_price < 30000){
			shipping_fee = 3000;
		}else{
			shipping_fee = 0;
		}
	    
		$(".price_sum").html("<b>"+comma(price)+"원</b>");
	   	$(".dc_price_sum").html("<b>"+comma(dc_price)+"원</b>");
	   	$(".shipping_fee").html("<b>"+comma(shipping_fee)+"원</b>");
	   	$(".sum_price").html(comma(total_price+shipping_fee)+"원");
});

</script>