package com.hp.member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hp.customer.domain.CancelCommand;
import com.hp.customer.service.CustomerService;
import com.hp.order.domain.PaymentCommand;
import com.inicis.inipay.INIpay50;

@Controller
public class NonMemberController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="customerService")
	private CustomerService customerService;

	@RequestMapping(value="/member/orderTrackingForm.do")
	public String orderTrackingForm() {
		
		return "orderTrackingForm";
	}
	
	@RequestMapping(value="/member/orderTracking.do")
	public String orderTrackingSub(@RequestParam(value="buyername", required=false) String buyername, 
			@RequestParam(value="order_code", required=false) String order_code, HttpServletResponse response, Model model) throws IOException {
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("buyername", buyername);
		map.put("order_code", order_code);
		
		List<PaymentCommand> order_view = customerService.getNonmemOrderTracking(map);
		
		if(order_view.size() <= 0) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('조회하신 주문 정보가 없습니다.'); location.href='/member/orderTrackingForm.do';</script>");
			out.flush();
			return "orderTrackingForm";
		}else {
			model.addAttribute("order_view", order_view);
			return "orderTracking";
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/member/nonMemOrderCancel.do", method=RequestMethod.POST)
	public Map<Object, Object> orderCancelReqSub(@ModelAttribute("cancelCommand") CancelCommand cancelCommand) {
		cancelCommand.setUser_id("nonmember");
		
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
}
