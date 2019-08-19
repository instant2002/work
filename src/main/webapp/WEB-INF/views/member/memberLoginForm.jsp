<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="login center-block" style="width: 40%; margin-bottom: 20px;">
   <form action="/member/loginSub.do" class="validation-engine" method="post">
      <h6>로그인</h6>
      <div class="required form-group">
         <input type="text" name="user_id" id="user_id2" class="form-control validate[required]" data-prompt-position="topLeft">
      </div>
      <div class="required form-group">
         <p>Password *</p>
         <input type="password" name="user_pwd" id="user_pwd" class="form-control validate[required]" data-prompt-position="topLeft">
      </div>
      <p>
         <input type="checkbox" id="checkbox1" class="stl rememberid" value="2">
         <label for="checkbox1" class="stl"><span></span>아이디 저장</label>
      </p>
      <input type="submit" name="login" class="btn btn-third-col btn-5margin" value="로그인">
      <input type="button" name="register" class="btn btn-third-col btn-5margin" value="회원가입" onclick="location.href='registForm.do'">
   </form>
   <hr>
   <a href="#">아이디 찾기</a> |
   <a href="#">비밀번호 찾기</a>
</div>
