function postingBookSubFunc(){
	var hobbyCheck = false;
	var getMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
	var getCheck= RegExp(/^[a-zA-Z0-9]{4,12}$/);
	var getName= RegExp(/^[가-힣]+$/);
	var fmt = RegExp(/^\d{6}[1234]\d{6}$/); //형식 설정
	
	if($('#book_name').val()==''){
		alert('도서명을 입력하세요.');
		$('#book_name').focus();
		return false;
	}

	if($('#origin_price').val()==''){
      alert("판매 가격을 입력하세요");
      $("#origin_price").focus();
      return false;
    }
	
	if(!chkNumFunc($('#origin_price').val())){
		alert("판매 가격에 숫자만 입력하세요");
		$("#origin_price").focus();
		return false;
	}
	
	if ($('#discounted').is(":checked")) {
	    $('input[name=discounted]').val('Y');
	} else {
	    $('input[name=discounted]').val('N');
	}
	
	if($('#discounted').is(":checked") == true && $('#dc_price').val()=='' ){
		alert("할인이 체크되어 있습니다.\n할인 가격을 입력하세요.");
		$("#dc_price").focus();
		return false;
	}
	
	if($('#discounted').is(":checked") == false && $('#dc_price').val()!='' ){
		alert("할인이 체크되어 있지 않습니다.\n체크해 주세요.");
		$("#dc_price").focus();
		return false;
	}
	
	if(!chkNumFunc($('#dc_price').val()) && $('#dc_price').val()!=''){
		alert("할인 가격에 숫자만 입력하세요");
		$("#dc_price").focus();
		return false;
	}
	
	if($('#dc_price').val()==''){
		$('#dc_price').val('0');
	}
	
	if(!chkNumFunc($('#book_order').val()) && $('#book_order').val()!=''){
		alert("순위에 숫자만 입력하세요");
		$("#book_order").focus();
		return false;
	}
	
	if($('#book_order').val()==''){
		$('#book_order').val('999');
	}
	
	if($('#writer').val()==''){
	      alert("저자를 입력해 주세요.");
	      $("#writer").focus();
	      return false;
	}
	
	if($('#release_date').val()==''){
		alert("출판일을 입력해 주세요.");
		$("#release_date").focus();
		return false;
	}
	
	function chkNumFunc(value) {
		return $.isNumeric(value)
	}
	
	if(!confirm("이대로 등록하시겠습니까?")) return;
	
	$('#posting_form')[0].submit();
}

