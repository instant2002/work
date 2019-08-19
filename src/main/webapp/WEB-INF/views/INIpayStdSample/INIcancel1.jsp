<%@ page language = "java" contentType = "text/html; charset=euc-kr" %>
<html>
<head>
<title>INIpay0 취소</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="css/group.css" type="text/css">
<style>
body, tr, td {font-size:9pt; font-family:굴림,verdana; color:#433F37; line-height:19px;}
table, img {border:none}

/* Padding ******/
.pl_01 {padding:1 10 0 10; line-height:19px;}
.pl_03 {font-size:20pt; font-family:굴림,verdana; color:#FFFFFF; line-height:29px;}

/* Link ******/
.a:link  {font-size:9pt; color:#333333; text-decoration:none}
.a:visited { font-size:9pt; color:#333333; text-decoration:none}
.a:hover  {font-size:9pt; color:#0174CD; text-decoration:underline}

.txt_03a:link  {font-size: 8pt;line-height:18px;color:#333333; text-decoration:none}
.txt_03a:visited {font-size: 8pt;line-height:18px;color:#333333; text-decoration:none}
.txt_03a:hover  {font-size: 8pt;line-height:18px;color:#EC5900; text-decoration:underline}
</style>
</head>
<body bgcolor="#FFFFFF" text="#242424" leftmargin=0 topmargin=15 marginwidth=0 marginheight=0 bottommargin=0 rightmargin=0>
<center>
<form name=ini method=post action=/order/paymentCancel.do>
<table width="632" border="0" cellspacing="0" cellpadding="0">
<tr>
  <td height="83" background="img/cancle_top.gif" style="padding:0 0 0 64">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="3%" valign="top"><img src="img/title_01.gif" width="8" height="27" vspace="5"></td>
      <td width="97%" height="40" class="pl_03"><font color="#FFFFFF"><b>취소요청</b></font></td>
    </tr>
    </table>
  </td>
</tr>
<tr>
  <td align="center" bgcolor="6095BC">
    <table width="620" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td bgcolor="#FFFFFF" style="padding:8 0 0 56">
        <table width="510" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="7"><img src="img/life.gif" width="7" height="30"></td>
          <td background="img/center.gif">
            <img src="img/icon03.gif" width="12" height="10">
            <b>정보를 기입하신 후 확인버튼을 눌러주십시오.</b>
          </td>
          <td width="8"><img src="img/right.gif" width="8" height="30"></td>
        </tr>
        </table>
        <br>
        <table width="510" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="510" colspan="2"  style="padding:0 0 0 23">
            <table width="470" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td height="1" colspan="3" align="center"  background="img/line.gif"></td>
            </tr>
            <tr>
              <td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
              <td width="83" height="25">MID</td>
              <td width="369"> <input type=text name=mid size=12 value="INIpayTest"></td>
            </tr>
            <tr>
              <td height="1" colspan="3" align="center"  background="img/line.gif"></td>
            </tr>
            <tr>
              <td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
              <td width="83" height="25">거래번호</td>
              <td width="369"> <input type=text name=tid size=40 value=""></td>
            </tr>
            <tr>
              <td height="1" colspan="3" align="center"  background="img/line.gif"></td>
            </tr>
            <tr>
              <td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
              <td width="83" height="26">취소사유</td>
              <td width="369"><input type=text name=msg size=40 value=""></td>
            </tr>
            <tr>
              <td height="1" colspan="3" align="center"  background="img/line.gif"></td>
            </tr>
            <tr>
              <td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
              <td width="83" height="26">취 소 코 드</td>
              <td width="369">
                <select name="cancelreason"	>
                <option value="">--선택--</option>
                <option value="1">거래취소</option>
                <option value="2">오류</option>
                <option value="3">기타사항</option>
                </select> (현금영수증)
              </td>
            </tr>
            <tr>
              <td height="1" colspan="3" align="center"  background="img/line.gif"></td>
            </tr>
            <tr valign="bottom">
              <td height="40" colspan="3" align="center"><input type=image src="img/button_04.gif" width="63" height="25"></td>
            </tr>
            </table>
          </td>
        </tr>
        </table>
        <br>
      </td>
    </tr>
    </table>
  </td>
</tr>
<tr>
  <td><img src="img/bottom01.gif" width="632" height="13"></td>
</tr>
</table>
</form>
</body>
</html>
