package com.hp.order.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.httpclient.DefaultHttpMethodRetryHandler;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
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
public class OrderMobilePaymentController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="orderService")
	private OrderService orderService;
	
	@Resource(name="customerService")
	private CustomerService customerService;
	
	@RequestMapping(value="/order/paymentMobileResult.do")
	public String form(@ModelAttribute("paymentMobileCommand") PaymentMobileCommand paymentMobileCommand, HttpSession session, HttpServletRequest request, HttpServletResponse response, Model model) throws IOException{
		if(log.isDebugEnabled())log.debug("paymentMobileCommand : " + paymentMobileCommand);
		
		String user_id = (String) session.getAttribute("user_id");
		
		String P_STATUS = paymentMobileCommand.getP_STATUS();
		String P_RMESG1 = paymentMobileCommand.getP_RMESG1();
		String P_TID = paymentMobileCommand.getP_TID();
		String P_REQ_URL = paymentMobileCommand.getP_REQ_URL();
		String P_MID = "unionbooks"; //변경!
		String param = "?P_MID="+P_MID+"&P_TID="+P_TID;
		P_REQ_URL = P_REQ_URL + param;
		

    	if(P_STATUS.equals("01")) { // 인증결과가 실패일 경우
			model.addAttribute("isResult", false);
			if(log.isDebugEnabled())log.debug("***************결제 실패***************");
    	}else {
    		System.out.println("P_REQ_URL : " + P_REQ_URL);
    		HttpClient client = new HttpClient();
    		GetMethod method = new GetMethod(P_REQ_URL);
    		method.getParams().setParameter(HttpMethodParams.RETRY_HANDLER, 
    	    		new DefaultHttpMethodRetryHandler(3, false));
    		
    		HashMap<String, String> map = new HashMap<String, String>();
        		
        	try {
        		int statusCode = client.executeMethod(method);
        		if (statusCode != HttpStatus.SC_OK) {
        			System.out.println("Method failed: " + method.getStatusLine());
        	      }
        		
        		byte[] responseBody = method.getResponseBody();   //  승인결과 파싱
        		  String[] values = new String(responseBody).split("&"); 

        		  for( int x = 0; x < values.length; x++ ) {
        			int i = values[x].indexOf("=");
        			String key1 = values[x].substring(0, i);
        			String value1 = values[x].substring(i+1);
        			if(key1.indexOf("P_NOTI") == -1) {
        				value1 = URLEncoder.encode(values[x].substring(i+1), "UTF-8");
        			}
        			map.put(key1, value1);  
        		  }
        		  System.out.println("map 1 : " + map);
        		  
			}catch (HttpException e) {
				System.out.println("Fatal protocol violation: " + e.getMessage());
		      e.printStackTrace();
		    } catch (IOException e) {
		    	System.out.println("Fatal transport error: " + e.getMessage());
		      e.printStackTrace();
		    } finally {
		      // Release the connection.
		      method.releaseConnection();
		    }
        	String[] noti_arr = map.get("P_NOTI").split("#!");
        	for( int x = 0; x < noti_arr.length; x++ ) {
        		int z = noti_arr[x].indexOf("=");
        		String key2 = noti_arr[x].substring(0, z);
        		String value2 = noti_arr[x].substring(z+1);
        		map.put(key2, value2);
        	}
        	
        	if(log.isDebugEnabled())log.debug("map : " + map);
        	map.remove("P_NOTI"); //필요없으니 삭제
        	
        	String paraVal="";
        	for( String key : map.keySet() ){
        		paraVal = paraVal+key+"="+map.get(key)+"&";
        	}
        	try{
//        	String u = "http://"+request.getServerName()+"/payment/complete_m.do?"+paraVal+"&user_id="+user_id; //변경!
        	String u = "http://"+request.getServerName()+":8080/payment/complete_m.do?"+paraVal+"&user_id="+user_id;
        	
			System.out.println("URL : " + u);
			URL url =new URL(u);
			URLConnection connection = url.openConnection();
			HttpURLConnection hurlc = (HttpURLConnection)connection;
			hurlc.setRequestMethod("POST");
			hurlc.setDoOutput(true);
			hurlc.setDoInput(true);
			hurlc.setUseCaches(false);
			hurlc.setDefaultUseCaches(false);
			
			PrintWriter out = new PrintWriter(hurlc.getOutputStream());
			out.close();
			
			BufferedReader in = new BufferedReader(new InputStreamReader(hurlc.getInputStream()));
			in.close();
        	}catch (Exception e) {
        		System.out.println("error : "+e);
			}
        	String order_code = map.get("order_code");
        	List<PaymentMobileCommand> paymentList = orderService.getMobilePaymentList(order_code);
        	
        	Map<String, String> resultMap = new HashMap<String, String>();
        	resultMap.put("payMethod", map.get("P_TYPE"));
        	resultMap.put("CARD_Num", map.get("P_CARD_NUM"));
        	resultMap.put("CARD_Quota", map.get("P_QUOTABASE"));
        	resultMap.put("applDate", map.get("P_AUTH_DT"));
        	
        	if(log.isDebugEnabled())log.debug("***************결제 성공***************");
			model.addAttribute("isResult", true);
			model.addAttribute("resultMap", resultMap);
			model.addAttribute("paymentList", paymentList);
    	}
		
		return "orderPaymentResult";
	}
	
	@ResponseBody
	@RequestMapping(value="/payment/complete_m.do", method=RequestMethod.POST)
	public boolean test(@ModelAttribute("paymentMobileCommand") PaymentMobileCommand paymentMobileCommand) throws UnsupportedEncodingException {
		if(log.isDebugEnabled())log.debug("paymentMobileCommand : " + paymentMobileCommand);
		
		paymentMobileCommand.setTid(paymentMobileCommand.getP_TID());
		paymentMobileCommand.setCardNum(paymentMobileCommand.getP_CARD_NUM());
		paymentMobileCommand.setPayMethod(paymentMobileCommand.getP_TYPE());
		paymentMobileCommand.setCardQuota(paymentMobileCommand.getP_QUOTABASE());
		
		/*상품번호 배열로 받아오기*/
		List<String> product_no_list = new ArrayList<String>();
		List<String> quantity_list = new ArrayList<String>();
		List<Integer> origin_price_list = new ArrayList<Integer>();
		List<Integer> dc_price_list = new ArrayList<Integer>();

		if(paymentMobileCommand.getPayment_list() != null) {
			Iterator<PaymentMobileCommand> it = paymentMobileCommand.getPayment_list().iterator();
			while(it.hasNext()) {
				PaymentMobileCommand str = it.next();
				
				paymentMobileCommand.setProduct_no(str.getProduct_no());
				paymentMobileCommand.setQuantity(str.getQuantity());
				paymentMobileCommand.setOrigin_price(str.getOrigin_price());
				paymentMobileCommand.setDc_price(str.getDc_price());
				
				orderService.orderComplete_m(paymentMobileCommand);
				if(log.isDebugEnabled())log.debug("comeOn!! paymentMobileCommand : " + paymentMobileCommand);
				
				product_no_list.add(str.getProduct_no());
				quantity_list.add(str.getQuantity());
				origin_price_list.add(str.getOrigin_price());
				dc_price_list.add(str.getDc_price());
			}
			
			//List의 null값 제거
			product_no_list.removeAll(Collections.singleton(null));
			quantity_list.removeAll(Collections.singleton(null));
			origin_price_list.removeAll(Collections.singleton(null));
			dc_price_list.removeAll(Collections.singleton(null));
			
			HashMap<String, Object> hm = new HashMap<String, Object>();
			hm.put("user_id", paymentMobileCommand.getUser_id());
			hm.put("product_arr", product_no_list);
			customerService.basketDelete(hm);
		}
		if(log.isDebugEnabled())log.debug("complete product_no_list : " + product_no_list);
		if(log.isDebugEnabled())log.debug("complete quantity_list : " + quantity_list);
		if(log.isDebugEnabled())log.debug("complete origin_price_list : " + origin_price_list);
		if(log.isDebugEnabled())log.debug("complete dc_price_list : " + dc_price_list);
		
		return true;
		
	}
}
