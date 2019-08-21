package com.hp.book.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hp.admin.domain.PostCommand;
import com.hp.book.dao.BookMapper;
import com.hp.book.domain.BookCommand;
import com.hp.common.domain.Criteria;

@Service("bookService")
public class BookServiceImpl implements BookService{
	
	@Resource(name = "bookMapper")
	private BookMapper bookMapper;

	@Override
	public BookCommand getBookDetailView(int product_no) {
		return bookMapper.getBookDetailView(product_no);
	}

	@Override
	public List<PostCommand> getBookList(Criteria criteria) {
		return bookMapper.getBookList(criteria);
	}

	@Override
	public int getBookListCount(Criteria criteria) {
		return bookMapper.getBookListCount(criteria);
	}
}
