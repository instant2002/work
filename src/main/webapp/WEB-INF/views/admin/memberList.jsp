<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<div class="col-xs-12">
<div class="col-xs-12 text-center" style="border: 1px solid #ddd; border-width: 2px 0px;">
		<h2><strong>고객 주문 내역</strong></h2>
	</div>
	<table class="table">
		<colgroup>
<!-- 			<col width="10%" />
			<col width="12%" />
			<col width="45%" />
			<col width="15%" />
			<col width="15%" /> -->
 		</colgroup>
		<thead style="font-weight: bold; border: solid #ddd; border-width: 1px 0px; background: #f9f9f9;">
			<tr>
				<td>아이디</td>
				<td>성함</td>
				<td>이메일</td>
				<td>휴대폰</td>
				<td>주소</td>
				<td>가입일</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="member_list" items="${member_list}">
				<tr>
					<td>${member_list.user_id}</td>
					<td>${member_list.user_name}</td>
					<td>${member_list.email}</td>
					<td>${member_list.phonenum1}</td>
					<td>(${member_list.postnum})${member_list.address1} ${member_list.address2}</td>
					<td>${member_list.regdate}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>