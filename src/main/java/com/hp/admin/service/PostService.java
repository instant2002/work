package com.hp.admin.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.hp.admin.domain.NoticeCommand;
import com.hp.admin.domain.PostCommand;
import com.hp.admin.domain.QnaAdminCommand;

public interface PostService {

	public void uploadBookInfo(PostCommand postCommand, String save_path);

	public List<PostCommand> getAllBooksInfo();

	public PostCommand getBookInfo(int product_no);

	public void postingBookEditSub(PostCommand postCommand, String save_path, HttpServletRequest request);

	public void postingBookDel(PostCommand postCommand, String save_path);

	public List<PostCommand> getMainBooksInfo(String book_new_num);

	public void uploadNotice(NoticeCommand noticeCommand, String save_img_path, MultipartHttpServletRequest mtf_request, String save_file_path) throws Exception;

	public List<NoticeCommand> getNoticeList();

	public void postingNoticeEditSub(NoticeCommand noticeCommand, String save_path, HttpServletRequest request, String save_file_path);

	public void postingNoticeDel(NoticeCommand noticeCommand, String save_path);

	public NoticeCommand getNoticeView(int num);

	public List<NoticeCommand> getNoticeFile(int num);

	public List<QnaAdminCommand> getQnaList();

	public QnaAdminCommand getQnaView(QnaAdminCommand qnaAdminCommand);

	public void qnaAnsSub(QnaAdminCommand qnaAdminCommand);

	public void updateQuestionIsanswer(int idx);

	public QnaAdminCommand getQnaAnswer(QnaAdminCommand qnaAdminCommand);


}
