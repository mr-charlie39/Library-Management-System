<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Edit Book | LMS</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@400;500;600;700&display=swap"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/assets/css/addbook.css">
  </head>
  <body>
    <div
      class="entry-loader"
      id="entryLoader"
      aria-live="polite"
      aria-label="Loading edit book page"
    >
      <div class="loader-card">
        <div class="loader-icon" aria-hidden="true"></div>
        <h1>Preparing Edit Workspace</h1>
        <p>Syncing catalog metadata and availability status.</p>
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
          <div class="brand-mark" aria-hidden="true">LB</div>
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
          <a class="nav-link" href="${pageContext.request.contextPath}/jsp/error.jsp">
            <span class="nav-icon" aria-hidden="true">
              <svg viewBox="0 0 24 24">
                <path d="M4 19h16M7 15l2-3 3 2 4-6 2 3" />
              </svg>
            </span>
            <span>Reports</span>
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
              <span>Edit Book Details</span>
            </h1>
          </div>
          <div class="topbar-actions">
            <a class="ghost-link" href="${pageContext.request.contextPath}/BookController?action=showBooklist">Back to Books</a>
            <div class="welcome-pill">Admin Panel</div>
          </div>
        </header>

        <section class="content">
          <section class="status-strip reveal" data-reveal>
            <article class="buffering">
              <small>Book Status</small>
              <strong>Available</strong>
              <span>Ready for circulation</span>
            </article>
            <article class="buffering">
              <small>Last Updated</small>
              <strong>Apr 28, 2026</strong>
              <span>By Catalog Manager</span>
            </article>
            <article class="buffering">
              <small>Review Needed</small>
              <strong>No</strong>
              <span>All fields validated</span>
            </article>
          </section>

          <section class="layout-grid">
            <section class="card form-card reveal buffering" data-reveal>
              <header class="card-header">
                <div>
                  <h2>Edit Book Information</h2>
                  <p>Update metadata to keep the catalog accurate.</p>
                </div>
                <span class="chip">Edit Mode</span>
              </header>
              
              <c:set var="flashSuccessMessage" value="${sessionScope.flashSuccess}" />
              <c:remove var="flashSuccess" scope="session" />

              <c:if test="${not empty flashSuccessMessage}">
                <div class="alert alert-success alert-dismissible" role="alert" style="margin-bottom: 1.5rem;">
                  <c:out value="${flashSuccessMessage}"/>
                  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
              </c:if>

              <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert" style="margin-bottom: 1.5rem;">
                  <c:out value="${errorMessage}"/>
                  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
              </c:if>

              <c:if test="${empty book or empty book.bookId}">
                <div class="alert alert-warning" role="alert" style="margin-bottom: 1.5rem;">
                  Book not found. <a href="${pageContext.request.contextPath}/BookController?action=showBooklist">Back to Books</a>
                </div>
              </c:if>

              <c:if test="${not empty book and not empty book.bookId}">
              <form action="${pageContext.request.contextPath}/BookController" method="post" class="book-form" id="editBookForm" novalidate>
                <input type="hidden" name="action" value="updateBook" />
                <input type="hidden" name="bookId" value="${book.bookId}" />
                
                <div class="field-grid two-col">
                  <label class="field">
                    <span>Book Title</span>
                    <input
                      type="text"
                      name="title"
                      placeholder="The Great Gatsby"
                      value="${book.title}"
                      required
                    />
                  </label>
                  <label class="field">
                    <span>Author</span>
                    <input
                      type="text"
                      name="author"
                      placeholder="F. Scott Fitzgerald"
                      value="${book.author}"
                      required
                    />
                  </label>
                </div>

                <div class="field-grid three-col">
                  <label class="field">
                    <span>Category</span>
                    <select name="category" required>
                      <option value="">Choose category</option>
                      <option value="fiction" <c:if test="${book.category eq 'fiction'}">selected</c:if>>Fiction</option>
                      <option value="non-fiction" <c:if test="${book.category eq 'non-fiction'}">selected</c:if>>Non-Fiction</option>
                      <option value="science" <c:if test="${book.category eq 'science'}">selected</c:if>>Science</option>
                      <option value="Science Fiction" <c:if test="${book.category eq 'Science Fiction'}">selected</c:if>>Science Fiction</option>
                      <option value="technology" <c:if test="${book.category eq 'technology'}">selected</c:if>>Technology</option>
                      <option value="Business" <c:if test="${book.category eq 'Business'}">selected</c:if>>Business</option>
                      <option value="history" <c:if test="${book.category eq 'history'}">selected</c:if>>History</option>
                      <option value="biography" <c:if test="${book.category eq 'biography'}">selected</c:if>>Biography</option>
                      <option value="mystery" <c:if test="${book.category eq 'mystery'}">selected</c:if>>Mystery</option>
                      <option value="romance" <c:if test="${book.category eq 'romance'}">selected</c:if>>Romance</option>
                    </select>
                  </label>
                  <label class="field">
                    <span>ISBN</span>
                    <input
                      type="text"
                      name="isbn"
                      placeholder="9780743273565"
                      value="${book.isbn}"
                      minlength="10"
                      required
                    />
                  </label>
                  <label class="field">
                    <span>Publisher</span>
                    <input
                      type="text"
                      name="publisher"
                      placeholder="Scribner"
                      value="${book.publisher}"
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
                      value="${book.totalCopies}"
                      required
                    />
                  </label>
                  <label class="field">
                    <span>Available Copies</span>
                    <input
                      type="number"
                      name="availableCopies"
                      min="0"
                      value="${book.availableCopies}"
                      required
                    />
                  </label>
                </div>

                <div class="form-footer">
                  <div class="completion-wrap" aria-live="polite">
                    <div class="completion-label">
                      <strong>Edit Completion</strong>
                      <span id="completionText">0%</span>
                    </div>
                    <div class="progress"><span id="completionBar"></span></div>
                  </div>
                  <div class="actions">
                    <a href="${pageContext.request.contextPath}/BookController?action=showBooklist" class="btn btn-soft">Cancel</a>
                    <button class="btn btn-primary" type="submit">Update Book</button>
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
                    <h4>Catalog Integrity</h4>
                    <blockquote>
                      "Every detail helps readers find their next story."
                    </blockquote>
                  </div>
                </div>
              </form>
              </c:if>
            </section>

            <aside class="side-column reveal" data-reveal>
              <article class="card preview-card buffering">
                <header class="card-header">
                  <h3>Current Snapshot</h3>
                  <span class="chip">Live</span>
                </header>

                <div class="book-preview">
                  <div class="cover-shape" aria-hidden="true"></div>
                  <h4 id="previewTitle">The Great Gatsby</h4>
                  <p class="preview-author" id="previewAuthor">
                    F. Scott Fitzgerald
                  </p>

                  <ul class="preview-meta">
                    <li>
                      <span>Category</span>
                      <strong id="previewCategory">Fiction</strong>
                    </li>
                    <li>
                      <span>ISBN</span><strong id="previewIsbn">9780743273565</strong>
                    </li>
                    <li>
                      <span>Publisher</span>
                      <strong id="previewPublisher">Charles Scribner's Sons</strong>
                    </li>
                    <li>
                      <span>Total Copies</span><strong id="previewPages">180</strong>
                    </li>
                    <li>
                      <span>Available Copies</span><strong id="previewCopies">5</strong>
                    </li>
                  </ul>
                </div>
              </article>

              <article class="card tips-card reveal" data-reveal>
                <header class="card-header">
                  <h3>Edit Checklist</h3>
                </header>
                <ul class="tips-list">
                  <li>Confirm ISBN matches the physical copy.</li>
                  <li>Update category if the catalog taxonomy changes.</li>
                  <li>Verify total copies equals inventory count.</li>
                </ul>
              </article>
            </aside>
          </section>
        </section>

        <footer class="footer-note">Developed by Muhammad Ali Abid - Copyright (c) 2026</footer>
      </main>
    </div>

    <script src="${pageContext.request.contextPath}/assets/js/editbook.js" ></script>
  </body>
</html>
