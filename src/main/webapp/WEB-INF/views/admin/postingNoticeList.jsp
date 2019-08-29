<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="text-center"><legend>공지사항 목록</legend></div>

<div class="col-xs-12">
	<table class="table table-hover">
	<c:choose>
		<c:when test="${empty notice}">
				<div class="text-center">등록되어 있는 공지사항이 없습니다. </div>
		</c:when>
		<c:otherwise>
		<thead style="font-weight: bold; border: solid #ddd; border-width: 2px 0px; background: #f9f9f9;">
			<tr>
				<td></td>
				<td>타이틀</td>
				<td>순위</td>
				<td>조회수</td>
				<td>날짜</td>
				<td></td>
				<td></td>
			</tr>
		</thead>
			<tbody>
			<c:forEach var="notice" items="${notice}">
				<tr>
					<td class=""><p>${notice.num }</p></td>
					<td class=""><a href="/service/noticeView.do?num=${notice.num }"><p class="ellipsis_7">${notice.title }</p></a></td>
					<td class=""><p>${notice.notice_order }</p></td>
					<td class=""><p>${notice.views }</p></td>
					<td class=""><p>${notice.upload_date }</p></td>
					<td class=""><a href="/admin/postingNoticeEditForm.do?num=${notice.num }">수정</a></td>
					<td class=""><a href="#" onclick="noticeDelFunc(${notice.num })">삭제</a></td>
				</tr>
			</c:forEach>
			</tbody>
			</c:otherwise>
		</c:choose>
	</table>
	<div class="text-center">
		<ul class="pagination">
			<li><a href="#">1</a></li>
			<li><a href="#">2</a></li>
			<li><a href="#">3</a></li>
			<li><a href="#">4</a></li>
			<li><a href="#">5</a></li>
		</ul>
	</div>
</div>
<script type="text/javascript">
function noticeDelFunc(num) {
	if(!confirm("선택된 공지사항 번호 = " + num + "\n정말로 삭제하시겠습니까?")){
		return false;
	}
	
	location.href="/admin/postingNoticeDel.do?num="+num;
}
</script>