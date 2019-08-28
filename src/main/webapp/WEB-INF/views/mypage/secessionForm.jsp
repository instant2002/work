<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="col-xs-12 text-center">
	<h2>
		<strong>회원 탈퇴</strong>
	</h2>
	<hr>
</div>

<form id="secessionSub" action="/customer/secessionSub.do" method="post">
	<div class="col-md-2 col-xs-3">
		<label for="name"><strong>탈퇴 사유</strong></label>
	</div>
	<div class="col-md-10 col-xs-9">
		<input id="radios-0" type="radio" name="secession_num" class="stl" value="1" >
		<label for="radios-0" class="stl secesson_radio"><span><span></span></span>배송 주문 불만족</label>
		<input id="radios-1" type="radio" name="secession_num" class="stl" value="2">
		<label for="radios-1" class="stl secesson_radio"><span><span></span></span>상품 품질 불만족</label>
		<input id="radios-2" type="radio" name="secession_num" class="stl" value="3">
		<label for="radios-2" class="stl secesson_radio"><span><span></span></span>서비스 불만족</label>
		<input id="radios-3" type="radio" name="secession_num" class="stl" value="4" checked="checked">
		<label for="radios-3" class="stl secesson_radio"><span><span></span></span>기타</label>
	</div>
	<div class="col-xs-12" style="margin-top: 20px;">
		<label for="secession_contents"><strong>탈퇴 내용</strong></label>
	</div>
		<textarea class="form-control" id="secession_contents" name="secession_contents" rows="3"></textarea>
	<div class="col-xs-12 text-center">
		<small><strong>회원 탈퇴 시 회원님의 모든 정보가 삭제됩니다!</strong><br>
		회원님의 개인정보, 주문내역 등 모든 정보가 쇼핑몰에서 삭제됩니다.<br>
		</small>
		<input id="agree" type="checkbox" name="checkbox"class="stl">
		<label for="agree" class="stl"><span></span><small>예, 정보 삭제에 동의합니다.</small></label>
	</div>
	<div class="col-xs-12 text-center" style="margin: 20px 0;">
		<button type="button" id="secession_conf" class="btn btn-buy-col">확인</button>
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