<%@ page language = "java" contentType = "text/html; charset=euc-kr" %>

<html>
<head>
<title>INIpay50 취소 결과</title>
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
<table width="632" border="0" cellspacing="0" cellpadding="0">
<tr>
  <td height="83" background="img/cancle_top.gif"style="padding:0 0 0 64">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="3%" valign="top"><img src="img/title_01.gif" width="8" height="27" vspace="5"></td>
      <td width="97%" height="40" class="pl_03"><font color="#FFFFFF"><b>취소결과</b></font></td>
    </tr>
    </table>
  </td>
</tr>
<tr>
  <td align="center" bgcolor="6095BC">
    <table width="620" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td bgcolor="#FFFFFF" style="padding:0 0 0 56">
        <table width="510" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td colspan="2"  style="padding:0 0 0 23">
            <table width="470" border="0" cellspacing="0" cellpadding="0">

            <tr>
              <td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
              <td width="109" height="26">결 과 코 드</td>
              <td width="343">${cancel.ResultCode}</td>
            </tr>
            <tr>
              <td height="1" colspan="3" align="center"  background="img/line.gif"></td>
            </tr>
            <tr>
              <td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
              <td width="109" height="25">결 과 내 용</td>
              <td width="343">${cancel.ResultMsg}</td>
            </tr>
            <tr>
              <td height="1" colspan="3" align="center"  background="img/line.gif"></td>
            </tr>
            <tr>
              <td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
              <td width="109" height="25">거 래 번 호</td>
              <td width="343">${cancel.tid}</td>
            </tr>
            <tr>
              <td height="1" colspan="3" align="center"  background="img/line.gif"></td>
            </tr>
            <tr>
              <td width='18' align='center'><img src='img/icon02.gif' width='7' height='7'></td>
              <td width='109' height='25'>취 소 날 짜</td>
              <td width='343'>${cancel.CancelDate}</td>
            </tr>
            <tr>
              <td height='1' colspan='3' align='center'  background='img/line.gif'></td>
            </tr>
            <tr>
              <td width='18' align='center'><img src='img/icon02.gif' width='7' height='7'></td>
              <td width='109' height='25'>취 소 시 각</td>
              <td width='343'>${cancel.CancelTime}</td>
            </tr>
            <tr>
              <td height='1' colspan='3' align='center'  background='img/line.gif'></td>
            </tr>
            <tr>
              <td width='18' align='center'><img src='img/icon02.gif' width='7' height='7'></td>
              <td width='109' height='25'>현금영수증<br>취소승인번호</td>
              <td width='343'>${cancel.CSHR_CancelNum}</td>
            </tr>
            <tr>
              <td height='1' colspan='3' align='center'  background='img/line.gif'></td>
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
</center>
</body>
</html>
