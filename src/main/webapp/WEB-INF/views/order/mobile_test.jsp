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
	///// 1. ���� �ʱ�ȭ �� POST ������ ����                                 ////
	/////////////////////////////////////////////////////////////////////////////
	request.setCharacterEncoding("euc-kr");

	String P_STATUS = request.getParameter("P_STATUS");			// ���� ����
	String P_RMESG1 = request.getParameter("P_RMESG1");			// ���� ��� �޽���
	String P_TID = request.getParameter("P_TID");				// ���� �ŷ���ȣ
	String P_REQ_URL = request.getParameter("P_REQ_URL");		// ������û URL
	String P_NOTI = request.getParameter("P_NOTI");				// ��Ÿ�ֹ�����
	



	/////////////////////////////////////////////////////////////////////////////
	///// 2. ���� ���̵� ���� :                                              ////
	/////    ������û ���������� ����� MID���� �����ϰ� �����ؾ� ��...      ////
	/////////////////////////////////////////////////////////////////////////////
	String P_MID = "INIpayTest";  



if(P_STATUS.equals("01")) { // ��������� ������ ���
	out.print("Auth Fail");
	out.print("<br>");	
	out.print(P_RMESG1);
}
else { // ��������� ������ ���


	/////////////////////////////////////////////////////////////////////////////
	///// 3. ���ο�û :                                                      ////
	/////    �������� ������ P_REQ_URL�� ���ο�û�� ��...                    ////
	///// 
	/////////////////////////////////////////////////////////////////////////////


	// ���ο�û�� ������
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
      byte[] responseBody = method.getResponseBody();   //  ���ΰ�� �Ľ�
	  String[] values = new String(responseBody).split("&"); 
      
      	
	  
		for( int x = 0; x < values.length; x++ ) 
		  {
			
			out.print(values[x]);  // ���ΰ���� ���
			out.print("<br>");
			
			
			// ���ΰ���� �Ľ̰� �߶� hashmap�� ����
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
    
    //out.print("<br>���ΰ�� ���� �� ���---------------------------------------------------------------------------<br>");

	      //out.print("<br>���뺯��---------------------------------------------------------------------------<br>");
	      //out.print("P_TID : "+map.get("P_TID")+"<br>");  // �ŷ���ȣ                           
				//out.print("P_STATUS : "+map.get("P_STATUS")+"<br>");                           // �ŷ����� - ���Ұ�� ����:00, ����:00 �̿� ����
				//out.print("P_RMESG1 : "+map.get("P_RMESG1")+"<br>");                              // ���� ��� �޽���
				//out.print("P_TYPE : "+map.get("P_TYPE")+"<br>");                                 // ���Ҽ��� 				
				//out.print("P_MID : "+map.get("P_MID")+"<br>");                                       // �������̵�
				//out.print("P_OID : "+map.get("P_OID")+"<br>");                             // �����ֹ���ȣ
				//out.print("P_AMT : "+map.get("P_AMT")+"<br>");                          // �ŷ��ݾ�
				//out.print("P_UNAME : "+map.get("P_UNAME")+"<br>");                 // �����ڸ�
				//out.print("P_NEXT_URL : "+map.get("P_NEXT_URL")+"<br>");  	// ������ ���� P_NEXT_URL 
				//out.print("P_NOTEURL : "+map.get("P_NOTEURL")+"<br>");				// ������ ���� NOTE_URL                    
				//out.print("P_AUTH_DT : "+map.get("P_AUTH_DT")+"<br>");        // ��������(YYYYmmddHHmmss)          	
				//out.print("P_MNAME : "+map.get("P_MNAME")+"<br>");			// �������� -->> ��û���� �ʵ峻 ��� �ȵ�
				//out.print("P_NOTI : "+map.get("P_NOTI")+"<br>");		 // ��Ÿ�ֹ�����
				
				

}



%>


