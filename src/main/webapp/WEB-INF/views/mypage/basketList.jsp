<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div class="col-xs-12">
<form action="/customer/basketDelete.do" method="POST" id="basketDelete">
</form>
<form action="/order/orderingInfo.do" method="POST" id="orderInfoSubForm"/>
	<div class="col-xs-12 text-center">
		<h2><strong>장바구니</strong></h2>
	</div>
		<input id="checkbox_all" type="checkbox" name="checkbox" value="2" class="stl basket_checkbox_all hidden-sm hidden-md hidden-lg" checked="checked">
		<label for="checkbox_all" class="stl hidden-sm hidden-md hidden-lg" style="margin-left: 15px;"><span></span></label>
	<table class="table">
		<colgroup>
			<col width="1%">
			<col width="14%" class="hidden-xs">
			<col width="30%" class="hidden-sm hidden-md hidden-lg" >
			<col width="45%">
			<col width="10%" class="hidden-xs">
			<col width="10%" class="hidden-xs">
			<col width="10%" class="hidden-xs">
			<col width="10%" class="hidden-xs">
		</colgroup>
		<thead class="hidden-xs" style="font-weight: bold; border: solid #ddd; border-width: 2px 0px; background: #f9f9f9;">
			<tr>
				<td>
					<input id="checkbox_all" type="checkbox" name="checkbox" class="stl basket_checkbox_all" checked="checked">
					<label for="checkbox_all" class="stl"><span></span></label>
				</td>
				<td></td>
				<td>상품 정보</td>
				<td>수량</td>
				<td>상품 금액</td>
				<td>할인 금액</td>
				<td>배송비</td>
			</tr>
		</thead>
	<c:choose>
		<c:when test="${empty basket}">
			<td colspan="7" class="text-center">장바구니가 비어있습니다.</td>
			</table>
		</c:when>
		<c:otherwise>
		<tbody>
		<c:forEach var="basket" items="${basket}" varStatus="status">
		<input type="hidden" value="${basket.product_no }" class="product_no_${status.index}">
			<tr>
				<td style="vertical-align: middle;">
					<input id="checkbox${status.index}" type="checkbox" name="checkbox" class="stl basket_checkbox basket_checkbox_${status.index}" checked="checked" value="${status.index}"><label for="checkbox${status.index}" class="stl"><span></span></label>
				</td>
				<td style="vertical-align: middle; padding: 8px 0;"><img src="${pageContext.request.contextPath}${basket.book_img_storedName}"></td>
				<td style="vertical-align: middle;">
					<font class="mobile_product_text"><b><a href="/book/detailView.do?product_no=${basket.product_no }">${basket.book_name}</a></b></font><br>
					<div class="hidden-sm hidden-md hidden-lg">
						<font class="mobile_price_text">상품 금액 : </font>&nbsp;<font class="origin_price_${status.index } mobile_price_text" ><fmt:formatNumber value="${basket.origin_price*basket.quantity}" groupingUsed="true"/>원</font>
						<br><font class="mobile_price_text">할인 금액 : </font>&nbsp;<font class="dc_price_${status.index } mobile_price_text" ><fmt:formatNumber value="${basket.dc_price*basket.quantity}" groupingUsed="true"/>원</font>
						<br><font class="mobile_price_text">기본 배송비</font>
						<br><br>
						<div class="cart_quantity_button clrfix product-count pull-left">
							<a rel="nofollow" class="btn btn-default btn-minus" href="#" title="Subtract" onclick="edit_quantity_minus('${status.index }','${basket.origin_price}','${basket.dc_price}');">–</a> 
							<input type="text" size="2" autocomplete="off" id="quantity_${status.index }" class="cart_quantity_input form-control grey count quantity_${status.index }" id="book_quantity" value="${basket.quantity}" style="width: 50px; font-size: 16px;" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');"> 
							<a rel="nofollow" class="btn btn-default btn-plus" href="#" title="Add" onclick="edit_quantity_plus('${status.index }','${basket.origin_price}','${basket.dc_price}');">+</a>
						</div>
					</div>
				</td>
				<td class="hidden-xs" style="vertical-align: middle;">
					<input type="number" value="${basket.quantity}" class="quantity_${status.index }" id="quantity_${status.index }" min="1" style="width: 50px;" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');">
				</td>
				<td class="hidden-xs origin_price_${status.index }" style="vertical-align: middle;"><fmt:formatNumber value="${basket.origin_price*basket.quantity}" groupingUsed="true"/>원</td>
				<td class="hidden-xs dc_price_${status.index }" style="vertical-align: middle;"><fmt:formatNumber value="${basket.dc_price*basket.quantity}" groupingUsed="true"/>원</td>
				<td class="hidden-xs" style="vertical-align: middle;">기본 배송비</td>
			</tr>
			<c:set var="price_sum" value="${price_sum+(basket.origin_price*basket.quantity) }"/>
			<c:set var="dc_price_sum" value="${dc_price_sum+(basket.dc_price*basket.quantity) }"/>
			<c:set var="quantity_sum" value="${quantity_sum+basket.quantity }"/>
			<c:set var="total_price" value="${total_price+((basket.origin_price-basket.dc_price)*basket.quantity) }"/>
			
		</c:forEach>
			<tr style="background: #d7d9db;">
				<td class="hidden-xs" colspan="7" style="text-align: right;">기본 배송비 : 3,000원<br>(30,000원 이상 결제시 배송비 무료)</td>
			<td class="hidden-sm hidden-md hidden-lg" colspan="3" style="text-align: right;">기본 배송비 : 3,000원<br>(30,000원 이상 결제시 배송비 무료)</td>
			</tr>
		</tbody>
	</table>
	
	<c:if test="${total_price < 30000 }">
		<c:set var="shipping_fee" value="3000"/>
	</c:if>
	<c:if test="${total_price >= 30000 }">
		<c:set var="shipping_fee" value="0"/>
	</c:if>
	
	<div class="col-xs-12" style="margin-bottom: 20px; padding-right: 0;">
	<div class="col-md-8"></div>
		<div class="col-md-4" style="padding-right: 0;">
			<button type="button" class="btn btn-yet-col btn-sm union_border_btn" onclick="deleteBasket('select')" style="float: right; margin-left: 10px;">
				선택 삭제
			</button>
			<button type="button" class="btn btn-yet-col btn-sm union_border_btn" onclick="deleteBasket('all')" style="float: right;">
				전체 삭제
			</button>
		</div>
	</div>
	
	<table class="table total-table" style="margin-top: 50px;">
	<tr>
		<td colspan="4" class="total-head hidden-xs">Total</td>
		<td colspan="2" class="total-head hidden-sm hidden-md hidden-lg">Total</td>
	</tr>
	<tr class="hidden-xs">
		<td>상품 금액 <br><font class="total_num">${fn:length(basket)}종</font> <font class="total_quantity">(${quantity_sum }개)</font> </td>
		<td>할인 금액</td>
		<td>배송비</td>
		<td>합계 금액</td>
	</tr>
	<tr class="hidden-xs">
		<td class="price_sum"><fmt:formatNumber value="${price_sum}" groupingUsed="true"/>원</td>
		<td class="dc_price_sum"><fmt:formatNumber value="${dc_price_sum}" groupingUsed="true"/>원</td>
		<td class="shipping_fee"><fmt:formatNumber value="${shipping_fee}" groupingUsed="true"/>원</td>
		<td class="sum_price"><fmt:formatNumber value="${total_price+shipping_fee }" groupingUsed="true"/>원</td>
	</tr>
	<tr class="hidden-sm hidden-md hidden-lg">
		<td>상품 금액 / <font class="total_num">${fn:length(basket)}종</font> <font class="total_quantity">(${quantity_sum }개)</font></td>
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
</form>
</div>
<div class="col-xs-12">
<div class="col-md-5"></div>
	<div class="col-md-2">
		<button type="button" class="btn btn-buy-col pull-left add-cart" onclick="orderSubFunc();" style="width: 100%; margin-bottom: 100px;">
			<i class="icon-bag"></i>&nbsp;&nbsp;주문하기
		</button>
	</div>
	<div class="col-md-5"></div>
</div>
</c:otherwise>
</c:choose>
<script type="text/javascript">
<c:forEach var="basket" items="${basket}" varStatus="status">
var price_${status.index} = ${basket.origin_price};
var dc_price_${status.index} = ${basket.dc_price};
var quantity_${status.index} = ${basket.quantity};

var price_calc_${status.index} = ${basket.origin_price};
var dc_price_calc_${status.index} = ${basket.dc_price};
var quantity_calc_${status.index} = ${basket.quantity};
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
	<c:forEach var="basket" items="${basket}" varStatus="status">
		checkedVal[${status.index}] = $(".basket_checkbox_${status.index}:checked").val();
	</c:forEach>
	
	if($(".basket_checkbox:checked").length == 0){
		alert("선택된 상품이 없습니다.");
		return false;
	}
	
	if($(".sum_price").html() == "3,000원"){
		alert("주문하실 수량이 없습니다.");
		return false;
	}
	
	var price = $(".sum_price").html().replace(/,/,"");
	price = price.replace("원","");
	var a = 0;
	for(var i=0;i<checkedVal.length;i++){
		if(checkedVal[i] != undefined){
			product_no_input = '<input type="hidden" name="order_list['+checkedVal[i]+'].product_no" value="'+$(".product_no_"+checkedVal[i]).val()+'"/>';
			quantity_input = '<input type="hidden" name="order_list['+checkedVal[i]+'].quantity" value="'+$(".quantity_"+checkedVal[i]).val()+'"/>';
			total_price = '<input type="hidden" name="total_price" value="'+(parseInt(price))+'"/>';
			$("#orderInfoSubForm").append(product_no_input);
			$("#orderInfoSubForm").append(quantity_input);
			if(a==0)$("#orderInfoSubForm").append(total_price);
			a++;
		}
	}
	$("#orderInfoSubForm").submit();
}

//장바구니 제거
function deleteBasket(action){
	var checkedVal = new Array();
	var allCheckBoxVal = new Array();
	var product_arr = new Array();
	
	<c:forEach var="basket" items="${basket}" varStatus="status">
	checkedVal[${status.index}] = $(".basket_checkbox_${status.index}:checked").val();
	allCheckBoxVal[${status.index}] = $(".basket_checkbox_${status.index}").val();
	</c:forEach>
	if(action == "all"){
		for(var i=0;i<allCheckBoxVal.length;i++){
			if(allCheckBoxVal[i] != undefined){
				product_arr[i] = $(".product_no_"+allCheckBoxVal[i]).val();
			}
		}
	}else{
		if($(".basket_checkbox:checked").length == 0){
			alert("선택된 상품이 없습니다.");
			return false;
		}
		
		for(var i=0;i<checkedVal.length;i++){
			if(checkedVal[i] != undefined){
				product_arr[i] = $(".product_no_"+checkedVal[i]).val();
			}
		}
	}
	
	//배열 빈 요소 제거
	product_arr = $.grep(product_arr,function(n){ return n == " " || n; });
	
	if(!confirm(product_arr.length+"개의 상품을 삭제하시겠습니까?")){
		return false;
	};
	
	$.ajax({
		url:'/customer/basketDelete.do',
		type:'post',
		data:{
			'product_arr':product_arr
		},
		dataType:'json',
		async:true,
		traditional:true,
		cache:false,
		timeout:30000,
		success:function(data){
			if(data){
				window.location.reload();
			}else{
				alert("처리 중 오류가 발생하였습니다.\n지속적인 오류가 발생될 시 고객센터에 문의해 주시기 바랍니다.");
			}
		},
		error:function(){
			alert("처리 중 오류가 발생하였습니다.\n지속적인 오류가 발생될 시 고객센터에 문의해 주시기 바랍니다.");
		}
	});
}

$(document).ready(function(){
	$(".basket_checkbox_all").click(function(){
		var isChecked = $(this).is(":checked");
		$(".basket_checkbox").prop("checked", isChecked);
		
		if(isChecked == false){
			total_price = 0;
			total_dc_price = 0;
			total_quantity = 0;
			shipping_fee = 0;
			<c:forEach var="basket" items="${basket}" varStatus="status">
			quantity_calc_${status.index} = 0;
			</c:forEach>
		}else{
			<c:forEach var="basket" items="${basket}" varStatus="status">
			total_price += price_${status.index}*Number($(".quantity_"+${status.index}).val());
			total_dc_price += dc_price_${status.index}*Number($(".quantity_"+${status.index}).val());
			total_quantity += Number($(".quantity_"+${status.index}).val());
			quantity_calc_${status.index} = Number($(".quantity_"+${status.index}).val());
			if(total_price-total_dc_price < 30000){
				shipping_fee = 3000;
			}else{
				shipping_fee = 0;
			}
			</c:forEach>
		}
		
		$(".total_quantity").html("("+total_quantity+")개");
		$(".total_num").html($(".basket_checkbox:checked").length +"종");
		$(".price_sum").html(comma(total_price)+"원");
		$(".dc_price_sum").html(comma(total_dc_price)+"원");
		$(".sum_price").html(comma(total_price-total_dc_price+shipping_fee)+"원");
		$(".shipping_fee").html(comma(shipping_fee)+"원");
		
		total_price = 0;
		total_dc_price = 0;
		shipping_fee = 0;
		total_quantity = 0;
	});
	
	$(".basket_checkbox").click(function(){
		var isChecked = $(this).is(":checked");
		var cb_count = $(".basket_checkbox").length;
		var cb_count_chk = $(".basket_checkbox:checked").length;
		if(cb_count == cb_count_chk){
			active = true;
			isChecked = true;
		}else{
			active = false;
		}
		if($(".basket_checkbox_all").is(":checked") || active){
			$(".basket_checkbox_all").prop("checked", isChecked);
			}
		$(".total_num").html($(".basket_checkbox:checked").length+"종");
	
		var checkbox_num = $(this).val();
		
		if(isChecked == false){
			window["price_calc_"+checkbox_num] = 0;
			window["dc_price_calc_"+checkbox_num] = 0;
			window["quantity_calc_"+checkbox_num] = 0;
		}else{
			window["price_calc_"+checkbox_num] = window["price_"+checkbox_num];
			window["dc_price_calc_"+checkbox_num] = window["dc_price_"+checkbox_num];
			window["quantity_calc_"+checkbox_num] = Number($(".quantity_"+checkbox_num).val());
		}
		
		<c:forEach var="basket" items="${basket}" varStatus="status">
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
		 
		$(".price_sum").html(comma(total_price)+"원");
		$(".dc_price_sum").html(comma(total_dc_price)+"원");
		$(".sum_price").html(comma((total_price-total_dc_price)+shipping_fee)+"원");
		$(".total_quantity").html("("+total_quantity+"개)");
		$(".shipping_fee").html(comma(shipping_fee)+"원");
		
		total_price = 0;
		total_dc_price = 0;
		shipping_fee = 0;
		total_quantity = 0;
		shipping_fee = 0;
		});
	 
	$("input[id^='quantity_']").on("propertychange change keyup paste input", function() {
		var quantity_val = $(this).val();
		var select_val = $(this).attr('id').substr($(this).attr('id').length-1);
		var isChecked = $(".basket_checkbox_"+select_val).is(":checked");
		
		if(quantity_val == "") $('.quantity_'+select_val).val("1");
	    if(quantity_val == oldVal) {
	        return;
	    }
	    oldVal = quantity_val;
	    
	    if(quantity_val <= 0) quantity_val = 1;
		
		window["price_calc_"+select_val] = window["price_"+select_val] * quantity_val;
		window["dc_price_calc_"+select_val] = window["dc_price_"+select_val] * quantity_val;
		window["quantity_calc_"+select_val] = Number(quantity_val);
		
		<c:forEach var="basket" items="${basket}" varStatus="status">
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
			$(".price_sum").html(comma(total_price)+"원");
			$(".dc_price_sum").html(comma(total_dc_price)+"원");
			$(".sum_price").html(comma((total_price-total_dc_price)+shipping_fee)+"원");
			$(".total_quantity").html("("+total_quantity+")개");
			$(".shipping_fee").html(comma(shipping_fee)+"원");
			
			$(".origin_price_"+select_val).html(comma(window["price_calc_"+select_val])+"원");
			$(".dc_price_"+select_val).html(comma(window["dc_price_calc_"+select_val])+"원");
			
		}else{
			$(".origin_price_"+select_val).html(comma(window["price_calc_"+select_val])+"원");
			$(".dc_price_"+select_val).html(comma(window["dc_price_calc_"+select_val])+"원");
		}
		$(".quantity_"+select_val).val(quantity_val);
		total_price = 0;
		total_dc_price = 0;
		shipping_fee = 0;
		total_quantity = 0;
		shipping_fee = 0;
	});
});
	function numberWithCommas(num) {
	    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	function edit_quantity_plus(num, origin_price, dc_price) {
		   var currentVal = parseInt($('.quantity_'+num).val(),10);
		   var currentVal = currentVal + 1; 
		   var isChecked = $(".basket_checkbox_"+num).is(":checked");
		   
			if(total_price-total_dc_price < 30000){
				shipping_fee = 3000;
			}else{
				shipping_fee = 0;
			}
			if(total_price == 0) shipping_fee = 0;
			
			window["price_calc_"+num] = window["price_"+num] * currentVal;
			window["dc_price_calc_"+num] = window["dc_price_"+num] * currentVal;
			window["quantity_calc_"+num] = Number(currentVal);
			
			<c:forEach var="basket" items="${basket}" varStatus="status">
			total_price += (price_${status.index}) * quantity_calc_${status.index};
			total_dc_price += (dc_price_${status.index} * quantity_calc_${status.index});
			total_quantity += quantity_calc_${status.index};
			</c:forEach>
			if(total_price-total_dc_price < 30000){
				shipping_fee = 3000;
			}else{
				shipping_fee = 0;
			}
		   
		   var total_price_ea = numberWithCommas(origin_price * currentVal);
		   var total_dc_price_ea = numberWithCommas(dc_price * currentVal);
		   $(".origin_price_"+num).html(total_price_ea+"원");
		   $(".dc_price_"+num).html(total_dc_price_ea+"원");
		   
		   if(isChecked){
				$(".price_sum").html(comma(total_price)+"원");
				$(".dc_price_sum").html(comma(total_dc_price)+"원");
				$(".sum_price").html(comma((total_price-total_dc_price)+shipping_fee)+"원");
				$(".total_quantity").html("("+total_quantity+")개");
				$(".shipping_fee").html(comma(shipping_fee)+"원");
				
				$(".origin_price_"+num).html(comma(window["price_calc_"+num])+"원");
				$(".dc_price_"+num).html(comma(window["dc_price_calc_"+num])+"원");
				
			}else{
				$(".origin_price_"+num).html(comma(window["price_calc_"+num])+"원");
				$(".dc_price_"+num).html(comma(window["dc_price_calc_"+num])+"원");
			}
			total_price = 0;
			total_dc_price = 0;
			shipping_fee = 0;
			total_quantity = 0;
			shipping_fee = 0;
	}
	
	function edit_quantity_minus(num, origin_price, dc_price) {
		   var currentVal = parseInt($('.quantity_'+num).val(),10);
		   var currentVal = currentVal - 1; 
			if(currentVal <= 0) currentVal = 0;
			
		   var isChecked = $(".basket_checkbox_"+num).is(":checked");
		   
			if(total_price-total_dc_price < 30000){
				shipping_fee = 3000;
			}else{
				shipping_fee = 0;
			}
			if(total_price == 0) shipping_fee = 0;
			
			
			window["price_calc_"+num] = window["price_"+num] * currentVal;
			window["dc_price_calc_"+num] = window["dc_price_"+num] * currentVal;
			window["quantity_calc_"+num] = Number(currentVal);
			
			<c:forEach var="basket" items="${basket}" varStatus="status">
			total_price += (price_${status.index}) * quantity_calc_${status.index};
			total_dc_price += (dc_price_${status.index} * quantity_calc_${status.index});
			total_quantity += quantity_calc_${status.index};
			</c:forEach>

			if(total_price-total_dc_price < 30000){
				shipping_fee = 3000;
			}else{
				shipping_fee = 0;
			}
		   
		   var total_price_ea = numberWithCommas(origin_price * currentVal);
		   var total_dc_price_ea = numberWithCommas(dc_price * currentVal);
		   $(".origin_price_"+num).html(total_price_ea+"원");
		   $(".dc_price_"+num).html(total_dc_price_ea+"원");
		   
		   if(currentVal >= 0){
			   var total_price_ea = numberWithCommas(origin_price * currentVal);
			   var total_dc_price_ea = numberWithCommas(dc_price * currentVal);

			   $(".origin_price_"+num).html(total_price_ea+"원");
			   $(".dc_price_"+num).html(total_dc_price_ea+"원");
			}
		   
		   if(isChecked){
				$(".price_sum").html(comma(total_price)+"원");
				$(".dc_price_sum").html(comma(total_dc_price)+"원");
				$(".sum_price").html(comma((total_price-total_dc_price)+shipping_fee)+"원");
				$(".total_quantity").html("("+total_quantity+")개");
				$(".shipping_fee").html(comma(shipping_fee)+"원");
				
				$(".origin_price_"+num).html(comma(window["price_calc_"+num])+"원");
				$(".dc_price_"+num).html(comma(window["dc_price_calc_"+num])+"원");
				
			}else{
				$(".origin_price_"+num).html(comma(window["price_calc_"+num])+"원");
				$(".dc_price_"+num).html(comma(window["dc_price_calc_"+num])+"원");
			}
		   
		   total_price = 0;
			total_dc_price = 0;
			shipping_fee = 0;
			total_quantity = 0;
			shipping_fee = 0;
	}
</script>