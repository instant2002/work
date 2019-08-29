<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<body oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
	<div class="container-fluid">
		<div class="row">
			<div class="text-center hidden-xs">
				<a href="/main.do"><img src="/images/unionbooks/unionbooks_logo4.jpg"></a>
			</div>
			<div class="text-center hidden-sm hidden-md hidden-lg">
				<a href="/main.do"><img src="/images/unionbooks/unionbooks_logo4.jpg" style="width: 140px;"></a>
			</div>
			<div class="col-lg-6 col-lg-offset-3">
				<div class="col-xs-12 hidden-xs text-center" style="border: solid #ddd; border-width: 2px 0px 1px 0px; background: #f9f9f9; padding: 10px 15px;">
					<span style="font-size: 20px;"><strong>${img_list[0].sample_img_title }</strong></span>
				</div>
				<div class="col-xs-12 hidden-sm hidden-md hidden-lg text-center" style="border: solid #ddd; border-width: 2px 0px 1px 0px; background: #f9f9f9;">
					<span style="font-size: 16px;"><strong>${img_list[0].sample_img_title }</strong></span>
				</div>
			</div>
			<div class="col-lg-6 col-lg-offset-3">
				<c:forEach var="img_list" items="${img_list}">
					<img src="${img_list.sample_img_storedName }">
				</c:forEach>
			</div>
			<div class="col-md-12" style="margin: 50px 0;">
				<div style="display: table; margin: 0 auto;">
					<button class="btn btn-buy-col pull-left add-cart" onclick="location.href='/main.do'">홈페이지 가기</button>
				</div>
			</div>

		</div>
	</div>
</body>