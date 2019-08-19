<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="${pageContext.request.contextPath}/js/datepicker-ko.js"></script>

<form class="form-horizontal" id="posting_form" action="/admin/postingBookSub.do" enctype="multipart/form-data" method="post">
<fieldset>

<div class="text-center"><legend>상품 목록</legend></div>

<div class="col-xs-12">
	<table class="table table-hover">
	<c:choose>
		<c:when test="${empty book}">
				<div class="text-center">등록되어 있는 상품이 없습니다. </div>
		</c:when>
		<c:otherwise>
		<thead style="font-weight: bold; border: solid #ddd; border-width: 2px 0px; background: #f9f9f9;">
			<tr>
				<td></td>
				<td>상품명</td>
				<td>상품가</td>
				<td>할인</td>
				<td>할인가</td>
				<td>등록일/출판일</td>
				<td></td>
				<td></td>
			</tr>
		</thead>
			<tbody>
			<c:forEach var="book" items="${book}">
				<tr>
					<td class=""><p>${book.product_no }</p></td>
					<td class=""><a href="/book/detailView.do?product_no=${book.product_no }"><p class="ellipsis_7">${book.book_name }</p></a></td>
					<td class=""><p>${book.origin_price }</p></td>
					<td class=""><p>${book.discounted }</p></td>
					<td class=""><p>${book.dc_price }</p></td>
					<td class=""><p>${book.upload_date }<br>${book.release_date }</p></td>
					<td class=""><a href="/admin/postingBookEditForm.do?product_no=${book.product_no }">수정</a></td>
					<td class=""><a href="#" onclick="bookDelFunc(${book.product_no })">삭제</a></td>
				</tr>
			</c:forEach>
			</tbody>
			</c:otherwise>
		</c:choose>
	</table>
</div>
<script type="text/javascript">
function bookDelFunc(product_no) {
	if(!confirm("선택된 상품 번호 = " + product_no + "\n정말로 삭제하시겠습니까?")){
		return false;
	}
	
	location.href="/admin/postingBookDel.do?product_no="+product_no;
}
</script>