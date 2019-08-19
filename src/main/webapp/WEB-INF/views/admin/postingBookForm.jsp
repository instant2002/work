<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="${pageContext.request.contextPath}/js/datepicker-ko.js"></script>

<form class="form-horizontal" id="posting_form" action="/admin/postingBookSub.do" enctype="multipart/form-data" method="post">
<fieldset>

<div class="text-center"><legend>상품 등록</legend></div>

<div class="form-group">
  <label class="col-md-4 control-label" for="book_name">도서명</label>  
  <div class="col-md-4">
  <input id="book_name" name="book_name" type="text" class="form-control input-md" placeholder="최대 30글자" maxlength="30">
  </div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label" for="origin_price">판매 가격</label>
  <div class="col-md-4">
  <input id="origin_price" name="origin_price" type="text" class="form-control input-md">
  </div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label" for="dc_price">할인 가격</label>
  <div class="col-md-4">
    <div class="input-group">
      <span class="input-group-addon">
          <input type="checkbox" id="discounted">     
          <input type="hidden" name="discounted" value="N">     
      </span>
      <input id="dc_price" name="dc_price" class="form-control" type="text">
    </div>
    <p class="help-block">할인을 할 거면 체크박스 클릭 후 판매 가격 입력</p>
  </div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label" for="checkboxes">분류</label>
  <div class="col-md-4">
    <label class="checkbox-inline" for="book_group_001">
      <input type="checkbox" name="book_group_arr" id="book_group_001" value="1">
      신규
    </label>
    <label class="checkbox-inline" for="book_group_002">
      <input type="checkbox" name="book_group_arr" id="book_group_002" value="2">
     인기
    </label>
  </div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label" for="checkboxes">카테고리</label>
  <div class="col-md-4">
    <button type="button" class="btn btn-outline-secondary" data-toggle="modal" data-target="#myModal">
  	카테고리
	</button>
  </div>
</div>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
<div>
</div>
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">카테고리 선택</h4>
      </div>
      <div class="modal-body">
		  <div class="col-xd-12 text-center">
		   <legend>서적</legend>
		  </div>
		  <div class="text-center" style="margin-bottom: 40px;">
		    <label class="checkbox-inline" for="book_cate_001">
		      <input type="checkbox" name="book_cate_arr" id="book_cate_001" value="1">
		      간호학
		    </label>
		    <label class="checkbox-inline" for="book_cate_002">
		      <input type="checkbox" name="book_cate_arr" id="book_cate_002" value="2">
		      의학
		    </label>
		    <label class="checkbox-inline" for="book_cate_003">
		      <input type="checkbox" name="book_cate_arr" id="book_cate_003" value="3">
		      기타서적
		    </label>
		    <label class="checkbox-inline" for="book_cate_004">
		      <input type="checkbox" name="book_cate_arr" id="book_cate_004" value="4">
		      보건,의류관계법규
		    </label>
		  </div>
		  <div class="col-xd-12 text-center">
		  
		   <legend>학회지</legend>
		  </div>
		  <div class="text-center" style="margin-bottom: 40px;">
		    <label class="checkbox-inline" for="book_cate_005">
		      <input type="checkbox" name="book_cate_arr" id="book_cate_005" value="5">
		      의학관련
		    </label>
		    <label class="checkbox-inline" for="book_cate_006">
		      <input type="checkbox" name="book_cate_arr" id="book_cate_006" value="6">
		      간호학관련
		    </label>
		    <label class="checkbox-inline" for="book_cate_007">
		      <input type="checkbox" name="book_cate_arr" id="book_cate_007" value="7">
		      보건학관련
		    </label>
		    <label class="checkbox-inline" for="book_cate_008">
		      <input type="checkbox" name="book_cate_arr" id="book_cate_008" value="8">
		      공학관련
		    </label>
		    <label class="checkbox-inline" for="book_cate_009">
		      <input type="checkbox" name="book_cate_arr" id="book_cate_009" value="9">
		      기타학회지
		    </label>
		  </div>
		  <div class="col-xd-12 text-center">
		  
		   <legend>기타출판물</legend>
		  </div>
		  <div class="text-center" style="margin-bottom: 40px;">
		    <label class="checkbox-inline" for="book_cate_010">
		      <input type="checkbox" name="book_cate_arr" id="book_cate_010" value="10">
		      관공서관련
		    </label>
		    <label class="checkbox-inline" for="book_cate_011">
		      <input type="checkbox" name="book_cate_arr" id="book_cate_011" value="11">
		      학교관련
		    </label>
		    <label class="checkbox-inline" for="book_cate_012">
		      <input type="checkbox" name="book_cate_arr" id="book_cate_012" value="12">
		      기타
		    </label>
		  </div>
		  
		  <div class="col-xd-12 text-center">
		   <legend>기타인쇄물</legend>
		  </div>
		  <div class="text-center" style="margin-bottom: 40px;">
		    <label class="checkbox-inline" for="book_cate_013">
		      <input type="checkbox" name="book_cate_arr" id="book_cate_013" value="13">
		      관공서관련
		    </label>
		    <label class="checkbox-inline" for="book_cate_014">
		      <input type="checkbox" name="book_cate_arr" id="book_cate_014" value="14">
		      학교관련
		    </label>
		    <label class="checkbox-inline" for="book_cate_015">
		      <input type="checkbox" name="book_cate_arr" id="book_cate_015" value="15">
		      학회관련
		    </label>
		    <label class="checkbox-inline" for="book_cate_016">
		      <input type="checkbox" name="book_cate_arr" id="book_cate_016" value="16">
		      기타
		    </label>
		  </div>
		  <div class="text-center">
		  <label class="checkbox-inline" for="book_cate_all">
		      <input type="checkbox" id="book_cate_all">
		      전체
		    </label>
		  </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
  </div>

<div class="form-group">
	<label class="col-md-4 control-label" for="book_order">순위</label>
	<div class="col-md-4">
		<input id="book_order" name="book_order" type="text"
			class="form-control input-md" maxlength="3">
	</div>
</div>

		<div class="form-group">
  <label class="col-md-4 control-label">사진</label>  
  <div class="col-md-4">
  	<input id="book_img_file" filestyle="" type="file" name="book_img_file" data-class-button="btn btn-default" data-class-input="form-control" data-button-text="" data-icon-name="fa fa-upload" class="form-control" tabindex="-1" style="position: absolute; clip: rect(0px 0px 0px 0px);">
	<div class="bootstrap-filestyle input-group">
		<input type="text" id="book_img_name" class="form-control" name="book_img_name" disabled="">
		<span class="group-span-filestyle input-group-btn" tabindex="0" style="border: 1px solid #d7d9db;">
			<label for="book_img_file" class="btn btn-default " style="padding: 3px 17px;">
				<span class="glyphicon fa fa-upload"></span>
			</label>
		</span>
	</div>
  </div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label" for="writer">저자</label>
  <div class="col-md-4">
  <input id="writer" name="writer" type="text" class="form-control input-md" maxlength="20" placeholder="최대 20글자">
  </div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label" for="release_date">출판일</label>  
  <div class="col-md-4">
  <input id="release_date" name="release_date" type="text" class="form-control input-md" readonly="readonly">
  </div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label" for="book_explanation">설명</label>
  <div class="col-md-4">
  <textarea class="form-control" id="book_explanation" name="book_explanation" rows="10"></textarea>
  </div>
</div>


</fieldset>

<div class="control-group">
      <div class="controls">
        <button class="btn btn-success center-block" onclick="postingBookSubFunc(); return false;">등록하기</button>
      </div>
    </div>
</form>


<script src="${pageContext.request.contextPath}/js/availability_posting.js"></script>
<script type="text/javascript">

//파일명만 추출
$(document).ready(function(){
	$("#book_img_file").on('change', function(){  // 값이 변경되면
		if(window.FileReader){  // modern browser
			var filename = $(this)[0].files[0].name;
		} else {  // old IE
			var filename = $(this).val().split('/').pop().split('\\').pop();  // 파일명만 추출
		}
		// 추출한 파일명 삽입
		$("#book_img_name").val(filename);
	});
});

//카테고리 전체 선택
$(document).ready(function(){
	   $("#book_cate_all").click(function(){
	      var isChecked = $("#book_cate_all").is(":checked");
	      $("[name=book_cate_arr]").prop("checked", isChecked);
	   });
	});

//datepicker
$(function(){
	    $("#release_date").datepicker();
});
</script>

