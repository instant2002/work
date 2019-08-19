package com.hp.book.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import com.hp.admin.domain.PostCommand;
import com.hp.book.domain.BookCommand;
import com.hp.common.domain.Criteria;

@Repository
public interface BookMapper {

	@Select("SELECT * FROM book_info WHERE product_no = #{product_no} AND is_sale != 'N'")
	public BookCommand getBookDetailView(int product_no);

	public List<PostCommand> getBookList(Criteria criteria);

	public int getBookListCount();

}
