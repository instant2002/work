<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div class="col-xs-12 text-center">
	<h2>
		<strong>비밀번호 확인</strong>
	</h2>
</div>
<div class="col-xs-12">
	<small>회원님의 정보 보호를 위해 비밀번호 재확인 후 회원 정보를 수정하실 수 있습니다.</small>
	<hr>
</div>
<form id="identSub" action="/customer/editInfo.do" method="post">    
	<div class="form-group">
	  <label class="col-md-4 control-label" for="passwordinput">비밀번호 확인</label>
	  <div class="col-md-4">
	    <input id="userpwd" name="user_pwd" type="password" class="form-control input-md">
	  </div>
	</div>

<div class="col-xs-12 text-center" style="margin-top: 15px;">
	<button type="button" id="identChkBtn" class="btn">확인</button>
</div>
</form>

<script type="text/javascript">
$(document).ready(function() {
	$("#identChkBtn").click(function() {
		if($("#userpwd").val() == ""){
			alert("비밀번호를 입력해 주세요.");
			$("#userpwd").focus();
			return false;
		}
		$("#identSub").submit();
	});
});
</script>