<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
<div class="col-xs-12">
	<div class="col-xs-12">
		<h2><strong>고객 문의</strong></h2>
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

<form id="answerForm">
<input type="hidden" name="idx" value="${qnaView.idx }">
<div class="col-xs-12">
	<div class="col-xs-12">
		<c:if test="${empty(answer.ansContents) }">
			<h2><strong>답변하기</strong></h2>
		</c:if>
		<c:if test="${!empty(answer.ansContents) }">
			<h2><strong>답변완료</strong></h2>
		</c:if>
	</div>
	<div class="col-xs-12" style="border: solid #ddd; border-width: 2px 0px 1px 0px; background: #f9f9f9; padding: 10px 15px;">
		<span style="font-size: 20px;"><strong>[답변]${qnaView.title }</strong></span>
	</div>
	<div class="col-xs-12" style="border: solid #ddd; border-width: 0px 0px 1px 0px; height: 40px; vertical-align: middle; padding-top: 8px;">
		<strong><span>관리자</span></strong>
		<span style="border-left: 1px solid #dbdbdb; font-size: 11px; margin-left: 10px; padding-left: 10px;">
		<c:if test="${empty(answer.answer_upload_date) }">
			<c:set var="sysYear"><fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy-MM-dd" /></c:set>
			<c:out value="${sysYear}" />
		</c:if>
		<c:if test="${!empty(answer.answer_upload_date) }">
			${answer.answer_upload_date}
		</c:if>
		</span>
	</div>
	<div>
		<c:if test="${empty(answer.ansContents) }">
			<textarea class="form-control" id="ansContents" name="ansContents" rows="10"></textarea>
		</c:if>
		<c:if test="${!empty(answer.ansContents) }">
			<pre style="border: 1px solid white; padding: 10px;">${answer.ansContents}</pre>
		</c:if>
	</div>
</div>
</form>
<hr style="width: 100%; margin-bottom: 30px;">
<div class="col-md-8"></div>
<div class="col-md-4">
	<button class="btn btn-sm btn-yet-col" type="button" onclick="location.href='/admin/qnaList.do'" style="float: right; margin-left: 10px;">목록으로</button>
	<c:if test="${empty(answer.ansContents) }">
		<button class="btn btn-sm btn-yet-col" type="button" onclick="answerSubFunc();" style="float: right; background: #e0e0e0;">등록하기</button>
	</c:if>
</div>

<script type="text/javascript">
function answerSubFunc() {
		if(confirm("이대로 답변하시겠습니까?")){
	    	if($("#ansContents").val() != ""){
			$.ajax({
				url:'/admin/qnaAnsSub.do',
				type:'POST',
				data:$("#answerForm").serialize(),
				dataType:'json',
				async: true,
				cache:false,
				timeout:30000,
				success:function(data){
					if(data){
	    				alert("답변하였습니다.");
						location.href='/admin/qnaList.do'
					}else{
						alert("처리 중 오류가 발생하였습니다.");
					}
				},
				error:function(){
					alert("처리 중 오류가 발생하였습니다.");
				}
			});
	    	}else{
	    		alert("답변이 비어있습니다.");
	    		$("#ansContents").focus();
	    	}
		}
	}
</script>