<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div class="col-xs-12">
<form action="/order/orderingInfo.do" method="POST" id="orderInfoSubForm">

<c:choose>
	<c:when test="${empty order}">
		<div class="text-center">결제할 상품이 없습니다. </div>
	</c:when>
	<c:otherwise>
	<div class="col-xs-12 text-center">
		<h2><strong>주문 상품 확인</strong></h2>
	</div>
	<table class="table table-striped">
		<thead style="font-weight: bold; border: solid #ddd; border-width: 2px 0px;">
			<tr style="background: #f9f9f9;">
				<td style="width: 16px;"><input type="checkbox" id="order_checkbox_all" checked="checked"></td>
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
		<input type="hidden" value="${order.product_no }" id="product_no_${status.index}">
			<tr>
				<td style="vertical-align: middle;"><input type="checkbox" class="order_checkbox" id="order_checkbox_${status.index}" checked="checked" value="${status.index}"></td>
				<td><img src="${pageContext.request.contextPath}${order.book_img_storedName}" style="width: 80px;"></td>
				<td style="vertical-align: middle;">
					<a href="/book/detailView.do?product_no=${order.product_no }">${order.book_name}</a>
				</td>
				<td style="vertical-align: middle;"><input type="number" value="${quantity[status.index]}" id="quantity_${status.index }" min="1" style="width: 50px;" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');"></td>
				<td id="origin_price_${status.index }" style="vertical-align: middle;"><fmt:formatNumber value="${order.origin_price*quantity[status.index]}" groupingUsed="true"/>원</td>
				<td id="dc_price_${status.index }" style="vertical-align: middle;"><fmt:formatNumber value="${order.dc_price*quantity[status.index]}" groupingUsed="true"/>원</td>
				<td style="vertical-align: middle;">기본 배송비</td>
			</tr>
			<c:set var="price_sum" value="${price_sum+(order.origin_price*quantity[status.index]) }"/>
			<c:set var="dc_price_sum" value="${dc_price_sum+(order.dc_price*quantity[status.index]) }"/>
			<c:set var="quantity_sum" value="${quantity_sum+quantity[status.index] }"/>
			<c:set var="total_price" value="${total_price+((order.origin_price-order.dc_price)*quantity[status.index]) }"/>
			
		</c:forEach>
			<tr style="background: #d7d9db;">
			<td colspan="7" style="text-align: right;">(30,000원 이상 결제시 배송비 무료) 기본 배송비 : 3,000원</td>
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
		<td id="total_price"><fmt:formatNumber value="${total_price+3000 }" groupingUsed="true"/>원</td>
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
<c:forEach var="order" items="${order}" varStatus="status">
var price_${status.index} = ${order.origin_price};
var dc_price_${status.index} = ${order.dc_price};
var quantity_${status.index} = ${quantity[status.index]};

var price_calc_${status.index} = ${order.origin_price};
var dc_price_calc_${status.index} = ${order.dc_price};
var quantity_calc_${status.index} = ${quantity[status.index]};
</c:forEach>

var total_price = 0;
var total_quantity = 0;
var total_dc_price = 0
var total_quantity = 0;
var shipping_fee = 0;
var oldVal = ""

function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

function orderSubFunc(){
	var checkedVal = new Array();
	<c:forEach var="order" items="${order}" varStatus="status">
		checkedVal[${status.index}] = $("#order_checkbox_${status.index}:checked").val();
	</c:forEach>
	
	if($(".order_checkbox:checked").length == 0){
		alert("선택된 제품이 없습니다.");
		return false;
	}
	
	if($("#total_price").html() == "3,000원"){
		alert("주문하실 수량이 없습니다.");
		return false;
	}
	
	var price = $("#total_price").html().replace(/,/,"");
	price = price.replace("원","");
	
	for(var i=0;i<checkedVal.length;i++){
		if(checkedVal[i] != undefined){
			product_no_input = '<input type="hidden" name="order_list['+checkedVal[i]+'].product_no" value="'+$("#product_no_"+checkedVal[i]).val()+'"/>';
			quantity_input = '<input type="hidden" name="order_list['+checkedVal[i]+'].quantity" value="'+$("#quantity_"+checkedVal[i]).val()+'"/>';
			total_price = '<input type="hidden" name="total_price" value="'+(parseInt(price))+'"/>';
			$("#orderInfoSubForm").append(product_no_input);
			$("#orderInfoSubForm").append(quantity_input);
			if(i==0)$("#orderInfoSubForm").append(total_price);
		}
	$("#orderInfoSubForm").submit();
	}
}

$(document).ready(function(){
	
	$("#order_checkbox_all").click(function(){
		var isChecked = $(this).is(":checked");
		$(".order_checkbox").prop("checked", isChecked);
		
		if(isChecked == false){
			total_price = 0;
			total_dc_price = 0;
			total_quantity = 0;
			shipping_fee = 0;
			<c:forEach var="order" items="${order}" varStatus="status">
			quantity_calc_${status.index} = 0;
			</c:forEach>
		}else{
			<c:forEach var="order" items="${order}" varStatus="status">
			total_price += price_${status.index}*Number($("#quantity_"+${status.index}).val());
			total_dc_price += dc_price_${status.index}*Number($("#quantity_"+${status.index}).val());
			total_quantity += Number($("#quantity_"+${status.index}).val());
			quantity_calc_${status.index} = Number($("#quantity_"+${status.index}).val());
			if(total_price-total_dc_price < 30000){
				shipping_fee = 3000;
			}else{
				shipping_fee = 0;
			}
			</c:forEach>
		}
		
		$("#total_quantity").html("("+total_quantity+")개");
		$("#total_num").html($(".order_checkbox:checked").length +"종");
		$("#price_sum").html(comma(total_price)+"원");
		$("#dc_price_sum").html(comma(total_dc_price)+"원");
		$("#total_price").html(comma(total_price-total_dc_price+shipping_fee)+"원");
		$("#shipping_fee").html(comma(shipping_fee)+"원");
		
		total_price = 0;
		total_dc_price = 0;
		shipping_fee = 0;
		total_quantity = 0;
	});
	
	$(".order_checkbox").click(function(){
		var isChecked = $(this).is(":checked");
		var cb_count = $(".order_checkbox").length;
		var cb_count_chk = $(".order_checkbox:checked").length;
		if(cb_count == cb_count_chk){
			active = true;
			isChecked = true;
		}else{
			active = false;
		}
		if($("#order_checkbox_all").is(":checked") || active){
			$("#order_checkbox_all").prop("checked", isChecked);
			}
		$("#total_num").html($(".order_checkbox:checked").length+"종");
	
		var checkbox_num = $(this).val();
		
		if(isChecked == false){
			window["price_calc_"+checkbox_num] = 0;
			window["dc_price_calc_"+checkbox_num] = 0;
			window["quantity_calc_"+checkbox_num] = 0;
		}else{
			window["price_calc_"+checkbox_num] = window["price_"+checkbox_num];
			window["dc_price_calc_"+checkbox_num] = window["dc_price_"+checkbox_num];
			window["quantity_calc_"+checkbox_num] = Number($("#quantity_"+checkbox_num).val());
		}
		
		<c:forEach var="order" items="${order}" varStatus="status">
		total_price += (price_${status.index}) * quantity_calc_${status.index};
		total_dc_price += (dc_price_${status.index} * quantity_calc_${status.index});
		total_quantity += quantity_calc_${status.index};
		</c:forEach>
		
		if(total_price-total_dc_price < 30000){
			shipping_fee = 3000;
		}else{
			shipping_fee = 0;
		}
		if(total_price == 0) shipping_fee = 0;
		 
		$("#price_sum").html(comma(total_price)+"원");
		$("#dc_price_sum").html(comma(total_dc_price)+"원");
		$("#total_price").html(comma((total_price-total_dc_price)+shipping_fee)+"원");
		$("#total_quantity").html("("+total_quantity+"개)");
		$("#shipping_fee").html(comma(shipping_fee)+"원");
		
		total_price = 0;
		total_dc_price = 0;
		shipping_fee = 0;
		total_quantity = 0;
		shipping_fee = 0;
		});
	 
	$("input[id^='quantity_']").on("propertychange change keyup paste input", function() {
		var quantity_val = $(this).val();
		var select_val = $(this).attr('id').substr($(this).attr('id').length-1);
		var isChecked = $("#order_checkbox_"+select_val).is(":checked");
		
		if(quantity_val == "") $('#quantity_'+select_val).val("1");
	    if(quantity_val == oldVal) {
	        return;
	    }
	    oldVal = quantity_val;
		
		window["price_calc_"+select_val] = window["price_"+select_val] * quantity_val;
		window["dc_price_calc_"+select_val] = window["dc_price_"+select_val] * quantity_val;
		window["quantity_calc_"+select_val] = Number(quantity_val);
		
		<c:forEach var="order" items="${order}" varStatus="status">
		total_price += (price_${status.index}) * quantity_calc_${status.index};
		total_dc_price += (dc_price_${status.index} * quantity_calc_${status.index});
		total_quantity += quantity_calc_${status.index};
		</c:forEach>
		
		if(total_price-total_dc_price < 30000){
			shipping_fee = 3000;
		}else{
			shipping_fee = 0;
		}
		
		if(isChecked){
			$("#price_sum").html(comma(total_price)+"원");
			$("#dc_price_sum").html(comma(total_dc_price)+"원");
			$("#total_price").html(comma((total_price-total_dc_price)+shipping_fee)+"원");
			$("#total_quantity").html("("+total_quantity+")개");
			$("#shipping_fee").html(comma(shipping_fee)+"원");
			
			$("#origin_price_"+select_val).html(comma(window["price_calc_"+select_val])+"원");
			$("#dc_price_"+select_val).html(comma(window["dc_price_calc_"+select_val])+"원");
			
		}else{
			$("#origin_price_"+select_val).html(comma(window["price_calc_"+select_val])+"원");
			$("#dc_price_"+select_val).html(comma(window["dc_price_calc_"+select_val])+"원");
		}
		
		total_price = 0;
		total_dc_price = 0;
		shipping_fee = 0;
		total_quantity = 0;
		shipping_fee = 0;
	});
	});
	

</script>