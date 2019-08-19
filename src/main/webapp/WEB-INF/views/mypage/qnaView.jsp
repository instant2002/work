<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<div class="col-xs-12">
	<div class="col-xs-12">
		<h2><strong>나의 문의</strong></h2>
	</div>
	<div class="col-xs-12" style="border: solid #ddd; border-width: 2px 0px 1px 0px; background: #f9f9f9; padding: 10px 15px;">
		<span style="font-size: 20px;"><strong>${qnaView.title }</strong></span>
	</div>
	<div class="col-xs-12" style="border: solid #ddd; border-width: 0px 0px 1px 0px; height: 40px; vertical-align: middle; padding-top: 8px;">
		<strong><span>${qnaView.user_name }</span></strong>
		<span style="border-left: 1px solid #dbdbdb; font-size: 11px; margin-left: 10px; padding-left: 10px;">${qnaView.question_upload_date }</span>
	</div>
	<div>
		<pre style="border: 1px solid white; padding: 10px;">${qnaView.contents }</pre>
	</div>
</div>

<hr style="width: 100%; margin-bottom: 30px;">

<div class="col-xs-12">
	<div class="col-xs-12" style="border: solid #ddd; border-width: 2px 0px 1px 0px; background: #f9f9f9; padding: 10px 15px;">
		<span style="font-size: 20px;"><strong>[답변]${qnaView.title }</strong></span>
	</div>
	<div class="col-xs-12" style="border: solid #ddd; border-width: 0px 0px 1px 0px; height: 40px; vertical-align: middle; padding-top: 8px;">
		<strong><span>관리자</span></strong>
		<span style="border-left: 1px solid #dbdbdb; font-size: 11px; margin-left: 10px; padding-left: 10px;">
			<c:if test="${!empty(answer.answer_upload_date) }">
				${answer.answer_upload_date }
			</c:if>
		</span>
	</div>
	<div>
		<c:if test="${empty(answer.ansContents) }">
			<pre style="border: 1px solid white; padding: 10px;">고객님의 소중한 문의에 운영진이 답변을 준비 중이오니, 조금만 더 기다려 주세요.</pre>
		</c:if>
		<c:if test="${!empty(answer.ansContents) }">
			<pre style="border: 1px solid white; padding: 10px;">${answer.ansContents}</pre>
		</c:if>
	</div>
</div>
<hr style="width: 100%; margin-bottom: 30px;">
<div class="col-md-8"></div>
<div class="col-md-4">
	<button class="btn btn-sm btn-yet-col" type="button" onclick="location.href='/customer/qnaList.do'" style="float: right; margin-left: 10px;">목록으로</button>
	<button class="btn btn-sm btn-yet-col" type="button" onclick="qnaDelFunc(${qnaView.idx }); return false;" style="float: right; background: #e0e0e0;">삭제하기</button>
</div>

<script type="text/javascript">
function qnaDelFunc(idx) {
		if(confirm("정말로 삭제하시겠습니까?")){
			$.ajax({
				url:'/customer/qnaDelSub.do',
				type:'POST',
				data:{idx:idx},
				dataType:'json',
				async: true,
				cache:false,
				timeout:30000,
				success:function(data){
					if(data){
	    				alert("삭제되었습니다.");
						location.href='/customer/qnaList.do'
					}else{
						alert("처리 중 오류가 발생하였습니다.\n지속적인 오류가 발생될 시 고객센터에 문의해 주시기 바랍니다.");
					}
				},
				error:function(){
					alert("처리 중 오류가 발생하였습니다.\n지속적인 오류가 발생될 시 고객센터에 문의해 주시기 바랍니다.");
				}
			});
		}
	}
</script>