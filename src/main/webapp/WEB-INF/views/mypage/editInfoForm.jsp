<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<form class="form-horizontal" id="modify_form" action="/customer/modifySub.do" method="post">
<fieldset>

<div class="text-center"><legend style="font-weight: bold;">회원 정보 수정</legend></div>

<div class="form-group">
  <label class="col-md-4 control-label" for="textinput">이름</label>  
  <div class="col-md-4">
  <input id="userName" name="user_name" type="text" class="form-control input-md" value="${user.user_name }">
  </div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label" for="textinput">아이디</label>  
  <div class="col-md-4">
  <input id=userId name="user_id" type="text" class="form-control input-md" readonly="readonly" value="${user.user_id}">
  </div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label" for="textinput">기존 비밀번호</label>  
  <div class="col-md-4">
  <input id="userPwd" name="user_pwd" type="password" class="form-control input-md">
  </div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label" for="textinput">신규 비밀번호</label>
  <div class="col-md-4">
  <input id="nuserPwd" name="nuser_pwd" type="password" class="form-control input-md">
  </div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label" for="textinput">신규 비밀번호 확인</label>  
  <div class="col-md-4">
  <input id="nuserPwdConf" type="password" class="form-control input-md">
  </div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label" for="textinput">생년월일</label>  
  <div class="col-md-4">
  <input id="birth" name="birth" type="text" class="form-control input-md" value="${user.birth }">
  </div>
</div>

<div class="form-group">
<label class="col-md-4 control-label" for="radios">성별</label>
<div class="col-md-4"> 
  <label class="radio-inline" for="radios-0">
    <input type="radio" name="gender" id="radios-0" value="M">
    남성
  </label> 
  <label class="radio-inline" for="radios-1">
    <input type="radio" name="gender" id="radios-1" value="F">
    여성
  </label> 
</div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label" for="textinput">이메일</label>  
  <div class="col-md-4">
  <input id="email" name="email" type="text" class="form-control input-md" value="${user.email }">
  </div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label" for="textinput">휴대폰 번호</label>  
  <div class="col-md-4">
  <input id="phoneNum1" name="phonenum1" type="text" class="form-control input-md" value="${user.phonenum1 }">
  </div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label" for="textinput">전화번호</label>  
  <div class="col-md-4">
  <input id="phoneNum2" name="phonenum2" type="text" class="form-control input-md" value="${user.phonenum2 }">
  </div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label" for="textinput">주소</label>  
  <div class="col-md-4">
  <input id="postnum" name="postnum" type="text" id="postNum" class="form-control input-md" placeholder="우편 번호" readonly="readonly" value="${user.postnum }" style="width: 120px; float: left;">
  <button type="button" class="btn btn-secondary" onclick="execPostCode();">검색</button>
  <input id="address1" name="address1" id="address1" class="form-control input-md" placeholder="기본 주소" readonly="readonly" value="${user.address1 }">
  <input id="address2" name="address2" id="address2" class="form-control input-md" placeholder="나머지 주소" value="${user.address2 }">
  </div>
</div>

</fieldset>

<div class="control-group">
      <div class="controls">
        <button class="btn btn-success center-block" onclick="modifySubFunc(); return false;">수정하기</button>
      </div>
    </div>
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
	
	//성별 불러와서 자동으로 체크박스에 체크
	$("input:radio[name=gender][value=" + '<c:out value="${ user.gender }"/>' + "]").attr("checked","checked");
	
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
<script src="${pageContext.request.contextPath}/js/datepicker-ko.js"></script>
<script src="${pageContext.request.contextPath}/js/availability_modify.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>