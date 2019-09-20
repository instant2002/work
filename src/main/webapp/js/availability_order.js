function isMobile(){
		var UserAgent = navigator.userAgent;
		if (UserAgent.match(/iPhone|iPod|Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOS|Opera Mini|Opera Mobi|POLARIS|IEMobile|lgtelecom|nokia|SonyEricsson/i) != null || UserAgent.match(/LG|SAMSUNG|Samsung/) != null)
		{
			return true;
		}else{
			return false;
		}
	}

function orderSubFunc(){
	if($('#buyername').val()==''){
		alert('주문자 정보를 입력하세요.');
		$('#buyername').focus();
		return false;
	}
	if($('#buyeremail').val()==''){
		alert('주문자 이메일을 입력하세요.');
		$('#buyeremail').focus();
		return false;
	}
	if($('#buyertel').val()==''){
		alert('주문자 휴대폰 번호를 입력하세요.');
		$('#buyertel').focus();
		return false;
	}
	if($('#buyertel2').val()==''){
		alert('주문자 전화번호를 입력하세요.');
		$('#buyertel2').focus();
		return false;
	}
	if($('#recipientname').val()==''){
		alert('받는분 정보를 입력하세요.');
		$('#recipientname').focus();
		return false;
	}
	if($('#recipientemail').val()==''){
		alert('받는분 이메일을 입력하세요.');
		$('#recipientemail').focus();
		return false;
	}
	if($('#recipienttel').val()==''){
		alert('받는분 휴대폰 번호를 입력하세요.');
		$('#recipienttel').focus();
		return false;
	}
	if($('#recipienttel2').val()==''){
		alert('받는분 전화번호를 입력하세요.');
		$('#recipienttel2').focus();
		return false;
	}
	if($('#recipient_postnum').val()==''){
		alert('주소를 입력하세요.');
		$('#recipient_postnum').focus();
		return false;
	}
	if($('#recipient_address2').val()==''){
		alert('상세주소를 입력하세요.');
		$('#recipient_address2').focus();
		return false;
	}
	if($("#nonMem").val() == "Y"){
		if(!$("#nonMemAgree").prop("checked")){
			alert('비회원 주문에 대한 개인정보 수집 이용 동의가 필요합니다.');
			$('#nonMemAgree').focus();
			return false;
		}
	}

	if(isMobile()){
		mobile_callInipay();
	}else{
		callInipay();
	}
}

