<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="${pageContext.request.contextPath}/js/datepicker-ko.js"></script>

<form class="form-horizontal" id="postingNotice_form" action="/admin/postingNoticeEditSub.do" enctype="multipart/form-data" method="post">
<input type="hidden" name="num" value="${notice.num }">
<fieldset>

<div class="text-center"><legend>공지사항 수정</legend></div>

<div class="form-group">
  <label class="col-md-4 control-label" for="title">공지 타이틀</label>  
  <div class="col-md-4">
  <input id="title" name="title" type="text" class="form-control input-md" maxlength="30" value="${notice.title }">
  </div>
</div>

<div class="form-group">
	<label class="col-md-4 control-label" for="notice_order">순위</label>
	<div class="col-md-4">
		<input id="notice_order" name="notice_order" type="text"
			class="form-control input-md" maxlength="3" value="${notice.notice_order }">
	</div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label" for="contents">내용</label>
  <div class="col-md-4">
  <textarea class="form-control" id="contents" name="contents" rows="10">${notice.contents }</textarea>
  </div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label">사진</label>  
  <div class="col-md-4">
  	<input id="notice_img_file" filestyle="" type="file" name="notice_img_file" data-class-button="btn btn-default" data-class-input="form-control" data-button-text="" data-icon-name="fa fa-upload" class="form-control" tabindex="-1" style="position: absolute; clip: rect(0px 0px 0px 0px);">
	<div class="bootstrap-filestyle input-group">
		<input type="text" id="notice_img_name" class="form-control" name="notice_img_name" readonly="readonly" value="${notice.notice_img_name }" onclick="fileDownload('${notice.notice_img_name }','${notice.notice_img_storedName }');">
		<input type="hidden" name="notice_img_storedName" value="${notice.notice_img_storedName }">
		<span class="group-span-filestyle input-group-btn" tabindex="0" style="border: 1px solid #d7d9db;">
			<label for="notice_img_file" class="btn btn-default " style="padding: 3px 17px;">
				<span class="glyphicon fa fa-upload"></span>
			</label>
		</span>
	</div>
  </div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label">파일</label>  
  <div class="col-md-4">
<c:forEach var="file_list" items="${file_list}">
  	<input id="notice_img_file" filestyle="" type="file" name="notice_img_file" data-class-button="btn btn-default" data-class-input="form-control" data-button-text="" data-icon-name="fa fa-upload" class="form-control" tabindex="-1" style="position: absolute; clip: rect(0px 0px 0px 0px);">
	<div class="bootstrap-filestyle input-group">
		<input type="text" class="form-control" readonly="readonly" value="${file_list.notice_file_name }" onclick="fileDownload('${file_list.notice_file_name }','${file_list.notice_file_storedName }');">
		<span class="group-span-filestyle input-group-btn" tabindex="0" style="border: 1px solid #d7d9db;">
			<label for="notice_img_file" class="btn btn-default " style="padding: 3px 17px;">
				<span class="glyphicon fa fa-minus"></span>
			</label>
		</span>
	</div>
</c:forEach>	
  </div>
</div>

<div class="form-group" id="file_area">
<div id="file_inputs">
  <label class="col-md-4 control-label">파일 추가</label>
  <div class="col-md-4" id="fileDiv">
  	<p><input type='file' multiple="multiple" name='notice_file'></p>
  </div>
</div>
</div>
</fieldset>

<div class="control-group">
      <div class="controls">
        <button type="button" class="btn btn-success center-block" onclick="postingNoticeSubFunc(); return false;">수정하기</button>
      </div>
    </div>
</form>

<form id="fileDownForm" name="fileDownForm" action="/common/downloadFile.do">
</form>

<script src="${pageContext.request.contextPath}/js/availability_NoticePosting.js"></script>
<script type="text/javascript">
//파일명만 추출
$(document).ready(function(){
	$("#notice_img_file").on('change', function(){  // 값이 변경되면
		if(window.FileReader){  // modern browser
			var filename = $(this)[0].files[0].name;
		} else {  // old IE
			var filename = $(this).val().split('/').pop().split('\\').pop();  // 파일명만 추출
		}
		// 추출한 파일명 삽입
		$("#notice_img_name").val(filename);
	});
});

/* function fileDownload (name,storedName){
	$.ajax({
		url:'/common/downloadFile.do',
		type:'get',
		data:{name:name, storedName:storedName},
		dataType:'json',
		async: true,
		cache:false,
		timeout:30000,
		success: function(data){
	           alert("전송성공!!");
	           console.log(data); //응답받은 데이터 콘솔로 출력         
	           output(data); //받은 정보를 화면 출력하는 함수 호출
	       },error:function(e){
	           console.log(e);
	           alert("처리 중 오류가 발생하였습니다.\n지속적인 오류가 발생될 시 고객센터에 문의해 주시기 바랍니다.");
		}
	});
} */

//파일 다운로드
function fileDownload (name,storedName){
	var frm = $("#fileDownForm");
	var input_name = '<input type="hidden" id="download_name" name="name" value="'+name+'">';
	var input_storedName = '<input type="hidden" id="download_storedName" name="storedName" value="'+storedName+'">';
	frm.append(input_name);
	frm.append(input_storedName);
	frm.submit();
	$("#download_name").remove();
	$("#download_storedName").remove();
}
</script>

