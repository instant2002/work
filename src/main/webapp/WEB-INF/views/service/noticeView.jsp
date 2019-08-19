<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<div class="col-xs-12">
	<div class="col-xs-12">
		<h2><strong>공지사항</strong></h2>
	</div>
	<div class="col-xs-12" style="border: solid #ddd; border-width: 2px 0px 1px 0px; background: #f9f9f9; padding: 10px 15px;">
		<span style="font-size: 20px;"><strong>${notice.title }</strong></span>
	</div>
	<div class="col-xs-12" style="border: solid #ddd; border-width: 0px 0px 1px 0px; height: 40px; vertical-align: middle; padding-top: 8px;">
		<strong><span>관리자</span></strong>
		<span style="border-left: 1px solid #dbdbdb; font-size: 11px; margin-left: 10px; padding-left: 10px;">${notice.upload_date }</span>
		<strong><span style="float: right;">조회수 ${notice.views }</span></strong>
	</div>
	<c:if test="${file_list.size() > 0}">
	<div class="col-xs-12" style="border: solid #ddd; border-width: 0px 0px 1px 0px;  padding: 10px 15px;">
	<font style="padding: 0 10px 0 10px; font-weight: bold; background: url('${pageContext.request.contextPath}/images/file_icon.png') no-repeat 0 6px;">첨부파일</font>
		<div>
		<c:forEach var="file_list" items="${file_list}">
			<a href="/common/downloadFile.do?name=${file_list.notice_file_name }&storedName=${file_list.notice_file_storedName}">${file_list.notice_file_name }</a><br>
		</c:forEach>
		</div>
	</div>
	</c:if>
	<c:if test="${notice.notice_img_storedName != '' }">
	<img src="${notice.notice_img_storedName }" style="margin-top: 30px;">
	</c:if>
	<div>
		<pre style="border: 1px solid white;">${notice.contents }</pre>
	</div>
</div>
<hr style="width: 100%; margin-bottom: 30px;">
<div class="col-md-10"></div>
<div class="col-md-2">
	<button class="btn btn-sm btn-yet-col" type="button" onclick="location.href='/service/noticeList.do'">목록으로</button>
</div>
