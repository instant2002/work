<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>	
<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js">
<!--<![endif]-->
<head>
<meta charset="utf-8">
<title>Unionbooks - 유니온북스</title>
<meta name="description" content="">
<meta name="keywords" content="">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/accessiblemegamenu/megamenu.css"> --%>
<link href='http://fonts.googleapis.com/css?family=Open+Sans:300,400,700'	rel='stylesheet' type='text/css'>
<link href='${pageContext.request.contextPath}/font-face/helvetica.css'	rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/vendor/validation-engine.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/fonts/simple-line-icons.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/fonts/elegant-icons.css">
<script	src="${pageContext.request.contextPath}/js/modernizr-2.6.2.min.js"></script>
<!-- JS Libs -->
<script src="${pageContext.request.contextPath}/js/jquery-1.11.0.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-ui-1.10.4.custom.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script	src="${pageContext.request.contextPath}/js/jquery.bxslider.min.js"></script>
<script	src="${pageContext.request.contextPath}/js/jquery-accessibleMegaMenu.js"></script>
<script	src="${pageContext.request.contextPath}/js/jquery.validationEngine.js"></script>
<script	src="${pageContext.request.contextPath}/js/jquery.validationEngine-en.js"></script>
<script src="${pageContext.request.contextPath}/js/fastclick.js"></script>
<!-- Eliminating the 300ms click delay on mobile browsers -->
<script src="${pageContext.request.contextPath}/js/plugins.js"></script>
<script src="${pageContext.request.contextPath}/js/scripts.js"></script>

<!-- 추가 -->
<script src="${pageContext.request.contextPath}/js/remember-id.js"></script>
<script src="${pageContext.request.contextPath}/js/all.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-ui.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.css">
</head>

<tiles:insertAttribute name="header"/>
<div class="col-md-3 cat-sidebar" style="right: 0%;">
<tiles:insertAttribute name="left"/>
</div>
<div class="col-md-9 cat-content">
<tiles:insertAttribute name="body"/>
</div>
<tiles:insertAttribute name="footer"/>
   
</body>
</html>