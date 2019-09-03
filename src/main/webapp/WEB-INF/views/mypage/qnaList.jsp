<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<div class="col-xs-12 text-center">
		<h2><strong>1:1 문의 목록(Q&A)</strong></h2>
	</div>
	<table class="table table-hover">
		<colgroup class="hidden-xs">
			<col width="5%">
			<col width="60%">
			<col width="25%">
			<col width="15%">
		</colgroup>
		<thead class="hidden-xs" style="font-weight: bold; border: solid #ddd; border-width: 2px 0px; background: #f9f9f9;">
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
				<td class="hidden-xs">${qna_list.idx }</td>
				<td class="hidden-xs"><a href="/customer/qnaView.do?idx=${qna_list.idx }">${qna_list.title }</a></td>
				<td class="hidden-xs">${qna_list.question_upload_date }</td>
				<c:if test="${qna_list.isAnswer == 'Y' }">
					<c:set value="답변 완료" var="aswer_status"/>
				</c:if>
				<c:if test="${qna_list.isAnswer == 'N' }">
					<c:set value="준비중" var="aswer_status"/>
				</c:if>
				<td class="text-center hidden-xs"><c:out value="${aswer_status}"/></td>
				<td class="hidden-sm hidden-md hidden-lg">
					<a href="/customer/qnaView.do?idx=${qna_list.idx }">
					<div>
						<font class="notice_mobile_font1">${qna_list.title }</font><br>
						<font class="notice_mobile_font2">${qna_list.question_upload_date }<br>
						답변 상태 : <c:out value="${aswer_status}"/></font>
					</div>
					</a>
				</td>
			</tr>
		</c:forEach>
</c:otherwise>
</c:choose>
		</tbody>
	</table>
	<hr style="width: 100%; margin-bottom: 30px;">
<div class="col-xs-12 text-center" style="margin-bottom: 100px;">
	<button class="btn btn-buy-col" onclick="location.href='/service/qnaForm.do'">
		문의 등록
	</button>
</div>