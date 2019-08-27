<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<div class="hidden-xs">
		<div class="col-xs-12">
			<h2>
				<strong>공지사항</strong>
			</h2>
		</div>
		<div class="col-xs-12" style="border: solid #ddd; border-width: 2px 0px 1px 0px; background: #f9f9f9; padding: 10px 15px;">
			<span style="font-size: 20px;"><strong>${notice.title }</strong></span>
		</div>
	</div>
	<div class="hidden-sm hidden-md hidden-lg">
	<div class="col-xs-12 text-center">
		<h2>
			<strong>공지사항</strong>
		</h2>
	</div>
	<div class="col-xs-12" style="border: solid #ddd; border-width: 2px 0px 1px 0px; background: #f9f9f9;;">
		<span style="font-size: 16px;"><strong>${notice.title }</strong></span>
	</div>
	</div>
	<div class="col-xs-12" style="border: solid #ddd; border-width: 0px 0px 1px 0px; line-height: 30px;">
		<strong><span>관리자</span></strong> <span style="border-left: 1px solid #dbdbdb; font-size: 11px; margin-left: 10px; padding-left: 10px;">${notice.upload_date }</span> <strong><span style="float: right;">조회수 ${notice.views }</span></strong>
	</div>
	<c:if test="${file_list.size() > 0}">
		<div class="col-xs-12" style="border: solid #ddd; border-width: 0px 0px 1px 0px; padding: 10px 15px;">
			<font style="padding: 0 10px 0 10px; font-weight: bold; background: url('${pageContext.request.contextPath}/images/file_icon.png') no-repeat 0 6px;">첨부파일</font>
			<div>
				<c:forEach var="file_list" items="${file_list}">
					<a href="/common/downloadFile.do?name=${file_list.notice_file_name }&storedName=${file_list.notice_file_storedName}">${file_list.notice_file_name }</a>
					<br>
				</c:forEach>
			</div>
		</div>
	</c:if>
	
	<c:if test="${attFile_list.size() > 0}">
		<div class="col-xs-12" style="border: solid #ddd; border-width: 0px 0px 1px 0px; padding: 10px 15px;">
			<font style="padding: 0 10px 0 10px; font-weight: bold;">첨부자료</font>
			<div>
				<c:forEach var="attFile_list" items="${attFile_list}">
					<a onclick="showFile('${attFile_list.notice_idx}','${attFile_list.notice_attFile_name}');">${attFile_list.notice_attFile_name }</a>
					<br>
				</c:forEach>
			</div>
		</div>
	</c:if>
	<c:if test="${notice.notice_img_storedName != '' }">
		<img src="${notice.notice_img_storedName }" style="margin-top: 30px;">
	</c:if>
	<div>
		<pre style="border: 1px solid white; white-space: pre-wrap;">${notice.contents }</pre>
	</div>
<hr style="width: 100%; margin-bottom: 30px;">
<div style="display: table; margin: 0 auto 50px auto;">
	<button class="btn btn-sm btn-yet-col" type="button" onclick="location.href='/service/noticeList.do'">목록으로</button>
</div>
<form action="/service/showSample.do" method="POST" id="showFileForm">
	<input type="hidden" name="notice_idx" id="show_notice_idx">
	<input type="hidden" name="notice_attFile_name" id="show_notice_attFile_name">
</form>
<script type="text/javascript">
function showFile(notice_idx, notice_attFile_name){
	$("#show_notice_idx").val(notice_idx);
	$("#show_notice_attFile_name").val(notice_attFile_name);
	$("#showFileForm").submit();
}
</script>