<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="${pageContext.request.contextPath}/js/datepicker-ko.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<form class="form-horizontal" id="register_form" action='/member/regist.do' method="POST">
  <fieldset>
    <div id="legend" class="text-center">
      <legend>회원가입</legend>
    </div>
    <div class="row" style="margin-bottom: 40px;">
<div class="regist-form center-block" id="regist">
      <div class="required form-group">
         <p>회원 아이디</p>
         <input type="text" name="user_id" id="userId" class="form-control validate[required]" placeholder="8~20자리 이상의 아이디를 입력해 주세요." data-prompt-position="topLeft" >
      </div>
      <span id="message_id" class="help-block"></span>
      <img src="${pageContext.request.contextPath}/images/ajax-loader.gif" width="16" 
                   height="16" id="loading" style="display:none;">
      
      <div class="required form-group">
         <p>비밀번호</p>
         <input type="password" name="user_pwd" id="userPwd" class="form-control validate[required]" placeholder="비밀번호는 8~20자리까지 입력 가능합니다." data-prompt-position="topLeft">
      </div>
      
      <div class="required form-group">
         <p>비밀번호 확인</p>
         <input type="password" id="userPwdConf" class="form-control validate[required]" placeholder="비밀번호를 다시 입력해 주세요." data-prompt-position="topLeft">
      </div>
      
      <div class="required form-group">
         <p>이름</p>
         <input type="text" name="user_name" id="userName" class="form-control validate[required]" placeholder="" data-prompt-position="topLeft">
      </div>
      
      <div class="required form-group">
 		  <p>생년월일</p>
      	  <input type="text" id="birth" name="birth" class="input-small" readonly="readonly">
      </div>
      
      <div class="required form-group">
         <p>이메일</p>
         <input type="text" name="email" id="email" class="form-control validate[required]" placeholder="" data-prompt-position="topLeft">
      </div>
      
      <div class="required form-group">
         <p>휴대폰 번호</p>
         <input type="text" name="phonenum1" id="phoneNum1" class="form-control validate[required]" placeholder="" data-prompt-position="topLeft">
      </div>
      
      <div class="required form-group">
         <p>전화번호</p>
         <input type="text" name="phonenum2" id="phoneNum2" class="form-control validate[required]" placeholder="" data-prompt-position="topLeft">
      </div>
      
      <div class="required form-group">
		<p>성별</p>
	    <div class="custom-control custom-radio col-md-3">
			<input type="radio" name="gender" value="M" id="man" class="input-small">
			<label class="custom-control-label" for="man">남성</label>
		</div> 
		<div class="custom-control custom-radio col-md-3">
			<input type="radio" name="gender" value="F" id="woman" class="custom-control-input">
			<label class="custom-control-label" for="woman">여성</label>
		</div>
	  </div>
      
      <div class="required form-group">
         <p>주소</p>
         <input type="text" name="postnum" id="postNum" class="form-control validate[required]" placeholder="우편 번호" readonly="readonly" data-prompt-position="topLeft" style="width: 120px; float: left;">
         <button type="button" class="btn btn-secondary" onclick="execPostCode();">검색</button>
         <input type="text" name="address1" id="address1" class="form-control validate[required]" placeholder="기본 주소" readonly="readonly" data-prompt-position="topLeft">
         <input type="text" name="address2"id="address2" class="form-control validate[required]" placeholder="나머지 주소" data-prompt-position="topLeft">
      </div>
    
    <div class="control-group">
      <div class="controls">
        <button class="btn btn-success center-block" onclick="registSubFunc(); return false;">가입하기</button>
      </div>
    </div>
</div>
  </fieldset>
</form>

<script type="text/javascript">
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

				$("[name=postnum]").val(data.zonecode);
				$("[name=address1]").val(fullRoadAddr);
			}
		}).open();
	}
	
	//휴대폰 번호 자동 하이픈
	var cellPhone = document.getElementById('phoneNum1');
		cellPhone.onkeyup = function(event) {
		event = event || window.event;
		var _val = this.value.trim();
		this.value = autoHypenPhone(_val);
	};
	
	//전화번호 자동 하이픈
	var cellPhone = document.getElementById('phoneNum2');
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
	
	//datepicker
	 $(function(){
		    $("#birth").datepicker();
	});
</script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="${pageContext.request.contextPath}/js/availability.js"></script>
<script src="${pageContext.request.contextPath}/js/reduplicationId.js"></script>