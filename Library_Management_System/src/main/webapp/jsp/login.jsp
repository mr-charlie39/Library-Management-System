<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>LMS Login</title>
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@400;500;600;700&display=swap"
	rel="stylesheet" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/login.css">
</head>
<body>
	<main class="page-shell">
		<section class="auth-layout">
			<aside class="visual-panel" aria-hidden="true">
				<div class="panel-badge">LMS Portal</div>
				<h2>Knowledge in Motion</h2>
				<p>Track books, members, due dates, and returns with one
					connected dashboard for daily library operations.</p>

				<div class="quick-stats">
					<article>
						<strong>10k+</strong> <span>Books Managed</span>
					</article>
					<article>
						<strong>2.4k</strong> <span>Active Members</span>
					</article>
					<article>
						<strong>99.9%</strong> <span>System Uptime</span>
					</article>
				</div>

				<div class="project-points">
					<article>
						<h3>Book Catalog</h3>
						<p>Organize titles by category, author, language, and
							availability status.</p>
					</article>
					<article>
						<h3>Member Records</h3>
						<p>Maintain student and staff profiles with borrowing history
							and activity logs.</p>
					</article>
					<article>
						<h3>Issue And Return</h3>
						<p>Speed up circulation with quick issue, return, late fee,
							and reminder tracking.</p>
					</article>
				</div>

				<div class="project-meta">
					<span>Digital Catalog</span> <span>Circulation Control</span> <span>Reports
						And Insights</span>
				</div>

				<div class="book-stack">
					<span></span> <span></span> <span></span>
				</div>
			</aside>

			<section class="login-card" aria-labelledby="login-title">
				<div class="top-logo" aria-hidden="true">
					<svg viewBox="0 0 88 88" role="img">
              <defs>
                <linearGradient id="crestFill" x1="0%" y1="0%" x2="100%"
							y2="100%">
                  <stop offset="0%" stop-color="#bf9cff" />
                  <stop offset="100%" stop-color="#6d34c4" />
                </linearGradient>
              </defs>
              <path
							d="M44 6c13 8 24 9 33 10 0 35-7 51-33 66C18 67 11 51 11 16c9-1 20-2 33-10z"
							fill="url(#crestFill)" />
              <path
							d="M44 16c8 5 15 6 21 7 0 24-5 35-21 47-16-12-21-23-21-47 6-1 13-2 21-7z"
							fill="#f6efff" />
              <path d="M34 33h20M34 42h20M34 51h13" stroke="#443030"
							stroke-width="3" stroke-linecap="round" stroke-linejoin="round" />
              <path d="M55 52l8 8" stroke="#7f5f35" stroke-width="4"
							stroke-linecap="round" />
            </svg>
				</div>

				<div class="brand-row">
					<div class="brand-copy">
						<p class="eyebrow">Library Management System</p>
						<h1 id="login-title">Sign In</h1>
					</div>
				</div>

				<p class="subtitle">Access your librarian dashboard and manage
					your collection.</p>

				<div class="trust-row" aria-hidden="true">
					<span>Secure Access</span> <span>Fast Login</span> <span>Role
						Based</span>
				</div>

				<c:set var="flashSuccessMessage" value="${sessionScope.flashSuccess}" />
				<c:remove var="flashSuccess" scope="session" />
				<c:if test="${not empty flashSuccessMessage}">
					<div class="alert alert-success alert-dismissible fade show" role="alert">
						<c:out value="${flashSuccessMessage}" />
						<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
					</div>
				</c:if>

				<c:if test="${not empty errorMessage}">
					<div class="alert alert-danger alert-dismissible fade show"
						role="alert">
						<c:out value="${errorMessage}" />
						<button type="button" class="btn-close" data-bs-dismiss="alert"
							aria-label="Close"></button>
					</div>
				</c:if>

				<form class="login-form"
					action="${pageContext.request.contextPath}/Authentication"
					method="post">
					<input type="hidden" name="action" value="checklogin"> <label
						for="username">Username</label> <input id="username"
						name="username" type="text" placeholder="Enter your username"
						required />

					<div class="text-danger small" id="usernameError"></div>

					<label for="password">Password</label>
					<div class="password-wrap">
						<input id="password" name="password" type="password"
							placeholder="Enter your password" required />
						<div class="text-danger small" id="passwordError"></div>
						<button class="toggle-password" type="button" id="togglePassword"
							aria-label="Show password" aria-pressed="false">
							<svg class="eye-open" viewBox="0 0 24 24" aria-hidden="true">
                  <path
									d="M1.5 12s3.9-6.5 10.5-6.5S22.5 12 22.5 12s-3.9 6.5-10.5 6.5S1.5 12 1.5 12z"
									fill="none" stroke="currentColor" stroke-width="1.9"
									stroke-linecap="round" stroke-linejoin="round" />
                  <circle cx="12" cy="12" r="3.2" fill="none"
									stroke="currentColor" stroke-width="1.9" />
                </svg>
							<svg class="eye-off" viewBox="0 0 24 24" aria-hidden="true">
                  <path
									d="M2 2l20 20M10.6 5.7A10.8 10.8 0 0112 5.5c6.6 0 10.5 6.5 10.5 6.5a17.3 17.3 0 01-4.1 4.8M6.7 6.7A17.5 17.5 0 001.5 12S5.4 18.5 12 18.5c1.4 0 2.7-.3 3.9-.7"
									fill="none" stroke="currentColor" stroke-width="1.9"
									stroke-linecap="round" stroke-linejoin="round" />
                </svg>
						</button>
					</div>

					<div class="form-meta">
						<label class="remember"> <input type="checkbox"
							name="remember" /> <span>Remember me</span>
						</label>
					</div>

					<button type="submit" class="sign-in-btn">
						<svg viewBox="0 0 24 24" aria-hidden="true">
                <path d="M13 4.5l6.5 7.5-6.5 7.5M4.5 12h14" fill="none"
								stroke="currentColor" stroke-width="2" stroke-linecap="round"
								stroke-linejoin="round" />
              </svg>
						<span>Sign In</span>
					</button>

					<div class="support-links">

						<p>
							Don't have an account? <a href="${pageContext.request.contextPath}/BookController?action=showsignup" class="text-link">Sign up
								here</a>
						</p>
					</div>

					<div class="security-note">
						<svg viewBox="0 0 24 24" aria-hidden="true">
                <path
								d="M12 3.2l7 2.9v5.1c0 5-2.9 8.8-7 10.6-4.1-1.8-7-5.6-7-10.6V6.1l7-2.9zm-2.2 8.7l1.6 1.6 2.9-3"
								fill="none" stroke="currentColor" stroke-width="1.8"
								stroke-linecap="round" stroke-linejoin="round" />
              </svg>
						<span>Protected sign-in with encrypted session handling.</span>
					</div>
				</form>
			</section>
		</section>
	</main>
	<footer class="page-credit">
		<p>Developed by Muhammad Ali Abid</p>
		<p>Copyright © 2026. All rights reserved.</p>
	</footer>
	<script>
		document.addEventListener("DOMContentLoaded", function() {

			/* ── Password visibility toggle ── */
			const passwordInput = document.getElementById("password");
			const togglePassword = document.getElementById("togglePassword");

			togglePassword.addEventListener("click", function() {
				const shouldShow = passwordInput.type === "password";
				passwordInput.type = shouldShow ? "text" : "password";
				this.setAttribute("aria-pressed", String(shouldShow));
				this.setAttribute("aria-label", shouldShow ? "Hide password"
						: "Show password");
			});

			/* ── Form validation on submit ── */
			const form = document.querySelector(".login-form");
			const usernameInput = document.getElementById("username");
			const usernameError = document.getElementById("usernameError");
			const passwordError = document.getElementById("passwordError");

			form.addEventListener("submit", function(event) {
				// Clear previous errors
				usernameError.textContent = "";
				passwordError.textContent = "";

				const username = usernameInput.value.trim();
				const password = passwordInput.value.trim();
				let hasError = false;

				if (!username) {
					usernameError.textContent = "Please enter your username.";
					hasError = true;
				}

				if (!password) {
					passwordError.textContent = "Please enter your password.";
					hasError = true;
				}

				if (hasError) {
					event.preventDefault(); // Stop form submission
				}
			});

		});
	</script>
</body>
</html>