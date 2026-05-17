<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="includes/include.jsp"%>

<section class="content">
	<section class="kpi-grid">

		<!-- ✅ Fixed: content moved outside aria-hidden span -->
		<article class="kpi reveal buffering" data-reveal>
			<span class="kpi-watermark" aria-hidden="true"> <svg
					viewBox="0 0 24 24">
					<path d="M4 5h16v14H4zM7 9h10M7 13h7" />
				</svg>
			</span> <small>Total Books</small> <strong><c:out
					value="${dashboardStats.totalBooks}" /></strong> <span>Catalog
				Updated</span>
		</article>

		<article class="kpi reveal buffering" data-reveal>
			<span class="kpi-watermark" aria-hidden="true"> <svg
					viewBox="0 0 24 24">
					<path d="M12 5v14M5 12h14" />
				</svg>
			</span> <small>Books Assigned (Total)</small>
			<!-- ✅ Fixed: booksAssigned → bookAssigned -->
			<strong><c:out value="${dashboardStats.bookAssigned}" /></strong> <span>All Time</span>
		</article>

		<article class="kpi reveal buffering" data-reveal>
			<span class="kpi-watermark" aria-hidden="true"> <svg
					viewBox="0 0 24 24">
					<path d="M9 7l-5 5 5 5M20 12H5" />
				</svg>
			</span> <small>Books Returned (Total)</small>
			<!-- ✅ Fixed: booksReturned → bookReturned -->
			<strong><c:out value="${dashboardStats.bookReturned}" /></strong> <span>All Time</span>
		</article>

		<article class="kpi reveal buffering" data-reveal>
			<span class="kpi-watermark" aria-hidden="true"> <svg
					viewBox="0 0 24 24">
					<path d="M16 19v-1a4 4 0 00-8 0v1M12 11a3 3 0 100-6 3 3 0 000 6z" />
				</svg>
			</span> <small>Users</small> <strong><c:out
					value="${dashboardStats.totalUsers}" /></strong> <span>Active Today</span>
		</article>

	</section>

	<section class="dashboard-grid">
		<article class="card reveal buffering" data-reveal>
			<header class="card-header">
				<div>
					<h3>Currently Issued Books</h3>
					<p>Live records with borrower status and due dates.</p>
				</div>
				<button class="chip" type="button">View All</button>
			</header>

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
												     real POST, so the return actually persists. --%> 
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
		</article>

		<aside class="card reveal buffering" data-reveal>
			<div class="side-panel">
				<div class="stat-line">
					<strong>Due Today</strong>
					<p>5 books require immediate return follow-up.</p>
					<div class="progress" aria-hidden="true">
						<span style="width: 62%"></span>
					</div>
				</div>

				<div class="stat-line">
					<strong>Overdue This Week</strong>
					<p>12 pending returns with reminder sent.</p>
					<div class="progress" aria-hidden="true">
						<span style="width: 48%"></span>
					</div>
				</div>

				<div class="stat-line">
					<strong>Catalog Completion</strong>
					<p>Metadata indexing is almost complete.</p>
					<div class="progress" aria-hidden="true">
						<span style="width: 84%"></span>
					</div>
				</div>
			</div>
		</aside>
	</section>
</section>

<div class="footer-note">Developed by Muhammad Ali Abid ·
	Copyright &copy; 2026</div>
</main>
</div>

<script>
    const loader = document.getElementById("entryLoader");
    const reveals = document.querySelectorAll("[data-reveal]");

    document.querySelectorAll('.nav-link').forEach(link => {
        if (link.tagName === 'A') return;
        link.addEventListener('click', function(e) {
            // your existing button logic
        });
    });

    const revealObserver = new IntersectionObserver(
        (entries) => {
            entries.forEach((entry) => {
                if (entry.isIntersecting) {
                    entry.target.classList.add("visible");
                    revealObserver.unobserve(entry.target);
                }
            });
        },
        {
            threshold: 0.18,
        }
    );

    reveals.forEach((item) => revealObserver.observe(item));

    window.addEventListener("load", () => {
        setTimeout(() => {
            document.body.classList.add("loaded");
            // ✅ Fixed: null check before accessing loader
            if (loader) {
                loader.setAttribute("aria-hidden", "true");
            }
        }, 1050);
    });
</script>
</body>
</html>