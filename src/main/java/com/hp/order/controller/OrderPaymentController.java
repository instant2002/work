package com.hp.order.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.inicis.std.util.ParseUtil;
import com.inicis.std.util.SignatureUtil;
import com.inicis.std.util.HttpUtil;


import com.hp.customer.service.CustomerService;
import com.hp.order.domain.PaymentCommand;
import com.hp.order.service.OrderService;

@Controller
public class OrderPaymentController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="orderService")
	private OrderService orderService;
	
	@Resource(name="customerService")
	private CustomerService customerService;
	
	@RequestMapping(value="/order/paymentResult.do")
	public String form(@ModelAttribute("paymentComman") PaymentCommand paymentCommand, HttpSession session, HttpServletRequest request, Model model) throws Exception {
		
		String user_id = (String) session.getAttribute("user_id");
		String order_code = "";
		
		request.setCharacterEncoding("UTF-8");

//		이니페이 로직 시작
		Map<String,String> paramMap = new Hashtable<String,String>();
		Enumeration elems = request.getParameterNames();
		String temp = "";
		while(elems.hasMoreElements()){
			temp = (String) elems.nextElement();
			paramMap.put(temp, request.getParameter(temp));
		}
		
		if("0000".equals(paramMap.get("resultCode"))){ //인증 성공인 경우
		
		String mid 		= paramMap.get("mid");						// 가맹점 ID 수신 받은 데이터로 설정
		String timestamp= SignatureUtil.getTimestamp();				// util에 의해서 자동생성
		String charset 	= "UTF-8";								    // 리턴형식[UTF-8,EUC-KR](가맹점 수정후 고정)
		String format 	= "JSON";								    // 리턴형식[XML,JSON,NVP](가맹점 수정후 고정)
		String authToken= paramMap.get("authToken");			    // 취소 요청 tid에 따라서 유동적(가맹점 수정후 고정)
		String authUrl	= paramMap.get("authUrl");				    // 승인요청 API url(수신 받은 값으로 설정, 임의 세팅 금지)
		
		Map<String, String> signParam = new HashMap<String, String>();
		signParam.put("authToken",	authToken);		// 필수
		signParam.put("timestamp",	timestamp);		// 필수
		
		String signature = SignatureUtil.makeSignature(signParam);
		
		Map<String, String> authMap = new Hashtable<String, String>();
		authMap.put("mid"			    ,mid);			  // 필수
		authMap.put("authToken"		,authToken);	// 필수
		authMap.put("signature"		,signature);	// 필수
		authMap.put("timestamp"		,timestamp);	// 필수
		authMap.put("charset"		  ,charset);		// default=UTF-8
		authMap.put("format"		  ,format);		  // default=XML
  		//authMap.put("price" 		,price);		    // 가격위변조체크기능 (선택사용)
		
		HttpUtil httpUtil = new HttpUtil();
		String authResultString = httpUtil.processHTTP(authMap, authUrl);
		String test = authResultString.replace(",", "&").replace(":", "=").replace("\"", "").replace(" ","").replace("\n", "").replace("}", "").replace("{", "");
		
		Map<String, String> resultMap = new HashMap<String, String>();
		resultMap = ParseUtil.parseStringToMap(test); //문자열을 MAP형식으로 파싱
		
		Map<String , String> secureMap = new HashMap<String, String>();
		secureMap.put("mid"			, mid);								//mid
		secureMap.put("tstamp"		, timestamp);						//timestemp
		secureMap.put("MOID"		, resultMap.get("MOID"));			//MOID
		secureMap.put("TotPrice"	, resultMap.get("TotPrice"));		//TotPrice
		
		String secureSignature = SignatureUtil.makeSignatureAuth(secureMap);
		
		if("0000".equals(resultMap.get("resultCode")) && secureSignature.equals(resultMap.get("authSignature")) ){//결제 보안
			System.out.println("성공인데...");
			String[] merchatData = paymentCommand.getMerchantData().split("&");
					for(String data : merchatData) {
						if(data.indexOf("order_code=") == 0) {
							order_code = data.substring(data.lastIndexOf("=")+1);
						}
						System.out.println(data);
					}
			try{
				/*String u = "http://unionbooks.kr/payment/complete.do?"+paymentCommand.getMerchantData()+"&user_id="+user_id+"&payMethod="+resultMap.get("payMethod")+"&cardNum="+resultMap.get("CARD_Num")+"&cardQuota="+resultMap.get("CARD_Quota")+"&tid="+resultMap.get("tid"); //변경!
*/				String u = "http://localhost:8080/payment/complete.do?"+paymentCommand.getMerchantData()+"&user_id="+user_id+"&payMethod="+resultMap.get("payMethod")+"&cardNum="+resultMap.get("CARD_Num")+"&cardQuota="+resultMap.get("CARD_Quota")+"&tid="+resultMap.get("tid");
				System.out.println(u);
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
				
				BufferedReader in = new BufferedReader(
					new InputStreamReader(hurlc.getInputStream()));
				in.close();
			}catch(Exception e){
				System.out.println("error : "+e);
			}
			
			List<PaymentCommand> paymentList = orderService.getPaymentList(order_code);
			
			if(log.isDebugEnabled())log.debug("***************결제 성공***************");
			model.addAttribute("isResult", true);
			model.addAttribute("resultMap", resultMap);
			model.addAttribute("paymentList", paymentList);
			
			}else {
				if(log.isDebugEnabled())log.debug("***************결제 실패***************");
				model.addAttribute("isResult", false);
			}
		}else {
			model.addAttribute("isResult", false);
		}
		return "orderPaymentResult";
	}
	
	@ResponseBody
	@RequestMapping(value="/payment/complete.do", method=RequestMethod.POST)
	public boolean test(@ModelAttribute("paymentComman") PaymentCommand paymentCommand) throws UnsupportedEncodingException {
		if(log.isDebugEnabled())log.debug("PaymentCommand : " + paymentCommand);
		
		/*상품번호 배열로 받아오기*/
		List<String> product_no_list = new ArrayList<String>();
		List<String> quantity_list = new ArrayList<String>();
		List<Integer> origin_price_list = new ArrayList<Integer>();
		List<Integer> dc_price_list = new ArrayList<Integer>();

		if(paymentCommand.getPayment_list() != null) {
			Iterator<PaymentCommand> it = paymentCommand.getPayment_list().iterator();
			while(it.hasNext()) {
				PaymentCommand str = it.next();
				
				paymentCommand.setProduct_no(str.getProduct_no());
				paymentCommand.setQuantity(str.getQuantity());
				paymentCommand.setOrigin_price(str.getOrigin_price());
				paymentCommand.setDc_price(str.getDc_price());
				
				orderService.orderComplete(paymentCommand);
				if(log.isDebugEnabled())log.debug("comeOn!! PaymentCommand : " + paymentCommand);
				
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
			hm.put("user_id", paymentCommand.getUser_id());
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
