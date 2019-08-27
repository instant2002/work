package com.hp.customer.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hp.common.domain.Criteria;
import com.hp.common.util.PageMaker;
import com.hp.customer.domain.CancelCommand;
import com.hp.customer.service.CustomerService;
import com.hp.order.domain.PaymentCommand;
import com.inicis.inipay.INIpay50;

@Controller
public class OrderCancelController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="customerService")
	private CustomerService customerService;
	
	@ResponseBody
	@RequestMapping(value="/customer/orderCancelReqSub.do", method=RequestMethod.POST)
	public Map<Object, Object> orderCancelReqSub(@ModelAttribute("cancelCommand") CancelCommand cancelCommand, HttpSession session) {
		String user_id = (String) session.getAttribute("user_id");
		cancelCommand.setUser_id(user_id);
		
		if(log.isDebugEnabled()) log.debug("CancelCommand : " + cancelCommand);
		
		Map<Object,Object> map = new HashMap<Object,Object>();
		
		try {
			boolean able = false;
			String msg = "";
			CancelCommand cancelData = customerService.cancelData(cancelCommand);
			if(cancelData != null){
				if(!cancelData.getDelivery_status().equals("W")) {
					msg = "배송중이거나, 배송이 완료된 상품입니다.\n환불을 원하신다면 고객센터에 문의해주시기 바랍니다.";
				}else if(!cancelData.getPayment_status().equals("P")){
					msg = "결제된 상품이 아닙니다.\n결제된 상품만 이용이 가능한 서비스입니다.";
				}else if(!cancelData.getRefund_status().equals("N")){
				msg = "이미 환불 신청이 진행중이거나, 환불이 완료된 주문입니다.";
				}else {
					cancelData.setCanceler_tel(cancelCommand.getCanceler_tel());
					cancelData.setCanceler_email(cancelCommand.getCanceler_email());
					cancelData.setCancel_msg(cancelCommand.getCancel_msg());
					
					INIpay50 inipay = new INIpay50();
					String mid = "unionbooks"; // 가맹점 ID(가맹점 수정후 고정)
					
//					inipay.SetField("inipayhome", "/unionbooks2019/tomcat/webapps/ROOT/INIpay50_JAVA");		// INIpay50 절대경로 (key / log 디렉토리) 변경!
					inipay.SetField("inipayhome", "/D:\\study\\work\\src\\main\\webapp\\INIpay50_JAVA");		// INIpay50 절대경로 (key / log 디렉토리)
					inipay.SetField("debug", "true");								// 로그모드  (true / false)
					inipay.SetField("type", "cancel");								// type (고정)
					inipay.SetField("crypto", "execure");						    // 암복호화모듈 (고정)
					inipay.SetField("mid", mid );			// 상점아이디
					inipay.SetField("admin", "1111");							// 키파일 비밀번호

					inipay.SetField("tid", cancelCommand.getTid() );
					inipay.SetField("cancelmsg", cancelCommand.getCancel_msg() ); //고객 취소 메시지
					inipay.SetField("cancelreason", "1" ); //취소 사유 = 결제취소로 고정
					
					/****************
					* 3. 취소 요청 *
					****************/
					inipay.startAction();
				
					String ResultCode = inipay.GetResult("ResultCode");
					String ResultMsg = inipay.GetResult("ResultMsg");
					String CSHR_CancelNum = inipay.GetResult("CSHR_CancelNum");  //현금영수증 취소승인번호
					String CancelDate = inipay.GetResult("CancelDate");//취소 날짜
					String CancelTime = inipay.GetResult("CancelTime");//취소 시각
					String cancelmsg = inipay.GetResult("cancelmsg");//취소 메시지
					
					System.out.println("ResultCode : " + ResultCode);
					System.out.println("ResultMsg : " + ResultMsg);
					System.out.println("CSHR_CancelNum : " + CSHR_CancelNum);
					System.out.println("CancelTime : " + CancelTime);
					System.out.println("CancelDate : " + CancelDate);
					System.out.println("cancelmsg : " + cancelmsg);
					
					if(ResultCode == "00") {
						msg = "고객님의 주문을 취소하였습니다.\n감사합니다.";
						able = true;
						customerService.insertCancelReq(cancelData);
					}else {
						msg = "거래 취소 요청 중 오류가 발생하였습니다.\n계속해서 오류가 발생시 고객센터에 문의해주시기 바랍니다.";
						able = false;
					}
					if(log.isDebugEnabled()) log.debug("cancelData : " + cancelData);
				}
				map.put("able", able);
				map.put("msg", msg);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	@RequestMapping("/customer/orderCancelList.do")
	public String orderCancelList(Criteria criteria, HttpSession session, Model model) {
		String user_id = (String) session.getAttribute("user_id");
		criteria.setUser_id(user_id);
		
		int cancel_count = customerService.getCancelOrderListCount(criteria);
		
		PageMaker pageMaker = new PageMaker();
		if(criteria.getPerPageNum() <= 10) {
			criteria.setPerPageNum(10); //UI상 10개씩만 보이게 한다
		}
		
		pageMaker.setCri(criteria);
	    pageMaker.setTotalCount(cancel_count); //전체 페이지 수
	    List<CancelCommand> cancel_list = customerService.getCancelOrderList(criteria); 
	    pageMaker.setPage(criteria.getPage());//현재 페이지 넘기기
	    model.addAttribute("cancel_list", cancel_list);
		model.addAttribute("criteria", criteria);
		model.addAttribute("pageMaker", pageMaker);
		return "orderCancelList";
	}
	
	@RequestMapping("/customer/orderCancelDetail.do")
	public String orderCancelDetailForm(@RequestParam(value="order_code",required=false) String order_code, HttpSession session, Model model) {
		String user_id = (String) session.getAttribute("user_id");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("order_code", order_code);
		map.put("user_id", user_id);
		
		List<PaymentCommand> cancel_view = customerService.getOrderCancelDetail(map);
		
		model.addAttribute("cancel_view", cancel_view);
		
		return "orderCancelDetail";
	}
	
	@ResponseBody
	@RequestMapping(value="/customer/cancelRetractSub.do", method=RequestMethod.POST)
	public Map<Object, Object> orderCancelRetractSub(@RequestParam(value="order_code",required=false) String order_code, HttpSession session) {		
		String user_id = (String) session.getAttribute("user_id");
		
		Map<Object,Object> paramMap = new HashMap<Object,Object>();
		paramMap.put("order_code", order_code);
		paramMap.put("user_id", user_id);
		
		Map<Object,Object> map = new HashMap<Object,Object>();
		
		try {
			boolean able = false;
			String msg = "";
			String refund_status = customerService.cancelDataChk(paramMap);
			if(refund_status != null){
				if(refund_status.equals("F")) {
					msg = "이미 주문 취소 처리가 완료되었습니다.";
				}else {
					msg = "주문 취소를 철회하였습니다.\n해당 주문은 '주문 내역'에서 확인이 가능합니다.\n감사합니다.";
					able = true;
					customerService.cancelRetract(paramMap);
				}
				map.put("able", able);
				map.put("msg", msg);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	
}
