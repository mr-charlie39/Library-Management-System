// Simple page reveal animation
window.addEventListener('load', () => {
  document.body.classList.add('loaded');
  
  // Hide loader
  const entryLoader = document.getElementById('entryLoader');
  if (entryLoader) {
    entryLoader.style.display = 'none';
  }
  
  // Reveal content
  const appShell = document.getElementById('appShell');
  if (appShell) {
    appShell.classList.add('visible');
    const reveals = document.querySelectorAll('[data-reveal]');
    reveals.forEach((el, idx) => {
      el.style.setProperty('--delay', (idx * 70) + 'ms');
      el.classList.add('visible');
    });
  }
  
  // Update form preview when fields change
  const form = document.getElementById('editBookForm');
  if (form) {
    form.addEventListener('input', updatePreview);
  }
  
  updatePreview();
});

function updatePreview() {
  const form = document.getElementById('editBookForm');
  if (!form) return;
  
  const previewTitle = document.getElementById('previewTitle');
  const previewAuthor = document.getElementById('previewAuthor');
  const previewCategory = document.getElementById('previewCategory');
  const previewIsbn = document.getElementById('previewIsbn');
  const previewPublisher = document.getElementById('previewPublisher');
  const previewPages = document.getElementById('previewPages');
  const previewCopies = document.getElementById('previewCopies');
  
  const requiredFields = Array.from(form.querySelectorAll('[required]'));
  const filled = requiredFields.filter(f => f.value.trim()).length;
  const percent = Math.round((filled / requiredFields.length) * 100);
  
  const completionText = document.getElementById('completionText');
  const completionBar = document.getElementById('completionBar');
  
  if (completionText) completionText.textContent = percent + '%';
  if (completionBar) completionBar.style.width = percent + '%';
  
  if (previewTitle) previewTitle.textContent = form.elements.title.value || 'Untitled';
  if (previewAuthor) previewAuthor.textContent = form.elements.author.value || 'Unknown Author';
  if (previewCategory) previewCategory.textContent = form.elements.category.value || '-';
  if (previewIsbn) previewIsbn.textContent = form.elements.isbn.value || '-';
  if (previewPublisher) previewPublisher.textContent = form.elements.publisher.value || '-';
  if (previewPages) previewPages.textContent = form.elements.totalCopies.value || '-';
  if (previewCopies) previewCopies.textContent = form.elements.availableCopies.value || '-';
}