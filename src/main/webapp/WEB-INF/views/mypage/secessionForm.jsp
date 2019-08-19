<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="col-xs-12 text-center">
	<h2>
		<strong>회원 탈퇴</strong>
	</h2>
	<hr>
</div>

<form id="secessionSub" action="/customer/secessionSub.do" method="post">
	<div class="form-group">
		<label for="name"><strong>탈퇴 사유</strong></label> 
		<label class="radio-inline" for="radios-0"> 
			<input type="radio" name="secession_num" id="radios-0" value="1"> 배송 주문 불만족
		</label> 
		<label class="radio-inline" for="radios-1"> 
			<input type="radio" name="secession_num" id="radios-1" value="2"> 상품 품질 불만족
		</label> 
		<label class="radio-inline" for="radios-2"> 
			<input type="radio" name="secession_num" id="radios-2" value="3"> 서비스 불만족
		</label> 
		<label class="radio-inline" for="radios-3"> 
			<input type="radio" name="secession_num" id="radios-3" value="4" checked="checked"> 기타
		</label>
	</div>
	<div class="form-group">
		<label for="secession_contents"><strong>탈퇴 내용</strong></label>
		<textarea class="form-control" id="secession_contents" name="secession_contents" rows="3"></textarea>
	</div>
	<div class="col-xs-12 text-center">
		<small><strong>회원 탈퇴 시 회원님의 모든 정보가 삭제됩니다!</strong><br>
		회원님의 개인정보, 주문내역 등 모든 정보가 쇼핑몰에서 삭제됩니다.<br>
		예, 정보 삭제에 동의합니다.<small>
		<input type="checkbox" id="agree">
	</div>
	<div class="col-xs-12 text-center">
		<button type="button" id="secession_conf" class="btn">확인</button>
	</div>
</form>

<script type="text/javascript">
$(document).ready(function() {
	$("#secession_conf").click(function() {
		if(!$("#agree").prop("checked")){
			alert('정보 삭제에 동의해 주십시오.');
			$("#agree").focus();
			return false;
		}
		
		if(!confirm("정말로 회원 탈퇴하시겠습니까?")) return;
			$("#secessionSub").submit();
	});
});
</script>