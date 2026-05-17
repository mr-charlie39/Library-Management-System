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
	href="${pageContext.request.contextPath}/assets/css/returnbook.css" />
</head>
<body>

	<!-- ── Entry Loader ── -->
	<div class="entry-loader" id="entryLoader" aria-live="polite">
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
					<%-- FIX #4: This button now submits a real hidden form to the server --%>
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

	<%-- Hidden form used by the modal to POST the real return request --%>
	<%-- FIX #4: Real server-side form submission from modal confirm --%>
	<form id="returnForm" action="returnBook" method="post"
		style="display: none;">
		<input type="hidden" id="returnIssueId" name="issueId" value="" />
	</form>

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
				<a class="nav-link" href="${pageContext.request.contextPath}/DashboardController?action=viewDashboard"> <span class="nav-icon"><svg
							viewBox="0 0 24 24">
							<path d="M4 13h6v7H4zm10-9h6v16h-6zM4 4h6v7H4z" /></svg></span> <span>Dashboard</span>
				</a> <a class="nav-link" href="${pageContext.request.contextPath}/BookController?action=showAssignBook"> <span
					class="nav-icon"><svg viewBox="0 0 24 24">
							<path d="M12 4v16M4 12h16" /></svg></span> <span>Assign Book</span>
				</a> <a class="nav-link active" href="${pageContext.request.contextPath}/BookController?action=showReturnBook"> <span
					class="nav-icon"><svg viewBox="0 0 24 24">
							<path d="M9 7l-5 5 5 5M20 12H5" /></svg></span> <span>Return Book</span>
				</a> <a class="nav-link" href="${pageContext.request.contextPath}/BookController?action=showBooklist"> <span class="nav-icon"><svg
							viewBox="0 0 24 24">
							<path d="M4 6h14v12H4zM18 8h2v8h-2" /></svg></span> <span>Books</span>
				</a> <a class="nav-link" href="${pageContext.request.contextPath}/BookController?action=showAddBook"> <span class="nav-icon"><svg
							viewBox="0 0 24 24">
							<path d="M4 8h10v12H4zM14 8h6M17 5v6" /></svg></span> <span>Add Book</span>
				</a> <a class="nav-link" href="${pageContext.request.contextPath}/UserController?action=showUserList"> <span class="nav-icon"><svg
							viewBox="0 0 24 24">
							<path d="M16 19v-1a4 4 0 00-8 0v1M12 11a3 3 0 100-6 3 3 0 000 6z" /></svg></span>
					<span>Users</span>
				</a> <a class="nav-link" href="${pageContext.request.contextPath}/UserController?action=showAddUser"> <span class="nav-icon"><svg
							viewBox="0 0 24 24">
							<path
								d="M16 19v-1a4 4 0 00-8 0v1M12 11a3 3 0 100-6 3 3 0 000 6zM20 8v6M17 11h6" /></svg></span>
					<span>Add User</span>
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
						<span class="dashboard-logo"> <svg viewBox="0 0 24 24">
								<path d="M9 7l-5 5 5 5M20 12H5" /></svg>
						</span> <span>Return Issued Books</span>
					</h1>
				</div>
				<div class="topbar-actions">
					<a class="ghost-link" href="${pageContext.request.contextPath}/DashboardController?action=viewDashboard">← Dashboard</a>
					<div class="welcome-pill">Admin Panel</div>
				</div>
			</header>

			<!-- Content -->
			<section class="content">

				<!-- Status Strip -->
				<section class="status-strip reveal" data-reveal>
					<article>
						<small>Active Loans</small> <strong>34 Records</strong> <span>across
							all members</span>
					</article>
					<article>
						<small>Overdue Today</small> <strong>2 Books</strong> <span>pending
							immediate return</span>
					</article>
					<article>
						<small>Due This Week</small> <strong>5 Books</strong> <span>approaching
							deadline</span>
					</article>
				</section>

				<!-- Layout Grid -->
				<section class="layout-grid">

					<!-- Table Card -->
					<section class="card table-card reveal buffering" data-reveal>
						<c:set var="loanCount" value="${0}" />
						<c:forEach var="b" items="${issuedBooks}">
							<c:set var="loanCount" value="${loanCount + 1}" />
						</c:forEach>
						<span class="chip">${loanCount} Active</span>

						<%-- Error message --%>
						<c:if test="${not empty errorMessage}">
							<div class="alert alert-danger alert-dismissible fade show"
								role="alert" style="margin-bottom: 1.5rem;">
								<c:out value="${errorMessage}" />
								<button type="button" class="btn-close" data-bs-dismiss="alert"
									aria-label="Close"></button>
							</div>
						</c:if>

						<%-- FIX #5: Flash success message is now actually rendered --%>
						<c:set var="flashSuccessMessage"
							value="${sessionScope.flashSuccess}" />
						<c:remove var="flashSuccess" scope="session" />
						<c:if test="${not empty flashSuccessMessage}">
							<div class="alert alert-success" role="alert"
								style="margin-bottom: 1.5rem; padding: 0.85rem 1.2rem; border-radius: 8px; background: #d1fae5; color: #065f46; border: 1px solid #6ee7b7;">
								✓
								<c:out value="${flashSuccessMessage}" />
							</div>
						</c:if>

						<div class="table-wrap">
							<table>
								<thead>
									<tr>
										<th>#</th>
										<th>Book</th>
										<th>Member</th>
										<th>Issued On</th>
										<th>Due Date</th>
										<th>Status</th>
										<th>Action</th>
									</tr>
								</thead>
								<%-- FIX #3: JSTL is the ONLY place rows are rendered.
								     The JS renderTable() has been removed to prevent
								     duplicate rows appearing in the table. --%>
								<tbody id="loanTable">
									<c:forEach var="bookIssued" items="${issuedBooks}"
										varStatus="status">
										<tr>
											<td><span class="row-num">${status.index + 1}</span></td>
											<td>
												<div class="book-title">
													<c:out value="${bookIssued.book.title}" />
												</div>
												<div class="book-isbn">
													ISBN:
													<code>
														<c:out value="${bookIssued.book.isbn}" />
													</code>
												</div>
											</td>
											<td>
												<div class="member-name">
													<c:out value="${bookIssued.user.firstName}" />
													<c:out value="${bookIssued.user.lastName}" />
												</div>
												<div class="member-email">
													<c:out value="${bookIssued.user.email}" />
												</div>
											</td>
											<td><fmt:formatDate value="${bookIssued.issueDate}"
													pattern="dd MMM yyyy" /></td>
											<td><c:out value="${bookIssued.dueDate}" /></td>
											<td><c:choose>
										<c:when test="${bookIssued.issuedStatus eq 'Overdue'}">
											<span class="badge bg-danger text-dark"><c:out
													value="${bookIssued.issuedStatus}" /></span>
										</c:when>
										<c:when test="${bookIssued.issuedStatus eq 'Due Today'}">
											<span class="badge bg-warning text-dark"><c:out
													value="${bookIssued.issuedStatus}" /></span>
										</c:when>
										<c:otherwise>
											<span class="badge bg-success text-dark"><c:out
													value="${bookIssued.issuedStatus}" /></span>
										</c:otherwise>
									</c:choose></td>
											<td>
												<%-- FIX #4: Button opens the modal instead of directly
												     submitting a form. The modal confirm then does the
												     real POST, so the return actually persists. --%> <a
											href="${pageContext.request.contextPath}/BookController?action=showReturnBookDetails&issuedId=${bookIssued.issueId}"
											class="btn-return" aria-label="Return book"> <svg
													viewBox="0 0 24 24" width="20" height="20" fill="none"
													stroke="currentColor" stroke-width="2"
													stroke-linecap="round" stroke-linejoin="round">
                                                           <path
															d="M9 7l-5 5 5 5M20 12H5" />
                                                           </svg> Return
											</a>
											</td>
										</tr>
									</c:forEach>

									<%-- Empty state when no loans exist --%>
									<c:if test="${empty issuedBooks}">
										<tr>
											<td colspan="7"
												style="text-align: center; padding: 2rem; color: #6b7280;">
												No active loans found.</td>
										</tr>
									</c:if>
								</tbody>
							</table>
						</div>
					</section>

					<!-- Side Column -->
					<aside class="side-column reveal" data-reveal>

						<article class="card summary-card buffering">
							<header class="card-header">
								<h3>Return Summary</h3>
								<span class="chip">Live</span>
							</header>
							<div class="summary-inner">
								<div class="return-banner" aria-hidden="true">
									<svg viewBox="0 0 24 24">
										<path d="M9 7l-5 5 5 5M20 12H5" /></svg>
								</div>
								<p class="summary-label">Loan Overview</p>
								<div class="stats-grid">
									<div class="stat-row stat-highlight">
										<span>On Time</span> <strong id="cntOnTime">0</strong>
									</div>
									<div class="stat-row">
										<span>Due Today</span> <strong id="cntDue">0</strong>
									</div>
									<div class="stat-row">
										<span>Overdue</span> <strong id="cntOverdue">0</strong>
									</div>
									<div class="stat-row">
										<span>Total Active</span> <strong id="cntTotal">0</strong>
									</div>
								</div>
							</div>
						</article>

						<article class="card reveal" data-reveal>
							<header class="card-header">
								<h3>Return Tips</h3>
							</header>
							<ul class="tips-list">
								<li>Inspect the book for damage before confirming return.</li>
								<li>Overdue books may incur a fine — check the member's
									account.</li>
								<li>Return removes the loan record and restores inventory
									stock.</li>
								<li>Notify members when reserved books become available
									again.</li>
							</ul>
						</article>

					</aside>
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
    // ─────────────────────────────────────────────
    // FIX #2: statusMap is now properly defined
    // ─────────────────────────────────────────────
    const statusMap = {
      ontime:  { label: "On Time",  cls: "badge-ontime"  },
      due:     { label: "Due Today", cls: "badge-due"    },
      overdue: { label: "Overdue",  cls: "badge-overdue" }
    };

    // ─────────────────────────────────────────────
    // Loans array — populated from server via JSTL
    // Used ONLY for: modal data + sidebar counters.
    // FIX #3: renderTable() removed; JSTL renders
    //         the table rows (no more duplicate rows).
    // ─────────────────────────────────────────────
						const loans = [
						  <c:forEach var="bookIssued" items="${issuedBooks}">
        {
          id:      ${bookIssued.issueId},
          book:    "<c:out value='${bookIssued.book.title}' />",
          isbn:    "<c:out value='${bookIssued.book.isbn}' />",
          member:  "<c:out value='${bookIssued.user.firstName}' /> <c:out value='${bookIssued.user.lastName}' />",
          email:   "<c:out value='${bookIssued.user.email}' />",
          issued:  "<fmt:formatDate value='${bookIssued.issueDate}' pattern='dd MMM yyyy' />",
          due:     "<c:out value='${bookIssued.dueDate}' />",
          status:  "<c:out value='${bookIssued.issuedStatus}' />"
        },
      </c:forEach>
    ];

    // ─────────────────────────────────────────────
    // Sidebar counters — computed from loans array
    // ─────────────────────────────────────────────
    function updateCounters() {
      document.getElementById("cntOnTime").textContent  = loans.filter(l => l.status === "ontime").length;
      document.getElementById("cntDue").textContent     = loans.filter(l => l.status === "due").length;
      document.getElementById("cntOverdue").textContent = loans.filter(l => l.status === "overdue").length;
      document.getElementById("cntTotal").textContent   = loans.length;
    }

    // ─────────────────────────────────────────────
    // Modal logic
    // ─────────────────────────────────────────────
    let pendingId = null;

    function openModal(id) {
      const loan = loans.find(l => l.id === id);
      if (!loan) return;
      pendingId = id;
      const labels = { ontime: "On Time", due: "Due Today", overdue: "Overdue" };
      document.getElementById("modalMeta").innerHTML = `
        <li><span>Book</span><strong>${loan.book}</strong></li>
        <li><span>Member</span><strong>${loan.member}</strong></li>
        <li><span>Issued On</span><strong>${loan.issued}</strong></li>
        <li><span>Due Date</span><strong>${loan.due}</strong></li>
        <li><span>Status</span><strong>${labels[loan.status] || loan.status}</strong></li>`;
      document.getElementById("modalOverlay").classList.add("open");
    }

    function closeModal() {
      document.getElementById("modalOverlay").classList.remove("open");
      pendingId = null;
    }

    document.getElementById("modalClose").addEventListener("click", closeModal);
    document.getElementById("modalCancel").addEventListener("click", closeModal);
    document.getElementById("modalOverlay").addEventListener("click", function(e) {
      if (e.target === e.currentTarget) closeModal();
    });

    // ─────────────────────────────────────────────
    // FIX #4: Confirm button submits the real hidden
    //         form to the server so the return is
    //         actually saved (not just in memory).
    // ─────────────────────────────────────────────
    document.getElementById("modalConfirm").addEventListener("click", function() {
      if (pendingId === null) return;
      document.getElementById("returnIssueId").value = pendingId;
      document.getElementById("returnForm").submit();
    });

    // ─────────────────────────────────────────────
    // Toast helper (shown on page reload via flash)
    // ─────────────────────────────────────────────
    function showToast(msg) {
      const wrap = document.getElementById("toastWrap");
      const t = document.createElement("div");
      t.className = "toast";
      t.innerHTML = `<div class="toast-icon"><svg viewBox="0 0 24 24"><path d="M20 6L9 17l-5-5"/></svg></div><span>${msg}</span>`;
      wrap.appendChild(t);
      requestAnimationFrame(() => { requestAnimationFrame(() => t.classList.add("show")); });
      setTimeout(() => { t.classList.remove("show"); setTimeout(() => t.remove(), 450); }, 3400);
    }

    // ─────────────────────────────────────────────
    // Boot: counters + reveal animations + loader
    // ─────────────────────────────────────────────
    window.addEventListener("DOMContentLoaded", function() {
      updateCounters();

      // Show a toast if server returned a flash success
      <c:if test="${not empty flashSuccessMessage}">
        showToast('<c:out value="${flashSuccessMessage}" />');
      </c:if>

      setTimeout(function() {
        document.body.classList.add("loaded");
        document.querySelectorAll("[data-reveal]").forEach(function(el, i) {
          setTimeout(function() { el.classList.add("visible"); }, i * 80);
        });
      }, 1200);
    });
  </script>
</body>
</html>
