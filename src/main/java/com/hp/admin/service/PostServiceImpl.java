package com.hp.admin.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.hp.admin.dao.PostMapper;
import com.hp.admin.domain.NoticeCommand;
import com.hp.admin.domain.PostCommand;
import com.hp.admin.domain.QnaAdminCommand;
import com.hp.admin.domain.SampleCommand;

@Service("postService")
public class PostServiceImpl implements PostService {
	private Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "postMapper")
	private PostMapper postMapper;

	@Override
	public void uploadBookInfo(PostCommand postCommand, String save_path) {

		MultipartFile multipartFile = postCommand.getBook_img_file();

		try {
			// 파일 정보
			String book_img_name = multipartFile.getOriginalFilename();
			if (book_img_name != null && book_img_name != "") {
				String extName = book_img_name.substring(book_img_name.lastIndexOf("."), book_img_name.length());
				Long book_img_size = multipartFile.getSize();

				// 서버에서 저장 할 파일 이름
				String book_img_storedName = genSaveFileName(extName);

				postCommand.setBook_img_name(book_img_name);
				postCommand.setBook_img_storedName("/unionbooks_img/" + book_img_storedName);

				System.out.println("book_img_name : " + book_img_name);
				System.out.println("extensionName : " + extName);
				System.out.println("book_img_size : " + book_img_size);
				System.out.println("book_img_storedName : " + book_img_storedName);

				// 파일 경로 없으면 생성
				File filePath = new File(save_path);
				if (filePath.exists() == false) {
					filePath.mkdirs();
				}

				writeFile(multipartFile, book_img_storedName, save_path);
			}
			postMapper.uploadBookInfo(postCommand);

		} catch (IOException e) {
			// 원래라면 RuntimeException 을 상속받은 예외가 처리되어야 하지만
			// 편의상 RuntimeException을 던진다.
			// throw new FileUploadException();
			throw new RuntimeException(e);
		}
	}

	// 현재 시간을 기준으로 파일 이름 생성
	private String genSaveFileName(String extName) {
		String fileName = "";

		Calendar calendar = Calendar.getInstance();
		fileName += calendar.get(Calendar.YEAR);
		fileName += calendar.get(Calendar.MONTH);
		fileName += calendar.get(Calendar.DATE);
		fileName += calendar.get(Calendar.HOUR);
		fileName += calendar.get(Calendar.MINUTE);
		fileName += calendar.get(Calendar.SECOND);
		fileName += calendar.get(Calendar.MILLISECOND);
		fileName += extName;

		return fileName;
	}

	// 파일을 실제로 write 하는 메서드
	private boolean writeFile(MultipartFile multipartFile, String book_img_storedName, String save_path)
			throws IOException {
		boolean result = false;

		byte[] data = multipartFile.getBytes();
		FileOutputStream fos = new FileOutputStream(save_path + "/" + book_img_storedName);
		fos.write(data);
		fos.close();

		return result;
	}

	@Override
	public List<PostCommand> getAllBooksInfo() {
		return postMapper.getAllBooksInfo();
	}

	@Override
	public PostCommand getBookInfo(int product_no) {
		return postMapper.getBookInfo(product_no);
	}

	@Override
	public void postingBookEditSub(PostCommand postCommand, String save_path, HttpServletRequest request) {

		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
		Iterator<String> iterator = multipartHttpServletRequest.getFileNames();

		MultipartFile multipartFile = null;
		String uploadFileName = iterator.next();

		multipartFile = multipartHttpServletRequest.getFile(uploadFileName);

		String is_new = "N";
		if (multipartFile.isEmpty() == false) {
			String saveFileName = multipartFile.getOriginalFilename();

			if (saveFileName != null && !saveFileName.equals("")) {
				is_new = "Y";
			}
		}

		// 새로운 파일이 있으면
		if (is_new == "Y") {
			String fileName_before = postCommand.getBook_img_storedName();
			String fileName = fileName_before.substring(fileName_before.lastIndexOf("/") + 1);

			multipartFile = postCommand.getBook_img_file();

			try {
				// 파일 정보
				String book_img_name = multipartFile.getOriginalFilename();
				if (book_img_name != null && book_img_name != "") {
					String extName = book_img_name.substring(book_img_name.lastIndexOf("."), book_img_name.length());
					Long book_img_size = multipartFile.getSize();

					String book_img_storedName = postCommand.getBook_img_storedName();

					if (book_img_storedName == "" || book_img_storedName.isEmpty()) {
						// 서버에서 저장 할 파일 이름
						fileName = genSaveFileName(extName);
						postCommand.setBook_img_storedName("/unionbooks_img/" + fileName);
					}

					postCommand.setBook_img_name(book_img_name);

					// 파일 경로 없으면 생성
					File filePath = new File(save_path);
					if (filePath.exists() == false) {
						filePath.mkdirs();
					}
					
					System.out.println("book_img_name : " + book_img_name);
					System.out.println("extensionName : " + extName);
					System.out.println("book_img_size : " + book_img_size);
					System.out.println("book_img_storedName : " + book_img_storedName);
					System.out.println("save_path : " + save_path);
					System.out.println("fileName : " + fileName);

					multipartFile.transferTo(new File(save_path + "/" + fileName));

//					writeFile(multipartFile, book_img_storedName, save_path); 
				}

			} catch (IOException e) {
				// 원래라면 RuntimeException 을 상속받은 예외가 처리되어야 하지만
				// 편의상 RuntimeException을 던진다.
				// throw new FileUploadException();
				throw new RuntimeException(e);
			}
		}

		postMapper.postingBookEditSub(postCommand);

	}

	@Override
	public void postingBookDel(PostCommand postCommand, String save_path) {
		
		String del_file_db = postCommand.getBook_img_storedName();
		if(del_file_db != null) {
			String del_file_name = del_file_db.substring(del_file_db.lastIndexOf("/") + 1);
			String del_file = save_path + "\\" + del_file_name;
			
			File file = new File(del_file);
			if (file.exists()) {
				file.delete();
				if(log.isDebugEnabled()){
					log.debug("삭제된 파일 : " + del_file_name);
				}
			}
		}
		
		String product_no = postCommand.getProduct_no();
		postMapper.postingBookDel(product_no);
	}

	@Override
	public List<PostCommand> getMainBooksInfo(String book_new_num) {
		return postMapper.getMainBooksInfo(book_new_num);
	}

	@Override
	public void uploadNotice(NoticeCommand noticeCommand, String save_img_path, MultipartHttpServletRequest mtfRequest, String save_file_path, MultipartHttpServletRequest mtfRequest2, String save_attachments_path) {
		MultipartFile multipartFile = noticeCommand.getNotice_img_file();
		List<MultipartFile> fileList = mtfRequest.getFiles("notice_file");
		List<MultipartFile> attFileList = mtfRequest2.getFiles("notice_attFile");
		
		try {
			// 파일 경로 없으면 생성
			File fileImgPath = new File(save_img_path);
			if (fileImgPath.exists() == false) fileImgPath.mkdirs();
			File filePath = new File(save_file_path);
			if (filePath.exists() == false) filePath.mkdirs();
			File atfilePath = new File(save_attachments_path);
			if (atfilePath.exists() == false) atfilePath.mkdirs();
			
			// 파일 정보
			String notice_img_name = multipartFile.getOriginalFilename();
			if (notice_img_name != null && notice_img_name != "") {
				String extName = notice_img_name.substring(notice_img_name.lastIndexOf("."), notice_img_name.length());
				Long notice_img_size = multipartFile.getSize();

				// 서버에서 저장 할 파일 이름
				String notice_img_storedName = genSaveFileName(extName);

				noticeCommand.setNotice_img_name(notice_img_name);
				noticeCommand.setNotice_img_storedName("/notice_img/" + notice_img_storedName);
				
				if(log.isDebugEnabled()){
					log.debug("notice_img_name : " + notice_img_name);
					log.debug("extensionName : " + extName);
					log.debug("notice_img_size : " + notice_img_size);
					log.debug("notice_img_storedName : " + notice_img_storedName);
					
				}

				writeFile(multipartFile, notice_img_storedName, save_img_path);
			}
			postMapper.uploadNotice(noticeCommand);
			
			int notice_idx = noticeCommand.getNum(); //생성된 공지 게시판의 idx값 얻어오기 
			
			for (MultipartFile mf : fileList) {//다중 파일 업로드
				
				String originFileName = mf.getOriginalFilename(); // 원본 파일 명
				String rand_name = Long.toString(System.currentTimeMillis())+(int)(Math.random()*50);
				String notice_file_storedName = save_file_path +"\\"+ rand_name;
				String FileExtName = originFileName.substring(originFileName.lastIndexOf("."), originFileName.length());
				
				if(log.isDebugEnabled()){
					log.debug("notice_files origin: " + save_file_path +"\\"+ originFileName);
					log.debug("notice_files rand : " + notice_file_storedName);
					log.debug("extensionFileName : " + FileExtName);
				}
				
				HashMap<String, Object> hm = new HashMap<String, Object>();
				hm.put("notice_idx", notice_idx);
				hm.put("notice_file_name", originFileName);
				hm.put("notice_file_storedName", "/notice_file/"+rand_name+FileExtName);
				
				mf.transferTo(new File(save_file_path +"/"+ rand_name+FileExtName));
				postMapper.uploadNoticeFile(hm);
			}
			
			for (MultipartFile attmf : attFileList) {//다중 첨부자료 업로드
				
				String originAttFileName = attmf.getOriginalFilename(); // 원본 파일 명
				String rand_attName = Long.toString(System.currentTimeMillis())+(int)(Math.random()*50);
				String notice_attFile_storedName = save_attachments_path +"\\"+ rand_attName;
				String attFileExtName = originAttFileName.substring(originAttFileName.lastIndexOf("."), originAttFileName.length());
				
				if(log.isDebugEnabled()){
					log.debug("notice_Attfiles origin: " + save_attachments_path +"\\"+ originAttFileName);
					log.debug("notice_Attfiles rand : " + notice_attFile_storedName);
					log.debug("extensionAttName : " + attFileExtName);
				}
				
				HashMap<String, Object> atthm = new HashMap<String, Object>();
				atthm.put("notice_idx", notice_idx);
				atthm.put("notice_attFile_name", originAttFileName);
				atthm.put("notice_attFile_storedName", "/attachments_file/"+rand_attName+attFileExtName);
				
				attmf.transferTo(new File(save_attachments_path +"/"+ rand_attName+attFileExtName));
				postMapper.uploadNoticeAttFile(atthm);
			}
			 
		} catch (IOException e) {
			e.printStackTrace();
			
		} catch (IllegalStateException e) {
            e.printStackTrace();
        }
		
	}

	@Override
	public List<NoticeCommand> getNoticeList() {
		return postMapper.getNoticeList();
	}

	@Override
	public void postingNoticeEditSub(NoticeCommand noticeCommand, String save_path, HttpServletRequest request, String save_file_path) {
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
		Iterator<String> iterator = multipartHttpServletRequest.getFileNames();

		MultipartFile multipartFile = null;
		String uploadFileName = iterator.next();

		multipartFile = multipartHttpServletRequest.getFile(uploadFileName);

		String is_new = "N";
		if (multipartFile.isEmpty() == false) {
			String saveFileName = multipartFile.getOriginalFilename();

			if (saveFileName != null && !saveFileName.equals("")) {
				is_new = "Y";
			}
		}

		// 새로운 파일이 있으면
		if (is_new == "Y") {
			String fileName_before = noticeCommand.getNotice_img_storedName();
			String fileName = fileName_before.substring(fileName_before.lastIndexOf("/") + 1);

			multipartFile = noticeCommand.getNotice_img_file();

			try {
				// 파일 정보
				String notice_img_name = multipartFile.getOriginalFilename();
				if (notice_img_name != null && notice_img_name != "") {
					String extName = notice_img_name.substring(notice_img_name.lastIndexOf("."), notice_img_name.length());
					Long notice_img_size = multipartFile.getSize();

					String notice_img_storedName = noticeCommand.getNotice_img_storedName();

					if (notice_img_storedName == "" || notice_img_storedName.isEmpty()) {
						// 서버에서 저장 할 파일 이름
						fileName = genSaveFileName(extName);
						noticeCommand.setNotice_img_storedName("/notice_img/" + fileName);
					}

					noticeCommand.setNotice_img_name(notice_img_name);

					// 파일 경로 없으면 생성
					File filePath = new File(save_path);
					if (filePath.exists() == false) {
						filePath.mkdirs();
					}

					multipartFile.transferTo(new File(save_path + "/" + fileName));

					/* writeFile(multipartFile, book_img_storedName, save_path); */
				}

			} catch (IOException e) {
				// 원래라면 RuntimeException 을 상속받은 예외가 처리되어야 하지만
				// 편의상 RuntimeException을 던진다.
				// throw new FileUploadException();
				throw new RuntimeException(e);
			}
		}

		postMapper.postingNoticeEditSub(noticeCommand);

	}

	@Override
	public void postingNoticeDel(NoticeCommand noticeCommand, String save_path, List<NoticeCommand> noticeFileCommand, String save_file_path, List<NoticeCommand> noticeAttFileCommand, String save_attachments_path) {
		if(log.isDebugEnabled()) log.debug("NoticeCommand : " + noticeCommand);
		if(log.isDebugEnabled()) log.debug("NoticeFileCommand List : " + noticeFileCommand);
		if(log.isDebugEnabled()) log.debug("NoticeAttFileCommand List : " + noticeAttFileCommand);
		
		String del_Img_file_db = noticeCommand.getNotice_img_storedName();
		
		int num = noticeCommand.getNum();
		
		//이미지 지우기
		if(del_Img_file_db != null) {
			String del_img_file_name = del_Img_file_db.substring(del_Img_file_db.lastIndexOf("/") + 1);
			String del_img_file = save_path + "\\" + del_img_file_name;
			
			File img_file = new File(del_img_file);
			if (img_file.exists()) {
				img_file.delete();
				if(log.isDebugEnabled()) log.debug("삭제된 이미지 : " + del_img_file_name);
			}
		}
		
		//첨부파일 지우기
		if(noticeFileCommand.size() > 0) {
			for (NoticeCommand file_list : noticeFileCommand) {
				String del_file_db = file_list.getNotice_file_storedName();
				
				String del_file_name = del_file_db.substring(del_file_db.lastIndexOf("/") + 1);
				String del_file = save_file_path + "\\" + del_file_name;
				
				File file = new File(del_file);
				if (file.exists()) {
					file.delete();
					if(log.isDebugEnabled()) log.debug("삭제된 첨부파일 : " + del_file_name);
				}
			}
			postMapper.postingNoticeFileDel(num);
		}
		
		//첨부자료 지우기
		if(noticeAttFileCommand.size() > 0) {
			for (NoticeCommand attFile_list : noticeAttFileCommand) {
				String del_attFile_db = attFile_list.getNotice_attFile_storedName();
				
				String del_attFile_name = del_attFile_db.substring(del_attFile_db.lastIndexOf("/") + 1);
				String del_attFile = save_attachments_path + "\\" + del_attFile_name;
				
				File attFile = new File(del_attFile);
				if (attFile.exists()) {
					attFile.delete();
					if(log.isDebugEnabled()) log.debug("삭제된 첨부자료 : " + del_attFile_name);
				}
			}
			postMapper.postingNoticeAttFileDel(num);
		}
		
		postMapper.postingNoticeDel(num);
	}

	@Override
	public NoticeCommand getNoticeView(int num) {
		return postMapper.getNoticeView(num);
	}

	@Override
	public List<NoticeCommand> getNoticeFile(int num) {
		return postMapper.getNoticeFile(num);
	}
	
	@Override
	public List<NoticeCommand> getNoticeAttFile(int num) {
		return postMapper.getNoticeAttFile(num);
	}

	@Override
	public List<QnaAdminCommand> getQnaList() {
		return postMapper.getQnaList();
	}

	@Override
	public QnaAdminCommand getQnaView(QnaAdminCommand qnaAdminCommand) {
		return postMapper.getQnaView(qnaAdminCommand);
	}

	@Override
	public void qnaAnsSub(QnaAdminCommand qnaAdminCommand) {
		postMapper.qnaAnsSub(qnaAdminCommand);
	}

	@Override
	public void updateQuestionIsanswer(int idx) {
		postMapper.updateQuestionIsanswer(idx);
	}

	@Override
	public QnaAdminCommand getQnaAnswer(QnaAdminCommand qnaAdminCommand) {
		return postMapper.getQnaAnswer(qnaAdminCommand);
	}

	@Override
	public void uploadSample(SampleCommand sampleCommand, String save_img_path, MultipartHttpServletRequest mtf_request)  {
		List<MultipartFile> imgList = mtf_request.getFiles("sample_img");
		try {
			// 파일 경로 없으면 생성
			File saveImgPath = new File(save_img_path);
			if (saveImgPath.exists() == false) saveImgPath.mkdirs();
			
			String sample_calling_name = Long.toString(System.currentTimeMillis())+(int)(Math.random()*50);
			
			for (MultipartFile mf : imgList) {//다중 파일 업로드
				
				String originimgName = mf.getOriginalFilename(); // 원본 파일 명
				String rand_name = Long.toString(System.currentTimeMillis())+(int)(Math.random()*50);
				String sample_img_storedName = save_img_path +"\\"+ rand_name;
				String imgExtName = originimgName.substring(originimgName.lastIndexOf("."), originimgName.length());//확장자
				
				if(log.isDebugEnabled()){
					log.debug("sample_img origin: " + save_img_path +"\\"+ originimgName);
					log.debug("sample_img rand : " + sample_img_storedName);
					log.debug("extensionImgName : " + imgExtName);
				}
				
				HashMap<String, Object> hm = new HashMap<String, Object>();
				hm.put("sample_img_title", sampleCommand.getSample_img_title());
				hm.put("sample_calling_name", sample_calling_name);
				hm.put("sample_img_name", originimgName);
				hm.put("sample_img_storedName", "/sample_img/"+rand_name+imgExtName);
				
				mf.transferTo(new File(save_img_path +"/"+ rand_name+imgExtName));
				postMapper.uploadSample(hm);
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		}catch (IllegalStateException e) {
            e.printStackTrace();
        }
	}

	@Override
	public List<SampleCommand> getSampleList() {
		return postMapper.getSampleList();
	}

	@Override
	public void postingSampleDel(List<SampleCommand> del_list, String sample_calling_name , String save_img_path) {
		if(del_list.size() > 0) {
			for (SampleCommand file_list : del_list) {
				String del_img_db = file_list.getSample_img_storedName();
				
				String del_img_name = del_img_db.substring(del_img_db.lastIndexOf("/") + 1);
				String del_img = save_img_path + "\\" + del_img_name;
				
				File file = new File(del_img);
				if (file.exists()) {
					file.delete();
					if(log.isDebugEnabled()) log.debug("삭제된 샘플 이미지 : " + del_img_name);
				}
			}
			postMapper.postingSampleDel(sample_calling_name);
		}
		
		
	}

	@Override
	public List<SampleCommand> getSampleImg(String sample_calling_name) {
		return postMapper.getSampleImg(sample_calling_name);
	}

}
