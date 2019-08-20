<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<body class="home-v3">
	<header>
		<!-- top bar begin -->
		<div id="top-bar">
			<div class="container">
				<div class="pull-left left-top-bar">
					<div id="top-contacts">
						<ul class="list-inline">
							<li class="hidden-xs"><i class="icon-call-in"></i> <span>02-6953-0822</span></li>
							<li class="hidden-xs"><i class="icon-envelope"></i> <span class="hidden-xs">unionbooks@daum.net</span></li>
						</ul>
					</div>
				</div>
				<div class="pull-right">
					<div id="user-top-bar">
						<ul class="list-inline">
							<li class="btn-group"><a href="#" class="pm_item visible-xs"> <i class="icon-bag"></i> (2)
							</a></li>
							<li class="btn-group dropdown"><c:choose>
									<c:when test="${!empty user_id}">
										<a href="/member/logout.do" class="pm_item" title="logout"> <i class="icon-logout"></i> <span class="hidden-sm hidden-xs">로그아웃</span>
										</a>
									</c:when>
									<c:otherwise>
										<a href="#" class="pm_item" data-toggle="dropdown" title="login"> <i class="icon-login"></i> <span class="hidden-sm hidden-xs">로그인</span>
										</a>
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
													<button type="button" class="btn btn-sm btn-third-col" onclick="document.getElementById('loginSub').submit();">로그인</button>
													<button type="button" class="btn btn-sm btn-third-col" onclick="location.href='/member/registForm.do'">회원가입</button>
												</div>
												<div class="text-center">
													<a href="#" class="active">ID 찾기 | </a> <a href="#" class="active">PW 찾기</a>
												</div>
												<div class="dd-delimiter"></div>
												<div class="form-group text-center">
													<button type="button" class="btn btn-sm btn-sec-col" onclick="location.href='/member/registForm.do'">회원가입</button>
												</div>
											</form>
										</div>
									</div>
								</div></li>
							<li class="btn-group hidden-xs "><a href="/customer/mypage.do" class="pm_item" data-toggle="" title="마이페이지"> <i class="icon-user"></i> <span class="hidden-sm">마이페이지</span>
							</a></li>
							<li class="btn-group hidden-xs"><a href="/customer/orderList.do" class="pm_item"> <i class="fas fa-truck"></i> <span class="hidden-sm">나의 주문</span>
							</a></li>
							<li class="btn-group hidden-xs"><a href="/customer/basketList.do" class="pm_item"> <i class="icon-basket"></i> <span class="hidden-sm">장바구니<span>
							</a></li>
							<li class="btn-group hidden-xs "><a href="/service/noticeList.do" class="pm_item" title="adminPage"> <i class="fas fa-user"></i> <span class="hidden-sm hidden-xs">고객센터</span>
							</a></li>
							<c:if test="${sessionScope.user_id == 'admin'}">
								<li class="btn-group hidden-xs "><a href="/admin/postingBookForm.do" class="pm_item" title="adminPage"> <i class="fas fa-user-cog"></i> <span class="hidden-sm hidden-xs">관리자</span>
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
					<div id="header-logo" class="col-md-4 col-sm-12 header-logo">
						<a href="/main.do"> <img src="${pageContext.request.contextPath}/images/unionbooks/unionbooks_logo2.jpg" class="logo hidden-xs" alt="Shop+ - Responsive HTML5 Multipurpose Ecommerce Template"> <img src="${pageContext.request.contextPath}/images/unionbooks_logo.png" class="logo visible-xs-inline" alt="Shop+ - Responsive HTML5 Multipurpose Ecommerce Template">
						</a>
					</div>
					<div class="col-md-4 top-search-box" style="margin-top: 30px;">
						<form action="/book/bookList.do" method="get">
							<div class="required">
								<input type="text" name=keyword placeholder="도서 검색" class="placeholder-fix top-search" autocomplete="off" value="${keyword}" style="border: 4px solid #1a208d; font-style: unset; height: 50px;">
								<button style="margin-right: 10px;">
									<i class="icon_search field-icon"></i>
								</button>
							</div>
						</form>
					</div>
					<div class="col-md-3" style="margin-top: 30px; float: right;">
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
		<!-- header bar end -->
		<hr style="co">
		<!-- mobile menu begin -->
		<div class="mobile-menu">
			<nav>
				<div class="mobile-menu-button">
					MENU <a href="#" class="mobile-menu-toggler"><span></span><span></span><span></span></a>
				</div>
				<div class="mobile-menu-body">
					<div class="mobile-menu-search clearfix">
						<form action="/">
							<div class="form-group">
								<input type="text" class="form-control" placeholder="Search">
							</div>
							<button type="submit" class="btn btn-default">
								<i class="icon-magnifier"></i>
							</button>
						</form>
					</div>
					<ul>
						<li><a href="#"><i class="icon-home"></i> Home</a></li>
						<li><a href="#"><i class="icon-user"></i> Men</a> <a class="submenu-toggler" href="#"><i class="arrow_carrot-down"></i></a>
							<ul>
								<li><a href="#"><span>Shirts</span></a></li>
								<li><a href="#"><span>Jumper & Cardigans</span></a></li>
								<li><a href="#"><span>Autumn Jackets</span></a></li>
								<li><a href="#"><span>Winter Jackets</span></a></li>
								<li><a href="#"><span>Leather Jackets</span></a></li>
								<li><a href="#"><span>Jeans</span></a></li>
								<li><a href="#"><span>Shoes</span></a></li>
							</ul></li>
						<li><a href="#"><i class="icon-user-female"></i> Women</a> <a class="submenu-toggler" href="#"><i class="arrow_carrot-down"></i></a>
							<ul>
								<li><a href="#"><span>Shirts</span></a></li>
								<li><a href="#"><span>Jumper & Cardigans</span></a></li>
								<li><a href="#"><span>Autumn Jackets</span></a></li>
								<li><a href="#"><span>Winter Jackets</span></a></li>
								<li><a href="#"><span>Leather Jackets</span></a></li>
								<li><a href="#"><span>Jeans</span></a></li>
								<li><a href="#"><span>Shoes</span></a></li>
							</ul></li>
						<li><a href="#"><i class="icon-screen-desktop"></i> Electronics</a> <a class="submenu-toggler" href="#"><i class="arrow_carrot-down"></i></a>
							<ul>
								<li><a href="#"><span>Shirts</span></a></li>
								<li><a href="#"><span>Jumper & Cardigans</span></a></li>
								<li><a href="#"><span>Autumn Jackets</span></a></li>
								<li><a href="#"><span>Winter Jackets</span></a></li>
								<li><a href="#"><span>Leather Jackets</span></a></li>
								<li><a href="#"><span>Jeans</span></a></li>
								<li><a href="#"><span>Shoes</span></a></li>
							</ul></li>
					</ul>
					<p>
						<i class="icon-call-in"></i> + 1 (800) 2364 332 23 16
					</p>
					<p>
						<i class="icon-envelope"></i>your@email.com
					</p>
				</div>
			</nav>
		</div>
		<!-- mobile menu end -->
		<!-- page header begin -->
		<!--
      <div class="pg-header">
         <div class="container">
            <div class="row">
               <div class="col-sm-6 title">
                  <h1>Home Page</h1>
               </div>
               <div class="col-sm-6 b-crumbs-block">
                  <div class="b-crumbs text-right"><a href="#">Home</a> <i class="arrow_carrot-right"></i> Basic Page</div>
               </div>
            </div>
         </div>
      </div>
   -->
		<!-- page header end -->

	</header>
	<!-- page body content begin -->
	<div class="pg-body">
		<div class="container">
			<div class="row">