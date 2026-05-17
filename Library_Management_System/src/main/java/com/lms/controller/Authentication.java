package com.lms.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.lms.pojo.User;
import com.lms.service.UserService;
import com.lms.servicelmpl.UserServiceImpl;

/**
 * Servlet implementation class Authentication
 */

public class Authentication extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Authentication() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		HttpSession session = request.getSession(false);
		boolean loggedIn = (session != null && session.getAttribute("user") != null);

		if (loggedIn && ("checklogin".equalsIgnoreCase(action)
				|| "showLoginPage".equalsIgnoreCase(action)
				|| "showsignup".equalsIgnoreCase(action))) {
			response.sendRedirect(request.getContextPath() + "/DashboardController?action=viewDashboard");
			return;
		}
		
		System.out.println("\n========== AUTHENTICATION REQUEST ==========");
		System.out.println("Request Method: " + request.getMethod());
		System.out.println("Action Parameter: " + action);
		System.out.println("Request URI: " + request.getRequestURI());
		
		if("checklogin".equalsIgnoreCase(action)) {
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			
			System.out.println("\n--- LOGIN ATTEMPT ---");
			System.out.println("Email/Username: " + username);
			System.out.println("Password: " + (password != null && !password.isEmpty() ? "****" : "[EMPTY]"));
			
			// Validation
			if(username == null || username.trim().isEmpty()) {
				System.out.println("✗ ERROR: Username is empty!");
				request.setAttribute("errorMessage", "Username is required");
				request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
				return;
			}
			
			if(password == null || password.trim().isEmpty()) {
				System.out.println("✗ ERROR: Password is empty!");
				request.setAttribute("errorMessage", "Password is required");
				request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
				return;
			}
			
			try {
				System.out.println("Attempting to authenticate...");
				UserService userService = new UserServiceImpl();
				User user = userService.checkLogin(username, password);
				
				if(user != null) {
					HttpSession newSession = request.getSession();
					newSession.setAttribute("user", user);
					
				    System.out.println("✓ LOGIN SUCCESSFUL!");
				    System.out.println("  - User ID: " + user.getUserId());
				    System.out.println("  - Email: " + user.getEmail());
				    System.out.println("  - Name: " + user.getFirstName() + " " + user.getLastName());
				    System.out.println("  - Role: " + user.getRole());
				    
				   
				    System.out.println("✓ Session created and user stored");
				    System.out.println("========== REDIRECTING TO DASHBOARD ==========\n");
				    response.sendRedirect(request.getContextPath() + "/DashboardController?action=viewDashboard");
				} else {
				    System.out.println("✗ LOGIN FAILED - Invalid credentials");
				    System.out.println("  No user found with email: " + username);
				    System.out.println("========== LOGIN FAILED ==========\n");
				    request.setAttribute("errorMessage", "Invalid username or password");
				    request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
				}
			} catch(Exception e) {
				System.out.println("✗ ERROR during authentication: " + e.getMessage());
				e.printStackTrace();
				System.out.println("========== LOGIN ERROR ==========\n");
				request.setAttribute("errorMessage", "An error occurred during login. Please try again.");
				request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
			}
		}else if("showLoginPage".equalsIgnoreCase(action)) {
			System.out.println("✓ SHOWING LOGIN PAGE");
			System.out.println("========== SHOW LOGIN PAGE ==========\n");
			request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
			
		} else if("showsignup".equalsIgnoreCase(action)) {
			System.out.println("\u2713 SHOWING SIGNUP PAGE");
			request.getRequestDispatcher("/jsp/includes/signup.jsp").forward(request, response);
		}
			else {
		
			response.sendRedirect(request.getContextPath() + "/jsp/error.jsp");
			System.out.println("✗ No valid action found. Action: " + action);
			System.out.println("========== INVALID ACTION ==========\n");
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