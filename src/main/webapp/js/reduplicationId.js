//아이디 중복 체크
var checkIdDuplicated = 0;
$('#userId').blur(function(){
		$('#message_id').html('');//메시지 초기화
		$('#loading').show(); //로딩 이미지 노출
		
		$.ajax({
			url:'/member/confirmId.do',
			type:'get',
			data:{userId:$('#userId').val()},
			dataType:'json',
			async: true,
			cache:false,
			timeout:30000,
			success:function(data){
				$('#loading').hide(); //로딩 이미지 감추기
				
				if(data.result == 'idNotFound'){
					$('#message_id').css('color','#000').text('등록 가능 ID');
					checkIdDuplicated = 1;
				}else if(data.result == 'idDuplicated'){
					$('#message_id').css('color','#EE4949').text('중복된 ID');
					checkIdDuplicated = 0;
				}else{
					alert('아이디 중복 체크 오류 발생');
				}
			},
			error:function(){
				$('#loading').hide(); //로딩 이미지 감추기
				alert('네트워크 오류 발생');
			}
		});
		
	});

	//아이디 중복 안내 메시지 초기화 및 아이디 중복 값 초기화
	$('#userId').keyup(function(){
		checkIdDuplicated = 0;
		$('#message_id').text('');
	});