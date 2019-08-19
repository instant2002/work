function qnaSubFunc(){
	if($('#phone').val()==''){
		alert('휴대폰 번호를 입력하세요.');
		$('#phone').focus();
		return false;
	}
	
	if($('#title').val()==''){
		alert('제목을 입력하세요.');
		$('#title').focus();
		return false;
	}
	
	if($('#contents').val()==''){
		alert('내용을 입력하세요.');
		$('#contents').focus();
		return false;
	}
	
	if(!confirm("이대로 작성하시겠습니까?")) return;
	
	$('#qnaSub')[0].submit();
}

