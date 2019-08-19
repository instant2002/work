package com.hp.common.controller;

import java.io.File;
import java.io.PrintWriter;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class CommonController {
	Logger log = Logger.getLogger(this.getClass());

	@RequestMapping(value = "/common/downloadFile.do")
	public void downloadFile(@RequestParam(value="name",required=false) String name,
							 @RequestParam(value="storedName",required=false) String storedName,
							 HttpServletResponse response, HttpServletRequest request) throws Exception {
		
		String save_path = request.getSession().getServletContext().getRealPath("");
		
		if(log.isDebugEnabled()){
			log.debug("name : " + name);
			log.debug("storedName : " + save_path + storedName);
		}
		
		try {
			byte fileByte[] = FileUtils.readFileToByteArray(new File(save_path + storedName));
			
			response.setContentType("application/octet-stream");
			response.setContentLength(fileByte.length);
			response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(name, "UTF-8") + "\";");
			response.setHeader("Content-Transfer-Encoding", "binary");
			response.getOutputStream().write(fileByte);
			response.getOutputStream().flush();
			response.getOutputStream().close();
		} catch (Exception e) {
			e.printStackTrace();
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('업로드 중 오류가 발생하였습니다.'); history.go(-1);</script>");
			out.flush();
		}
		
	}
}