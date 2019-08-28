<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<form class="form-horizontal" id="postingSampleImg_form" action="/admin/postingSampleImgSub.do" enctype="multipart/form-data" method="post">
	<fieldset>
		<div class="text-center">
			<legend>샘플 이미지 등록</legend>
		</div>
		<div class="form-group">
			<label class="col-md-4 control-label" for="title">샘플 타이틀</label>
			<div class="col-md-4">
				<input id="sample_img_title" name="sample_img_title" type="text" class="form-control input-md" maxlength="30">
			</div>
		</div>

		<div class="form-group" id="file_area">
			<div id="file_inputs">
				<label class="col-md-4 control-label">파일</label>
				<div class="col-md-4" id="sample_img">
					<p>
						<input type='file' multiple="multiple" name='sample_img'>
					</p>
				</div>
			</div>
		</div>
	</fieldset>

	<div class="col-md-4"></div>
	<div class="col-md-4">
		<div class="controls">
			<button type="button" style="float: left; margin-right: 10px;" class="btn btn-success center-block" onclick="postingSampleImgFunc(); return false;">등록하기</button>
		</div>
	</div>
</form>
<div class="col-md-4"></div>

<script type="text/javascript">
function postingSampleImgFunc(){
	if($("#sample_img_title").val() == ""){
		alert('샘플 타이틀을 입력하세요.');
		$("#title").focus();
		return false;
	}
	if(!confirm("이대로 등록하시겠습니까?")){
		return false; 
	}
	$("#postingSampleImg_form").submit();
}
</script>

