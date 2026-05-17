package com.lms.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;

import com.lms.pojo.Book;
import com.lms.pojo.BookIssued;
import com.lms.pojo.User;
import com.lms.service.BookService;
import com.lms.service.UserService;
import com.lms.servicelmpl.BookServicelmpl;
import com.lms.servicelmpl.UserServiceImpl;

@WebServlet("/BookController")
public class BookController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // ─────────────────────────────────────────────────────────────────────────
    // doGet  → navigation / read actions
    // doPost → form submissions that create or modify data
    // ─────────────────────────────────────────────────────────────────────────

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	HttpSession session = request.getSession(false);
		boolean loggedIn = (session != null && session.getAttribute("user") != null);

        String action = request.getParameter("action");
        System.out.println("[BookController GET] action=" + action);

        // FIX #1 — null or blank action goes to error.jsp, not dashboard
        if (action == null || action.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/jsp/error.jsp");
            return;
        }

        if (loggedIn && ("showLogin".equalsIgnoreCase(action)
        		|| "showsignup".equalsIgnoreCase(action))) {
        	response.sendRedirect(request.getContextPath() + "/DashboardController?action=viewDashboard");
        	return;
        }

       
        request.removeAttribute("errorMessage");

        if ("showAddBook".equalsIgnoreCase(action)) {
           
            request.getRequestDispatcher("/jsp/addBook.jsp").forward(request, response);

        } else if ("showLogin".equalsIgnoreCase(action)) {
           
            request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
            

        } else if ("showsignup".equalsIgnoreCase(action)) {
        	
        				
			request.getRequestDispatcher("/jsp/includes/signup.jsp").forward(request, response);
        } else if ("showDashboard".equalsIgnoreCase(action)) {
           
            response.sendRedirect(request.getContextPath() + "/DashboardController?action=viewDashboard");

        } else if ("showBooklist".equalsIgnoreCase(action)) {
          
            BookService bookService = new BookServicelmpl();
            List<Book> books = bookService.getAllBooksList();
            request.setAttribute("books", books);
            request.getRequestDispatcher("/jsp/booklist.jsp").forward(request, response);

        } else if ("showAssignBook".equalsIgnoreCase(action)) {
            
            UserService userService = new UserServiceImpl();
            BookService bookService = new BookServicelmpl();

            List<Book> bookList = bookService.getAllAllAvailableBooksList();
            List<User> userList = userService.getAllUsersList();

            if (bookList != null && !bookList.isEmpty() && userList != null && !userList.isEmpty()) {
                request.setAttribute("bookList", bookList);
                request.setAttribute("userList", userList);
            } else {
                request.setAttribute("errorMessage",
                        "Either no available books or no users found. Please try again.");
            }
            request.getRequestDispatcher("/jsp/assignbook.jsp").forward(request, response);

        } else if ("viewedit".equalsIgnoreCase(action)) {
            // ── Open Edit Book page for a specific book ───────────────────────
            String bookIdParam = request.getParameter("bookId");
            if (bookIdParam == null || bookIdParam.isBlank()) {
                request.getSession().setAttribute("flashError", "No book ID provided.");
                response.sendRedirect(request.getContextPath() + "/BookController?action=showBooklist");
                return;
            }

            try {
                long bookId = Long.parseLong(bookIdParam);
                BookService bookService = new BookServicelmpl();
                Book book = bookService.getBookById(bookId);

                if (book != null) {
                    request.setAttribute("book", book);
                    request.getRequestDispatcher("/jsp/editbook.jsp").forward(request, response);
                } else {
                    System.out.println("[BookController] No book found for ID: " + bookId);
                    request.getSession().setAttribute("flashError", "Book not found with ID: " + bookId);
                    response.sendRedirect(request.getContextPath() + "/BookController?action=showBooklist");
                }
            } catch (NumberFormatException e) {
                System.out.println("[BookController] Invalid bookId format: " + bookIdParam);
                request.getSession().setAttribute("flashError", "Invalid book ID format.");
                response.sendRedirect(request.getContextPath() + "/BookController?action=showBooklist");
            }

        } else if ("assignBook".equalsIgnoreCase(action)) {
            // ── Process book assignment ───────────────────────────────────────
            try {
                long bookId = Long.parseLong(request.getParameter("bookId"));
                long userId = Long.parseLong(request.getParameter("userId"));
                String dueDate        = request.getParameter("dueDate");
                String assignmentNotes = request.getParameter("assignmentNotes");

                Book book = new Book();
                book.setBookId(bookId);

                User user = new User();
                user.setUserId(userId);

                BookIssued bookIssued = new BookIssued();
                bookIssued.setBook(book);
                bookIssued.setUser(user);

                DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                LocalDate localDueDate = null;
                try {
                    localDueDate = LocalDate.parse(dueDate, dateFormatter);
                    System.out.println("[BookController] Parsed dueDate: " + localDueDate);
                } catch (DateTimeParseException e) {
                    System.err.println("[BookController] Error parsing dueDate: " + e.getMessage());
                    request.setAttribute("errorMessage", "Invalid due date format. Please use YYYY-MM-DD.");
                    request.getRequestDispatcher("/jsp/assignbook.jsp").forward(request, response);
                    return;
                }

                bookIssued.setDueDate(localDueDate);
                // FIX #2 — was getAssessmentNotes(value), must be set
                bookIssued.setAssessmentNotes(assignmentNotes);

                BookService bookService = new BookServicelmpl();
                boolean assignFlag = bookService.assignBook(bookIssued);

                if (assignFlag) {
                    request.getSession().setAttribute("successMessage", "Book assigned successfully!");
                    response.sendRedirect(
                            request.getContextPath() + "/BookController?action=showAssignBook");
                } else {
                    request.setAttribute("errorMessage", "Book not assigned. Please try again.");
                    request.getRequestDispatcher("/jsp/assignbook.jsp").forward(request, response);
                }

            } catch (NumberFormatException e) {
                System.err.println("[BookController] Invalid bookId or userId: " + e.getMessage());
                request.setAttribute("errorMessage", "Invalid book or user selection.");
                request.getRequestDispatcher("/jsp/assignbook.jsp").forward(request, response);
            }

        } else if ("showReturnBook".equalsIgnoreCase(action)) {
            // ── List all currently issued books ───────────────────────────────
            BookService bookService = new BookServicelmpl();
            List<BookIssued> issuedBooks = bookService.getAllIssuedBooksList();

            // FIX #3 — was (|| ) which caused NullPointerException when list was null.
            //          Must be (&& !isEmpty()) so the null check short-circuits safely.
            if (issuedBooks != null && !issuedBooks.isEmpty()) {
                LocalDate today = LocalDate.now();

                for (BookIssued bi : issuedBooks) {
                    LocalDate dueDate = bi.getDueDate();
                    if (dueDate == null) {
                        bi.setIssuedStatus("Unknown");
                    } else if (dueDate.isBefore(today)) {
                        bi.setIssuedStatus("Overdue");
                    } else if (dueDate.isEqual(today)) {
                        bi.setIssuedStatus("Due Today");
                    } else {
                        bi.setIssuedStatus("Active");
                    }
                }

                request.setAttribute("issuedBooks", issuedBooks);
                request.getRequestDispatcher("/jsp/returnbook.jsp").forward(request, response);

            } else {
                request.setAttribute("errorMessage", "No issued books found.");
                request.getRequestDispatcher("/jsp/returnbook.jsp").forward(request, response);
            }

        } else if ("showReturnBookDetails".equalsIgnoreCase(action)) {
            // ── Show details page for a specific issued book ──────────────────
            String issuedIdParam = request.getParameter("issuedId");
            if (issuedIdParam == null || issuedIdParam.isBlank()) {
                request.setAttribute("errorMessage", "No issued book ID provided.");
                request.getRequestDispatcher("/jsp/returnbook.jsp").forward(request, response);
                return;
            }

            try {
                long bookIssuedId = Long.parseLong(issuedIdParam);
                BookService bookService = new BookServicelmpl();
                BookIssued bookIssued  = bookService.getIssuedBookById(bookIssuedId);

                if (bookIssued != null) {
                    request.setAttribute("bookIssued", bookIssued);
                    request.getRequestDispatcher("/jsp/showReturnBookDetails.jsp").forward(request, response);
                } else {
                    request.setAttribute("errorMessage",
                            "No details found for the selected issued book. Please try again.");
                    request.getRequestDispatcher("/jsp/returnbook.jsp").forward(request, response);
                }
            } catch (NumberFormatException e) {
                System.err.println("[BookController] Invalid issuedId format: " + issuedIdParam);
                request.setAttribute("errorMessage", "Invalid issued book ID.");
                request.getRequestDispatcher("/jsp/returnbook.jsp").forward(request, response);
            }

        } else if ("returnBook".equalsIgnoreCase(action)) {
            // ── Process a book return ─────────────────────────────────────────
            String issuedIdParam = request.getParameter("issuedId");
            String returnDate    = request.getParameter("returnDate");
            String bookCondition = request.getParameter("bookCondition");
            String returnNotes   = request.getParameter("returnNotes");

            if (issuedIdParam == null || issuedIdParam.isBlank()) {
                request.setAttribute("errorMessage", "Missing issued book ID.");
                request.getRequestDispatcher("/jsp/returnbookdetails.jsp").forward(request, response);
                return;
            }

            try {
                int issuedId = Integer.parseInt(issuedIdParam);

                DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                LocalDate localReturnDate = null;
                try {
                    localReturnDate = LocalDate.parse(returnDate, dateFormatter);
                } catch (DateTimeParseException e) {
                    System.err.println("[BookController] Error parsing returnDate: " + e.getMessage());
                    request.setAttribute("errorMessage", "Invalid return date format. Please use YYYY-MM-DD.");
                    request.getRequestDispatcher("/jsp/returnbookdetails.jsp").forward(request, response);
                    return;
                }

                BookIssued bookIssued = new BookIssued();
                bookIssued.setIssueId(issuedId);
                bookIssued.setReturnDate(localReturnDate);
                bookIssued.setBookCondition(bookCondition);
                bookIssued.setReturnNotes(returnNotes);

                BookService bookService = new BookServicelmpl();
                boolean returnFlag = bookService.updateBookReturn(bookIssued);

                if (returnFlag) {
                    request.getSession().setAttribute("flashSuccess", "Book returned successfully.");
                    response.sendRedirect(
                            request.getContextPath() + "/BookController?action=showReturnBook");
                } else {
                    request.setAttribute("errorMessage", "Failed to return book. Please try again.");
                    request.getRequestDispatcher("/jsp/returnbookdetails.jsp").forward(request, response);
                }

            } catch (NumberFormatException e) {
                System.err.println("[BookController] Invalid issuedId: " + issuedIdParam);
                request.setAttribute("errorMessage", "Invalid issued book ID format.");
                request.getRequestDispatcher("/jsp/returnbookdetails.jsp").forward(request, response);
            }

        } else {
            // ── Unknown action → error page ───────────────────────────────────
            System.out.println("[BookController] Unknown GET action: " + action);
            response.sendRedirect(request.getContextPath() + "/jsp/error.jsp");
        }
    }

    // ─────────────────────────────────────────────────────────────────────────
    // doPost — handles form submissions only
    // ─────────────────────────────────────────────────────────────────────────

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");
		System.out.println("[BookController POST] action=" + action);

		if ("addBook".equalsIgnoreCase(action)) {
			handleAddBook(request, response);
		} else if ("updateBook".equalsIgnoreCase(action)) {
			handleUpdateBook(request, response);
		} else if ("returnBook".equalsIgnoreCase(action)) {
			doGet(request, response);
		} else {
			// Unknown POST action → error page
			System.out.println("[BookController] Unknown POST action: " + action);
			response.sendRedirect(request.getContextPath() + "/jsp/error.jsp");
		}
	}

    // ─────────────────────────────────────────────────────────────────────────
    // handleAddBook — validates and persists a new book
    // ─────────────────────────────────────────────────────────────────────────

    private void handleAddBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String title               = trim(request.getParameter("bookTitle"));
        String author              = trim(request.getParameter("author"));
        String category            = trim(request.getParameter("category"));
        String isbn                = trim(request.getParameter("isbn"));
        String publisher           = trim(request.getParameter("publisher"));
        String totalCopiesStr      = trim(request.getParameter("totalCopies"));
        String availableCopiesStr  = trim(request.getParameter("availableCopies"));

        // ── Field-level validation ────────────────────────────────────────────
        if (isEmpty(title)) {
            forwardWithError(request, response, "Book Title is required.");
            return;
        }
        if (isEmpty(author)) {
            forwardWithError(request, response, "Author is required.");
            return;
        }
        if (isEmpty(category)) {
            forwardWithError(request, response, "Category is required.");
            return;
        }
        if (isEmpty(isbn)) {
            forwardWithError(request, response, "ISBN is required.");
            return;
        }
        if (!isbn.matches("\\d{10}|\\d{13}")) {
            forwardWithError(request, response, "ISBN must be exactly 10 or 13 digits.");
            return;
        }
        if (isEmpty(publisher)) {
            forwardWithError(request, response, "Publisher is required.");
            return;
        }
        if (isEmpty(totalCopiesStr)) {
            forwardWithError(request, response, "Total Copies is required.");
            return;
        }
        if (isEmpty(availableCopiesStr)) {
            forwardWithError(request, response, "Available Copies is required.");
            return;
        }

        try {
            int totalCopies     = Integer.parseInt(totalCopiesStr);
            int availableCopies = Integer.parseInt(availableCopiesStr);

            if (totalCopies < 1) {
                forwardWithError(request, response, "Total copies must be at least 1.");
                return;
            }
            if (availableCopies < 0) {
                forwardWithError(request, response, "Available copies cannot be negative.");
                return;
            }
            if (availableCopies > totalCopies) {
                forwardWithError(request, response, "Available copies cannot exceed total copies.");
                return;
            }

            // ── Build POJO only after all validation passes ───────────────────
            Book book = new Book();
            book.setTitle(title);
            book.setAuthor(author);
            book.setCategory(category);
            book.setIsbn(isbn);
            book.setPublisher(publisher);
            book.setTotalCopies(totalCopies);
            book.setAvailableCopies(availableCopies);
            book.setStatus(availableCopies > 0 ? 1 : 0);
            book.setCreatedAt(new Timestamp(System.currentTimeMillis()));

            BookService bookService = new BookServicelmpl();
            boolean flag = bookService.addBook(book);

            if (flag) {
                System.out.println("[BookController] Book added successfully.");
                List<Book> books = bookService.getAllBooksList();

                if (books != null && !books.isEmpty()) {
                    request.getSession().setAttribute("flashSuccess", "Book added successfully!");
                    response.sendRedirect(
                            request.getContextPath() + "/BookController?action=showBooklist");
                } else {
                    request.setAttribute("errorMessage",
                            "Book added but the book list could not be retrieved.");
                    request.getRequestDispatcher("/jsp/addBook.jsp").forward(request, response);
                }
            } else {
                System.out.println("[BookController] Book insertion failed.");
                request.setAttribute("errorMessage", "Failed to add book. Please try again.");
                request.getRequestDispatcher("/jsp/addBook.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            forwardWithError(request, response,
                    "Total Copies and Available Copies must be valid whole numbers.");
        } catch (Exception e) {
            e.printStackTrace();
            forwardWithError(request, response, "Unexpected error: " + e.getMessage());
        }
    }

    // ─────────────────────────────────────────────────────────────────────────
    // handleUpdateBook — validates and updates an existing book
    // ─────────────────────────────────────────────────────────────────────────

    private void handleUpdateBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String bookIdStr = trim(request.getParameter("bookId"));
        if (isEmpty(bookIdStr)) {
            request.getSession().setAttribute("flashError", "Missing book ID for update.");
            response.sendRedirect(request.getContextPath() + "/BookController?action=showBooklist");
            return;
        }

        String title              = trim(request.getParameter("title"));
        String author             = trim(request.getParameter("author"));
        String category           = trim(request.getParameter("category"));
        String isbn               = trim(request.getParameter("isbn"));
        String publisher          = trim(request.getParameter("publisher"));
        String totalCopiesStr     = trim(request.getParameter("totalCopies"));
        String availableCopiesStr = trim(request.getParameter("availableCopies"));

        if (isEmpty(title) || isEmpty(author) || isEmpty(category) || isEmpty(isbn)
                || isEmpty(publisher) || isEmpty(totalCopiesStr) || isEmpty(availableCopiesStr)) {
            forwardWithEditError(request, response, "All fields are required.");
            return;
        }

        if (!isbn.matches("\\d{10}|\\d{13}")) {
            forwardWithEditError(request, response, "ISBN must be exactly 10 or 13 digits.");
            return;
        }

        try {
            long bookId         = Long.parseLong(bookIdStr);
            int totalCopies     = Integer.parseInt(totalCopiesStr);
            int availableCopies = Integer.parseInt(availableCopiesStr);

            if (totalCopies < 1) {
                forwardWithEditError(request, response, "Total copies must be at least 1.");
                return;
            }
            if (availableCopies < 0) {
                forwardWithEditError(request, response, "Available copies cannot be negative.");
                return;
            }
            if (availableCopies > totalCopies) {
                forwardWithEditError(request, response,
                        "Available copies cannot exceed total copies.");
                return;
            }

            Book book = new Book();
            book.setBookId(bookId);
            book.setTitle(title);
            book.setAuthor(author);
            book.setCategory(category);
            book.setIsbn(isbn);
            book.setPublisher(publisher);
            book.setTotalCopies(totalCopies);
            book.setAvailableCopies(availableCopies);
            book.setStatus(availableCopies > 0 ? 1 : 0);

            BookService bookService = new BookServicelmpl();
            boolean flag = bookService.updateBook(book);

            if (flag) {
                request.getSession().setAttribute("flashSuccess", "Book updated successfully.");
                response.sendRedirect(
                        request.getContextPath() + "/BookController?action=showBooklist");
            } else {
                forwardWithEditError(request, response, "Update failed. Please try again.");
            }

        } catch (NumberFormatException e) {
            forwardWithEditError(request, response, "Invalid numeric value for copies or book ID.");
        } catch (Exception e) {
            e.printStackTrace();
            forwardWithEditError(request, response, "Unexpected error: " + e.getMessage());
        }
    }

    // ─────────────────────────────────────────────────────────────────────────
    // Utility helpers
    // ─────────────────────────────────────────────────────────────────────────

    /** Forward to addBook.jsp with an error message. */
    private void forwardWithError(HttpServletRequest req, HttpServletResponse res, String message)
            throws ServletException, IOException {
        req.setAttribute("errorMessage", message);
        req.getRequestDispatcher("/jsp/addBook.jsp").forward(req, res);
    }

    /** Forward to editbook.jsp preserving form values so the user doesn't lose their input. */
    private void forwardWithEditError(HttpServletRequest req, HttpServletResponse res, String message)
            throws ServletException, IOException {
        req.setAttribute("errorMessage", message);
        Book book = new Book();
        book.setBookId(parseLongSafe(req.getParameter("bookId")));
        book.setTitle(trim(req.getParameter("title")));
        book.setAuthor(trim(req.getParameter("author")));
        book.setCategory(trim(req.getParameter("category")));
        book.setIsbn(trim(req.getParameter("isbn")));
        book.setPublisher(trim(req.getParameter("publisher")));
        book.setTotalCopies(parseIntSafe(req.getParameter("totalCopies")));
        book.setAvailableCopies(parseIntSafe(req.getParameter("availableCopies")));
        req.setAttribute("book", book);
        req.getRequestDispatcher("/jsp/editbook.jsp").forward(req, res);
    }

    private static long parseLongSafe(String value) {
        try { return Long.parseLong(trim(value)); }
        catch (Exception e) { return 0L; }
    }

    private static int parseIntSafe(String value) {
        try { return Integer.parseInt(trim(value)); }
        catch (Exception e) { return 0; }
    }

    private static String trim(String s) {
        return s == null ? "" : s.trim();
    }

    private static boolean isEmpty(String s) {
        return s == null || s.isEmpty();
    }
}
