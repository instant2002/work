package com.hp.order.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.ConnectException;
import java.net.HttpURLConnection;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.URL;
import java.net.URLConnection;
import java.net.UnknownHostException;
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
	public String form(@ModelAttribute("paymentMobileCommand") PaymentMobileCommand paymentMobileCommand, HttpSession session, HttpServletRequest request, Model model) throws Exception, UnknownHostException {
		if(log.isDebugEnabled())log.debug("paymentMobileCommand : " + paymentMobileCommand);
		
		String P_REQ_URL = paymentMobileCommand.getP_REQ_URL();
		String param = "?P_MID=INIpayTest&P_TID="+paymentMobileCommand.getP_TID();

        try {
        	String serverIp = P_REQ_URL;
            Socket socket = new Socket(serverIp, 443);
                
                // 입력스트림 
                InputStream in = socket.getInputStream();
                DataInputStream dis = new DataInputStream(in);
                
                // 데이터 출력 
                System.out.println("message : " + dis.readUTF());
                
                dis.close();

		}catch (UnknownHostException uhe) {
			uhe.printStackTrace();
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return "orderPaymentResult";

	}
}
