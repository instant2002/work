function postingNoticeSubFunc(){
	var hobbyCheck = false;
	var getMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
	var getCheck= RegExp(/^[a-zA-Z0-9]{4,12}$/);
	var getName= RegExp(/^[가-힣]+$/);
	var fmt = RegExp(/^\d{6}[1234]\d{6}$/); //형식 설정
	
	if($('#title').val()==''){
		alert('공지 타이틀을 입력하세요.');
		$('#title').focus();
		return false;
	}

	if(!chkNumFunc($('#notice_order').val()) && $('#notice_order').val()!=''){
		alert("순위에 숫자만 입력하세요");
		$("#notice_order").focus();
		return false;
	}
	
	if($('#notice_order').val()==''){
		$('#notice_order').val('999');
	}
	
	function chkNumFunc(value) {
		return $.isNumeric(value)
	}
	
	if(!confirm("이대로 등록하시겠습니까?")) return;
	
	$('#postingNotice_form')[0].submit();
}

