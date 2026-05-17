<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Add Book | LMS</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@400;500;600;700&display=swap"
      rel="stylesheet"
    />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/addbook.css" />
  </head>
  <body>
    <div
      class="entry-loader"
      id="entryLoader"
      aria-live="polite"
      aria-label="Loading add book page"
    >
      <div class="loader-card">
        <div class="loader-icon" aria-hidden="true"></div>
        <h1>Preparing Add Book Workspace</h1>
        <p>Loading shelf metadata and author registry.</p>
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

    <div class="app-shell" id="appShell">
      <aside class="sidebar reveal" data-reveal>
        <div class="brand">
          <div class="brand-mark" aria-hidden="true">📚</div>
          <div class="brand-text">
            <strong>Library</strong>
            <span>Management System</span>
          </div>
        </div>

        <nav class="nav-section" aria-label="Primary navigation">
          <a
            class="nav-link"
            href="${pageContext.request.contextPath}/DashboardController?action=viewDashboard"
          >
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
          <a class="nav-link" href="${pageContext.request.contextPath}/BookController?action=showBooklist">
            <span class="nav-icon" aria-hidden="true">
              <svg viewBox="0 0 24 24">
                <path d="M4 6h14v12H4zM18 8h2v8h-2" />
              </svg>
            </span>
            <span>Books</span>
          </a>
          <a class="nav-link active" href="${pageContext.request.contextPath}/BookController?action=showAddBook">
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

      <main class="main reveal" data-reveal>
        <header class="topbar">
          <div>
            <div class="topbar-title">Catalog Module</div>
            <h1 class="heading-with-icon">
              <span class="dashboard-logo" aria-hidden="true">
                <svg viewBox="0 0 24 24">
                  <path d="M4 6h14v12H4zM18 8h2v8h-2M7 10h6M7 14h8" />
                </svg>
              </span>
              <span>Add New Book</span>
            </h1>
          </div>
          <div class="topbar-actions">
            <a class="ghost-link" href="${pageContext.request.contextPath}/DashboardController?action=viewDashboard">Back to Dashboard</a>
            <div class="welcome-pill">Admin Panel</div>
          </div>
        </header>

        <section class="content">
          <section class="status-strip reveal" data-reveal>
            <article>
              <small>Template Quality</small>
              <strong>Production Ready</strong>
              <span>with motion + responsive behavior</span>
            </article>
            <article>
              <small>Auto Validation</small>
              <strong>Enabled</strong>
              <span>required fields tracked live</span>
            </article>
            <article>
              <small>Estimated Catalog Time</small>
              <strong>2-3 min</strong>
              <span>for complete metadata entry</span>
            </article>
          </section>

          <section class="layout-grid">
            <section class="card form-card reveal" data-reveal>
              <header class="card-header">
                <div>
                <c:if test="${not empty errorMessage}">
          <div class="alert alert-danger alert-dismissible fade show" role="alert">
          <c:out value="${errorMessage}"/>
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
          </div>
          </c:if>
                  <h2>Book Details</h2>
                  <p>
                    Use complete metadata so search, issue, and reports remain
                    accurate.
                  </p>
                </div>
                <span class="chip">Form v2</span>
              </header>

              <form action="${pageContext.request.contextPath}/BookController" class="book-form" id="bookForm" novalidate method="post">
              <input type="hidden" name="action" value="addBook">
                <div class="field-grid two-col">
                  <label class="field">
                    <span>Book Title</span>
                    <input
                      type="text"
                      name="bookTitle"
                      placeholder="Atomic Habits"
                      required
                    />
                  </label>
                  <label class="field">
                    <span>Author</span>
                    <input
                      type="text"
                      name="author"
                      placeholder="James Clear"
                      required
                    />
                  </label>
                </div>

                <div class="field-grid three-col">
                  <label class="field">
                    <span>Category</span>
                    <select name="category" required>
                      <option value="">Choose category</option>
                      <option>Fiction</option>
                      <option>Technology</option>
                      <option>Science</option>
                      <option>History</option>
                      <option>Business</option>
                    </select>
                  </label>
                  <label class="field">
                    <span>ISBN</span>
                    <input
                      type="text"
                      name="isbn"
                      placeholder="9780735211292"
                      minlength="10"
                      required
                    />
                  </label>
                  <label class="field">
                    <span>Publisher</span>
                    <input
                      type="text"
                      name="publisher"
                      placeholder="Penguin Random House"
                      required
                    />
                  </label>
                </div>

                <div class="field-grid two-col">
                  <label class="field">
                    <span>Total Copies</span>
                    <input
                      type="number"
                      name="totalCopies"
                      min="1"
                      value="1"
                      required
                    />
                  </label>
                  <label class="field">
                    <span>Available Copies</span>
                    <input
                      type="number"
                      name="availableCopies"
                      min="0"
                      value="1"
                      required
                    />
                  </label>
                </div>

                <div class="form-footer">
                  <div class="completion-wrap" aria-live="polite">
                    <div class="completion-label">
                      <strong>Form Completion</strong>
                      <span id="completionText">0%</span>
                    </div>
                    <div class="progress"><span id="completionBar"></span></div>
                  </div>
                  <div class="actions">
                    <button class="btn btn-soft" type="reset">Clear</button>
                    <button class="btn btn-primary" type="submit">
                      Save Book
                    </button>
                  </div>
                </div>

                <div
                  class="form-signature"
                  aria-label="Library quote and brand mark"
                >
                  <div class="signature-mark" aria-hidden="true">
                    <svg viewBox="0 0 24 24">
                      <path
                        d="M3 6.5c2.2-1.6 4.4-1.6 6.6 0v10.8c-2.2-1.6-4.4-1.6-6.6 0z"
                      />
                      <path
                        d="M21 6.5c-2.2-1.6-4.4-1.6-6.6 0v10.8c2.2-1.6 4.4-1.6 6.6 0z"
                      />
                      <path d="M9.6 9.2h4.8M9.6 12h4.8" />
                      <path d="M12 3.5v2.1M9.9 4.7l2.1 1.2 2.1-1.2" />
                    </svg>
                  </div>
                  <div class="signature-copy">
                    <h4>Moonlight Stacks</h4>
                    <blockquote>
                      "A room without books is like a sky without stars."
                    </blockquote>
                  </div>
                </div>
              </form>
            </section>

            <aside class="side-column reveal" data-reveal>
              <article class="card preview-card buffering">
                <header class="card-header">
                  <h3>Live Preview</h3>
                  <span class="chip">Realtime</span>
                </header>

                <div class="book-preview">
                  <div class="cover-shape" aria-hidden="true"></div>
                  <h4 id="previewTitle">Untitled Book</h4>
                  <p class="preview-author" id="previewAuthor">
                    Unknown Author
                  </p>

                  <ul class="preview-meta">
                    <li>
                      <span>Category</span
                      ><strong id="previewCategory">-</strong>
                    </li>
                    <li>
                      <span>ISBN</span><strong id="previewIsbn">-</strong>
                    </li>
                    <li>
                      <span>Publisher</span
                      ><strong id="previewPublisher">-</strong>
                    </li>
                    <li>
                      <span>Total Copies</span
                      ><strong id="previewTotalCopies">-</strong>
                    </li>
                    <li>
                      <span>Available Copies</span
                      ><strong id="previewAvailableCopies">-</strong>
                    </li>
                  </ul>
                </div>
              </article>

              <article class="card tips-card reveal" data-reveal>
                <header class="card-header">
                  <h3>Smart Tips</h3>
                </header>
                <ul class="tips-list">
                  <li>Keep ISBN accurate to avoid duplicate catalog rows.</li>
                  <li>Use a normalized publisher name for cleaner reports.</li>
                  <li>Available copies should never exceed total copies.</li>
                </ul>
              </article>
            </aside>
          </section>
        </section>

        <footer class="footer-note">
          Developed by Muhammad Ali Abid · Copyright © 2026
        </footer>
      </main>
    </div>
<script src="${pageContext.request.contextPath}/assets/js/addbook.js" ></script>
  </body>
</html>
