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

					multipartFile.transferTo(new File(save_path + "\\" + fileName));

					/* writeFile(multipartFile, book_img_storedName, save_path); */
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
	public void uploadNotice(NoticeCommand noticeCommand, String save_img_path, MultipartHttpServletRequest mtfRequest, String save_file_path) {
		MultipartFile multipartFile = noticeCommand.getNotice_img_file();
		List<MultipartFile> fileList = mtfRequest.getFiles("notice_file");
		
		try {
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
				// 파일 경로 없으면 생성
				File fileImgPath = new File(save_img_path);
				if (fileImgPath.exists() == false) fileImgPath.mkdirs();
				File filePath = new File(save_file_path);
				if (filePath.exists() == false) filePath.mkdirs();

				writeFile(multipartFile, notice_img_storedName, save_img_path);
			}
			postMapper.uploadNotice(noticeCommand);
			
			int notice_idx = noticeCommand.getNum(); //생성된 공지 게시판의 idx값 얻어오기 
			
			for (MultipartFile mf : fileList) {//다중 파일 업로드
				
				String originFileName = mf.getOriginalFilename(); // 원본 파일 명
				String rand_name = Long.toString(System.currentTimeMillis())+(int)(Math.random()*50);
				String notice_file_storedName = save_file_path +"\\"+ rand_name;
				
				if(log.isDebugEnabled()){
					log.debug("notice_files origin: " + save_file_path +"\\"+ originFileName);
					log.debug("notice_files rand : " + notice_file_storedName);
				}
				
				HashMap<String, Object> hm = new HashMap<String, Object>();
				hm.put("notice_idx", notice_idx);
				hm.put("notice_file_name", originFileName);
				hm.put("notice_file_storedName", "/notice_file/"+rand_name);
				
				mf.transferTo(new File(save_file_path +"/"+ rand_name));
				postMapper.uploadNoticeFile(hm);
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

					multipartFile.transferTo(new File(save_path + "\\" + fileName));

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
	public void postingNoticeDel(NoticeCommand noticeCommand, String save_path) {
		String del_file_db = noticeCommand.getNotice_img_storedName();
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
		
		int num = noticeCommand.getNum();
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
}
