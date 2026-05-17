<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>LMS Dashboard</title>
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@400;500;600;700&display=swap"
	rel="stylesheet" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/dashboard.css">
</head>
<body>
	<div class="entry-loader" id="entryLoader" aria-live="polite"
		aria-label="Loading dashboard">
		<div class="loader-card">
			<div class="loader-icon" aria-hidden="true"></div>
			<h1>Preparing Dashboard</h1>
			<p>Syncing books, members, and circulation activity.</p>
			<div class="loader-bars" aria-hidden="true">
				<span></span> <span></span> <span></span>
			</div>
		</div>
	</div>

	<div class="app-shell" id="appShell">
		<aside class="sidebar reveal" data-reveal>
			<div class="brand">
				<div class="brand-mark" aria-hidden="true">📚</div>
				<div class="brand-text">
					<strong>Library</strong> <span>Management System</span>
				</div>
			</div>

			<nav class="nav-section" aria-label="Primary navigation">
				<a class="nav-link active"
					href="${pageContext.request.contextPath}/DashboardController?action=viewDashboard">
					<span class="nav-icon" aria-hidden="true"> <svg
							viewBox="0 0 24 24">
                <path d="M4 13h6v7H4zm10-9h6v16h-6zM4 4h6v7H4z" />
              </svg>
				</span> <span>Dashboard</span>
				</a> <a class="nav-link"
					href="${pageContext.request.contextPath}/BookController?action=showAssignBook">
					<span class="nav-icon" aria-hidden="true"> <svg
							viewBox="0 0 24 24">
                <path d="M12 4v16M4 12h16" />
              </svg>
				</span> <span>Assign Book</span>
				</a> <a class="nav-link"
					href="${pageContext.request.contextPath}/BookController?action=showReturnBook">
					<span class="nav-icon" aria-hidden="true"> <svg
							viewBox="0 0 24 24">
                <path d="M9 7l-5 5 5 5M20 12H5" />
              </svg>
				</span> <span>Return Book</span>
				</a> <a
					href="${pageContext.request.contextPath}/BookController?action=showBooklist"
					class="nav-link"> <span class="nav-icon" aria-hidden="true">
						<svg viewBox="0 0 24 24">
                <path d="M4 6h14v12H4zM18 8h2v8h-2" />
              </svg>
				</span> <span>Books</span>
				</a> <a class="nav-link"
					href="${pageContext.request.contextPath}/BookController?action=showAddBook">
					<span class="nav-icon" aria-hidden="true"> <svg
							viewBox="0 0 24 24">
                <path d="M4 8h10v12H4zM14 8h6M17 5v6" />
              </svg>
				</span> <span>Add Book</span>
				</a> <a class="nav-link"
					href="${pageContext.request.contextPath}/UserController?action=showUserList">
					<span class="nav-icon" aria-hidden="true"> <svg
							viewBox="0 0 24 24">
                <path
								d="M16 19v-1a4 4 0 00-8 0v1M12 11a3 3 0 100-6 3 3 0 000 6z" />
              </svg>
				</span> <span>Users</span>
				</a> <a class="nav-link"
					href="${pageContext.request.contextPath}/UserController?action=showAddUser">
					<span class="nav-icon" aria-hidden="true"> <svg
							viewBox="0 0 24 24">
                <path
								d="M16 19v-1a4 4 0 00-8 0v1M12 11a3 3 0 100-6 3 3 0 000 6zM20 8v6M17 11h6" />
              </svg>
				</span> <span>Add User</span>
				</a>
			</nav>
		</aside>
		<main class="main reveal" data-reveal>
			<header class="topbar">
				<div>
					<div class="topbar-title">Welcome Back</div>
					<h2 class="heading-with-icon">
						<span class="dashboard-logo" aria-hidden="true"> <svg
								viewBox="0 0 24 24">
                  <path d="M3 13h7v8H3zm11-10h7v18h-7zM3 3h7v8H3z" />
                </svg>
						</span> <span>Dashboard Overview</span>
					</h2>
				</div>
				<div class="topbar-actions">
					<label class="search" aria-label="Search books or users"> <input
						type="search" placeholder="Search books, users, ISBN..." />
					</label>
					<div class="welcome-pill">Welcome, ${user.firstName} ,
						${user.lastName}</div>
					<button class="signout-btn" type="button"
						onclick="window.location.href='${pageContext.request.contextPath}/BookController?action=showLogin'">
						Sign out</button>
				</div>
			</header>