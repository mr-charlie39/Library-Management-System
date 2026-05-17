<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- Redirect before any markup is rendered to avoid response-commit errors. --%>
<c:if test="${empty userlist && empty param.loaded}">
  <c:redirect url="${pageContext.request.contextPath}/UserController">
    <c:param name="action" value="showUserList" />
    <c:param name="loaded" value="1" />
  </c:redirect>
</c:if>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Users | Library Management</title>
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link
    href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;400;500;600;700&display=swap"
    rel="stylesheet"
  />
      <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/userslist.css" />

</head>
<body>
  <div
    class="entry-loader"
    id="pageLoader"
    aria-live="polite"
    aria-label="Loading users directory"
  >
    <div class="loader-card">
      <div class="loader-icon" aria-hidden="true"></div>
      <h1>Loading User Directory</h1>
      <p>Syncing member profiles and staff accounts...</p>
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
        <div class="brand-mark" aria-hidden="true">
          <svg viewBox="0 0 24 24">
            <path d="M4 5h16v14H4z" />
            <path d="M8 3h8v4H8z" />
          </svg>
        </div>
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
        <a class="nav-link" href="${pageContext.request.contextPath}/BookController?action=showBooklist">
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
        <a class="nav-link active" href="${pageContext.request.contextPath}/UserController?action=showUserList">
          <span class="nav-icon" aria-hidden="true">
            <svg viewBox="0 0 24 24">
              <path d="M16 19v-1a4 4 0 00-8 0v1" />
              <circle cx="12" cy="7" r="4" />
            </svg>
          </span>
          <span>Users</span>
        </a>
        <a class="nav-link" href="${pageContext.request.contextPath}/UserController?action=showAddUser">
          <span class="nav-icon" aria-hidden="true">
            <svg viewBox="0 0 24 24">
              <path d="M16 19v-1a4 4 0 00-8 0v1" />
              <circle cx="12" cy="7" r="4" />
              <path d="M19 8v6M16 11h6" />
            </svg>
          </span>
          <span>Add User</span>
        </a>
      </nav>
    </aside>

    <main class="main reveal" data-reveal data-delay="140">
      <header class="topbar">
        <div>
          <div class="topbar-title">User Management</div>
          <div class="heading-with-icon">
            <div class="dashboard-logo" aria-hidden="true">
              <svg viewBox="0 0 24 24">
                <path d="M16 19v-1a4 4 0 00-8 0v1" />
                <circle cx="12" cy="7" r="4" />
                <path d="M20 8v6M17 11h6" />
              </svg>
            </div>
            <h1>Users Directory</h1>
          </div>
        </div>
        <div class="topbar-actions">
          <a href="${pageContext.request.contextPath}/DashboardController?action=viewDashboard" class="ghost-link">
            <svg viewBox="0 0 24 24" class="link-icon">
              <path d="M19 12H5M12 19l-7-7 7-7" />
            </svg>
            Back to Dashboard
          </a>
          <div class="welcome-pill">
            <span class="pill-icon" aria-hidden="true">
              <svg viewBox="0 0 24 24">
                <path d="M4 6h14v12H4z" />
                <path d="M18 8h2v8h-2" />
              </svg>
            </span>
            Active Users
          </div>
        </div>
      </header>


      <div class="content">
        <div class="page-header reveal" data-reveal data-delay="220">
          <div class="header-title">
            <h2 class="page-h1">Members and Staff</h2>
            <p class="header-subtitle">Track profiles, roles, and access across the library.</p>
          </div>
          <a href="${pageContext.request.contextPath}/UserController?action=showAddUser" class="btn btn-primary add-user-btn">
            <span>+ Add New User</span>
          </a>
        </div>

        <section class="stats-grid reveal" data-reveal data-delay="300">
          <article class="stat-card">
            <div class="stat-icon">
              <svg viewBox="0 0 24 24">
                <path d="M16 19v-1a4 4 0 00-8 0v1" />
                <circle cx="12" cy="7" r="4" />
              </svg>
            </div>
            <div>
              <p class="stat-label">Total Users</p>
              <h3 class="stat-value">128</h3>
              <span class="stat-trend">+8 this month</span>
            </div>
          </article>
          <article class="stat-card">
            <div class="stat-icon">
              <svg viewBox="0 0 24 24">
                <path d="M9 12l2 2 4-4" />
                <path d="M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
            </div>
            <div>
              <p class="stat-label">Active Members</p>
              <h3 class="stat-value">96</h3>
              <span class="stat-trend">78% engagement</span>
            </div>
          </article>
          <article class="stat-card">
            <div class="stat-icon">
              <svg viewBox="0 0 24 24">
                <path d="M4 19.5h16" />
                <path d="M6 12.5h12" />
                <path d="M4 5.5h16" />
              </svg>
            </div>
            <div>
              <p class="stat-label">Library Staff</p>
              <h3 class="stat-value">12</h3>
              <span class="stat-trend">3 new hires</span>
            </div>
          </article>
          <article class="stat-card">
            <div class="stat-icon">
              <svg viewBox="0 0 24 24">
                <path d="M12 8v4l3 3" />
                <path d="M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
            </div>
            <div>
              <p class="stat-label">Pending Approvals</p>
              <h3 class="stat-value">5</h3>
              <span class="stat-trend">Needs review</span>
            </div>
          </article>
        </section>

        <div class="search-filter-wrap reveal" data-reveal data-delay="360">
          <label class="search-box" aria-label="Search users">
            <svg viewBox="0 0 24 24" class="search-icon">
              <path d="M11 19a8 8 0 100-16 8 8 0 000 16zm6-2l4 4" />
            </svg>
            <input
              type="search"
              class="search-input"
              placeholder="Search by name, email, or role..."
            />
          </label>
          <select class="filter-select" aria-label="Filter by role">
            <option value="">All Roles</option>
            <option value="member">Member</option>
            <option value="librarian">Librarian</option>
            <option value="admin">Admin</option>
          </select>
          <select class="filter-select" aria-label="Filter by status">
            <option value="">All Status</option>
            <option value="active">Active</option>
            <option value="inactive">Inactive</option>
            <option value="pending">Pending</option>
          </select>
        </div>
        
        <c:set var="flashSuccessMessage" value="${sessionScope.flashSuccess}" />
        <c:remove var="flashSuccess" scope="session" />
        <c:if test="${not empty flashSuccessMessage}">
          <div class="flash-message flash-success reveal" data-reveal data-delay="400">
            <span class="flash-icon" aria-hidden="true">
              <svg viewBox="0 0 24 24">
                <path d="M9 12l2 2 4-4" />
                <path d="M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
            </span>
            <span>${flashSuccessMessage}</span>
          </div>
        </c:if>
        
        <c:if test="${not empty errorMessage}">
          <div class="flash-message flash-error reveal" data-reveal data-delay="400">
            <span>${errorMessage}</span>
          </div>
        </c:if>

        <c:choose>
          <c:when test="${not empty userlist}">
            <div class="table-wrapper reveal" data-reveal data-delay="420">
              <div class="table-scroll">
                <table class="users-table">
                  <thead>
                    <tr>
                      <th>#</th>
                      <th>User</th>
                      <th>Email</th>
                      <th>Role</th>
                      <th>Joined</th>
                      <th>Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="user" items="${userlist}" varStatus="status">
                      <c:set var="firstInitial" value="${not empty user.firstName ? fn:substring(user.firstName, 0, 1) : ''}" />
                      <c:set var="lastInitial" value="${not empty user.lastName ? fn:substring(user.lastName, 0, 1) : ''}" />
                      <tr>
                        <td><span class="row-badge">${status.index + 1}</span></td>
                        <td>
                          <div class="user-cell">
                            <div class="user-avatar avatar-cool">${firstInitial}${lastInitial}</div>
                            <div>
                              <div class="user-name">
                                <c:out value="${user.firstName}"/>
                              </div>
                            </div>
                          </div>
                        </td>
                        <td><c:out value="${user.email}" /></td>
                        <td><span class="role-pill role-member"><c:out value="${user.role}" /></span></td>
                        <td><c:out value="${user.createdAt}" /></td>
                        <td>
                          <button class="action-btn btn-edit" type="button" title="Edit User" onclick="window.location.href='${pageContext.request.contextPath}/UserController?action=viewUser&userId=${user.userId}'">
                            <svg viewBox="0 0 24 24">
                              <path d="M12 20h9" />
                              <path d="M16.5 3.5a2.1 2.1 0 013 3L7 19l-4 1 1-4z" />
                            </svg>
                          </button>
                          <form action="${pageContext.request.contextPath}/UserController" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="deleteUser" />
                            <input type="hidden" name="userId" value="${user.userId}" />
                            <button class="action-btn btn-delete" type="submit" title="Delete User" onclick="return confirm('Delete this user?');">
                              <svg viewBox="0 0 24 24">
                                <path d="M3 6h18" />
                                <path d="M8 6V4h8v2" />
                                <path d="M19 6l-1 14H6L5 6" />
                              </svg>
                            </button>
                          </form>
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </div>

              <div class="pagination-wrap">
                <div class="pagination">
                  <button class="pagination-btn" type="button" disabled>Previous</button>
                  <div class="page-indicators">
                    <button class="page-btn active" type="button">1</button>
                    <button class="page-btn" type="button">2</button>
                    <button class="page-btn" type="button">3</button>
                  </div>
                  <button class="pagination-btn" type="button">Next</button>
                </div>
                <div class="pagination-info">
                  Showing <strong>1</strong> - <strong>4</strong> of <strong>128</strong> users
                </div>
              </div>
            </div>
          </c:when>
          <c:otherwise>
            <div class="table-wrapper reveal" data-reveal data-delay="420">
              <div class="no-data">
                <div class="no-data-icon" aria-hidden="true">
                  <svg viewBox="0 0 24 24">
                    <path d="M12 8v4l3 3" />
                    <path d="M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                  </svg>
                </div>
                <h3>No Users Found</h3>
                <p>Try adjusting your search or filter to find what you're looking for.</p>
                <a href="${pageContext.request.contextPath}/UserController?action=showAddUser" class="btn btn-secondary">
                  <span>+ Add First User</span>
                </a>
              </div>
            </div>
          </c:otherwise>
        </c:choose>
      </div>
    </main>
  </div>

  <script>
    document.addEventListener('DOMContentLoaded', function() {
      setTimeout(function() {
        document.body.classList.add('loaded');
        initializeRevealAnimations();
      }, 1000);
    });

    function initializeRevealAnimations() {
      const revealElements = document.querySelectorAll('[data-reveal]');
      revealElements.forEach(function(element, index) {
        const delay = element.getAttribute('data-delay') || index * 80;
        element.style.setProperty('--delay', delay + 'ms');
        element.classList.add('visible');
      });
    }
  </script>
</body>
</html>
