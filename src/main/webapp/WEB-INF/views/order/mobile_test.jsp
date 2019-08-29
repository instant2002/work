<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="java.io.*" %>
<%@page import="java.util.HashMap"%>
<%@page import="org.apache.commons.httpclient.*" %>
<%@page import="org.apache.commons.httpclient.methods.*" %>
<%@page import="org.apache.commons.httpclient.methods.GetMethod" %> 
<%@page import="org.apache.commons.httpclient.params.HttpMethodParams" %>



<%



	/////////////////////////////////////////////////////////////////////////////
	///// 1. 변수 초기화 및 POST 인증값 받음                                 ////
	/////////////////////////////////////////////////////////////////////////////
	request.setCharacterEncoding("euc-kr");

	String P_STATUS = request.getParameter("P_STATUS");			// 인증 상태
	String P_RMESG1 = request.getParameter("P_RMESG1");			// 인증 결과 메시지
	String P_TID = request.getParameter("P_TID");				// 인증 거래번호
	String P_REQ_URL = request.getParameter("P_REQ_URL");		// 결제요청 URL
	String P_NOTI = request.getParameter("P_NOTI");				// 기타주문정보
	



	/////////////////////////////////////////////////////////////////////////////
	///// 2. 상점 아이디 설정 :                                              ////
	/////    결제요청 페이지에서 사용한 MID값과 동일하게 세팅해야 함...      ////
	/////////////////////////////////////////////////////////////////////////////
	String P_MID = "INIpayTest";  



if(P_STATUS.equals("01")) { // 인증결과가 실패일 경우
	out.print("Auth Fail");
	out.print("<br>");	
	out.print(P_RMESG1);
}
else { // 인증결과가 성공일 경우


	/////////////////////////////////////////////////////////////////////////////
	///// 3. 승인요청 :                                                      ////
	/////    인증값을 가지고 P_REQ_URL로 승인요청을 함...                    ////
	///// 
	/////////////////////////////////////////////////////////////////////////////


	// 승인요청할 데이터
	P_REQ_URL = P_REQ_URL + "?P_TID=" + P_TID + "&P_MID=" + P_MID;

    // Create an instance of HttpClient.
    HttpClient client = new HttpClient();

    // Create a method instance.
    GetMethod method = new GetMethod(P_REQ_URL);
    
    // Provide custom retry handler is necessary
    method.getParams().setParameter(HttpMethodParams.RETRY_HANDLER, 
    		new DefaultHttpMethodRetryHandler(3, false));
    
    HashMap<String, String> map = new HashMap<String, String>();
    
    try {
      // Execute the method.
      int statusCode = client.executeMethod(method);

      if (statusCode != HttpStatus.SC_OK) {
        //System.err.println("Method failed: " + method.getStatusLine());
		    out.print("Method failed: " + method.getStatusLine());
      }

      // Read the response body.
      byte[] responseBody = method.getResponseBody();   //  승인결과 파싱
	  String[] values = new String(responseBody).split("&"); 
      
      	
	  
		for( int x = 0; x < values.length; x++ ) 
		  {
			
			out.print(values[x]);  // 승인결과를 출력
			out.print("<br>");
			
			
			// 승인결과를 파싱값 잘라 hashmap에 저장
			//int i = values[x].indexOf("=");			
			//String key1 = values[x].substring(0, i);
			//String value1 = values[x].substring(i+1);
			//String key1 = arr1[0].trim();
			//String value1 = arr1[1].trim();
			//map.put(key1, value1);			  
		  }

    } catch (HttpException e) {
      ////System.err.println("Fatal protocol violation: " + e.getMessage());
	    out.print("Fatal protocol violation: " + e.getMessage());
      e.printStackTrace();
    } catch (IOException e) {
      ////System.err.println("Fatal transport error: " + e.getMessage());
	    out.print("Fatal transport error: " + e.getMessage());
      e.printStackTrace();
    } finally {
      // Release the connection.
      method.releaseConnection();
    }  
    
    //out.print("<br>승인결과 저장 및 출력---------------------------------------------------------------------------<br>");

	      //out.print("<br>공통변수---------------------------------------------------------------------------<br>");
	      //out.print("P_TID : "+map.get("P_TID")+"<br>");  // 거래번호                           
				//out.print("P_STATUS : "+map.get("P_STATUS")+"<br>");                           // 거래상태 - 지불결과 성공:00, 실패:00 이외 실패
				//out.print("P_RMESG1 : "+map.get("P_RMESG1")+"<br>");                              // 지불 결과 메시지
				//out.print("P_TYPE : "+map.get("P_TYPE")+"<br>");                                 // 지불수단 				
				//out.print("P_MID : "+map.get("P_MID")+"<br>");                                       // 상점아이디
				//out.print("P_OID : "+map.get("P_OID")+"<br>");                             // 상점주문번호
				//out.print("P_AMT : "+map.get("P_AMT")+"<br>");                          // 거래금액
				//out.print("P_UNAME : "+map.get("P_UNAME")+"<br>");                 // 구매자명
				//out.print("P_NEXT_URL : "+map.get("P_NEXT_URL")+"<br>");  	// 가맹점 전달 P_NEXT_URL 
				//out.print("P_NOTEURL : "+map.get("P_NOTEURL")+"<br>");				// 가맹점 전달 NOTE_URL                    
				//out.print("P_AUTH_DT : "+map.get("P_AUTH_DT")+"<br>");        // 승인일자(YYYYmmddHHmmss)          	
				//out.print("P_MNAME : "+map.get("P_MNAME")+"<br>");			// 가맹점명 -->> 요청정보 필드내 명시 안됨
				//out.print("P_NOTI : "+map.get("P_NOTI")+"<br>");		 // 기타주문정보
				
				

}



%>


