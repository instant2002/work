package com.hp.order.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.io.*;
import java.util.Calendar;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hp.customer.service.CustomerService;
import com.hp.order.domain.PaymentCommand;
import com.hp.order.domain.PaymentMobileCommand;
import com.hp.order.service.OrderService;

@Controller
public class OrderMobileNotiController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="orderService")
	private OrderService orderService;
	
	@Resource(name="customerService")
	private CustomerService customerService;
	
	@RequestMapping(value="/payment/mobileNoti.do")
	public String form(@ModelAttribute("paymentComman") PaymentMobileCommand paymentMobileCommand, HttpSession session, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		if(log.isDebugEnabled())log.debug("paymentMobileCommand : " + paymentMobileCommand);
		
		String user_id = (String) session.getAttribute("user_id");
		String order_code = "";
		
		request.setCharacterEncoding("UTF-8");
		
		PrintWriter out = response.getWriter();


/*******************************************************************************
' FILE NAME : mx_rnoti.asp
' FILE DESCRIPTION :
' 이니시스 smart phone 결제 결과 수신 페이지 샘플
' 기술문의 : ts@inicis.com
' HISTORY 
' 2010. 02. 25 최초작성 
' 2010  06. 23 WEB 방식의 가상계좌 사용시 가상계좌 채번 결과 무시 처리 추가(APP 방식은 해당 없음!!)
' WEB 방식일 경우 이미 P_NEXT_URL 에서 채번 결과를 전달 하였으므로, 
' 이니시스에서 전달하는 가상계좌 채번 결과 내용을 무시 하시기 바랍니다.
'*******************************************************************************/
// 이니시스 NOTI 서버에서 받은 Value
//  P_TID	거래번호
//  P_MID	상점아이디
//  P_AUTH_DT	승인일자
//  P_STATUS	거래상태 (00:성공, 01:실패)
//  P_TYPE	지불수단
//  P_OID	상점주문번호
//  P_FN_CD1	금융사코드1
//  P_FN_CD2	금융사코드2
//  P_FN_NM	금융사명 (은행명, 카드사명, 이통사명)
//  P_AMT	거래금액
//  P_UNAME	결제고객성명
//  P_RMESG1	결과코드
//  P_RMESG2	결과메시지
//  P_NOTI	노티메시지(상점에서 올린 메시지)
//  P_AUTH_NO	승인번호

//**********************************************************************************
//이부분에 로그파일 경로를 수정해주세요.	
String file_path = "/D:\\study\\work\\src\\main\\webapp\\mobile_log";  //로그를 기록할 디렉터리
//String file_path = "/unionbooks2019/tomcat/webapps/ROOT/mobile_log";  //로그를 기록할 디렉터리 변경!
//**********************************************************************************
String addr = request.getRemoteAddr().toString();

if("118.129.210.25".equals(addr) || "203.238.37.15".equals(addr) || "183.109.71.153".equals(addr)) //PG에서 보냈는지 IP로 체크 
{
	// 이니시스에서 받은 value
	String P_TID   	= paymentMobileCommand.getP_TID();   
	String P_MID     	= paymentMobileCommand.getP_MID();   
	String P_AUTH_DT   	= paymentMobileCommand.getP_AUTH_DT(); 
	String P_STATUS      	= paymentMobileCommand.getP_STATUS();  
	String P_TYPE       	= paymentMobileCommand.getP_TYPE();    
	String P_OID      	= paymentMobileCommand.getP_OID();     
	String P_FN_CD1    	= paymentMobileCommand.getP_FN_CD1();  
	String P_FN_CD2    	= paymentMobileCommand.getP_FN_CD2();  
	String P_FN_NM     	= paymentMobileCommand.getP_FN_NM();   
	String P_UNAME     	= paymentMobileCommand.getP_UNAME();   
	String P_AMT       	= paymentMobileCommand.getP_AMT();     
	String P_RMESG1      	= paymentMobileCommand.getP_RMESG1();  
	String P_RMESG2    	= paymentMobileCommand.getP_RMESG2();  
	String P_NOTI    	= paymentMobileCommand.getP_NOTI();    
	String P_AUTH_NO      	= paymentMobileCommand.getP_AUTH_NO(); 

	Map<String,String> map = new HashMap<String,String>();
	map.put("P_TID", P_TID);
	map.put("P_MID", P_MID);
	map.put("P_AUTH_DT", P_AUTH_DT);
	map.put("P_STATUS", P_STATUS);
	map.put("P_TYPE", P_TYPE);
	map.put("P_OID", P_OID);
	map.put("P_FN_CD1", P_FN_CD1);
	map.put("P_FN_CD2", P_FN_CD2);
	map.put("P_FN_NM", P_FN_NM);
	map.put("P_AMT", P_AMT);
	map.put("P_UNAME", P_UNAME);
	map.put("P_RMESG1", P_RMESG1);
	map.put("P_RMESG2", P_RMESG2);
	map.put("P_NOTI", P_NOTI);
	map.put("P_AUTH_NO", P_AUTH_NO);
	
	/***********************************************************************************
	 결제처리에 관한 로그 기록
	 위에서 상점 데이터베이스에 등록 성공유무에 따라서 성공시에는 "OK"를 이니시스로 실패시는 "FAIL" 을
	 리턴하셔야합니다. 아래 조건에 데이터베이스 성공시 받는 FLAG 변수를 넣으세요
	 (주의) OK를 리턴하지 않으시면 이니시스 지불 서버는 "OK"를 수신할때까지 계속 재전송을 시도합니다
	 기타 다른 형태의 out.println(response.write)는 하지 않으시기 바랍니다
	***********************************************************************************/
	try{
		writeLog(file_path, paymentMobileCommand);
		  
		if (P_STATUS.equals("00")){
			System.out.println("0101 여기 ok");
			out.print("OK");
	     		return "";

		}else {
			System.out.println("0202 여기 fail");
			out.print("FAIL");
		}
		
	}catch(Exception e){
		System.out.println("0303 여기 error");
		return e.getMessage();
	}
}
System.out.println("0404 여기 fail");
out.print("FAIL");
	return "";
	}
	
	private void writeLog(String file_path, PaymentMobileCommand paymentMobileCommand) throws Exception{
        File file = new File(file_path);
        file.createNewFile();

        FileWriter file2 = new FileWriter(file_path+"/noti_input_"+getDate()+".log", true);
	
	    file2.write("\n************************************************\n");
	    file2.write("PageCall time : " 	+ getTime());
	    file2.write("\n P_TID : " 	+ paymentMobileCommand.getP_TID());
		file2.write("\n P_MID : " 	+ paymentMobileCommand.getP_MID());
		file2.write("\n P_AUTH_DT : " 	+ paymentMobileCommand.getP_AUTH_DT());
		file2.write("\n P_STATUS : " 	+ paymentMobileCommand.getP_STATUS());
		file2.write("\n P_TYPE : " 	+ paymentMobileCommand.getP_TYPE());
		file2.write("\n P_OID : " 	+ paymentMobileCommand.getP_OID());
		file2.write("\n P_FN_CD1 : " 	+ paymentMobileCommand.getP_FN_CD1());
		file2.write("\n P_FN_CD2 : " 	+ paymentMobileCommand.getP_FN_CD2());
		file2.write("\n P_FN_NM : " 	+ paymentMobileCommand.getP_FN_NM());
		file2.write("\n P_AMT : " 	+ paymentMobileCommand.getP_AMT());
		file2.write("\n P_UNAME : " 	+ paymentMobileCommand.getP_UNAME());
		file2.write("\n P_RMESG1 : " 	+ paymentMobileCommand.getP_RMESG1());
		file2.write("\n P_RMESG2 : " 	+ paymentMobileCommand.getP_RMESG2());
		file2.write("\n P_NOTI : " 	+ paymentMobileCommand.getP_NOTI());	
		file2.write("\n P_AUTH_NO : " +	 paymentMobileCommand.getP_AUTH_NO());	        
	    file2.write("\n************************************************\n");
	    file2.close();
    }
	
	 private String getTime()
	    {
	    	Calendar calendar = Calendar.getInstance();
	    	
	    	StringBuffer times = new StringBuffer();

	    	times.append("[");
	    	if((calendar.get(Calendar.HOUR_OF_DAY))<10) 
	        { 
	            times.append("0"); 
	        } 
	 		times.append(Integer.toString(calendar.get(Calendar.HOUR_OF_DAY)));
	 		times.append(":");
	 		if((calendar.get(Calendar.MINUTE))<10) 
	        { 
	            times.append("0"); 
	        }
	 		times.append(Integer.toString(calendar.get(Calendar.MINUTE)));
	 		times.append(":");
	 		if((calendar.get(Calendar.SECOND))<10) 
	        { 
	            times.append("0"); 
	        }
	 		times.append(Integer.toString(calendar.get(Calendar.SECOND)));
	 		times.append("]");
	 		
	 		return times.toString();
	    }
	 
	 private String getDate()
	    {
	    	Calendar calendar = Calendar.getInstance();
	    	
	    	StringBuffer times = new StringBuffer();
	        times.append(Integer.toString(calendar.get(Calendar.YEAR)));
			if((calendar.get(Calendar.MONTH)+1)<10)
	        { 
	            times.append("0"); 
	        }
			times.append(Integer.toString(calendar.get(Calendar.MONTH)+1));
			if((calendar.get(Calendar.DATE))<10) 
	        {
	            times.append("0");	
	        } 
			times.append(Integer.toString(calendar.get(Calendar.DATE)));
	    	
	    	return times.toString();
	    }
	
}
