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

	public void uploadNoticeFile(HashMap<String, Object> hm);

	public List<NoticeCommand> getNoticeFile(int num);

	public List<QnaAdminCommand> getQnaList();

	@Select("SELECT * FROM question WHERE idx = #{idx}")
	public QnaAdminCommand getQnaView(QnaAdminCommand qnaAdminCommand);

	public void qnaAnsSub(QnaAdminCommand qnaAdminCommand);

	@Update("UPDATE question SET isAnswer = 'Y' WHERE idx = #{idx}")
	public void updateQuestionIsanswer(int idx);

	
	@Select("SELECT * FROM answer WHERE ansQuesIdx = #{idx}")
	public QnaAdminCommand getQnaAnswer(QnaAdminCommand qnaAdminCommand);

}
