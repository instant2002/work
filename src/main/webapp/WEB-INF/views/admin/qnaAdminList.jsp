<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<div class="col-xs-12 text-center">
		<h2><strong>고객 1:1 문의 목록(Q&A)</strong></h2>
	</div>
	<div class="col-xs-12" style="margin-bottom: 10px;">
		<span class="sort_item">
			<a href="">인기순</a>&nbsp;&nbsp;|&nbsp;&nbsp;
			<a href="">최근등록순</a>&nbsp;&nbsp;|&nbsp;&nbsp;
			<a href="">판매인기순</a>&nbsp;&nbsp;|&nbsp;&nbsp;
			<a href="">낮은가격순</a>&nbsp;&nbsp;|&nbsp;&nbsp;
			<a href="">높은가격순</a>&nbsp;&nbsp;|&nbsp;&nbsp;
			<a href="">상품평많은순</a>
		</span>
	</div>
	<table class="table">
		<colgroup>
			<col style="width: 5%">
			<col style="width: 60%">
			<col style="width: 25%">
			<col style="width: 15%">
		</colgroup>
		<thead style="font-weight: bold; border: solid #ddd; border-width: 2px 0px; background: #f9f9f9;">
			<tr>
				<td>번호</td>
				<td>제목</td>
				<td>날짜</td>
				<td class="text-center">답변 여부</td>
			</tr>
		</thead>
		<tbody>
<c:choose>
	<c:when test="${empty qna_list}">
	<tr>
		<td colspan="4" class="text-center">문의하신 내역이 없습니다.</td>
	</tr>
	</c:when>
	<c:otherwise>
		<c:forEach var="qna_list" items="${qna_list}" varStatus="status">
			<tr>
				<td>${qna_list.idx }</td>
				<td><a href="/admin/qnaView.do?idx=${qna_list.idx }">${qna_list.title }</a></td>
				<td>${qna_list.question_upload_date }</td>
				<c:if test="${qna_list.isAnswer == 'Y' }">
					<c:set value="O" var="aswer_status"/>
				</c:if>
				<c:if test="${qna_list.isAnswer == 'N' }">
					<c:set value="X" var="aswer_status"/>
				</c:if>
				
				<td class="text-center"><c:out value="${aswer_status}"/></td>
			</tr>
		</c:forEach>
</c:otherwise>
</c:choose>
		</tbody>
	</table>
