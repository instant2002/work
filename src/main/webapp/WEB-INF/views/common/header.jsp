<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<body class="home-v3">
	<header>
		<!-- top bar begin -->
		<div id="top-bar">
			<div class="container mobile_header_container">
				<div class="pull-left left-top-bar">
					<div id="top-contacts">
						<ul class="list-inline">
							<button type="button" class="mobile_sidebar_btn" onclick="$('#sideBar').toggle('slide');"></button>
							<li class="hidden-xs"><i class="icon-call-in"></i> <span>02-6953-0822</span></li>
							<li class="hidden-xs"><i class="icon-envelope"></i> <span class="hidden-xs">unionbooks@daum.net</span></li>
						</ul>
					</div>
				</div>
				<div class="pull-right">
					<div id="user-top-bar">
						<ul class="list-inline">
							<li class="btn-group"><a href="/customer/mypage.do" class="pm_item visible-xs"> <i class="icon-user"></i></a></li>
							<li class="btn-group"><a href="/customer/basketList.do" class="pm_item visible-xs"> <i class="icon-bag"></i></a></li>
							<li class="btn-group"><a href="/customer/orderList.do" class="pm_item visible-xs"> <i class="fas fa-truck"></i></a></li>
							</a>
							<li class="btn-group dropdown hidden-sm hidden-xs"><c:choose>
								<c:when test="${!empty user_id}">
									<a href="/member/logout.do" class="pm_item" title="logout"> <i class="icon-logout"></i> <span class="hidden-sm hidden-xs">로그아웃</span>
									</a>
								</c:when>
								<c:otherwise>
								<a href="#" class="pm_item" data-toggle="dropdown" title="login"> <i class="icon-login"></i> <span class="hidden-sm hidden-xs">로그인</span></a>
								</c:otherwise>
							</c:choose>
							<div class="dropdown-menu dropdown-menu-right" role="menu">
								<span class="dropdown-triangle-up"></span> <a href="#" class="dd-close-btn"><i class="icon_close"></i></a>
								<div class="dropdown-head">
									<h4 class="pull-left">로그인</h4>
								</div>
								<div class="dd-wrapper">
									<div id="dd_login">
										<form id="loginSub" action="/member/loginSub.do" method="post">
											<div class="required form-group">
												<input type="text" name="user_id" id="user_id" placeholder="아이디" class="placeholder-fix"> <i class="icon_mail field-icon"></i>
											</div>
											<div class="required form-group">
												<input type="password" name="user_pwd" id="user_pwd" placeholder="비밀번호" class="placeholder-fix"> <i class="icon_lock field-icon"></i>
											</div>
											<div class="form-group">
												<input id="remember" class="stl rememberid" type="checkbox" value="1"> <label class="stl" for="remember"><span></span>아이디 저장</label>
											</div>
											<div class="form-group text-center">
												<button type="button" class="btn btn-sm login_btn" onclick="document.getElementById('loginSub').submit();">로그인</button>
												<button type="button" class="btn btn-sm logout_btn" onclick="location.href='/member/registForm.do'">회원가입</button>
											</div>
											<div class="text-center">
												<a href="#" class="active">ID 찾기 | </a> <a href="#" class="active">PW 찾기</a>
											</div>
											<div class="dd-delimiter"></div>
										</form>
									</div>
								</div>
							</div>
							</li>
							<li class="btn-group hidden-xs "><a href="/customer/mypage.do" class="pm_item" data-toggle="" title="마이페이지"> <i class="icon-user"></i> <span class="hidden-sm">마이페이지</span>
							</a></li>
							<li class="btn-group hidden-xs"><a href="/customer/orderList.do" class="pm_item"> <i class="fas fa-truck"></i> <span class="hidden-sm">나의 주문</span>
							</a></li>
							<li class="btn-group hidden-xs"><a href="/customer/basketList.do" class="pm_item"> <i class="icon-basket"></i> <span class="hidden-sm">장바구니<span></a></li>
							<li class="btn-group hidden-xs "><a href="/service/noticeList.do" class="pm_item" title="adminPage"> <i class="fas fa-user"></i> <span class="hidden-sm hidden-xs">고객센터</span>
							</a></li>
							<c:if test="${sessionScope.user_id == 'admin'}">
								<li class="btn-group hidden-xs "><a href="/admin/postingBookList.do" class="pm_item" title="adminPage"> <i class="fas fa-user-cog"></i> <span class="hidden-sm hidden-xs">관리자</span>
								</a></li>
							</c:if>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<!-- top bar end -->
		<!-- header bar begin -->
		<div id="header-bar">
			<div class="container">
				<div class="row">
					<div id="header-logo" class="col-md-3 col-sm-12 header-logo">
						<a href="/main.do"> <img src="${pageContext.request.contextPath}/images/unionbooks/unionbooks_logo4.jpg" class="logo hidden-xs"> <img src="${pageContext.request.contextPath}/images/unionbooks/unionbooks_logo4.jpg" class="logo visible-xs-inline">
						</a>
					</div>
					<div class="col-xs-12 sideBar_searchBox top-search-box hidden-md hidden-lg" style="padding: 0 10px; border-bottom: 10px solid #f8f8f8; line-height: 42px; height: 77px;">
						<form action="/book/bookList.do" method="get" id="sideBar_searchForm">
							<input type="text" name="keyword" placeholder="도서 검색" class="placeholder-fix top-search" autocomplete="off" value="" style="border: 4px solid #11539d; font-style: unset; height: 40px;">
						</form>
						<button style=" top:0; margin-right: 10px;" onclick="document.getElementById('sideBar_searchForm').submit();">
							<i class="icon_search field-icon"></i>
						</button>
					</div>
					<div class="col-md-5 top-search-box hide_mobile" style="margin-top: 30px;">
						<!-- 						<form action="/book/bookList.do" method="get"> -->
						<div class="required">
							<form action="/book/bookList.do" method="get" id="top_searchForm">
								<input type="text" name=keyword placeholder="도서 검색" class="placeholder-fix top-search" autocomplete="off" value="${keyword}" style="border: 4px solid #265198; font-style: unset; height: 50px;">
								<button style="margin-right: 10px;" onclick="document.getElementById('top_searchForm').submit();">
									<i class="icon_search field-icon"></i>
								</button>
							</form>
						</div>
						</form>
					</div>
					<div class="col-md-3 hide_mobile" style="margin-top: 30px; float: right;">
						<div id="shopping-cart-wrapper">
							<a href="/book/bookList.do" class="shp-ca">
								<div class="s-bag-1">
									<i class="fas fa-book-medical"></i>
								</div>
								<div class="s-cart-pan">
									<div class="s-bag-2">
										<strong>전체 도서</strong>
									</div>
								</div>
							</a>
						</div>
					</div>
				</div>
			</div>
		</div>
		<hr style="margin-top: 0;">
	</header>
	
	<aside class="side-bar" id="sideBar" style="display: none;">
		<div class="col-xs-12 sideBar_top">
		<c:choose>
			<c:when test="${empty user_id}">
				<button type="button" class="btn btn-sm login_btn" onclick="location.href='/member/loginForm.do';">로그인</button>
				<button type="button" class="btn btn-yet-col btn-sm union_border_btn" onclick="location.href='/member/registForm.do'">회원가입</button>
			</c:when>
			<c:otherwise>
				<button type="button" class="btn btn-sm login_btn" onclick="location.href='/member/logout.do';">로그아웃</button>
				<font style="margin-left: 20px; font-weight: bold; color: #8a8989;">${user_id} 님</font>
			</c:otherwise>
		</c:choose>
			<span class="css-cancel mobile_sidebar_btn" onclick="$('#sideBar').toggle('slide');"></span>
		</div>
		<div>
			<div class="col-xs-3 side_quickMenu" onclick="location.href='/customer/mypage.do'">
				<div class="col-xs-12 side_quickMenu_icon">
					<i class="icon-user"></i>	
				</div>
				<div class="col-xs-12 side_quickMenu_font" >
					마이페이지
				</div>
			</div>
			<div class="col-xs-3 side_quickMenu" onclick="location.href='/customer/wishList.do'">
				<div class="col-xs-12 side_quickMenu_icon">
					<i class="icon-heart"></i>	
				</div>
				<div class="col-xs-12 side_quickMenu_font">
					위시리스트
				</div>
			</div>
			<div class="col-xs-3 side_quickMenu" onclick="location.href='/customer/basketList.do'">
				<div class="col-xs-12 side_quickMenu_icon">
					<i class="icon-basket"></i>	
				</div>
				<div class="col-xs-12 side_quickMenu_font">
					장바구니
				</div>
			</div>
			<div class="col-xs-3 side_quickMenu" style="border-right: none;" onclick="location.href='/customer/orderList.do'">
				<div class="col-xs-12 side_quickMenu_icon">
					<i class="fas fa-truck"></i>	
				</div>
				<div class="col-xs-12 side_quickMenu_font">
					주문배송
				</div>
			</div>
		</div>
		
		<div class="col-xs-12 side_mainMenu" style="margin-top: 20px; border: none; color: #265198;">
			<strong>도서 구분</strong>
		</div>
		<div class="col-xs-12 side_mainMenu" onclick="location.href='/book/bookList.do'">
				<i class="fas fa-book-medical side_mainMenu_i1"></i>&nbsp;&nbsp;&nbsp;<strong>전체 도서</strong>
				<i class="fas fa-chevron-right side_mainMenu_i2"></i>
		</div>
		<div class="col-xs-12 side_mainMenu" onclick="location.href='/book/bookList.do'" style="border: none;">
				<i class="fas fa-book-medical side_mainMenu_i1"></i>&nbsp;&nbsp;&nbsp;<strong>신간 도서</strong>
				<i class="fas fa-chevron-right side_mainMenu_i2"></i>
		</div>
		<div class="col-xs-12 side_mainMenu" onclick="location.href='/book/bookList.do'" style="border-bottom: 10px solid #f8f8f8;">
				<i class="fas fa-book-medical side_mainMenu_i1"></i>&nbsp;&nbsp;&nbsp;<strong>추천 도서</strong>
				<i class="fas fa-chevron-right side_mainMenu_i2"></i>
		</div>
		
		
		<div class="col-xs-12 side_mainMenu" style="margin-top: 20px; border: none; color: #265198;">
			<strong>커뮤니티</strong>
		</div>
		<div class="col-xs-12 side_mainMenu" onclick="location.href='/service/noticeList.do'">
				<i class="fas fa-bullhorn side_mainMenu_i1"></i>&nbsp;&nbsp;&nbsp;<strong>공지사항</strong>
				<i class="fas fa-chevron-right side_mainMenu_i2"></i>
		</div>
		<div class="col-xs-12 side_mainMenu" onclick="location.href='/service/qnaForm.do'" style="border: none;">
				<i class="fas fa-comments side_mainMenu_i1"></i>&nbsp;&nbsp;&nbsp;<strong>1:1 문의</strong>
				<i class="fas fa-chevron-right side_mainMenu_i2"></i>
		</div>
		<div class="col-xs-12 side_mainMenu" onclick="location.href='/service/faqList.do'" style="border-bottom: 10px solid #f8f8f8;">
				<i class="fas fa-question-circle side_mainMenu_i1"></i>&nbsp;&nbsp;&nbsp;<strong>FAQ 게시판</strong>
				<i class="fas fa-chevron-right side_mainMenu_i2"></i>
		</div>
		
		<div class="col-xs-12 side_mainMenu" style="margin-top: 20px; color: #989898; border: none;">
			<div class="side_bottom_font">
			월 ~ 금 : 오전 10시 ~ 오후 6시<br>
			토요일 | 일요일 | 공휴일 : 휴무<br>
			</div>
			<div class="side_bottom_font">
			Tel : 02) 6953-0822<br>
			E-mail : unionbooks@daum.net
			</div>
		</div>
	</aside>

	<div class="pg-body">
		<div class="container">
			<div class="row">