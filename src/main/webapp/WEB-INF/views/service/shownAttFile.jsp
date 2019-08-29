<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<body  oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
	<div class="container-fluid">
		<div class="row">
			<div class="text-center hidden-xs">
				<a href="/main.do"><img src="/images/unionbooks/unionbooks_logo4.jpg"></a>
			</div>
			<div class="text-center hidden-sm hidden-md hidden-lg">
				<a href="/main.do"><img src="/images/unionbooks/unionbooks_logo4.jpg" style="width: 140px;"></a>
			</div>
			<div class="col-lg-6 col-lg-offset-3">
				<img src="${storedName}">
			</div>
			<div class="col-md-12" style="margin: 50px 0;">
				<div style="display: table; margin: 0 auto;">
					<button class="btn btn-buy-col pull-left add-cart" onclick="history.back();">목록으로</button>
				</div>
			</div>
			
		</div>
	</div>
</body>