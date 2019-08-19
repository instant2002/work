<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<div class="col-xs-12">
	<div class="col-xs-12 text-center">
		<h2><strong>공지사항</strong></h2>
	</div>
	<table class="table table-hover">
		<thead style="font-weight: bold; border: solid #ddd; border-width: 2px 0px; background: #f9f9f9;">
			<tr>
				<td style="width: 60px;">번호</td>
				<td>제목</td>
				<td>날짜</td>
				<td>작성자</td>
				<td>조회</td>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="notice" items="${notice}">
			<tr> 
				<td>${notice.num }</td>
				<td>
					<a href="/service/noticeView.do?num=${notice.num }">${notice.title }</a> 
				</td>
				<td>${notice.upload_date }</td>
				<td>관리자</td>
				<td>${notice.views }</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>