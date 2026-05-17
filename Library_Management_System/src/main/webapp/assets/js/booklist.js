/* ==========================================
   BOOKS LIST PAGE - JAVASCRIPT
   ========================================== */

// State management
let currentPage = 1;
const itemsPerPage = 5;
let booksData = window.booksData || [];
let filteredBooks = [...booksData];
const contextPath = window.appContextPath || '';

// DOM Elements
const entryLoader = document.getElementById('entryLoader');
const appShell = document.getElementById('appShell');
const booksTable = document.getElementById('booksTable');
const searchInput = document.getElementById('searchInput');
const categoryFilter = document.getElementById('categoryFilter');
const successAlert = document.getElementById('successAlert');
const prevBtn = document.querySelector('.prev-btn');
const nextBtn = document.querySelector('.next-btn');
const pageIndicators = document.querySelector('.page-indicators');
const paginationInfo = document.querySelector('.pagination-info');

/* ==========================================
   REVEAL OBSERVER
   ✅ FIXED: Moved IntersectionObserver here from JSP inline script
   so it runs AFTER body.loaded is set, not before
   ========================================== */

const revealObserver = new IntersectionObserver(
  (entries) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        entry.target.classList.add('visible');
        revealObserver.unobserve(entry.target);
      }
    });
  },
  { threshold: 0.18 }
);

/* ==========================================
   INITIALIZATION
   ========================================== */

document.addEventListener('DOMContentLoaded', () => {
  if (window.booksData && window.booksData.length > 0) {
    booksData = window.booksData;
    filteredBooks = [...booksData];
  }

  if (!booksTable || !searchInput || !categoryFilter || !prevBtn || !nextBtn || !pageIndicators || !paginationInfo) {
    document.body.classList.add('loaded');
    if (entryLoader) {
      entryLoader.setAttribute('aria-hidden', 'true');
    }
    return;
  }

  // Initialize everything first
  initializeEventListeners();
  populateCategoryFilter();
  populateBooks();

  // ✅ FIXED: Single unified loader → reveal sequence
  // 1. Wait 1050ms (matches loader animation duration)
  // 2. Add body.loaded → CSS hides loader + reveals app-shell via body.loaded .app-shell
  // 3. Add appShell.visible → JS class as backup (belt-and-suspenders)
  // 4. Start observing [data-reveal] elements for staggered sidebar/main reveal
  setTimeout(() => {
    document.body.classList.add('loaded');           // hides loader via CSS
    if (entryLoader) {
      entryLoader.setAttribute('aria-hidden', 'true'); // accessibility
    }
    if (appShell) {
      appShell.classList.add('visible');               // reveals app shell
    }

    // Start reveal observer AFTER content is shown
    const reveals = document.querySelectorAll('[data-reveal]');
    reveals.forEach((el) => revealObserver.observe(el));
  }, 1050);
});

function initializeEventListeners() {
  searchInput.addEventListener('input', handleSearch);
  categoryFilter.addEventListener('change', handleFilter);
  prevBtn.addEventListener('click', handlePrevPage);
  nextBtn.addEventListener('click', handleNextPage);

  // Keyboard shortcuts
  document.addEventListener('keydown', handleKeyboardShortcuts);
}

/* ==========================================
   SEARCH & FILTER LOGIC
   ========================================== */

function handleSearch(e) {
  const query = e.target.value.toLowerCase().trim();

  filteredBooks = booksData.filter(book =>
    book.title.toLowerCase().includes(query) ||
    book.author.toLowerCase().includes(query) ||
    book.isbn.includes(query)
  );

  // Apply category filter on top of search
  const selectedCategory = categoryFilter.value;
  if (selectedCategory && selectedCategory !== 'all') {
    filteredBooks = filteredBooks.filter(
      book => book.category.toLowerCase() === selectedCategory.toLowerCase()
    );
  }

  currentPage = 1;
  populateBooks();
  updatePagination();
}

function handleFilter(e) {
  const selectedCategory = e.target.value;

  if (!selectedCategory || selectedCategory === 'all') {
    filteredBooks = [...booksData];
  } else {
    filteredBooks = booksData.filter(
      book => book.category.toLowerCase() === selectedCategory.toLowerCase()
    );
  }

  // Apply search on top of filter
  const searchQuery = searchInput.value.toLowerCase().trim();
  if (searchQuery) {
    filteredBooks = filteredBooks.filter(book =>
      book.title.toLowerCase().includes(searchQuery) ||
      book.author.toLowerCase().includes(searchQuery) ||
      book.isbn.includes(searchQuery)
    );
  }

  currentPage = 1;
  populateBooks();
  updatePagination();
}

function populateCategoryFilter() {
  if (!booksData || booksData.length === 0) {
    categoryFilter.innerHTML = '<option value="all">All Categories</option>';
    return;
  }

  const categories = ['all', ...new Set(booksData.map(b => b.category))];
  categoryFilter.innerHTML = categories
    .map(cat => `<option value="${cat}">${cat === 'all' ? 'All Categories' : cat}</option>`)
    .join('');
}

/* ==========================================
   TABLE POPULATION
   ========================================== */

function populateBooks() {
  const start = (currentPage - 1) * itemsPerPage;
  const end = start + itemsPerPage;
  const pageBooks = filteredBooks.slice(start, end);

  if (pageBooks.length === 0) {
    booksTable.innerHTML = `
      <tr>
        <td colspan="7" style="text-align:center; padding: 2rem; color: var(--ink-soft); font-size: 0.95rem;">
          📭 ${booksData.length === 0 ? 'No books in database yet.' : 'No books found matching your search.'}
        </td>
      </tr>
    `;
    updatePagination();
    return;
  }

  booksTable.innerHTML = pageBooks
    .map((book, idx) => {
      const categoryEmoji = getCategoryEmoji(book.category);
      const isAvailable = Number(book.status) === 1;
      const statusText = isAvailable ? 'Available' : 'Assigned';
      const statusIcon = isAvailable ? '✓' : '◐';
      const statusColor = isAvailable ? 'available' : 'assigned';
      const formattedDate = formatDatabaseDate(book.dateAdded);
      return `
      <tr style="--delay: ${idx * 50}ms">
        <td class="td-title">
          <span class="book-icon">📖</span>
          <span class="book-title" title="${escapeHtml(book.title)}">${escapeHtml(book.title)}</span>
        </td>
        <td class="td-author">
          <span class="author-name" title="${escapeHtml(book.author)}">
            ✍ ${escapeHtml(book.author)}
          </span>
        </td>
        <td class="td-category">
          <span class="category-badge badge-${getCategoryClass(book.category)}" title="${book.category}">
            <span style="display: inline-block; margin-right: 4px;">${categoryEmoji}</span>
            ${escapeHtml(book.category)}
          </span>
        </td>
        <td class="td-isbn">
          <span class="isbn-code" title="ISBN: ${book.isbn}">📱 ${book.isbn}</span>
        </td>
        <td class="td-date">
          <span class="date-badge" title="Added on ${formattedDate}">📅 ${formattedDate}</span>
        </td>
        <td class="td-status">
          <span class="status-badge status-${statusColor}" title="Status: ${statusText}">
            <span>${statusIcon}</span>
            ${statusText}
          </span>
        </td>
        <td class="td-actions">
          <button class="action-btn btn-edit" onclick="window.location='${contextPath}/BookController?action=viewedit&bookId=${book.id}'" title="Edit Book" aria-label="Edit ${escapeHtml(book.title)}">
            <span style="font-size: 1.1rem;">✎</span>
          </button>
          <button class="action-btn btn-delete" onclick="deleteBook(${book.id})" title="Delete Book" aria-label="Delete ${escapeHtml(book.title)}">
            <span style="font-size: 1.2rem;">🗑</span>
          </button>
        </td>
      </tr>
    `;
    })
    .join('');

  updatePagination();
}

function getCategoryEmoji(category) {
  const emojiMap = {
    'Fiction': '📚',
    'Technology': '💻',
    'Science': '🔬',
    'History': '🏛',
    'Business': '💼',
    'Art': '🎨',
    'Health': '⚕️',
    'Sports': '⚽'
  };
  return emojiMap[category] || '📖';
}

function getCategoryClass(category) {
  const classMap = {
    'Fiction': 'fiction',
    'Technology': 'technology',
    'Science': 'science',
    'History': 'history'
  };
  return classMap[category] || 'fiction';
}

function escapeHtml(text) {
  const div = document.createElement('div');
  div.textContent = text;
  return div.innerHTML;
}

/* ==========================================
   PAGINATION
   ========================================== */

function updatePagination() {
  const totalPages = Math.ceil(filteredBooks.length / itemsPerPage);

  // Update page indicators
  pageIndicators.innerHTML = '';
  for (let i = 1; i <= totalPages; i++) {
    const btn = document.createElement('button');
    btn.className = `page-btn ${i === currentPage ? 'active' : ''}`;
    btn.textContent = i;
    btn.addEventListener('click', () => goToPage(i));
    pageIndicators.appendChild(btn);
  }

  // Update prev/next buttons
  prevBtn.disabled = currentPage === 1;
  nextBtn.disabled = currentPage === totalPages || totalPages === 0;

  // Update pagination info
  const start = filteredBooks.length === 0 ? 0 : (currentPage - 1) * itemsPerPage + 1;
  const end = Math.min(currentPage * itemsPerPage, filteredBooks.length);
  paginationInfo.innerHTML = `Showing <strong>${start}</strong> - <strong>${end}</strong> of <strong>${filteredBooks.length}</strong> books`;
}

function handlePrevPage() {
  if (currentPage > 1) {
    goToPage(currentPage - 1);
  }
}

function handleNextPage() {
  const totalPages = Math.ceil(filteredBooks.length / itemsPerPage);
  if (currentPage < totalPages) {
    goToPage(currentPage + 1);
  }
}

function goToPage(pageNum) {
  currentPage = pageNum;
  populateBooks();

  // Scroll to table with smooth animation
  const tableWrapper = document.querySelector('.table-wrapper');
  tableWrapper.scrollIntoView({ behavior: 'smooth', block: 'start' });
}

/* ==========================================
   CRUD OPERATIONS
   ========================================== */

function editBook(bookId) {
  const book = booksData.find(b => b.id === bookId);
  if (book) {
    // In production, this would navigate to an edit page or open a modal
    console.log('Edit book:', book);
    showAlert(`✎ Edit mode for: ${book.title}`, true);
  }
}

function deleteBook(bookId) {
  const book = booksData.find(b => b.id === bookId);
  if (!book) return;

  // Confirm deletion
  if (confirm(`Are you sure you want to delete "${book.title}"?`)) {
    const index = booksData.indexOf(book);
    if (index > -1) {
      booksData.splice(index, 1);
      filteredBooks = filteredBooks.filter(b => b.id !== bookId);

      // Adjust pagination if needed
      const totalPages = Math.ceil(filteredBooks.length / itemsPerPage);
      if (currentPage > totalPages && totalPages > 0) {
        currentPage = totalPages;
      }

      populateBooks();
      showBookDeletedSuccess(book.title);
    }
  }
}

/* ==========================================
   ALERTS
   ========================================== */

function showAlert(message, isSuccess = true) {
  const alertClass = isSuccess ? 'alert-success' : 'alert-error';
  const alertEl = document.getElementById('successAlert');
  const alertMessage = document.getElementById('alertMessage');
  const closeAlertBtn = document.getElementById('closeAlertBtn');

  // Update alert content and class
  alertEl.className = `alert ${alertClass} alert-dismissible`;
  alertMessage.textContent = message;
  alertEl.style.display = 'block';

  // Setup close button
  closeAlertBtn.onclick = function () {
    alertEl.style.display = 'none';
  };

  // Auto-hide after 5 seconds
  setTimeout(() => {
    if (alertEl.style.display !== 'none') {
      alertEl.style.display = 'none';
    }
  }, 5000);
}

function showBookAddedSuccess(bookTitle = 'Book') {
  showAlert(`✓ ${bookTitle} has been added successfully to the library!`, true);
}

function showBookDeletedSuccess(bookTitle = 'Book') {
  showAlert(`✓ ${bookTitle} has been deleted successfully!`, true);
}

/* ==========================================
   KEYBOARD SHORTCUTS
   ========================================== */

function handleKeyboardShortcuts(e) {
  // Ctrl+F / Cmd+F - Focus search input
  if ((e.ctrlKey || e.metaKey) && e.key === 'f') {
    e.preventDefault();
    searchInput.focus();
    searchInput.select();
  }

  // Escape - Clear search
  if (e.key === 'Escape' && document.activeElement === searchInput) {
    searchInput.value = '';
    searchInput.dispatchEvent(new Event('input'));
  }

  // Arrow keys - Navigate pages (when not in input)
  if (document.activeElement !== searchInput) {
    if (e.key === 'ArrowLeft') {
      handlePrevPage();
    } else if (e.key === 'ArrowRight') {
      handleNextPage();
    }
  }
}

/* ==========================================
   UTILITY FUNCTIONS
   ========================================== */

function debounce(func, delay) {
  let timeoutId;
  return function (...args) {
    clearTimeout(timeoutId);
    timeoutId = setTimeout(() => func(...args), delay);
  };
}

function formatDate(date) {
  return new Intl.DateTimeFormat('en-US', {
    year: 'numeric',
    month: 'short',
    day: 'numeric'
  }).format(new Date(date));
}

function formatDatabaseDate(timestamp) {
  if (!timestamp) return '';

  if (typeof timestamp === 'string') {
    // Convert "YYYY-MM-DD HH:MM:SS" to ISO for Date parsing
    const isoTimestamp = timestamp.replace(' ', 'T');
    const date = new Date(isoTimestamp);
    return isNaN(date) ? '' : formatDate(date);
  }

  const date = new Date(timestamp);
  return isNaN(date) ? '' : formatDate(date);
}

/* ==========================================
   EXPORT / BULK OPERATIONS
   ========================================== */

function exportBooks() {
  const csv = [
    ['ID', 'Title', 'Author', 'Category', 'ISBN', 'Status'],
    ...filteredBooks.map(b => [b.id, b.title, b.author, b.category, b.isbn, b.status])
  ]
    .map(row => row.map(cell => `"${cell}"`).join(','))
    .join('\n');

  const blob = new Blob([csv], { type: 'text/csv' });
  const url = window.URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.href = url;
  a.download = 'books.csv';
  a.click();
  window.URL.revokeObjectURL(url);
}

function bulkDelete(bookIds) {
  if (confirm(`Delete ${bookIds.length} books? This action cannot be undone.`)) {
    bookIds.forEach(id => {
      const index = booksData.findIndex(b => b.id === id);
      if (index > -1) {
        booksData.splice(index, 1);
      }
    });
    filteredBooks = [...booksData];
    populateBooks();
    showAlert(`${bookIds.length} books deleted successfully`, true);
  }
}

/* ==========================================
   CLEANUP ON UNLOAD
   ========================================== */

window.addEventListener('beforeunload', () => {
  searchInput.removeEventListener('input', handleSearch);
  categoryFilter.removeEventListener('change', handleFilter);
  document.removeEventListener('keydown', handleKeyboardShortcuts);
});
