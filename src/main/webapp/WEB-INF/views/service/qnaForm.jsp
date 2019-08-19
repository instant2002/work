<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="${pageContext.request.contextPath}/js/datepicker-ko.js"></script>

<form class="form-horizontal" id="qnaSub" action="/service/qnaSub.do" method="post">
<fieldset>
<div><h2><b>1:1 문의하기(Q&A)</b></h2></div>
<table class="table qna_table">
	<colgroup>
		<col style="width: 15%">
		<col style="width: 85%">
	</colgroup>
	<tbody style="border-bottom: 1px solid #ddd;">
			<tr>
				<th class="text-center"><b>작성자</b></th>
				<td><div class="col-md-6">${member.user_name }</div><input type="hidden" name="user_name" value="${member.user_name }"></td>
			</tr>
			<tr> 
				<th class="text-center"><b>휴대폰</b></th>
				<td><div class="col-md-3"><input id="phone" name="phone" type="text" class="form-control" value="${member.phonenum1}"></div></td>
			</tr>
			<tr> 
				<th class="text-center"><b>이메일</b></th>
				<td><div class="col-md-5"><input id="email" name="email" type="text" class="form-control" value="${member.email}"></div></td>
			</tr>
			<tr> 
				<th class="text-center"><b>제목</b></th>
				<td><div class="col-md-6"><input id="title" name="title" type="text" class="form-control"></div></td>
			</tr>
			<tr> 
				<th class="text-center"><b>내용</b></th>
				<td><div class="col-md-6"><textarea class="form-control" id="contents" name="contents" rows="10"></textarea></div></td>
			</tr>
		</tbody>
</table>
</fieldset>

<div class="control-group" style="margin-top: 20px;">
      <div class="controls">
        <button type="button" class="btn btn-success center-block" onclick="qnaSubFunc(); return false;">등록하기</button>
      </div>
</div>
</form>

<script src="${pageContext.request.contextPath}/js/qnaSub.js"></script>

<script type="text/javascript">
//휴대폰 번호 자동 하이픈
var cellPhone = document.getElementById('phone');
cellPhone.onkeyup = function(event) {
event = event || window.event;
var _val = this.value.trim();
this.value = autoHypenPhone(_val);
};

function autoHypenPhone(str) {
	str = str.replace(/[^0-9]/g, '');
	var tmp = '';
	if (str.length < 4) {
		return str;
	} else if (str.length < 7) {
		tmp += str.substr(0, 3);
		tmp += '-';
		tmp += str.substr(3);
		return tmp;
	} else if (str.length < 11) {
		tmp += str.substr(0, 3);
		tmp += '-';
		tmp += str.substr(3, 3);
		tmp += '-';
		tmp += str.substr(6);
		return tmp;
	} else {
		tmp += str.substr(0, 3);
		tmp += '-';
		tmp += str.substr(3, 4);
		tmp += '-';
		tmp += str.substr(7);
		return tmp;
	}
	return str;
}
</script>
