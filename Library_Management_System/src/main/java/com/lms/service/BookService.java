package com.lms.service;

import java.util.List;

import com.lms.pojo.Book;
import com.lms.pojo.BookIssued;

public interface BookService {
	public boolean addBook(Book book);
	public boolean updateBook(Book book);
	public List<Book> getAllBooksList();
	public List<Book> getAllBookByStatus(String status);
	public Book getBookById(Long id);
	public boolean assignBook(BookIssued bookIssued);
	public List<Book> getAllAllAvailableBooksList();
	public List<BookIssued> getAllIssuedBooksList();
	public BookIssued getIssuedBookById(Long issueId);
	public boolean updateBookReturn(BookIssued bookIssued);
}
