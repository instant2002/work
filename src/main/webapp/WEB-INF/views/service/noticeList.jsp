<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="col-xs-12" style="margin-bottom: 30px;">
	<div class="col-xs-12 text-center">
		<h2><strong>공지사항</strong></h2>
	</div>
	<table class="table table-hover">
			<colgroup class="hidden-xs">
				<col width="5%">
				<col width="50%">
				<col width="20%">
				<col width="10%">
				<col width="15%">
			</colgroup>
		<thead class="hidden-xs" style="font-weight: bold; border: solid #ddd; border-width: 2px 0px; background: #f9f9f9;">
			<tr>
				<td>번호</td>
				<td>제목</td>
				<td class="text-center">날짜</td>
				<td>작성자</td>
				<td>조회</td>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="notice" items="${notice}">
			<tr> 
				<td class="hidden-xs">${notice.num }</td>
				<td class="hidden-xs"><b><a href="/service/noticeView.do?num=${notice.num }">${notice.title }</a></b></td>
				<td class="text-center hidden-xs">${notice.upload_date }</td>
				<td class="hidden-xs">관리자</td>
				<td class="hidden-xs">${notice.views }</td>
				<td class="hidden-sm hidden-md hidden-lg">
					<a href="/service/noticeView.do?num=${notice.num }">
						<div>
							<font class="notice_mobile_font1">${notice.title }</font> <br>
							<font class="notice_mobile_font2">관리자 &nbsp;&nbsp;${notice.upload_date } <br>조회수&nbsp;&nbsp;${notice.views }</font>
						</div>
					</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>