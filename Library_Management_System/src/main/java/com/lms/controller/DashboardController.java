package com.lms.controller;
import com.lms.service.DashboardService;
import com.lms.service.BookService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import com.lms.pojo.DashboardStats;
import com.lms.pojo.BookIssued;
import com.lms.servicelmpl.DashboardServicelmpl;
import com.lms.servicelmpl.BookServicelmpl;

/**
 * Servlet implementation class DashboardController
 */
@WebServlet("/DashboardController")
public class DashboardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DashboardController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String action = request.getParameter("action");
		
		if("viewDashboard".equalsIgnoreCase(action)) {
			DashboardService dashboardService = new DashboardServicelmpl();
			DashboardStats stats = dashboardService.fetchDashboardStats();
			request.setAttribute("dashboardStats", stats);

			BookService bookService = new BookServicelmpl();
			List<BookIssued> issuedBooks = bookService.getAllIssuedBooksList();
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
			}
			request.setAttribute("issuedBooks", issuedBooks);
			request.getRequestDispatcher("/jsp/dashboard.jsp").forward(request, response);
		} else {
			response.sendRedirect(request.getContextPath() + "/jsp/error.jsp");
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}