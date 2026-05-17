package com.lms.dao;

import java.util.List;

import com.lms.pojo.Book;
import com.lms.pojo.BookIssued;

public interface BookDao {
	public boolean addBook(Book book);
	public boolean updateBook(Book book);
	public List<Book> getAllBooksList();
	public List<Book> getAllBookByStatus(String status);
	public Book getBookById(Long id);
	public boolean assignBook(BookIssued bookIssued);
	public boolean updateAvailableBook(Long bookId, int availableCopies);
	public List<Book> getAllAvailableBooksList();
	public BookIssued getIssuedBookById(Long issueId);
	public boolean updateBookReturn(BookIssued bookIssued);
	public List<BookIssued> getAllIssuedBooksList();
	public List<BookIssued> getIssuedBooksByUserId();
	
}
