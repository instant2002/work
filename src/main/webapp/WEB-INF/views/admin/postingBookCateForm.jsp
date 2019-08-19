<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="${pageContext.request.contextPath}/js/datepicker-ko.js"></script>

<form class="form-horizontal" id="posting_form" action="/admin/postingBookSub.do" enctype="multipart/form-data" method="post">
<fieldset>

<div class="text-center"><legend>상품 분류 등록</legend></div>

<div class="col-xs-12">

<div class="col-md-3"></div>
<div class="col-md-6">
<table class="table table-striped table-hover">
				<div class="text-center" style="display: none;">등록되어 있는 상품이 없습니다. </div>
		<thead>
			<tr>
				<td class="col-md-2">번호</td>
				<td class="col-md-8">분류명</td>
				<td class="col-md-2"></td>
			</tr>
		</thead>
			<tbody>
				<tr>
					<td class="">1</td>
					<td class=""><input type="text"></td>
					<td class="">삭제</td>
					
				</tr>
			</tbody>
	</table>
</div>
<div class="col-md-3"></div>
</div>
