<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<section class="clearfix text-center store-alt-products">
		<div class="news-list">
			<div class="back-line">
				<h2 class="news-title">신간 도서</h2>
			</div>
			<div class="row relative">
				<div class="news-container clearfix">
					<c:forEach var="book_new" items="${book_new}">
					<div class="col-md-3 col-xs-4 pl-item news-item">
						<figure>
							<a href="/book/detailView.do?product_no=${book_new.product_no }"> <img
								src="${pageContext.request.contextPath}${book_new.book_img_storedName }"
								alt="" style="width: 200px;">
							</a>
							<c:if test="${book_new.discounted == 'Y'}">
							<label class="pl-badge hide_mobile"><fmt:formatNumber value="${(book_new.dc_price / book_new.origin_price * 100)}" pattern="#"/>%↓</label>
							</c:if>
						</figure>
						<div class="pl-caption">
							<p class="pl-price-block">
							<a href="/book/detailView.do?product_no=${book_new.product_no }"><span class="pl-name ellipsis_8 mobile_book_name">${book_new.book_name }</span></a><br>
							<c:choose>
								<c:when test="${book_new.discounted == 'Y'}">
									<span class="pl-price-old"><fmt:formatNumber value="${book_new.origin_price}" groupingUsed="true"/>원</span>
									<span class="pl-price"> <fmt:formatNumber value="${book_new.origin_price-book_new.dc_price}" groupingUsed="true"/>원</span>
								</c:when>
								<c:otherwise>
									<span class="pl-price"><fmt:formatNumber value="${book_new.origin_price}" groupingUsed="true"/>원</span>
								</c:otherwise>
							</c:choose>
							</p>
						</div>
					</div>
					</c:forEach>
				</div>

				<div class="gap-60 clearfix"></div>

			</div>
			<!-- news-container -->
		</div>
		<!-- news-list -->
	</section>
	<!-- products block -->

	<section class="clearfix text-center store-alt-products">
		<div class="news-list">
			<div class="back-line">
				<h2 class="news-title">추천 도서</h2>
			</div>
			<div class="row">
				<div class="news-container clearfix">
				<c:forEach var="book_commend" items="${book_commend}">
					<div class="col-md-3 col-xs-4 pl-item news-item">
						<figure>
							<a href="/book/detailView.do?product_no=${book_commend.product_no }"> <img
								src="${pageContext.request.contextPath}${book_commend.book_img_storedName }"
								alt="" style="width: 200px;">
							</a>
							<c:if test="${book_commend.discounted == 'Y'}">
							<label class="pl-badge hide_mobile"><fmt:formatNumber value="${(book_commend.dc_price / book_commend.origin_price * 100)}" pattern="#"/>%↓</label>
							</c:if>
						</figure>
						<div class="pl-caption">
							<p class="pl-price-block">
							<a href="/book/detailView.do?product_no=${book_commend.product_no }"><span class="pl-name ellipsis_8 mobile_book_name">${book_commend.book_name }</span></a><br>
							<c:choose>
								<c:when test="${book_commend.discounted == 'Y'}">
									<span class="pl-price-old"><fmt:formatNumber value="${book_commend.origin_price}" groupingUsed="true"/>원</span>
									<span class="pl-price"> <fmt:formatNumber value="${book_commend.origin_price-book_commend.dc_price}" groupingUsed="true"/>원</span>
								</c:when>
								<c:otherwise>
									<span class="pl-price"><fmt:formatNumber value="${book_commend.origin_price}" groupingUsed="true"/>원</span>
								</c:otherwise>
							</c:choose>
							</p>
						</div>
					</div>
					</c:forEach>
				</div>
				<div class="gap-70 clearfix"></div>
			</div>
			<!-- news-container -->
		</div>
		<!-- news-list -->
	</section>
	<!-- products block -->

</div>
<!-- cat-content -->
