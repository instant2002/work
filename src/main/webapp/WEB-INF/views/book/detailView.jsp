<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
   <!-- page body content begin -->
   <div class="pg-body clearfix">
      <div class="container clearfix">
      <div class="row">
            <div class="container">
               <div class="col-xs-12 product-top-line">
                  <a href="/book/bookList.do" class="btn btn-yet-col2 col-xs-2 back-catalog pull-left">전체 도서 보기</a>
               </div>
            </div>
         </div>
         <div class="row">
            <div class="col-md-6 col-lg-7 col-xs-12 product-images">
               <div class="clearfix zoom-content">
                  <div aria-hidden="true" aria-labelledby="product-added" role="dialog" tabindex="-1" id="product-pupGallery-box" class="modal fade" style="display: none;">
                    <div class="modal-dialog modal-lg">
                      <div class="modal-content">
                        <div class="modal-header">
                           <a aria-hidden="true" data-dismiss="modal" class="modal-close" href="#"><i class="icon_close"></i></a>
                           <h4 class="modal-title">Information</h4>
                        </div>
                        <div class="modal-body modal-body-info">
                           <div class="clearfix zoom-content-2">
                              <div class="clearfix big-image">
                                 <img id="zoom_04" src="${book.book_img_storedName }" data-zoom-image="/images/product_page_gallery/1-big-3x.jpg" alt=""/> 
                              </div>
                           </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  
                  <div aria-hidden="true" aria-labelledby="product-added" role="dialog" tabindex="-1" id="product-video-box" class="modal fade" style="display: none;">
                    <div class="modal-dialog modal-md">
                      <div class="modal-content">
                        <div class="modal-header">
                           <a aria-hidden="true" data-dismiss="modal" class="modal-close" href="#"><i class="icon_close"></i></a>
                           <h4 class="modal-title">Product video</h4>
                        </div>
                        <div class="modal-body modal-body-info">
                           <div class="embed-responsive embed-responsive-16by9">
                              <iframe class="embed-responsive-item" src="" allowfullscreen=""></iframe>
                           </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="clearfix big-image product-page">
                     <img id="zoom_03" src="${book.book_img_storedName }" data-zoom-image="/images/product_page_gallery/1-big-3x.jpg" alt=""/> 
                  </div>
                  <br/>
               </div>
            </div>
            <div class="col-md-6 col-lg-5 col-xs-12 product-info">
               <div id="zoom-window-container" style="position: relative;"></div>
               <div class="product-reviews">
                  <h3><strong>${book.book_name }</strong></h3>
               </div>
               <div class="hr"></div>
               <c:choose>
               <c:when test="${book.discounted == 'Y'}">
               <c:set value="${book.origin_price-book.dc_price}" var="book_price"/>
               <div class="price">
                  &#8361; <fmt:formatNumber value="${book.origin_price-book.dc_price}" groupingUsed="true"/>
                  <span class="old-price">&#8361; <fmt:formatNumber value="${book.origin_price}" groupingUsed="true"/></span>
               </div>
               </c:when>
               <c:otherwise>
               <c:set value="${book.origin_price}" var="book_price"/>
               <div class="price">
               	  &#8361; <fmt:formatNumber value="${book.origin_price}" groupingUsed="true"/>
               </div>
               </c:otherwise>
               </c:choose>
               <p class="availability col-sm-pull-right col-xs-pull-left">
               		재고 : <span>
               			<c:if test="${book.stock == 'Y' }">
               				<span class="in-stock">
               				</span>있음</span>
               			</c:if>
               			<c:if test="${book.stock != 'Y' }">
               				<span class="out-stock">
               				</span>없음</span>
               			</c:if>
               </p>
               <div class="hr"></div>
               <table class="table table-borderless">
               <tr>
                   <th>상품 번호</th>
                   <td><span>${book.product_no}</span></td>
               </tr>
               <tr>
                   <th>저자</th>
                   <td><span>${book.writer}</span></td>
               </tr>
               <tr>
                   <th>출판일</th>
                   <td><span>${book.release_date}</span></td>
               </tr>
               </table>
               <div class="hr"></div>
               <p>주문 문의 : 010-2872-2161 </p>
               <div class="hr"></div>
               <form action="/order/orderCheckForm.do" method="POST" id="orderSubForm">
               <div class="cart_quantity_button clrfix product-count pull-left">
                  <a rel="nofollow" class="btn btn-default btn-minus" href="#" title="Subtract" onclick="edit_quantity_minus();">&ndash;</a>
                  <input type="text" size="2" autocomplete="off" class="cart_quantity_input form-control grey count" id="book_quantity" value="1" name="order_list[0].quantity" style="width: 80px;" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');">
                  <a rel="nofollow" class="btn btn-default btn-plus" href="#" title="Add" onclick="edit_quantity_plus();">+</a>
               </div>
               <input type="hidden" name="order_list[0].product_no" value="${book.product_no}">
               </form>
               <div class="total_price" id="total_price">
               	  <fmt:formatNumber value="${book_price}" groupingUsed="true"/> 원
               </div>
               <div class="hr"></div>
               <c:if test="${book.stock == 'Y' }">
	               <button class="btn btn-buy-col pull-left add-cart" onclick="document.getElementById('orderSubForm').submit();"><i class="fas fa-book-open"></i>&nbsp;&nbsp;구매하기</button>
	               <button class="btn btn-cart-col pull-left add-cart" onclick="insertBasket(${book.product_no});"><i class="icon-basket"></i>&nbsp;&nbsp;장바구니</button>
	               <button class="btn btn-wish-col pull-left add-cart" onclick="insertWishList(${book.product_no});"><i class="icon-heart"></i>&nbsp;&nbsp;위시리스트</button>
               </c:if>
               <c:if test="${book.stock == 'N' }">
               	<div class="col-xd=12 text-center">
               		<h5>현재 상품이 매진되었습니다.</h5>
               		<h5>빠른 시일 내에 준비하겠습니다.</h5>
               		<h5>감사합니다.</h5>
               	</div>
               </c:if>
               
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

				<div class="hr"></div>
               <div class="product-tabs">
                  <!-- Nav tabs -->
                  <ul role="tablist" class="nav nav-tabs">
                    <li class="active" style="width: 100%;"><a data-toggle="tab" role="tab" href="#tab-description" style="text-align: center;">DESCRIPTION</a></li>
                  </ul>

                  <!-- Tab panes -->
                  <div class="tab-content">
                     <div id="tab-description" class="tab-pane active">
                        <pre><p>${book.book_explanation }</p></pre>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div> <!-- pg-body -->
   
   <script type="text/javascript">
   var oldVal = ""
   function numberWithCommas(num) {
	    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
   
   function edit_quantity_plus() {
	   var currentVal = parseInt($('#book_quantity').val(),10);
	   var currentVal = currentVal + 1; 
	   var price = <c:out value="${book_price}"/>;
	   var total_price = numberWithCommas(price * currentVal);
	   $("#total_price").html(total_price+" 원");
   }
   
   function edit_quantity_minus() {
	   var currentVal = parseInt($('#book_quantity').val(),10);
	   var currentVal = currentVal - 1; 
	   if(currentVal >= 0){
		   var price = <c:out value="${book_price}"/>;
		   var total_price = numberWithCommas(price * currentVal);
		   if(!isNaN(total_price)){
			   total_price = 0;
		   }
		   $("#total_price").html(total_price+" 원");
   		}
   }

   $("#book_quantity").on("propertychange change keyup paste input", function() {
	    var currentVal = $(this).val();
	    if(currentVal == "") $('#book_quantity').val("1");
	    if(currentVal == oldVal) {
	        return;
	    }
	    oldVal = currentVal;
	    var price = <c:out value="${book_price}"/>;
	    var total_price = numberWithCommas(price * currentVal);
	    $("#total_price").html(total_price+" 원");
	    
	});
   
    function insertBasket (product_no){
    	var isLogin = "${isLogin}" ;
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
    	var isLogin = "${isLogin}" ;
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