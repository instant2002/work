package com.hp.book.service;

import java.util.List;

import com.hp.admin.domain.PostCommand;
import com.hp.book.domain.BookCommand;
import com.hp.common.domain.Criteria;

public interface BookService {

	public BookCommand getBookDetailView(int product_no);

	public List<PostCommand> getBookList(Criteria criteria);

	public int getBookListCount();

}
