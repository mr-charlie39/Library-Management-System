package com.lms.daolmpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.lms.dao.BookDao;
import com.lms.pojo.Book;
import com.lms.pojo.BookIssued;
import com.lms.pojo.User;
import com.lms.util.DBUtil;

public class BookDaolmpl implements BookDao {

	@Override
	public boolean addBook(Book book) {

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {

			conn = DBUtil.getConnection();
			System.out.println("Database Connection: SUCCESS");

			String query = "INSERT INTO books (title, author, category, isbn, publisher, total_copies, available_copies, added_at) "
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
			System.out.println("SQL Query: " + query);

			ps = conn.prepareStatement(query);
			ps.setString(1, book.getTitle());
			ps.setString(2, book.getAuthor());
			ps.setString(3, book.getCategory());
			ps.setString(4, book.getIsbn());
			ps.setString(5, book.getPublisher());
			ps.setInt(6, book.getTotalCopies());
			ps.setInt(7, book.getAvailableCopies());
			ps.setTimestamp(8, book.getCreatedAt());

			System.out.println("Book Details - Title: " + book.getTitle() + ", Author: " + book.getAuthor()
					+ ", Category: " + book.getCategory() + ", ISBN: " + book.getIsbn() + ", Publisher: "
					+ book.getPublisher() + ", Total Copies: " + book.getTotalCopies() + ", Available Copies: "
					+ book.getAvailableCopies() + ", Added At: " + book.getCreatedAt());

			int result = ps.executeUpdate();

			if (result > 0) {
				System.out.println("✓ Book added successfully to database!");
				return true;
			} else {
				System.out.println("✗ No rows affected. Book insertion failed.");
			}

		} catch (Exception e) {
			System.out.println("✗ Error adding book: " + e.getMessage());
			e.printStackTrace();
		} finally {
			try {
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return false;
	}

	@Override
	public boolean updateBook(Book book) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {

			conn = DBUtil.getConnection();
			System.out.println("Database Connection: SUCCESS");

			String query = "UPDATE books SET title = ?, author = ?, category = ?, isbn = ?, publisher = ?, total_copies = ?, available_copies = ? "
					+ "WHERE book_id = ?";
			System.out.println("SQL Query: " + query);

			ps = conn.prepareStatement(query);
			ps.setString(1, book.getTitle());
			ps.setString(2, book.getAuthor());
			ps.setString(3, book.getCategory());
			ps.setString(4, book.getIsbn());
			ps.setString(5, book.getPublisher());
			ps.setInt(6, book.getTotalCopies());
			ps.setInt(7, book.getAvailableCopies());
			ps.setLong(8, book.getBookId());

			System.out.println("Book Details - Title: " + book.getTitle() + ", Author: " + book.getAuthor()
					+ ", Category: " + book.getCategory() + ", ISBN: " + book.getIsbn() + ", Publisher: "
					+ book.getPublisher() + ", Total Copies: " + book.getTotalCopies() + ", Available Copies: "
					+ book.getAvailableCopies());

			int result = ps.executeUpdate();

			if (result > 0) {
				System.out.println("✓ Book updated successfully in database!");
				return true;
			} else {
				System.out.println("✗ No rows affected. Book update failed.");
			}

		} catch (Exception e) {
			System.out.println("✗ Error updating book: " + e.getMessage());
			e.printStackTrace();
		} finally {
			try {
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return false;

	}

	public List<Book> getAllBooksList() {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {

			conn = DBUtil.getConnection();
			System.out.println("Database Connection: SUCCESS");
			String query = "SELECT * FROM books ORDER BY book_id DESC";
			System.out.println("SQL Query: " + query);
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			List<Book> books = new java.util.ArrayList<>();
			while (rs.next()) {
				Book book = new Book();
				book.setBookId(rs.getLong("book_id"));
				book.setTitle(rs.getString("title"));
				book.setAuthor(rs.getString("author"));
				book.setCategory(rs.getString("category"));
				book.setIsbn(rs.getString("isbn"));
				book.setPublisher(rs.getString("publisher"));
				book.setTotalCopies(rs.getInt("total_copies"));
				book.setAvailableCopies(rs.getInt("available_copies"));
				book.setCreatedAt(rs.getTimestamp("added_at"));
				book.setStatus(book.getAvailableCopies() > 0 ? 1 : 0);
				books.add(book);
			}

			System.out.println("✓ Books retrieved successfully from database! Total Books: " + books.size());
			return books;

		} catch (Exception e) {
			e.printStackTrace();
		}

		finally {
			try {
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	@Override
	public List<Book> getAllBookByStatus(String status) {
		// TODO Auto-generated method stub
		return null;
	}

	public Book getBookById(Long id) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {

			conn = DBUtil.getConnection();
			System.out.println("Database Connection: SUCCESS");
			String query = "SELECT * FROM books WHERE book_id = ?";

			System.out.println("SQL Query: " + query);
			ps = conn.prepareStatement(query);
			ps.setLong(1, id);
			rs = ps.executeQuery();

			while (rs.next()) {
				Book book = new Book();
				book.setBookId(rs.getLong("book_id"));
				book.setTitle(rs.getString("title"));
				book.setAuthor(rs.getString("author"));
				book.setCategory(rs.getString("category"));
				book.setIsbn(rs.getString("isbn"));
				book.setPublisher(rs.getString("publisher"));
				book.setTotalCopies(rs.getInt("total_copies"));
				book.setAvailableCopies(rs.getInt("available_copies"));
				book.setCreatedAt(rs.getTimestamp("added_at"));
				book.setStatus(book.getAvailableCopies() > 0 ? 1 : 0);
				return book;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		finally {
			try {
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return null;
	}

	@Override
	public boolean assignBook(BookIssued bookIssued) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			conn = DBUtil.getConnection();
			System.out.println("Database Connection: SUCCESS");

			String query = "INSERT INTO book_issued (book_id, user_id, issue_date, due_date, status , assignment_notes) "
					+ "VALUES (?, ?, ?, ?, ? , ?)";
			System.out.println("SQL Query: " + query);

			ps = conn.prepareStatement(query);
			ps.setLong(1, bookIssued.getBook().getBookId());
			ps.setLong(2, bookIssued.getUser().getUserId());
			ps.setTimestamp(3, new Timestamp(bookIssued.getIssueDate().getTime()));
			ps.setDate(4, java.sql.Date.valueOf(bookIssued.getDueDate()));
			ps.setString(5, bookIssued.getStatus());
			ps.setString(6, "Book assigned to user. Due on " + bookIssued.getDueDate());

			int result = ps.executeUpdate();

			if (result > 0) {
				System.out.println("✓ Book assigned successfully to user!");
				return true;
			} else {
				System.out.println("✗ No rows affected. Book assignment failed.");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return false;

	}

	@Override
	public boolean updateAvailableBook(Long bookId, int availableCopies) {
		// TODO Auto-generated method stub
		Connection conn = null;
		PreparedStatement ps = null;

		try {
			conn = DBUtil.getConnection();
			System.out.println("Database Connection: SUCCESS");

			String query = "UPDATE books SET available_copies = ? WHERE book_id = ?";
			System.out.println("SQL Query: " + query);

			ps = conn.prepareStatement(query);
			ps.setInt(1, availableCopies);
			ps.setLong(2, bookId);

			int result = ps.executeUpdate();

			if (result > 0) {
				System.out.println("✓ Book availability updated successfully! Remaining copies: " + availableCopies);
				return true;
			} else {
				System.out.println("✗ No rows affected. Book availability update failed.");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();

			}

		}
		return false;
	}

	@Override
	public List<Book> getAllAvailableBooksList() {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {

			conn = DBUtil.getConnection();
			System.out.println("Database Connection: SUCCESS");
			String query = "SELECT * FROM books where available_copies > 0 ORDER BY book_id DESC";
			System.out.println("SQL Query: " + query);

			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();

			ArrayList<Book> bookList = new ArrayList<>();

			while (rs.next()) {
				Book book = new Book();
				book.setBookId(rs.getLong("book_id"));
				book.setTitle(rs.getString("title"));
				book.setAuthor(rs.getString("author"));
				book.setCategory(rs.getString("category"));
				book.setIsbn(rs.getString("isbn"));
				book.setPublisher(rs.getString("publisher"));
				book.setTotalCopies(rs.getInt("total_copies"));
				book.setAvailableCopies(rs.getInt("available_copies"));
				book.setStatus(rs.getInt("available_copies") > 0 ? 1 : 0);

				bookList.add(book);
			}

			return bookList;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return new ArrayList<>();
	}

	@Override
	public List<BookIssued> getAllIssuedBooksList() {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<BookIssued> issuedBooksList = new ArrayList<>();

		try {

			conn = DBUtil.getConnection();
			System.out.println("Database Connection: SUCCESS");
			String query = "SELECT bi.issue_id, bi.book_id, bi.user_id, bi.issue_date, bi.due_date, bi.return_date, bi.status, bi.assignment_notes, bi.book_condition, bi.return_notes,"
					+ " b.title, b.author, b.category, b.isbn, b.publisher, b.total_copies, b.available_copies,"
					+ " u.first_name, u.last_name, u.email, u.phone_no"
					+ " FROM book_issued bi"
					+ " JOIN books b ON bi.book_id = b.book_id"
					+ " JOIN users u ON bi.user_id = u.user_id"
					+ " WHERE bi.status = 'Issued'"
					+ " ORDER BY bi.issue_id DESC";

			System.out.println("SQL Query: " + query);

			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();

			while (rs.next()) {
				issuedBooksList.add(mapIssuedRecord(rs));
			}

			System.out.println("✓ Issued books retrieved successfully from database! Total Issued Books: "
					+ issuedBooksList.size());
			return issuedBooksList;

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return null;
	}

	private BookIssued mapIssuedRecord(ResultSet rs) throws Exception {
		BookIssued bookIssued = new BookIssued();
		bookIssued.setIssueId(rs.getInt("issue_id"));
		bookIssued.setIssueDate(rs.getTimestamp("issue_date"));
		bookIssued.setDueDate(rs.getDate("due_date").toLocalDate());
		bookIssued.setReturnDate(rs.getDate("return_date") != null ? rs.getDate("return_date").toLocalDate() : null);
		bookIssued.setStatus(rs.getString("status"));
		bookIssued.setBookCondition(rs.getString("book_condition"));
		bookIssued.setAssessmentNotes(rs.getString("assignment_notes"));
		bookIssued.setReturnNotes(rs.getString("return_notes"));

		Book book = new Book();
		book.setBookId(rs.getLong("book_id"));
		book.setTitle(rs.getString("title"));
		book.setAuthor(rs.getString("author"));
		book.setCategory(rs.getString("category"));
		book.setIsbn(rs.getString("isbn"));
		book.setPublisher(rs.getString("publisher"));
		book.setTotalCopies(rs.getInt("total_copies"));
		book.setAvailableCopies(rs.getInt("available_copies"));

		User user = new User();
		user.setUserId(rs.getLong("user_id"));
		user.setFirstName(rs.getString("first_name"));
		user.setLastName(rs.getString("last_name"));
		user.setEmail(rs.getString("email"));
		user.setPhoneNo(rs.getString("phone_no"));

		bookIssued.setBook(book);
		bookIssued.setUser(user);

		return bookIssued;

	}

	@Override
	public boolean updateBookReturn(BookIssued bookIssued) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			conn = DBUtil.getConnection();
			System.out.println("Database Connection: SUCCESS");

			String query = "UPDATE book_issued SET return_date = ?, status = ?, book_condition = ?, return_notes = ? "
					+ "WHERE issue_id = ?";
			System.out.println("SQL Query: " + query);

			ps = conn.prepareStatement(query);
			ps.setDate(1, java.sql.Date.valueOf(bookIssued.getReturnDate()));
			ps.setString(2, bookIssued.getStatus());
			ps.setString(3, bookIssued.getBookCondition());
			ps.setString(4, bookIssued.getReturnNotes());
			ps.setInt(5, bookIssued.getIssueId());

			int result = ps.executeUpdate();

			if (result > 0) {
				System.out.println("✓ Book return updated successfully in database!");
				return true;
			} else {
				System.out.println("✗ No rows affected. Book return update failed.");
				
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return false;
	}

	@Override
	public BookIssued getIssuedBookById(Long issueId) {

	    Connection conn = null;
	    PreparedStatement ps = null;
	    ResultSet rs = null;

	    try {
	        conn = DBUtil.getConnection();
	        System.out.println("Database Connection: SUCCESS");

	        String query =
	            "SELECT bi.issue_id, bi.book_id, bi.user_id, bi.issue_date, " +
	            "bi.due_date, bi.return_date, bi.status, bi.assignment_notes, " +
	            "bi.book_condition, bi.return_notes, " +
	            "b.title, b.author, b.category, b.isbn, b.publisher, " +
	            "b.total_copies, b.available_copies, " +
	            "u.first_name, u.last_name, u.email, u.phone_no " +
	            "FROM book_issued bi " +
	            "JOIN books b ON bi.book_id = b.book_id " +
	            "JOIN users u ON bi.user_id = u.user_id " +
	            "WHERE bi.issue_id = ?";

	        System.out.println("SQL Query: " + query);

	        ps = conn.prepareStatement(query);
	        ps.setLong(1, issueId);

	        rs = ps.executeQuery();

	        if (rs.next()) {
	            return mapIssuedRecord(rs);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();

	    } finally {

	        try {
	            if (rs != null) rs.close();
	            if (ps != null) ps.close();
	            if (conn != null) conn.close();

	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }

	    return null;
	}

	@Override
	public List<BookIssued> getIssuedBooksByUserId() {
		// TODO Auto-generated method stub
		return null;
	}		
	

}