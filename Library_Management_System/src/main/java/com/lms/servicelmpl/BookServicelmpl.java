package com.lms.servicelmpl;

import java.util.List;

import com.lms.dao.BookDao;
import com.lms.daolmpl.BookDaolmpl;
import com.lms.pojo.Book;
import com.lms.pojo.BookIssued;
import com.lms.service.BookService;

public class BookServicelmpl implements BookService {
	
	BookDao bookdao = new BookDaolmpl();
	
	@Override
	public boolean addBook(Book book) {
		return bookdao.addBook(book);
	}

	@Override
	public boolean updateBook(Book book) {
		try {
			return bookdao.updateBook(book);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bookdao.updateBook(book);
	}

	@Override
	public List<Book> getAllBooksList() {
		try {
			return bookdao.getAllBooksList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<Book> getAllBookByStatus(String status) {
		try {
			return bookdao.getAllBookByStatus(status);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public Book getBookById(Long id) {
		// TODO Auto-generated method stub
		return bookdao.getBookById(id);
	}

	@Override
	public boolean assignBook(BookIssued bookIssued) {
		bookIssued.setStatus("Issued");
		bookIssued.setIssueDate(new java.util.Date());
		
		boolean assignFlag = false;
		Book book = bookdao.getBookById(bookIssued.getBook().getBookId());
		
		if(book != null && book.getAvailableCopies() > 0) {
			int availableCopies = book.getAvailableCopies() - 1;
			
			boolean updateFlag = bookdao.updateAvailableBook(bookIssued.getBook().getBookId(), availableCopies);
			
			if(updateFlag) {
				System.out.println("✓ Book availability updated successfully! Remaining copies: " + availableCopies);
				
				assignFlag = bookdao.assignBook(bookIssued);
				
				if(!assignFlag) {
					System.out.println("✗ Book assignment failed. Rolling back availability update.");
					bookdao.updateAvailableBook(bookIssued.getBook().getBookId(), availableCopies + 1);
					return false;
					
				}
			} else {
				System.out.println("✗ Book availability update failed. Assignment aborted.");
				return false;
				}
				
		}
		else {
			System.out.println("✗ Book with ID " + bookIssued.getBook().getBookId() + " is not available for assignment.");
		}
		return assignFlag;
	}


	@Override
	public List<Book> getAllAllAvailableBooksList() {
		// TODO Auto-generated method stub
		return bookdao.getAllAvailableBooksList();
	}

	@Override
	public List<BookIssued> getAllIssuedBooksList() {
		// TODO Auto-generated method stub
		return bookdao.getAllIssuedBooksList();
	}

	@Override
	public BookIssued getIssuedBookById(Long issueId) {
		return bookdao.getIssuedBookById(issueId);
	}

	@Override
	public boolean updateBookReturn(BookIssued bookIssued) {
		bookIssued.setStatus("Returned");

		BookIssued issuedRecord = bookdao.getIssuedBookById((long) bookIssued.getIssueId());
		if (issuedRecord == null || issuedRecord.getBook() == null) {
			return false;
		}

		long bookId = issuedRecord.getBook().getBookId();
		Book book = bookdao.getBookById(bookId);
		boolean returnflag = false;

		if (book != null) {
			int availableCopies = book.getAvailableCopies() + 1;

			boolean updateflag = bookdao.updateAvailableBook(bookId, availableCopies);

			if (updateflag) {
				returnflag = bookdao.updateBookReturn(bookIssued);

				if (!returnflag) {
					bookdao.updateAvailableBook(bookId, availableCopies - 1);
				}
			}
		}
		return returnflag;
	}




}