<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Return Book | LMS</title>
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@400;500;600;700&display=swap"
	rel="stylesheet" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/showRetunBookDetails.css">
</head>
<body>

	<!-- ── Entry Loader ── -->
	<div class="entry-loader" id="entryLoader" aria-live="polite"
		aria-label="Loading return book page">
		<div class="loader-card">
			<div class="loader-icon" aria-hidden="true">
				<svg viewBox="0 0 24 24">
					<path d="M9 7l-5 5 5 5M20 12H5" /></svg>
			</div>
			<h1>Preparing Return Desk</h1>
			<p>Loading active loans and member records.</p>
			<div class="loader-bars" aria-hidden="true">
				<span></span><span></span><span></span>
			</div>
		</div>
	</div>

	<!-- ── Ambient Orbs ── -->
	<div class="ambient" aria-hidden="true">
		<span class="orb orb-a"></span> <span class="orb orb-b"></span> <span
			class="orb orb-c"></span>
	</div>

	<!-- ── Toast Area ── -->
	<div class="toast-wrap" id="toastWrap" aria-live="assertive"></div>

	<!-- ── Return Confirm Modal ── -->
	<div class="modal-overlay" id="modalOverlay" role="dialog"
		aria-modal="true" aria-labelledby="modalTitle">
		<div class="modal">
			<div class="modal-header">
				<h3 id="modalTitle">Confirm Book Return</h3>
				<button class="modal-close" id="modalClose" aria-label="Close">✕</button>
			</div>
			<div class="modal-body">
				<ul class="modal-meta" id="modalMeta"></ul>
				<div class="modal-actions">
					<button class="btn-cancel" id="modalCancel">Cancel</button>
					<button class="btn-confirm" id="modalConfirm">
						<svg
							style="width: 13px; height: 13px; stroke: #fff; stroke-width: 2; stroke-linecap: round; stroke-linejoin: round; fill: none; display: inline-block; vertical-align: middle; margin-right: 0.3rem"
							viewBox="0 0 24 24">
							<path d="M20 6L9 17l-5-5" /></svg>
						Confirm Return
					</button>
				</div>
			</div>
		</div>
	</div>

	<!-- ── App Shell ── -->
	<div class="app-shell" id="appShell">

		<!-- Sidebar -->
		<aside class="sidebar reveal" data-reveal>
			<div class="brand">
				<div class="brand-mark" aria-hidden="true">📚</div>
				<div class="brand-text">
					<strong>Library</strong> <span>Management System</span>
				</div>
			</div>

			<nav class="nav-section" aria-label="Primary navigation">
				<a class="nav-link" href="${pageContext.request.contextPath}/DashboardController?action=viewDashboard"> <span class="nav-icon"
					aria-hidden="true"> <svg viewBox="0 0 24 24">
							<path d="M4 13h6v7H4zm10-9h6v16h-6zM4 4h6v7H4z" /></svg>
				</span> <span>Dashboard</span>
				</a> <a class="nav-link" href="${pageContext.request.contextPath}/BookController?action=showAssignBook"> <span
					class="nav-icon" aria-hidden="true"> <svg
							viewBox="0 0 24 24">
							<path d="M12 4v16M4 12h16" /></svg>
				</span> <span>Assign Book</span>
				</a> <a class="nav-link active" href="${pageContext.request.contextPath}/BookController?action=showReturnBook"> <span
					class="nav-icon" aria-hidden="true"> <svg
							viewBox="0 0 24 24">
							<path d="M9 7l-5 5 5 5M20 12H5" /></svg>
				</span> <span>Return Book</span>
				</a> <a class="nav-link" href="${pageContext.request.contextPath}/BookController?action=showBooklist"> <span class="nav-icon"
					aria-hidden="true"> <svg viewBox="0 0 24 24">
							<path d="M4 6h14v12H4zM18 8h2v8h-2" /></svg>
				</span> <span>Books</span>
				</a> <a class="nav-link" href="${pageContext.request.contextPath}/BookController?action=showAddBook"> <span class="nav-icon"
					aria-hidden="true"> <svg viewBox="0 0 24 24">
							<path d="M4 8h10v12H4zM14 8h6M17 5v6" /></svg>
				</span> <span>Add Book</span>
				</a> <a class="nav-link" href="${pageContext.request.contextPath}/UserController?action=showUserList"> <span class="nav-icon"
					aria-hidden="true"> <svg viewBox="0 0 24 24">
							<path d="M16 19v-1a4 4 0 00-8 0v1M12 11a3 3 0 100-6 3 3 0 000 6z" /></svg>
				</span> <span>Users</span>
				</a> <a class="nav-link" href="${pageContext.request.contextPath}/UserController?action=showAddUser"> <span class="nav-icon"
					aria-hidden="true"> <svg viewBox="0 0 24 24">
							<path
								d="M16 19v-1a4 4 0 00-8 0v1M12 11a3 3 0 100-6 3 3 0 000 6zM20 8v6M17 11h6" /></svg>
				</span> <span>Add User</span>
				</a> <a class="nav-link" href="${pageContext.request.contextPath}/jsp/error.jsp"> <span class="nav-icon"
					aria-hidden="true"> <svg viewBox="0 0 24 24">
							<path d="M4 19h16M7 15l2-3 3 2 4-6 2 3" /></svg>
				</span> <span>Reports</span>
				</a>
			</nav>
		</aside>

		<!-- Main -->
		<main class="main reveal" data-reveal>

			<!-- Topbar -->
			<header class="topbar">
				<div>
					<div class="topbar-title">Circulation Module</div>
					<h1 class="heading-with-icon">
						<span class="dashboard-logo" aria-hidden="true"> <svg
								viewBox="0 0 24 24">
                <path d="M9 7l-5 5 5 5M20 12H5" />
              </svg>
						</span> <span>Return Book Detail</span>
					</h1>
				</div>
				<div class="topbar-actions">
					<a class="ghost-link" href="${pageContext.request.contextPath}/DashboardController?action=viewDashboard">← Dashboard</a>
					<div class="welcome-pill">Admin Panel</div>
				</div>
			</header>

			<!-- Content -->
			<section class="content">

				<header class="page-header reveal" data-reveal>
					<div>
						<p class="section-kicker">Circulation</p>
						<h2>Return Book Detail</h2>
						<p>Verify book condition and capture notes before completing
							the return.</p>
					</div>
					<a class="ghost-link back-link" href="${pageContext.request.contextPath}/BookController?action=showReturnBook">← Back to
						Returns</a>
				</header>

				<c:if test="${not empty errorMessage}">
					<div class="alert alert-danger alert-dismissible fade show"
						role="alert" style="margin-bottom: 1.5rem;">
						<c:out value="${errorMessage}" />
						<button type="button" class="btn-close" data-bs-dismiss="alert"
							aria-label="Close"></button>
					</div>
				</c:if>

				<c:set var="flashSuccessMessage"
					value="${sessionScope.flashSuccess}" />
				<c:remove var="flashSuccess" scope="session" />

				<section class="detail-grid">
					<article class="card form-card reveal" data-reveal>
						<header class="card-header"
							style="padding: 0 0 0.85rem; border-bottom: 1px solid #e1d2f5; margin-bottom: 0.95rem;">
							<div>
								<h3>Finalize Return</h3>
								<p>Update the member record before confirming.</p>
							</div>
							<span class="chip">Required</span>
						</header>

						<div class="detail-summary">
							<div class="detail-header">
								<div class="detail-cover" aria-hidden="true">📘</div>
								<div>
									<h3 class="detail-title" id="bookTitle" name="bookTitle">${bookIssued.book.title}</h3>
									<p class="detail-subtitle" name="author">${bookIssued.book.author}</p>
									<div class="detail-meta">
										<span name="loan">Active Loan</span> <span name="dueDate">Due
											${bookIssued.dueDate}</span>
									</div>
								</div>
							</div>

							<div class="detail-table-wrap">
								<table class="detail-table">
									<tbody>
										<tr>
											<th scope="row" name="isbn">ISBN</th>
											<td><code>${bookIssued.book.isbn}</code></td>
										</tr>
										<tr>
											<th scope="row" name="issuedDAte">Issued On</th>
											<td>${bookIssued.issueDate}</td>
										</tr>
										<tr>
											<th scope="row" name="returnDate">Return Due</th>
											<td>${bookIssued.dueDate}</td>
										</tr>
										<tr>
											<th scope="row">Borrower</th>
											<td id="memberName" name="lastName">${bookIssued.user.firstName}
												${bookIssued.user.lastName}</td>
										</tr>
										<tr>
											<th scope="row">Email</th>
											<td name="email">${bookIssued.user.email}</td>
										</tr>
										<tr>
											<th scope="row">Status</th>
											<td><span class="badge badge-due">Active</span></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>


						<form class="return-form" id="returnForm" method="post" action="${pageContext.request.contextPath}/BookController">
							<input type="hidden" name="action" value="returnBook" />
							<input type="hidden" name="issuedId" value="${bookIssued.issueId}" />
							<div class="form-grid">
								<div class="form-field">
									<label for="returnDate">Return Date</label> <input type="date"
										id="returnDate" value="2025-10-26" name="returnDate" required />
								</div>
								<div class="form-field">
									<label for="bookCondition">Book Condition</label> <select
										id="bookCondition" required name="bookCondition">
										<option value="good" selected>Good</option>
										<option value="fair">Fair</option>
										<option value="damaged">Damaged</option>
										<option value="lost">Lost</option>
									</select>
								</div>
							</div>

							<div class="form-field">
								<label for="returnNotes">Return Notes</label>
								<textarea id="returnNotes"
									placeholder="Record any damages or remarks." name="returnNotes"></textarea>
							</div>

							<div class="alert-note">
								<div class="alert-dot">i</div>
								<span>Record any damages or remarks in the notes to keep
									the member history up to date.</span>
							</div>

							<div class="form-actions">
								<button type="submit" class="btn-return">
									<svg viewBox="0 0 24 24">
										<path d="M20 6L9 17l-5-5" /></svg>
									Confirm Return
								</button>
							</div>
						</form>
					</article>
				</section>

				<!-- Signature -->
				<div class="form-signature reveal" data-reveal>
					<div class="signature-mark" aria-hidden="true">
						<svg viewBox="0 0 24 24">
              <path
								d="M3 6.5c2.2-1.6 4.4-1.6 6.6 0v10.8c-2.2-1.6-4.4-1.6-6.6 0z" />
              <path
								d="M21 6.5c-2.2-1.6-4.4-1.6-6.6 0v10.8c2.2-1.6 4.4-1.6 6.6 0z" />
              <path d="M9.6 9.2h4.8M9.6 12h4.8" />
            </svg>
					</div>
					<div class="signature-copy">
						<h4>Moonlight Stacks</h4>
						<blockquote>"A reader lives a thousand lives before
							he dies."</blockquote>
					</div>
				</div>

			</section>

			<footer class="footer-note"> Developed by Muhammad Ali Abid
				· Copyright © 2026 </footer>
		</main>
	</div>

	<script>
    /* ── Toast ── */
    function showToast(msg) {
      const wrap = document.getElementById("toastWrap");
      const t = document.createElement("div");
      t.className = "toast";
      t.innerHTML = `
        <div class="toast-icon" aria-hidden="true">
          <svg viewBox="0 0 24 24"><path d="M20 6L9 17l-5-5"/></svg>
        </div>
        <span>${msg}</span>`;
      wrap.appendChild(t);
      requestAnimationFrame(() => { requestAnimationFrame(() => t.classList.add("show")); });
      setTimeout(() => {
        t.classList.remove("show");
        setTimeout(() => t.remove(), 450);
      }, 3400);
    }

    /* ── Loader → reveal ── */
    window.addEventListener("DOMContentLoaded", () => {
      const form = document.getElementById("returnForm");
      const bookTitle = document.getElementById("bookTitle");
      const memberName = document.getElementById("memberName");

      form.addEventListener("submit", () => {
        showToast(`Return saved for "${bookTitle.textContent}" · ${memberName.textContent}`);
      });

      setTimeout(() => {
        document.body.classList.add("loaded");
        document.querySelectorAll("[data-reveal]").forEach((el, i) => {
          setTimeout(() => el.classList.add("visible"), i * 80);
        });
      }, 1200);
    });
  </script>
</body>
</html>
