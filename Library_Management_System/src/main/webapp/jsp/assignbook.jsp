<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Assign Book | LMS</title>
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@400;500;600;700&display=swap"
	rel="stylesheet" />
<!-- JSP Expression left normal here so Tomcat evaluates it -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/assignbook.css" />
</head>
<body>

	<!-- ── Entry Loader ── -->
	<div class="entry-loader" id="entryLoader" aria-live="polite"
		aria-label="Loading assign book page">
		<div class="loader-card">
			<div class="loader-icon" aria-hidden="true"></div>
			<h1>Preparing Assignment Desk</h1>
			<p>Loading member registry and available catalog.</p>
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
				</a> <a class="nav-link active" href="${pageContext.request.contextPath}/BookController?action=showAssignBook"> <span
					class="nav-icon" aria-hidden="true"> <svg
							viewBox="0 0 24 24">
							<path d="M12 4v16M4 12h16" /></svg>
				</span> <span>Assign Book</span>
				</a> <a class="nav-link" href="${pageContext.request.contextPath}/BookController?action=showReturnBook"> <span
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
                  <path d="M12 4v16M4 12h16" />
                </svg>
						</span> <span>Assign Book to Member</span>
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
						<small>Default Loan Period</small> <strong>14 Days</strong> <span>auto-filled
							on issue</span>
					</article>
					<article>
						<small>Overdue Today</small> <strong>3 Books</strong> <span>pending
							return</span>
					</article>
				</section>

				<!-- Layout Grid -->
				<section class="layout-grid">

					<!-- Form Card -->
					<section class="card form-card reveal" data-reveal>
						<header class="card-header">
							<div>
								<h2>Assignment Details</h2>
								<p>Select a book and member, then confirm the loan period.</p>
							</div>
							<span class="chip">Circulation</span>
						</header>

					<c:set var="flashSuccessMessage"
						value="${sessionScope.flashSuccess}" />
					<c:remove var="flashSuccess" scope="session" />

					<c:if test="${not empty flashSuccessMessage}">
						<div class="flash-message flash-success">
							<span>${flashSuccessMessage}</span>
						</div>
					</c:if>

					<c:if test="${not empty errorMessage}">
						<div class="flash-message flash-error">
							<span>${errorMessage}</span>
						</div>
					</c:if>

					<form class="book-form" id="assignForm" action="${pageContext.request.contextPath}/BookController"
							method="get" novalidate>
							<input type="hidden" name="action" value="assignBook" />

							<!-- Book & Member -->
							<div class="field-grid two-col">
								<div class="form-floating">
									<select class="form-select" id="bookId" name="bookId" style="background: linear-gradient(180deg, #ffffff, #f2e9ff); border: 2px solid #d8c7ef; border-radius: 14px; padding: 0.75rem 2.4rem 0.75rem 0.9rem; font-weight: 600; font-size: 0.95rem; color: #2d1840; box-shadow: 0 6px 16px rgba(127, 70, 192, 0.12);">
									<option value="" selected disabled style="color: #655a72; font-weight: 600; letter-spacing: 0.02em; background: linear-gradient(180deg, #ffffff, #f3eefc);">Choose a book</option>
										<c:forEach var="book" items="${bookList}">
											<option value="${book.bookId}">
												<c:out value="${book.title}" /> -
												<c:out value="${book.author}" /> (Available -
												<c:out value="${book.availableCopies}" />)
											</option>
										</c:forEach>
									</select> <label class="field"> <span>Select Book</span>
									</label>
								</div>

								<div class="form-floating">
									<select class="form-select" id="userId" name="userId" style="background: linear-gradient(180deg, #ffffff, #f2e9ff); border: 2px solid #d8c7ef; border-radius: 14px; padding: 0.75rem 2.4rem 0.75rem 0.9rem; font-weight: 600; font-size: 0.95rem; color: #2d1840; box-shadow: 0 6px 16px rgba(127, 70, 192, 0.12);">
									<option value="" selected disabled style="color: #655a72; font-weight: 600; letter-spacing: 0.02em; background: linear-gradient(180deg, #ffffff, #f3eefc);">Choose a member</option>
										<c:forEach var="user" items="${userList}">
											<option value="${user.userId}">
												<c:out value="${user.firstName}" />
												<c:out value="${user.lastName}" /> -
												<c:out value="${user.email}" />
											</option>
										</c:forEach>
									</select> <label for="selectMember"><i
										class="bi bi-person-fill me-2"></i>Select Member</label>
								</div>
							</div>

							<!-- Dates -->
							<div class="field-grid two-col">
								<label class="field"> <span>Issue Date</span> <input
									type="date" name="issueDate" id="issueDate" required />
								</label> <label class="field"> <span>Due Date</span> <input
									type="date" name="dueDate" id="dueDate" required />
								</label>
							</div>

							<!-- Notes -->
							<label class="field"> <span>Assignment Notes <em
									style="font-weight: 400; font-style: normal; color: #8c7aa5">(optional)</em></span>
								<textarea name="assignmentNotes" id="assignmentNotes"
									placeholder="e.g. Reserve for reading club session, handle with care…"></textarea>
							</label>

							<!-- Footer -->
							<div class="form-footer">
								<div class="actions">
									<button class="btn btn-soft" type="reset">Clear</button>
									<button class="btn btn-primary" type="submit">
										<svg
											style="width: 15px; height: 15px; stroke: #fff; stroke-width: 2; stroke-linecap: round; stroke-linejoin: round; fill: none; display: inline-block; vertical-align: middle; margin-right: 0.35rem"
											viewBox="0 0 24 24">
											<path d="M20 6L9 17l-5-5" /></svg>
										Assign Book
									</button>
								</div>
							</div>

							<!-- Signature -->
							<div class="form-signature" aria-label="Library brand mark">
								<div class="signature-mark" aria-hidden="true">
									<svg viewBox="0 0 24 24">
                      <path
											d="M3 6.5c2.2-1.6 4.4-1.6 6.6 0v10.8c-2.2-1.6-4.4-1.6-6.6 0z" />
                      <path
											d="M21 6.5c-2.2-1.6-4.4-1.6-6.6 0v10.8c2.2-1.6 4.4-1.6-6.6 0z" />
                      <path d="M9.6 9.2h4.8M9.6 12h4.8" />
                      <path d="M12 3.5v2.1M9.9 4.7l2.1 1.2 2.1-1.2" />
                    </svg>
								</div>
								<div class="signature-copy">
									<h4>Moonlight Stacks</h4>
									<blockquote>"The more that you read, the more
										things you will know."</blockquote>
								</div>
							</div>

						</form>
					</section>

					<!-- Side Column -->
					<aside class="side-column reveal" data-reveal>

						<!-- Assignment Summary -->
						<article class="card preview-card buffering">
							<header class="card-header">
								<h3>Assignment Preview</h3>
								<span class="chip">Live</span>
							</header>

							<div class="assignment-summary">
								<!-- Banner -->
								<div class="assign-banner" aria-hidden="true">
									<svg viewBox="0 0 24 24">
                      <path d="M12 4v16M4 12h16" />
                    </svg>
								</div>

								<p class="summary-label">Loan Summary</p>

								<ul class="summary-meta">
									<li><span>Book</span> <strong id="previewBook">—</strong>
									</li>
									<li><span>Member</span> <strong id="previewMember">—</strong>
									</li>
									<li><span>Issue Date</span> <strong id="previewIssue">—</strong>
									</li>
									<li><span>Due Date</span> <strong id="previewDue">—</strong>
									</li>
								</ul>

								<div class="duration-badge" id="durationBadge"
									style="display: none">
									<svg
										style="width: 12px; height: 12px; stroke: currentColor; stroke-width: 2; stroke-linecap: round; fill: none"
										viewBox="0 0 24 24">
										<circle cx="12" cy="12" r="9" />
										<path d="M12 7v5l3 3" /></svg>
									<span id="durationText">0 days</span>
								</div>
							</div>
						</article>

						<!-- Tips -->
						<article class="card tips-card reveal" data-reveal>
							<header class="card-header">
								<h3>Assignment Tips</h3>
							</header>
							<ul class="tips-list">
								<li>Verify the member's active loan count before assigning
									a new book.</li>
								<li>Due date defaults to 14 days from issue — adjust for
									special cases.</li>
								<li>Add a note if the book is fragile or part of a reserved
									set.</li>
								<li>Overdue books block new assignments until returned.</li>
							</ul>
						</article>

					</aside>
				</section>
			</section>

			<footer class="footer-note"> Developed by Muhammad Ali Abid
				· Copyright © 2026 </footer>
		</main>
	</div>

	<script>
      /* ── Helpers ── */
      const $ = id => document.getElementById(id);
      const fmt = iso => {
        if (!iso) return '—';
        const [y, m, d] = iso.split('-');
        return `\${d}/\${m}/\${y}`;
      };

      /* ── Loader → reveal ── */
      window.addEventListener('DOMContentLoaded', () => {
        // Set today as default issue date
        const today = new Date().toISOString().split('T')[0];
        $('issueDate').value = today;

        // Default due date = today + 14 days
        const due = new Date(); due.setDate(due.getDate() + 14);
        $('dueDate').value = due.toISOString().split('T')[0];

        updatePreview();

        setTimeout(() => {
          document.body.classList.add('loaded');
          document.querySelectorAll('[data-reveal]').forEach((el, i) => {
            setTimeout(() => el.classList.add('visible'), i * 80);
          });
        }, 1100);
      });

      /* ── Live Preview ── */
      function getBookLabel(val) {
								const opt = document.querySelector(`#bookId option[value="${val}"]`);
								if (!opt) return '—';
								return opt.text.split('—')[0].trim();
							}
							function getMemberLabel(val) {
								const opt = document.querySelector(`#userId option[value="${val}"]`);
								if (!opt) return '—';
								return opt.text.split('—')[0].trim();
							}

							function updatePreview() {
								const bv = $('bookId').value;
								const mv = $('userId').value;
								const iv = $('issueDate').value;
								const dv = $('dueDate').value;

								$('previewBook').textContent   = bv ? getBookLabel(bv)   : '—';
        $('previewMember').textContent = mv ? getMemberLabel(mv) : '—';
        $('previewIssue').textContent  = fmt(iv);
        $('previewDue').textContent    = fmt(dv);

        // Duration badge
        if (iv && dv) {
          const diff = Math.round((new Date(dv) - new Date(iv)) / 86400000);
          const badge = $('durationBadge');
          if (diff > 0) {
            badge.style.display = 'inline-flex';
            $('durationText').textContent = `\${diff} day\${diff !== 1 ? 's' : ''} loan`;
          } else {
            badge.style.display = 'none';
          }
          // Warn if due < issue
          $('dueDate').classList.toggle('warn', diff < 0);
        }
      }

      ['bookId','userId','issueDate','dueDate'].forEach(id => {
        $(id).addEventListener('change', updatePreview);
        $(id).addEventListener('input', updatePreview);
      });

      /* ── Toast ── */
      function showToast(msg) {
        const wrap = $('toastWrap');
        const t = document.createElement('div');
        t.className = 'toast';
        t.innerHTML = `
          <div class="toast-icon" aria-hidden="true">
            <svg viewBox="0 0 24 24"><path d="M20 6L9 17l-5-5"/></svg>
          </div>
          <span>\${msg}</span>`;
        wrap.appendChild(t);
        requestAnimationFrame(() => { requestAnimationFrame(() => t.classList.add('show')); });
        setTimeout(() => {
          t.classList.remove('show');
          setTimeout(() => t.remove(), 450);
        }, 3200);
      }

      /* ── Form Submit ── */
      $('assignForm').addEventListener('submit', e => {
        const bv = $('bookId').value;
        const mv = $('userId').value;
        if (!bv || !mv || !$('issueDate').value || !$('dueDate').value) {
          e.preventDefault();
          showToast('⚠ Please fill all required fields.');
          return;
        }
        const bookName   = getBookLabel(bv);
        const memberName = getMemberLabel(mv);
        showToast(`✓ "\${bookName}" assigned to \${memberName}`);
        // TODO: submit via fetch/form action
      });

      /* ── Clear reset ── */
      $('assignForm').addEventListener('reset', () => {
        setTimeout(() => {
          const today = new Date().toISOString().split('T')[0];
          $('issueDate').value = today;
          const due = new Date(); due.setDate(due.getDate() + 14);
          $('dueDate').value = due.toISOString().split('T')[0];
          $('dueDate').classList.remove('warn');
          updatePreview();
        }, 10);
      });
    </script>
</body>
</html>
