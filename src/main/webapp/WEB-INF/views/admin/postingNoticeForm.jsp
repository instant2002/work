<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="${pageContext.request.contextPath}/js/datepicker-ko.js"></script>

<form class="form-horizontal" id="postingNotice_form" action="/admin/postingNoticeSub.do" enctype="multipart/form-data" method="post">
<fieldset>

<div class="text-center"><legend>공지사항 등록</legend></div>

<div class="form-group">
  <label class="col-md-4 control-label" for="title">공지 타이틀</label>  
  <div class="col-md-4">
  <input id="title" name="title" type="text" class="form-control input-md" maxlength="30">
  </div>
</div>

<div class="form-group">
	<label class="col-md-4 control-label" for="notice_order">순위</label>
	<div class="col-md-4">
		<input id="notice_order" name="notice_order" type="text"
			class="form-control input-md" maxlength="3">
	</div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label" for="contents">내용</label>
  <div class="col-md-4">
  <textarea class="form-control" id="contents" name="contents" rows="10"></textarea>
  </div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label">사진</label>  
  <div class="col-md-4">
  	<input id="notice_img_file" filestyle="" type="file" name="notice_img_file" data-class-button="btn btn-default" data-class-input="form-control" data-button-text="" data-icon-name="fa fa-upload" class="form-control" tabindex="-1" style="position: absolute; clip: rect(0px 0px 0px 0px);">
	<div class="bootstrap-filestyle input-group">
		<input type="text" id="notice_img_name" class="form-control" name="notice_img_name" disabled="">
		<span class="group-span-filestyle input-group-btn" tabindex="0" style="border: 1px solid #d7d9db;">
			<label for="notice_img_file" class="btn btn-default " style="padding: 3px 17px;">
				<span class="glyphicon fa fa-upload"></span>
			</label>
		</span>
	</div>
  </div>
</div>

<div class="form-group" id="file_area">
<div id="file_inputs">
  <label class="col-md-4 control-label">파일</label>
  <div class="col-md-4" id="fileDiv">
  	<p><input type='file' multiple="multiple" name='notice_file'></p>
  </div>
</div>
</div>
</fieldset>

  <div class="col-md-4"></div>
  <div class="col-md-4">
	<div class="controls">
		<button type="button" style="float: left; margin-right: 10px;" class="btn btn-success center-block" onclick="postingNoticeSubFunc(); return false;">등록하기</button>
		<button type="button" style="float: left;" class="btn btn-success center-block" id="addFile">파일 추가</button>
	</div>
</div>
</form>
  <div class="col-md-4"></div>

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
	
	$("#notice_file").on('change', function(){  // 값이 변경되면
		if(window.FileReader){  // modern browser
			var filename = $(this)[0].files[0].name;
		} else {  // old IE
			var filename = $(this).val().split('/').pop().split('\\').pop();  // 파일명만 추출
		}
		// 추출한 파일명 삽입
		$("#notice_file_name").val(filename);
	});
});

</script>

