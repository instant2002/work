<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<body  oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
	<div class="container-fluid">
		<div class="row">
			<div class="col-xs-2 col-xs-offset-5">
				<a href="/main.do"> <img src="/images/unionbooks/unionbooks_logo3.jpg"> <img src="/images/unionbooks_logo.png" class="logo" style="max-width: 100%;">
				</a>
			</div>
			<div class="col-xs-6 col-xs-offset-3">
				<img src="${storedName }">
			</div>
			<div class="col-xs-2 col-xs-offset-5">
				
			</div>
			<div class="container-fluid row" style="margin: 20px 0px;">
				<div class="col-lg-1 col-md-1 col-sm-1 col-xs-1" style="float: none; margin: 0 auto;">
					<button class="btn btn-buy-col pull-left add-cart" onclick="history.back();">목록으로</button>
				</div>
			</div>
		</div>
	</div>
</body>