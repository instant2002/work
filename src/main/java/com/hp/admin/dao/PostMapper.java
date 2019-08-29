package com.hp.admin.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import com.hp.admin.domain.NoticeCommand;
import com.hp.admin.domain.PostCommand;
import com.hp.admin.domain.QnaAdminCommand;
import com.hp.admin.domain.SampleCommand;

@Repository
public interface PostMapper {

	public void uploadBookInfo(PostCommand postCommand);

	public List<PostCommand> getAllBooksInfo();

	@Select("SELECT * FROM book_info WHERE product_no = #{product_no}")
	public PostCommand getBookInfo(int product_no);

	public void postingBookEditSub(PostCommand postCommand);

	@Delete("DELETE FROM book_info WHERE product_no = #{product_no}")
	public void postingBookDel(String product_no);

	public List<PostCommand> getMainBooksInfo(String book_new_num);

	public void uploadNotice(NoticeCommand noticeCommand);

	public List<NoticeCommand> getNoticeList();

	@Select("SELECT * FROM notice WHERE num = #{num}")
	public NoticeCommand getNoticeView(int num);

	public void postingNoticeEditSub(NoticeCommand noticeCommand);

	@Delete("DELETE FROM notice WHERE num = #{num}")
	public void postingNoticeDel(int num);
	
	@Delete("DELETE FROM notice_file WHERE notice_idx = #{num}")
	public void postingNoticeFileDel(int num);

	@Delete("DELETE FROM notice_attachments_file WHERE notice_idx = #{num}")
	public void postingNoticeAttFileDel(int num);

	public void uploadNoticeFile(HashMap<String, Object> hm);

	public void uploadNoticeAttFile(HashMap<String, Object> atthm);
	
	public List<NoticeCommand> getNoticeFile(int num);

	public List<NoticeCommand> getNoticeAttFile(int num);
	
	public List<QnaAdminCommand> getQnaList();

	@Select("SELECT * FROM question WHERE idx = #{idx}")
	public QnaAdminCommand getQnaView(QnaAdminCommand qnaAdminCommand);

	public void qnaAnsSub(QnaAdminCommand qnaAdminCommand);

	@Update("UPDATE question SET isAnswer = 'Y' WHERE idx = #{idx}")
	public void updateQuestionIsanswer(int idx);

	
	@Select("SELECT * FROM answer WHERE ansQuesIdx = #{idx}")
	public QnaAdminCommand getQnaAnswer(QnaAdminCommand qnaAdminCommand);

	public void uploadSample(HashMap<String, Object> hm);

	public List<SampleCommand> getSampleList();

	@Delete("DELETE FROM sample_img WHERE sample_calling_name = #{sample_calling_name}")
	public void postingSampleDel(String sample_calling_name);

	public List<SampleCommand> getSampleImg(String sample_calling_name);

}
