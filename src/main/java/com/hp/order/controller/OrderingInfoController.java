package com.hp.order.controller;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.*;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hp.customer.service.CustomerService;
import com.hp.member.domain.MemberCommand;
import com.hp.order.domain.OrderCommand;
import com.hp.order.service.OrderService;
import com.inicis.std.util.SignatureUtil;

@Controller
public class OrderingInfoController {
	private Logger log = Logger.getLogger(this.getClass());

	@Resource(name="orderService")
	private OrderService orderService;
	
	@Resource(name="customerService")
	private CustomerService customerService;
	
	@RequestMapping(value="/order/orderingInfo.do")
	public String form(@ModelAttribute("orderCommand") OrderCommand orderCommand, HttpServletRequest request, HttpServletResponse response, 
			HttpSession session, Model model, @RequestParam(value="total_price",required=false) String total_price) throws Exception {
		if(log.isDebugEnabled())log.debug("OrderCommand : " + orderCommand);
		if(log.isDebugEnabled())log.debug("total_price : " + total_price);
		
		String user_id = (String) session.getAttribute("user_id");
		
		//주문번호 생성
		Random rand = new Random();
        String order_code = ""; //난수가 저장될 변수
        int len = 10;
        for(int i=0;i<len;i++) {
            //0~9 까지 난수 생성
            String ran = Integer.toString(rand.nextInt(10));
            order_code += ran;
        }
		
		/*상품번호 배열로 받아오기*/
		List<String> product_no_list = new ArrayList<String>();
		List<String> quantity_list = new ArrayList<String>();

		if(orderCommand.getOrder_list() != null) {
			Iterator<OrderCommand> it = orderCommand.getOrder_list().iterator();
			while(it.hasNext()) {
				OrderCommand str = it.next();
				product_no_list.add(str.getProduct_no());
				quantity_list.add(str.getQuantity());
			}
		}
		//List의 null값 제거
		product_no_list.removeAll(Collections.singleton(null));
		quantity_list.removeAll(Collections.singleton(null));
		
		if(log.isDebugEnabled())log.debug("product_no_list : " + product_no_list);
		if(log.isDebugEnabled())log.debug("quantity_list : " + quantity_list);
		
		List<OrderCommand> orderList = orderService.getOrderBook(product_no_list);
		MemberCommand memberCommand = customerService.getUserInfo(user_id);
		
		//이니페이 키 생성 시작
		String mid					= "unionbooks";		// 가맹점 ID(가맹점 수정후 고정)					
//		String signKey			    = "SU5JTElURV9UUklQTEVERVNfS0VZU1RS";	// 가맹점에 제공된 웹 표준 사인키(가맹점 수정후 고정)
		String signKey			    = "MXNSWkF6a1gvcEZlVUF5N1NUN1lvdz09";	// 가맹점에 제공된 웹 표준 사인키(가맹점 수정후 고정)
		String timestamp			= SignatureUtil.getTimestamp();			// util에 의해서 자동생성
//		String oid					= mid+"_"+SignatureUtil.getTimestamp();	// 가맹점 주문번호(가맹점에서 직접 설정)
		String oid = order_code;
		
		Map<String, String> signParam = new HashMap<String, String>();
		signParam.put("oid", oid); 					// 필수
		signParam.put("price", total_price);		// 필수
		signParam.put("timestamp", timestamp);		// 필수

		String signature = SignatureUtil.makeSignature(signParam); //signature 데이터 생성 (모듈에서 자동으로 signParam을 알파벳 순으로 정렬후 NVP 방식으로 나열해 hash)
		String mKey = SignatureUtil.hash(signKey, "SHA-256");

		Map<String, String> inipay = new HashMap<String, String>();
		inipay.put("mid", mid);
		inipay.put("signKey", signKey);
		inipay.put("timestamp", timestamp);
		inipay.put("price", total_price);
		inipay.put("oid", oid);
		inipay.put("signature", signature);
		inipay.put("mKey", mKey);
		//이니페이 키 생성 끝
		
		System.out.println("product_no_list"+product_no_list);
		System.out.println("quantity_list"+quantity_list);
		System.out.println("oid"+oid);
		System.out.println("signature"+signature);
		System.out.println("mKey"+mKey);
		
		model.addAttribute("order", orderList);
		model.addAttribute("quantity", quantity_list);
		model.addAttribute("user", memberCommand);
		model.addAttribute("inipay", inipay);
		model.addAttribute("order_code", order_code);
		
		return "orderInfoForm";
	}
	
	@RequestMapping(value="/order/close.do")
	public String close() {
		return "inipay_close";
	}
	@RequestMapping(value="/order/popup.do")
	public String popup() {
		return "inipay_popup";
	}
}
