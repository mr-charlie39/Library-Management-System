<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Books - Library Management</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;400;500;600;700&display=swap"
      rel="stylesheet"
    />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/booklist.css" />
  </head>
  <body>
    <div
      class="entry-loader"
      id="entryLoader"
      aria-live="polite"
      aria-label="Loading books library"
    >
      <div class="loader-card">
        <div class="loader-icon" aria-hidden="true"></div>
        <h1>Loading Books Library</h1>
        <p>Fetching all books from database...</p>
        <div class="loader-bars" aria-hidden="true">
          <span></span>
          <span></span>
          <span></span>
        </div>
      </div>
    </div>

    <div class="ambient" aria-hidden="true">
      <span class="orb orb-a"></span>
      <span class="orb orb-b"></span>
      <span class="orb orb-c"></span>
    </div>

    <!-- Main App Shell -->
    <div class="app-shell" id="appShell">
      <!-- Sidebar -->
      <aside class="sidebar reveal" data-reveal>
        <div class="brand">
          <div class="brand-mark" aria-hidden="true">📚</div>
          <div class="brand-text">
            <strong>Library</strong>
            <span>Management System</span>
          </div>
        </div>

        <nav class="nav-section" aria-label="Primary navigation">
          <a class="nav-link" href="${pageContext.request.contextPath}/DashboardController?action=viewDashboard">
            <span class="nav-icon" aria-hidden="true">
              <svg viewBox="0 0 24 24">
                <path d="M4 13h6v7H4zm10-9h6v16h-6zM4 4h6v7H4z" />
              </svg>
            </span>
            <span>Dashboard</span>
          </a>
          <a class="nav-link" href="${pageContext.request.contextPath}/BookController?action=showAssignBook">
            <span class="nav-icon" aria-hidden="true">
              <svg viewBox="0 0 24 24">
                <path d="M12 4v16M4 12h16" />
              </svg>
            </span>
            <span>Assign Book</span>
          </a>
          <a class="nav-link" href="${pageContext.request.contextPath}/BookController?action=showReturnBook">
            <span class="nav-icon" aria-hidden="true">
              <svg viewBox="0 0 24 24">
                <path d="M9 7l-5 5 5 5M20 12H5" />
              </svg>
            </span>
            <span>Return Book</span>
          </a>
          <a class="nav-link active" href="${pageContext.request.contextPath}/BookController?action=showBooklist">
            <span class="nav-icon" aria-hidden="true">
              <svg viewBox="0 0 24 24">
                <path d="M4 6h14v12H4zM18 8h2v8h-2" />
              </svg>
            </span>
            <span>Books</span>
          </a>
          <a class="nav-link" href="${pageContext.request.contextPath}/BookController?action=showAddBook">
            <span class="nav-icon" aria-hidden="true">
              <svg viewBox="0 0 24 24">
                <path d="M4 8h10v12H4zM14 8h6M17 5v6" />
              </svg>
            </span>
            <span>Add Book</span>
          </a>
          <a class="nav-link" href="${pageContext.request.contextPath}/UserController?action=showUserList">
            <span class="nav-icon" aria-hidden="true">
              <svg viewBox="0 0 24 24">
                <path
                  d="M16 19v-1a4 4 0 00-8 0v1M12 11a3 3 0 100-6 3 3 0 000 6z"
                />
              </svg>
            </span>
            <span>Users</span>
          </a>
          <a class="nav-link" href="${pageContext.request.contextPath}/UserController?action=showAddUser">
            <span class="nav-icon" aria-hidden="true">
              <svg viewBox="0 0 24 24">
                <path
                  d="M16 19v-1a4 4 0 00-8 0v1M12 11a3 3 0 100-6 3 3 0 000 6zM20 8v6M17 11h6"
                />
              </svg>
            </span>
            <span>Add User</span>
          </a>
          
        </nav>
      </aside>

      <!-- Main Content -->
      <main class="main reveal" data-reveal>
        <!-- Top Bar -->
        <header class="topbar">
          <div>
            <div class="topbar-title">Library Catalog</div>
            <h1 class="heading-with-icon">
              <span class="dashboard-logo" aria-hidden="true">
                <svg viewBox="0 0 24 24">
                  <path d="M4 5h16v14H4zM18 8h2v8h-2" />
                </svg>
              </span>
              <span>Books Library</span>
            </h1>
          </div>
          <div class="topbar-actions">
            <a class="ghost-link" href="${pageContext.request.contextPath}/BookController?action=showDashboard">Back to Dashboard</a>
            <div class="welcome-pill">Admin Panel</div>
          </div>
        </header>

        <!-- Fallback: show a session flash message if present (useful after redirects) -->
        <c:set var="flashSuccessMessage" value="${sessionScope.flashSuccess}" />
        <c:remove var="flashSuccess" scope="session" />

        <!-- Success Alert -->
        <div
          class="alert alert-success alert-dismissible"
          id="successAlert"
          style="display: none; margin-bottom: 1.5rem;"
          role="alert"
        >
          <h6 id="alertMessage">Success message will be printed here</h6>
          <button
            type="button"
            class="btn-close"
            id="closeAlertBtn"
            aria-label="Close"
          ></button>
        </div>

        <!-- Content Area -->
        <div class="content">
          <!-- Page Header -->
          <div class="page-header">
            <div class="header-title">
              <h1 class="page-h1">📖 Books Library</h1>
              <p class="header-subtitle">
                Manage and organize all library books
              </p>
            </div>
            <a href="${pageContext.request.contextPath}/BookController?action=showAddBook" class="btn btn-primary add-book-btn">
              <span>+ Add New Book</span>
            </a>
          </div>

          <!-- Search & Filter Section -->
          <div class="search-filter-wrap">
            <div class="search-box">
              <svg viewBox="0 0 24 24" class="search-icon">
                <path d="M11 19a8 8 0 100-16 8 8 0 000 16zm6-2l4 4" />
              </svg>
              <input
                type="search"
                placeholder="Search by title, author, or ISBN..."
                class="search-input"
                id="searchInput"
              />
            </div>
            <select class="filter-select" id="categoryFilter">
              <option value="">All Categories</option>
              <option value="fiction">Fiction</option>
              <option value="technology">Technology</option>
              <option value="science">Science</option>
              <option value="history">History</option>
            </select>
          </div>

          <!-- Books Table -->
          <div class="table-wrapper">
            <table class="books-table">
              <thead>
                <tr>
                  <th class="th-title">📚 Title</th>
                  <th class="th-author">✍ Author</th>
                  <th class="th-category">🏷 Category</th>
                  <th class="th-isbn">📱 ISBN</th>
                  <th class="th-publisher">📖 Publisher</th>
                  <th class="th-date">📅 Date Added</th>
                  <th class="th-status">⭐ Status</th>
                  <th class="th-actions">⚙ Actions</th>
                </tr>
              </thead>
              <tbody id="booksTable">
                <c:choose>
                  <c:when test="${not empty requestScope.books}">
                    <c:forEach var="book" items="${requestScope.books}">
                      <tr>
                        <td class="td-title">
                          <span class="book-icon">📖</span>
                          <span class="book-title"><c:out value="${book.title}"/></span>
                        </td>
                        <td class="td-author">
                          <span class="author-name">✍ <c:out value="${book.author}"/></span>
                        </td>
                        <td class="td-category">
                          <span class="category-badge badge-fiction"><c:out value="${book.category}"/></span>
                        </td>
                        <td class="td-isbn">
                          <span class="isbn-code">📱 <c:out value="${book.isbn}"/></span>
                        </td>
                        <td class="td-publisher">
                          <span class="publisher-name"><c:out value="${book.publisher}"/></span>
                        </td>
                        <td class="td-date">
                          <span class="date-badge">📅 <fmt:formatDate value="${book.createdAt}" pattern="MMM dd, yyyy"/></span>
                        </td>
                        <td class="td-status">
                          <span class="status-badge ${book.availableCopies > 0 ? 'status-available' : 'status-assigned'}">
                            <c:choose>
                              <c:when test="${book.availableCopies > 0}">✓ Available</c:when>
                              <c:otherwise>◐ Assigned</c:otherwise>
                            </c:choose>
                          </span>
                        </td>
                        <td class="td-actions">
                          <div class="actions-wrap">
                            <a class="action-btn btn-edit" href="${pageContext.request.contextPath}/BookController?action=viewedit&bookId=${book.bookId}" title="Edit ${book.title}" aria-label="Edit ${book.title}">
                              <span class="action-icon">✎</span>
                            </a>
                          </div>
                        </td>
                      </tr>
                    </c:forEach>
                  </c:when>
                  <c:otherwise>
                    <tr>
                      <td colspan="8" style="text-align:center; padding: 2rem; color: var(--ink-soft); font-size: 0.95rem;">
                        📭 No books in database yet. <a href="${pageContext.request.contextPath}/BookController?action=showAddBook">Add one now</a>
                      </td>
                    </tr>
                  </c:otherwise>
                </c:choose>
              </tbody>
            </table>
          </div>

          <!-- Pagination -->
          <div class="pagination-wrap">
            <div class="pagination">
              <button class="pagination-btn prev-btn" disabled>
                ← Previous
              </button>
              <div class="page-indicators">
                <button class="page-btn active" data-page="1">1</button>
                <button class="page-btn" data-page="2">2</button>
                <button class="page-btn" data-page="3">3</button>
              </div>
              <button class="pagination-btn next-btn">Next →</button>
            </div>
            <div class="pagination-info">
              Showing <strong id="startRecord">1</strong> -
              <strong id="endRecord">5</strong> of
              <strong id="totalBooks">45</strong> books
            </div>
          </div>
        </div>
      </main>
    </div>

    <script>
      // Simple loader hide after page loads
      window.addEventListener('load', () => {
        document.body.classList.add('loaded');
        const entryLoader = document.getElementById('entryLoader');
        if (entryLoader) {
          entryLoader.style.display = 'none';
        }
        
        // Show app shell
        const appShell = document.getElementById('appShell');
        if (appShell) {
          appShell.classList.add('visible');
          const reveals = document.querySelectorAll('[data-reveal]');
          reveals.forEach((el, idx) => {
            el.style.setProperty('--delay', (idx * 70) + 'ms');
            el.classList.add('visible');
          });
        }

        // Normalize category labels and apply matching badge classes.
        const categoryBadges = document.querySelectorAll('.category-badge');
        categoryBadges.forEach((badge) => {
          const rawText = (badge.textContent || '').trim();
          if (!rawText) {
            return;
          }

          const normalizedKey = rawText
            .toLowerCase()
            .replace(/&/g, ' and ')
            .replace(/[^a-z0-9]+/g, '-')
            .replace(/^-+|-+$/g, '');

          const prettyLabel = rawText
            .toLowerCase()
            .replace(/\b\w/g, (m) => m.toUpperCase());

          badge.textContent = prettyLabel;
          badge.classList.forEach((name) => {
            if (name.startsWith('badge-') && name !== 'badge-fiction') {
              badge.classList.remove(name);
            }
          });

          if (normalizedKey) {
            badge.classList.remove('badge-fiction');
            badge.classList.add(`badge-${normalizedKey}`);
          }
        });
        
        // Show flash success message if present
        const flashSuccessMessage = '<c:out value="${flashSuccessMessage}" />';
        if (flashSuccessMessage && flashSuccessMessage.trim().length > 0 && flashSuccessMessage !== '') {
          const successAlert = document.getElementById('successAlert');
          const alertMessage = document.getElementById('alertMessage');
          if (successAlert && alertMessage) {
            alertMessage.textContent = flashSuccessMessage;
            successAlert.style.display = 'block';
            setTimeout(() => {
              successAlert.style.display = 'none';
            }, 5000);
          }
        }
      });
    </script>
  </body>
</html>
