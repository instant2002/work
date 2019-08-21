<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<form action="/book/bookList.do" id="searchForm">
	<input type="hidden" name="sortby" value="${ordering.sortby}"> <input type="hidden" name="perPageNum" value="${ordering.perPageNum}"> <input type="hidden" name="book_group" value="${ordering.book_group}">
	<div class="input-group" style="margin-top: 20px;">
		<input type="text" class="form-control" name="keyword" id="keyword" placeholder="도서명을 입력하세요!" style="box-shadow: 0 0 0 2px #a8a8a8 inset;"> <span class="input-group-btn">
			<button class="btn btn-secondary" type="button" onclick="document.getElementById('searchForm').submit();">
				<i class="fas fa-search"></i>
			</button>
		</span>
	</div>
</form>

<form action="/book/bookList.do" id="orderingForm">
	<input type="hidden" name="keyword" value="${keyword}">
	<div class="cat-view-options">
		<div class="row">
			<div class="col-md-4">
				<div class="row no-gutter form-group">
					<div class="col-md-12">
						<select class="form-control cvo-control s-styled hasCustomSelect" name="sortby" style="cursor: pointer;">
							<option value="">정렬 없음</option>
							<option value="price">낮은 가격순</option>
							<option value="release_date">최신 출판순</option>
							<option value="name_asc">ㄱ-ㅎ순</option>
							<option value="name_desc">ㅎ-ㄱ순</option>
						</select>
					</div>
				</div>
			</div>
			<div class="col-md-3 col-lg-2">
				<div class="row no-gutter form-group">
					<div class="col-md-12">
						<select class="form-control cvo-control s-styled hasCustomSelect" name="perPageNum" style="cursor: pointer;">
							<option value="12">12개씩보기</option>
							<option value="20">20개씩보기</option>
							<option value="36">36개씩보기</option>
							<option value="60">60개씩보기</option>
						</select>
					</div>
				</div>
			</div>
			<div class="col-md-2 col-lg-2 cvo-availability-col">
				<div class="form-group">
					<select class="form-control cvo-control s-styled hasCustomSelect" name="book_group" style="cursor: pointer;">
						<option value="">선택 없음</option>
						<option value="1">신간 상품</option>
						<option value="2">인기 상품</option>
					</select>
				</div>
			</div>
			<div class="col-md-2 text-left">
				<button class="btn btn-yet-col" type="button" onclick="document.getElementById('orderingForm').submit();" style="font-size: 12px; padding: 2px 10px; font-family: -webkit-body;">적용</button>
				<button class="btn btn-yet-col" type="button" onclick="location.href='/book/bookList.do?page=${pageMaker.page}&keyword=${keyword}'" style="font-size: 12px; padding: 2px 10px; font-family: -webkit-body;">초기화</button>
			</div>
			<div class="col-md-1 col-lg-2 text-right">
				<div class="cvo-view-type" role="tablist">
					<ul class="list-inline">
						<li class="active"><a href="#pl-grid" role="tab" data-toggle="tab" class="cvo-grid"> <svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="14px" height="14px" viewBox="0 0 50 50" xml:space="preserve">
                                       <rect x="0" y="0" width="20" height="20" />
                                       <rect x="30" y="0" width="20" height="20" />
                                       <rect x="0" y="30" width="20" height="20" />
                                       <rect x="30" y="30" width="20" height="20" />
                                    </svg>
						</a></li>
						<li><a href="#pl-list" role="tab" data-toggle="tab" class="cvo-list"> <svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="14px" height="14px" viewBox="0 0 30.263 25.6" xml:space="preserve">
                                       <rect width="7.732" height="6.398" />
                                       <rect y="9.6" width="7.732" height="6.4" />
                                       <rect y="19.199" width="7.732" height="6.398" />
                                       <rect x="10.933" y="9.602" width="19.33" height="6.4" />
                                       <rect x="10.933" y="19.199" width="19.33" height="6.4" />
                                       <rect x="10.933" width="19.33" height="6.4" />
                                    </svg>
						</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</form>
<!-- cat-view-options -->

<div class="tab-content tab-no-style">
	<div class="tab-pane fade in active" id="pl-grid">
		<div class="products-list">
			<div class="row">
			<c:choose>
				<c:when test="${empty book_list}">
					<div class="col-md-12 text-center" style="margin-bottom: 50px;">
						등록되어 있는 상품이 없습니다!
					</div>
				</c:when>
				<c:otherwise>
				<c:forEach var="book_list" items="${book_list}">
					<div class="col-md-3 col-sm-6 pl-item" style="margin-bottom: 50px;">
						<figure>
							<a href="/book/detailView.do?product_no=${book_list.product_no }"> <img src="${pageContext.request.contextPath}${book_list.book_img_storedName }" width="200px">
							</a>
							<c:choose>
								<c:when test="${fn:contains (book_list.book_group, '2') && book_list.discounted == 'Y'}">
									<label class="pl-badge">NEW | - <fmt:formatNumber value="${(book_list.dc_price / book_list.origin_price * 100)}" pattern="#" />%
									</label>
								</c:when>
								<c:when test="${fn:contains (book_list.book_group, '2')}">
									<label class="pl-badge">NEW</label>
								</c:when>
								<c:when test="${book_list.discounted == 'Y'}">
									<label class="pl-badge">- <fmt:formatNumber value="${(book_list.dc_price / book_list.origin_price * 100)}" pattern="#" />%
									</label>
								</c:when>
							</c:choose>
						</figure>
						<div class="pl-caption">
							<p class="pl-price-block">
								<c:choose>
									<c:when test="${book_list.discounted == 'Y'}">
										<span class="pl-price-old">&#8361; <fmt:formatNumber value="${book_list.origin_price}" groupingUsed="true" /></span>
										<span class="pl-price"> &#8361; <fmt:formatNumber value="${book_list.origin_price-book_list.dc_price}" groupingUsed="true" /></span>
									</c:when>
									<c:otherwise>
										<span class="pl-price">&#8361; <fmt:formatNumber value="${book_list.origin_price}" groupingUsed="true" /></span>
									</c:otherwise>
								</c:choose>
							</p>
							<p class="pl-name">${book_list.book_name }</p>
						</div>
					</div>
				</c:forEach>
				</c:otherwise>
			</c:choose>
			</div>
		</div>
	</div>
	<!-- grid list -->
	<div class="modal fade" id="basketModal">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">×</button>
								<h4 class="modal-title text-center">알림</h4>
							</div>
							<div class="modal-body text-center" style="margin-top: 20px;">
							상품이 장바구니에 담겼습니다.<br>
							<b>지금 확인하시겠습니까?</b>
							<div class="col-md-12" style="margin-top: 10px;">
								<button type="button" class="btn btn-secondary" onclick="location.href='/customer/basketList.do'">예</button>
								<button type="button" class="btn btn-secondary" onclick="$('#basketModal').modal('hide');">아니오</button>
							</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal">닫기</button>
							</div>
						</div>
					</div>
				</div>
				
				<div class="modal fade" id="wishModal">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">×</button>
								<h4 class="modal-title text-center">알림</h4>
							</div>
							<div class="modal-body text-center" style="margin-top: 20px;">
							상품이 위시리스트에 담겼습니다.<br>
							<b>지금 확인하시겠습니까?</b>
							<div class="col-md-12" style="margin-top: 10px;">
								<button type="button" class="btn btn-secondary" onclick="location.href='/customer/wishList.do'">예</button>
								<button type="button" class="btn btn-secondary" onclick="$('#wishModal').modal('hide');">아니오</button>
							</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal">닫기</button>
							</div>
						</div>
					</div>
				</div>
	<div class="tab-pane fade" id="pl-list">
		<div class="products-listview">


<!-- 윤식아 여기 구매하기 form 만들다 말았다 파라미터를 스크립트로 던져야할 듯 -->
	<form action="/order/orderCheckForm.do" method="POST" id="orderSubForm">
	
	</form>

			<c:forEach var="book_list" items="${book_list}">
				<div class="plv-item">
					<div class="row no-gutter">
						<div class="col-sm-4">
							<figure>
								<a href="/book/detailView.do?product_no=${book_list.product_no }" class="plv-w-backside"> <img src="${pageContext.request.contextPath}${book_list.book_img_storedName }"></a>
							</figure>
						</div>
						<div class="col-sm-8">
							<div class="plv-body">
								<div class="plv-header">
									<div class="row">
										<div class="col-xs-6 plv-title">
											<a href="#">${book_list.book_name }</a>
										</div>
										<div class="col-xs-6 plv-availability">
											<span class="plva-label">재고:</span>
											<c:if test="${book_list.stock == 'Y' }"> 
												<i class="dot-green"></i> <span>있음</span>
											</c:if>
											<c:if test="${book_list.stock == 'N' }"> 
												<i class="dot-red"></i> <span>없음</span>
											</c:if>
										</div>
									</div>
								</div>
								<div class="pl-price-block">
								<c:choose>
									<c:when test="${book_list.discounted == 'Y'}">
										<span class="pl-price-old">&#8361; <fmt:formatNumber value="${book_list.origin_price}" groupingUsed="true" /></span>
										<span class="pl-price"> &#8361; <fmt:formatNumber value="${book_list.origin_price-book_list.dc_price}" groupingUsed="true" /></span>
									</c:when>
									<c:otherwise>
										<span class="pl-price">&#8361; <fmt:formatNumber value="${book_list.origin_price}" groupingUsed="true" /></span>
									</c:otherwise>
								</c:choose>
								</div>
								<div class="plv-exerpt">
									<table class="table table-borderless">
										<tbody>
										<colgroup>
											<col style="width: 25%">
											<col style="width: 75%">
										</colgroup>
										<tr>
												<th>상품 번호</th>
												<td>
													<span>${book_list.product_no}</span>
												</td>
											</tr>
											<tr>
												<th>저자</th>
												<td>
													<span>${book_list.writer}</span>
												</td>
											</tr>
											<tr>
												<th>출판일</th>
												<td>
													<span>${book_list.release_date}</span>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="plv-buttons">
									<c:if test="${book_list.stock == 'Y' }"> 
										<a class="btn btn-sec-col" onclick="orderSubFunc(${book_list.product_no})"><i class="fas fa-book-open"></i>&nbsp;&nbsp;구매하기</a> 
										<a class="btn btn-prim-col" onclick="insertBasket(${book_list.product_no});"><i class="icon-basket"></i>&nbsp;&nbsp;장바구니</a> 
										<a class="btn btn-prim-col" onclick="insertWishList(${book_list.product_no});"><i class="icon-heart"></i>&nbsp;&nbsp;위시리스트</a>
									</c:if>
								</div>

							</div>
						</div>
					</div>
				</div>
				<!-- plv-item -->
			</c:forEach>
			
		</div>
		<!-- tab pl-list -->
	</div>

	<c:if test="${pageMaker.endPage > 0 }">
		<div class="cat-pagination">
			<div class="row">
				<div class="col-sm-3"></div>
				<div class="col-sm-6 text-center">
					<ul class="pagination">
						<c:if test="${pageMaker.prev }">
							<li><a href='<c:url value="/book/bookList.do?page=${pageMaker.startPage-1}&keyword=${keyword}&sortby=${ordering.sortby}&perPageNum=${ordering.perPageNum}&book_group=${ordering.book_group}"/>'><i class="fa fa-chevron-left"></i></a></li>
						</c:if>
						<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx" varStatus="status">
							<c:choose>
								<c:when test="${pageMaker.page == status.index }">
									<li class="active">
								</c:when>
								<c:otherwise>
									<li>
								</c:otherwise>
							</c:choose>
							<a href='<c:url value="/book/bookList.do?page=${idx}&keyword=${keyword}&sortby=${ordering.sortby}&perPageNum=${ordering.perPageNum}&book_group=${ordering.book_group}"/>'>${idx}</a>
							</li>
						</c:forEach>
						<c:if test="${pageMaker.next && pageMaker.endPage >0 }">
							<li><a href='<c:url value="/book/bookList.do?page=${pageMaker.endPage+1}&keyword=${keyword}&sortby=${ordering.sortby}&perPageNum=${ordering.perPageNum}&book_group=${ordering.book_group}"/>'><i class="fa fa-chevron-right"></i></a></li>
						</c:if>
					</ul>
				</div>
				<div class="col-sm-3"></div>
			</div>
		</div>
	</c:if>

	<script type="text/javascript">
		// 적용된 정렬값 select box에 적용
		$("select[name=sortby]  option[value=${ ordering.sortby }]").attr("selected", "selected");
		$("select[name=perPageNum]  option[value=${ ordering.perPageNum }]").attr("selected", "selected");
		$("select[name=book_group]  option[value=${ ordering.book_group }]").attr("selected", "selected");
		$("#keyword").val("${keyword}");
		
		function orderSubFunc(product_no){
			$("#orderSubForm").append("<input type='hidden' name='order_list[0].product_no' value='"+product_no+"'>");
			$("#orderSubForm").append("<input type='hidden' name='order_list[0].quantity' value='1'>");
			$("#orderSubForm").submit();
		}

		function insertBasket (product_no){
	    	var isLogin = "${isLogin}";
	    	if(isLogin != 'no'){
			$.ajax({
				url:'/customer/basketSub.do',
				type:'get',
				data:{product_no:product_no},
				dataType:'json',
				async: true,
				cache:false,
				timeout:30000,
				success:function(data){
					if(data){
						$('#basketModal').modal();
					}else{
						alert("처리 중 오류가 발생하였습니다.\n지속적인 오류가 발생될 시 고객센터에 문의해 주시기 바랍니다.");
					}
				},
				error:function(){
					alert("처리 중 오류가 발생하였습니다.\n지속적인 오류가 발생될 시 고객센터에 문의해 주시기 바랍니다.");
				}
			});
	    	}else{
	    		alert("로그인이 필요한 서비스입니다.");
	    	}
		}
	    
	    function insertWishList (product_no){
	    	var isLogin = "${isLogin}";
	    	if(isLogin != 'no'){
			$.ajax({
				url:'/customer/wishSub.do',
				type:'get',
				data:{product_no:product_no},
				dataType:'json',
				async: true,
				cache:false,
				timeout:30000,
				success:function(data){
					if(data){
						$('#wishModal').modal();
					}else{
						alert("처리 중 오류가 발생하였습니다.\n지속적인 오류가 발생될 시 고객센터에 문의해 주시기 바랍니다.");
					}
				},
				error:function(){
					alert("처리 중 오류가 발생하였습니다.\n지속적인 오류가 발생될 시 고객센터에 문의해 주시기 바랍니다.");
				}
			});
	    	}else{
	    		alert("로그인이 필요한 서비스입니다.");
	    	}
		}
	</script>