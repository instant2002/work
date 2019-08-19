package com.hp.common.util;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.hp.admin.domain.NoticeCommand;

@Component("fileUtils")
public class FileUtils {
	private static final String filePath = "D:/study";
	private Logger log = Logger.getLogger(this.getClass());
	
	public List<Map<String,Object>> parseInsertFileInfo(NoticeCommand noticeCommand, HttpServletRequest request) throws Exception{
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
    	Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
    	
    	MultipartFile book_img_file = null;
    	String book_img_name = null;
    	String book_img_storedName = null;
    	String storedFileName = null;
    	
    	List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
        Map<String, Object> listMap = null; 
        
        String boardIdx = String.valueOf(noticeCommand.getNotice_idx());
        
        File file = new File(filePath);
        if(file.exists() == false){
        	file.mkdirs();
        }
        
        while(iterator.hasNext()){
        	book_img_file = multipartHttpServletRequest.getFile(iterator.next());
        	if(book_img_file.isEmpty() == false){
        		book_img_name = book_img_file.getOriginalFilename();
        		book_img_storedName = book_img_name.substring(book_img_name.lastIndexOf("."));
        		storedFileName = CommonUtils.getRandomString() + book_img_storedName;
        		
        		file = new File(filePath + storedFileName);
        		book_img_file.transferTo(file); //지정된 경로에 파일이 생성됨
        		
        		if(log.isDebugEnabled()){
					log.debug("ORIGINAL_FILE_NAME : " + book_img_name);
					log.debug("STORED_FILE_NAME : " + storedFileName);
					log.debug("FILE_SIZE : " + book_img_file.getSize());
					
				}
        		
        		listMap = new HashMap<String,Object>();
        		listMap.put("ORIGINAL_FILE_NAME", book_img_name);
        		listMap.put("STORED_FILE_NAME", storedFileName);
        		listMap.put("FILE_SIZE", book_img_file.getSize());
        		list.add(listMap);
        	}
        }
		return list;
	}
	
	public List<Map<String, Object>> parseUpdateFileInfo(Map<String, Object> map, HttpServletRequest request) throws Exception{
		
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
		
		Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
		
		MultipartFile multipartFile = null;
		String originalFileName = null;
		String originalFileExtension = null;
		String storedFileName = null;
		
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		Map<String, Object> listMap = null; 
		
		String boardIdx = (String)map.get("IDX");
		String requestName = null;
		String idx = null;
		
		
		while(iterator.hasNext()){
			multipartFile = multipartHttpServletRequest.getFile(iterator.next());
			if(multipartFile.isEmpty() == false){
				originalFileName = multipartFile.getOriginalFilename();
				originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
				storedFileName = CommonUtils.getRandomString() + originalFileExtension;
				
				multipartFile.transferTo(new File(filePath + storedFileName));
				
				listMap = new HashMap<String,Object>();
				listMap.put("IS_NEW", "Y");
				listMap.put("BOARD_IDX", boardIdx);
				listMap.put("ORIGINAL_FILE_NAME", originalFileName);
				listMap.put("STORED_FILE_NAME", storedFileName);
				listMap.put("FILE_SIZE", multipartFile.getSize());
				list.add(listMap);
			}
			else{
				requestName = multipartFile.getName();
				idx = "IDX_"+requestName.substring(requestName.indexOf("_")+1);
				if(map.containsKey(idx) == true && map.get(idx) != null){
					listMap = new HashMap<String,Object>();
					listMap.put("IS_NEW", "N");
					listMap.put("FILE_IDX", map.get(idx));
					list.add(listMap);
				}
			}
		}
		return list;
	}

}


