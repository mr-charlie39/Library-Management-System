package com.lms.filter;

import java.io.IOException;

import jakarta.servlet.FilterChain;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpServletResponse;
@WebFilter("/*")

public class AuthFilter implements jakarta.servlet.Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterchain)
			throws IOException, ServletException {
		HttpServletRequest httpServletRequest = (HttpServletRequest) request;
		HttpServletResponse httpServletResponse = (HttpServletResponse) response;

		String url = httpServletRequest.getRequestURI();
		String contextPath = httpServletRequest.getContextPath();
		String action = httpServletRequest.getParameter("action");
		HttpSession session = httpServletRequest.getSession(false);

		boolean loggedIn = (session != null && session.getAttribute("user") != null);
		boolean isRoot = url.equals(contextPath + "/");
		boolean isLoginPage = url.equals(contextPath + "/jsp/login.jsp");
		boolean isAuthEndpoint = url.equals(contextPath + "/Authentication");
		boolean isStaticAsset = url.startsWith(contextPath + "/assets/");
		boolean isJspRequest = url.startsWith(contextPath + "/jsp/");
		boolean isDirectJsp = isJspRequest && !isLoginPage;
		boolean isAuthLoginAction = isAuthEndpoint
				&& ("showLoginPage".equalsIgnoreCase(action) || "showsignup".equalsIgnoreCase(action)
				|| "checklogin".equalsIgnoreCase(action));
		boolean isBookLoginAction = url.equals(contextPath + "/BookController")
				&& ("showLogin".equalsIgnoreCase(action) || "showsignup".equalsIgnoreCase(action));
		boolean isLoginUiRequest = isLoginPage || isAuthLoginAction || isBookLoginAction;
		boolean allowedRequest = isRoot || isLoginPage || isAuthEndpoint || isStaticAsset;

		if (loggedIn && isLoginUiRequest) {
			httpServletResponse.sendRedirect(contextPath + "/DashboardController?action=viewDashboard");
			return;
		}

		if (isDirectJsp) {
			if (loggedIn) {
				httpServletResponse.sendError(HttpServletResponse.SC_NOT_FOUND);
			} else {
				RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/login.jsp");
				dispatcher.forward(request, response);
			}
			return;
		}

		if (loggedIn || allowedRequest) {
			filterchain.doFilter(request, response);
		} else {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/login.jsp");
			dispatcher.forward(request, response);
		}
	}

}