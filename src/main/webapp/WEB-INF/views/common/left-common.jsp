<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<aside>
	<div class="store-alt box-with-pager mobile-collapse" style="border: 2px solid #a8a8a8; padding: 0 12px; border-radius: 5px;">
		<h6 class="mobile-collapse-header store-alt text-center">공지사항</h6>
		<div class="wg-body mobile-collapse-body">
			<table class="table table-hover" style="margin-bottom: 0;">
				<c:choose>
					<c:when test="${empty notice}">
						<div class="text-center">등록되어 있는 공지사항이 없습니다.</div>
					</c:when>
					<c:otherwise>
						<tbody>
							<c:forEach var="notice" items="${notice}" varStatus="status">
								<c:if test="${status.index == 0}">
									<tr style="border-top: 2px solid #a8a8a8;">
								</c:if>
								<c:if test="${status.index != 0}">
									<tr>
								</c:if>
									<td>
										<a href="/service/noticeView.do?num=${notice.num }">
											<font class="ellipsis_7">${notice.title }</font>
										</a>
									</td>
								</tr>
							</c:forEach>
							<c:if test="${!empty notice}">
								<tr class="nonhover_bg">
									<td class="text-right"><font><a href="/service/noticeList.do">more</a></font></td>
								</tr>
							</c:if>
						</tbody>
					</c:otherwise>
				</c:choose>
			</table>
		</div>
		
			<!-- <font style="margin-left: 200px;"><a href="/service/noticeList.do">more</a></font> -->
	</div>

	<div class="widget wg-categories store-alt box-with-pager">
		<img src="${pageContext.request.contextPath}/images/unionbooks/left_Img1.jpg">
	</div>
</aside>
<!-- sidebar -->
