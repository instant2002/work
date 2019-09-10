<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="login center-block" style="margin-bottom: 30px;">
	<form action="/member/nonMemberSub.do" id="nonMemberSub" class="validation-engine" method="post">
		<input type="hidden" name="nonMem" id="nonMem" value="">
	</form>
	<form action="/member/loginSub.do" class="validation-engine" method="post">
		<h6><b>로그인</b></h6>
		<hr>
		<div class="required form-group">
			<p>ID *</p>
			<input type="text" name="user_id" id="user_id2" class="form-control validate[required]" data-prompt-position="topLeft" placeholder="아이디">
		</div>
		<div class="required form-group">
			<p>Password *</p>
			<input type="password" name="user_pwd" id="user_pwd" class="form-control validate[required]" data-prompt-position="topLeft" placeholder="비밀번호">
		</div>
		<p>
			<input type="checkbox" id="checkbox1" class="stl rememberid" value="2"> <label for="checkbox1" class="stl"><span></span>아이디 저장</label>
		</p>
		<input type="submit" name="login" class="btn login_btn btn-5margin" value="로그인"> <input type="button" name="register" class="btn logout_btn btn-5margin" value="회원가입" onclick="location.href='registForm.do'">
		<c:if test="${orderLogin == 'Y' }">
			<input type="button" class="btn btn-cart-col" style="margin-left: 5px;" value="비회원 주문" onclick="nonMemberFunc();">
		</c:if>
	</form>
	<hr>
	<a href="#">아이디 찾기</a> | <a href="#">비밀번호 찾기</a>
	<div style="margin-top: 50px;">
		<h6><b>비회원 주문 조회</b></h6>
		<hr>
		<form action="/member/orderTracking.do" class="validation-engine" method="post">
			<p>주문자 성함</p>
			<div class="required form-group">
				<input type="text" name="buyername" id="non_buyername" class="form-control validate[required]" data-prompt-position="topLeft" placeholder="주문자 성함">
			</div>
			<p>주문 번호</p>
			<div class="required form-group">
				<input type="text" name="order_code" id="non_order_code" class="form-control validate[required]" data-prompt-position="topLeft" placeholder="주문 번호">
			</div>
			<p style="color: #aaaaaa;">주문 번호를 잊으신 경우, 고객센터에 문의하여 주시기 바랍니다.</p>
			<input type="submit" class="btn btn-lg btn-prim-col" value="조회" style="width: 100%">
		</form>
	</div>
</div>
<script type="text/javascript">
	function nonMemberFunc() {
		$("#nonMem").val("Y");
		$("#nonMemberSub").submit();
	}
</script>