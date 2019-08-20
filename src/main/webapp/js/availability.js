function registSubFunc(){
	var hobbyCheck = false;
	var getMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
	var getCheck= RegExp(/^[a-zA-Z0-9]{8,20}$/);
	var getName= RegExp(/^[가-힣]+$/);
	var fmt = RegExp(/^\d{6}[1234]\d{6}$/); //형식 설정
	
	if($('#userId').val()==''){
		alert('아이디를 입력하세요.');
		$('#userId').focus();
		return false;
	}

	if(!getCheck.test($("#userId").val())){
      alert("8~20자리 이내의 아이디를 입력해주세요.");
      $("#userId").val("");
      $("#userId").focus();
      return false;
    }
	
    if(checkIdDuplicated==0){
		alert('아이디 중복을 확인해주세요.');
		if($('#userId').val()==''){
			$('#userId').focus();
		}
		return false;
	}
	if($('#userPwd').val()==''){
		alert('비밀번호를 입력하세요.');
		$('#userPwd').focus();
		return false;
	}
	if($("#userPwd").val().length < 8){
	      alert("비밀번호를 8자리 이상 입력하세요.");
	      $("#userPwd").val("");
	      $("#userPwdConf").val("");
	      $("#userPwd").focus();
	      return false;
	   }
	if($('#userPwdConf').val()==''){
		alert('비밀번호 확인을 입력하세요.');
		$('#cspasswd').focus();
		return false;
	}
    if($("#userPwd").val() != ($("#userPwdConf").val())){ 
    	alert("비밀번호가 일치하지 않습니다.");
	    $("#userPwdConf").val("");
	    $("#userPwdConf").focus();
    return false;
   }
	if($('#userName').val()==''){
		alert('이름을 입력하세요.');
		$('#mem_name').focus();
		return false;
	}
	if($('#email').val()==''){
		alert('이메일을 입력하세요.');
		$('#email').focus();
		return false;
	}
	if($('#phoneNum1').val()==''){
		alert('휴대폰 번호를 입력하세요.');
		$('#phoneNum1').focus();
		return false;
	}
	if($('#postNum').val()=='' || $('#address1').val()==''|| $('#address2').val()==''){
		alert('주소를 입력하세요.');
		$('#address2').focus();
		return false;
	}
	if($('.birth').val()==''){
		alert('생년월일을 선택하세요.');
		$('.mem_birth').focus();
		return false;
	}
	if($(':radio[name="gender"]:checked').length < 1){
	    alert('성별을 선택하세요.');                        
	    return false;
	}
	if($('#gender').val()==''){
		alert('성별을 선택하세요.');
		$('#gender').focus();
		return false;
	}
	$('#register_form')[0].submit();
}

