<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="text-center"><legend>샘플 이미지 목록</legend></div>
<div class="col-xs-12">
	<table class="table table-hover">
	<c:choose>
		<c:when test="${empty sample_list}">
				<div class="text-center">등록되어 있는 샘플 이미지가 없습니다.</div>
		</c:when>
		<c:otherwise>
		<thead style="font-weight: bold; border: solid #ddd; border-width: 2px 0px; background: #f9f9f9;">
			<tr>
				<td>타이틀</td>
				<td>URL</td>
				<td>날짜</td>
				<td></td>
			</tr>
		</thead>
			<tbody>
			<c:forEach var="sample_list" items="${sample_list}">
				<tr>
					<td class=""><a href="/service/sampleView.do?calling=${sample_list.sample_calling_name }"><p>${sample_list.sample_img_title}</p></a></td>
					<td class=""><p>http://unionbooks.kr/service/sampleView.do?calling=${sample_list.sample_calling_name }</p></td>
					<td class=""><p>${sample_list.sample_upload_date }</p></td>
					<td class=""><a href="#" onclick="sampleDelFunc('${sample_list.sample_calling_name }')">삭제</a></td>
				</tr>
			</c:forEach>
			</tbody>
			</c:otherwise>
		</c:choose>
	</table>
</div>
<script type="text/javascript">
function sampleDelFunc(sample_calling_name) {
	if(!confirm("정말로 삭제하시겠습니까?")){
		return false;
	}
	
	location.href="/admin/postingSampleDel.do?sample_calling_name="+sample_calling_name;
}
</script>