<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div class="col-xs-12">
<form action="/customer/wishDelete.do" method="POST" id="wishDelete">
</form>
<form action="/order/orderingInfo.do" method="POST" id="orderInfoSubForm"/>
	<div class="col-xs-12 text-center">
		<h2><strong>위시리스트</strong></h2>
	</div>
	<input id="wish_checkbox_all_m" type="checkbox" name="checkbox" class="stl wish_checkbox_all" checked="checked">
	<label for="wish_checkbox_all_m" class="stl hidden-sm hidden-md hidden-lg" style="margin-left: 15px;"><span></span></label>
	<table class="table" style="table-layout: fixed;">
		<colgroup>
			<col width="3%" class="hidden-xs">
			<col width="8%" class="hidden-sm hidden-md hidden-lg">
			<col width="14%" class="hidden-xs">
			<col width="30%" class="hidden-sm hidden-md hidden-lg" >
			<col width="38%">
			<col width="15%" class="hidden-xs">
			<col width="15%" class="hidden-xs">
			<col width="15%" class="hidden-xs">
		</colgroup>
		<thead class="hidden-xs" style="font-weight: bold; border: solid #ddd; border-width: 2px 0px; background: #f9f9f9;">
			<tr>
				<td>
					<input id="wish_checkbox_all_pc" type="checkbox" name="checkbox" class="stl wish_checkbox_all" checked="checked">
					<label for="wish_checkbox_all_pc" class="stl"><span></span></label>
				</td>
				<td ></td>
				<td>상품 정보</td>
				<td>상품 금액</td>
				<td>할인 금액</td>
				<td>배송비</td>
			</tr>
		</thead>
		<c:choose>
	<c:when test="${empty wish}">
		<td colspan="6" class="text-center">위시리스트가 비어있습니다.</td>
		</table>
	</c:when>
	<c:otherwise>
		<tbody>
		<c:forEach var="wish" items="${wish}" varStatus="status">
		<input type="hidden" value="${wish.product_no }" id="product_no_${status.index}">
			<tr>
				<td style="vertical-align: middle;">
					<input id="wish_checkbox_${status.index}" type="checkbox" name="checkbox" value="${status.index}" class="stl wish_checkbox hidden-sm hidden-md hidden-lg" checked="checked">
					<label for="wish_checkbox_${status.index}" class="stl"><span></span></label>
				</td>
				<td style="vertical-align: middle;"><img src="${pageContext.request.contextPath}${wish.book_img_storedName}"></td>
				<td style="vertical-align: middle;">
					<font class="mobile_product_text"><b><a href="/book/detailView.do?product_no=${wish.product_no }">${wish.book_name}</a></b></font><br>
					<div class="hidden-sm hidden-md hidden-lg">
						<font class="mobile_price_text">상품 금액 : </font>&nbsp;<font class="origin_price_${status.index } mobile_price_text" ><fmt:formatNumber value="${wish.origin_price}" groupingUsed="true"/>원</font>
						<br><font class="mobile_price_text">할인 금액 : </font>&nbsp;<font class="dc_price_${status.index } mobile_price_text" ><fmt:formatNumber value="${wish.dc_price}" groupingUsed="true"/>원</font>
						<br><font class="mobile_price_text">기본 배송비</font>
						<br><br>
					</div>
				</td>
				<td class="hidden-xs" id="origin_price_${status.index }" style="vertical-align: middle;"><fmt:formatNumber value="${wish.origin_price}" groupingUsed="true"/>원</td>
				<td class="hidden-xs" id="dc_price_${status.index }" style="vertical-align: middle;"><fmt:formatNumber value="${wish.dc_price}" groupingUsed="true"/>원</td>
				<td class="hidden-xs" style="vertical-align: middle;">기본 배송비</td>
			</tr>
			
		</c:forEach>
			<tr style="background: #d7d9db;">
			<td class="hidden-xs" colspan="7" style="text-align: right;">기본 배송비 : 3,000원<br>(30,000원 이상 결제시 배송비 무료)</td>
			<td class="hidden-sm hidden-md hidden-lg" colspan="3" style="text-align: right;">기본 배송비 : 3,000원<br>(30,000원 이상 결제시 배송비 무료)</td>
			</tr>
		</tbody>
	</table>
	<div class="hidden-xs" style="margin-bottom: 30px;">
		<div class="col-md-6" style="padding: 0;">
			<button type="button" class="btn btn-yet-col btn-sm union_border_btn" onclick="toBasket('select')">
				선택 장바구니에 담기
			</button>
			<button type="button" class="btn btn-yet-col btn-sm union_border_btn" onclick="toBasket('all')" style="margin-left: 10px;">
				전체 장바구니에 담기
			</button>
		</div>
		<div class="col-md-6" style="padding: 0;">
			<button type="button" class="btn btn-yet-col btn-sm" onclick="deletewish('select')" style="float: right; margin-left: 10px;">
				선택 삭제
			</button>
			<button type="button" class="btn btn-yet-col btn-sm" onclick="deletewish('all')" style="float: right;">
				전체 삭제
			</button>
		</div>
	</div>
	<div class="hidden-sm hidden-md hidden-lg" style="margin-bottom: 30px;">
	<div style="margin: 0 auto; display: table;">
		<button type="button" class="btn btn-yet-col btn-sm union_border_btn" onclick="deletewish('select')">
			선택 삭제
		</button>
		<button type="button" class="btn btn-yet-col btn-sm union_border_btn" onclick="toBasket('select')" style="margin-left: 10px;">
			선택 장바구니에 담기 
		</button>
	</div>
	</div>
	
</form>
</c:otherwise>
</c:choose>
<script type="text/javascript">

//위시리스트 제거
function deletewish(action){
	var checkedVal = new Array();
	var allCheckBoxVal = new Array();
	var product_arr = new Array();
	
	<c:forEach var="wish" items="${wish}" varStatus="status">
	checkedVal[${status.index}] = $("#wish_checkbox_${status.index}:checked").val();
	allCheckBoxVal[${status.index}] = $("#wish_checkbox_${status.index}").val();
	</c:forEach>
	
	if(action == "all"){
		for(var i=0;i<allCheckBoxVal.length;i++){
			if(allCheckBoxVal[i] != undefined){
				product_arr[i] = $("#product_no_"+allCheckBoxVal[i]).val();
			}
		}
	}else{
		if($(".wish_checkbox:checked").length == 0){
			alert("선택된 상품이 없습니다.");
			return false;
		}
		
		for(var i=0;i<checkedVal.length;i++){
			if(checkedVal[i] != undefined){
				product_arr[i] = $("#product_no_"+checkedVal[i]).val();
			}
		}
	}
	
	//배열 빈 요소 제거
	product_arr = $.grep(product_arr,function(n){ return n == " " || n; });
	
	if(!confirm(product_arr.length+"개의 상품을 삭제하시겠습니까?")){
		return false;
	};
	
	$.ajax({
		url:'/customer/wishDelete.do',
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

function toBasket(action){
	var checkedVal = new Array();
	var allCheckBoxVal = new Array();
	var product_arr = new Array();
	
	<c:forEach var="wish" items="${wish}" varStatus="status">
	checkedVal[${status.index}] = $("#wish_checkbox_${status.index}:checked").val();
	allCheckBoxVal[${status.index}] = $("#wish_checkbox_${status.index}").val();
	</c:forEach>
	
	if(action == "all"){
		for(var i=0;i<allCheckBoxVal.length;i++){
			if(allCheckBoxVal[i] != undefined){
				product_arr[i] = $("#product_no_"+allCheckBoxVal[i]).val();
			}
		}
	}else{
		if($(".wish_checkbox:checked").length == 0){
			alert("선택된 상품이 없습니다.");
			return false;
		}
		
		for(var i=0;i<checkedVal.length;i++){
			if(checkedVal[i] != undefined){
				product_arr[i] = $("#product_no_"+checkedVal[i]).val();
			}
		}
	}
	
	//배열 빈 요소 제거
	product_arr = $.grep(product_arr,function(n){ return n == " " || n; });
	
	if(!confirm(product_arr.length+"개의 상품을 장바구니에 담으시겠습니까?")){
		return false;
	};
	
	$.ajax({
		url:'/customer/toBasket.do',
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
				window.location.href='/customer/basketList.do';
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
	$(".wish_checkbox_all").click(function(){
		var isChecked = $(this).is(":checked");
		$(".wish_checkbox").prop("checked", isChecked);
	});
	
	$(".wish_checkbox").click(function(){
		var isChecked = $(this).is(":checked");
		var cb_count = $(".wish_checkbox").length;
		var cb_count_chk = $(".wish_checkbox:checked").length;
		if(cb_count == cb_count_chk){
			active = true;
			isChecked = true;
		}else{
			active = false;
		}
		if($(".wish_checkbox_all").is(":checked") || active){
			$(".wish_checkbox_all").prop("checked", isChecked);
			}
		});
	 
	});
	

</script>