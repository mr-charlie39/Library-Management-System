
document.addEventListener("DOMContentLoaded", () => {

  /* ────────────────────────────────────────────
     REFERENCES
  ──────────────────────────────────────────── */
  const loader    = document.getElementById("entryLoader");
  const reveals   = document.querySelectorAll("[data-reveal]");
  const form      = document.getElementById("bookForm");

  // Form fields (via name — no id needed)
  const titleInput          = form.elements["bookTitle"];
  const authorInput         = form.elements["author"];
  const categoryInput       = form.elements["category"];
  const isbnInput           = form.elements["isbn"];
  const publisherInput      = form.elements["publisher"];
  const totalCopiesInput    = form.elements["totalCopies"];
  const availableCopiesInput = form.elements["availableCopies"];

  // Preview elements
  const previewTitle          = document.getElementById("previewTitle");
  const previewAuthor         = document.getElementById("previewAuthor");
  const previewCategory       = document.getElementById("previewCategory");
  const previewIsbn           = document.getElementById("previewIsbn");
  const previewPublisher      = document.getElementById("previewPublisher");
  const previewTotalCopies    = document.getElementById("previewTotalCopies");
  const previewAvailableCopies = document.getElementById("previewAvailableCopies");

  // Completion bar
  const completionText = document.getElementById("completionText");
  const completionBar  = document.getElementById("completionBar");

  /* ────────────────────────────────────────────
     INJECT ERROR SPANS DYNAMICALLY
     (placed right after each input/select)
  ──────────────────────────────────────────── */
  function createErrorSpan(field) {
    const span = document.createElement("span");
    span.className = "field-error";
    span.style.cssText = "color:#e05252;font-size:.78rem;margin-top:4px;display:block;min-height:1em;";
    field.insertAdjacentElement("afterend", span);
    return span;
  }

  const titleError          = createErrorSpan(titleInput);
  const authorError         = createErrorSpan(authorInput);
  const categoryError       = createErrorSpan(categoryInput);
  const isbnError           = createErrorSpan(isbnInput);
  const publisherError      = createErrorSpan(publisherInput);
  const totalCopiesError    = createErrorSpan(totalCopiesInput);
  const availableCopiesError = createErrorSpan(availableCopiesInput);

  /* ────────────────────────────────────────────
     INDIVIDUAL FIELD VALIDATORS
     Each returns true if valid, false if not.
  ──────────────────────────────────────────── */
  function validateTitle() {
    const val = titleInput.value.trim();
    if (!val) {
      titleError.textContent = "Book title is required.";
      return false;
    }
    titleError.textContent = "";
    return true;
  }

  function validateAuthor() {
    const val = authorInput.value.trim();
    if (!val) {
      authorError.textContent = "Author name is required.";
      return false;
    }
    authorError.textContent = "";
    return true;
  }

  function validateCategory() {
    if (!categoryInput.value) {
      categoryError.textContent = "Please choose a category.";
      return false;
    }
    categoryError.textContent = "";
    return true;
  }

  function validateIsbn() {
    const val = isbnInput.value.trim();
    if (!val) {
      isbnError.textContent = "ISBN is required.";
      return false;
    }
    if (!/^\d+$/.test(val)) {
      isbnError.textContent = "ISBN must contain digits only.";
      return false;
    }
    if (val.length < 10) {
      isbnError.textContent = "ISBN must be at least 10 digits.";
      return false;
    }
    if (val.length !== 10 && val.length !== 13) {
      isbnError.textContent = "ISBN must be exactly 10 or 13 digits.";
      return false;
    }
    isbnError.textContent = "";
    return true;
  }

  function validatePublisher() {
    const val = publisherInput.value.trim();
    if (!val) {
      publisherError.textContent = "Publisher name is required.";
      return false;
    }
    publisherError.textContent = "";
    return true;
  }

  function validateTotalCopies() {
    const val   = totalCopiesInput.value.trim();
    const num   = Number(val);
    if (!val) {
      totalCopiesError.textContent = "Total copies is required.";
      return false;
    }
    if (Number.isNaN(num) || !Number.isInteger(num) || num < 1) {
      totalCopiesError.textContent = "Total copies must be a whole number of at least 1.";
      return false;
    }
    totalCopiesError.textContent = "";
    return true;
  }

  function validateAvailableCopies() {
    const aVal  = availableCopiesInput.value.trim();
    const tVal  = totalCopiesInput.value.trim();
    const aNum  = Number(aVal);
    const tNum  = Number(tVal);

    if (aVal === "") {
      availableCopiesError.textContent = "Available copies is required.";
      return false;
    }
    if (Number.isNaN(aNum) || !Number.isInteger(aNum) || aNum < 0) {
      availableCopiesError.textContent = "Available copies must be 0 or more.";
      return false;
    }
    if (!Number.isNaN(tNum) && aNum > tNum) {
      availableCopiesError.textContent = "Available copies cannot exceed total copies.";
      return false;
    }
    availableCopiesError.textContent = "";
    return true;
  }

  /* ────────────────────────────────────────────
     BLUR VALIDATION (validate as user leaves field)
  ──────────────────────────────────────────── */
  titleInput.addEventListener("blur", validateTitle);
  authorInput.addEventListener("blur", validateAuthor);
  categoryInput.addEventListener("blur", validateCategory);
  isbnInput.addEventListener("blur", validateIsbn);
  publisherInput.addEventListener("blur", validatePublisher);
  totalCopiesInput.addEventListener("blur", () => {
    validateTotalCopies();
    validateAvailableCopies(); // re-check available when total changes
  });
  availableCopiesInput.addEventListener("blur", validateAvailableCopies);

  /* ────────────────────────────────────────────
     SUBMIT VALIDATION (single listener)
  ──────────────────────────────────────────── */
  form.addEventListener("submit", (event) => {
    const isValid = [
      validateTitle(),
      validateAuthor(),
      validateCategory(),
      validateIsbn(),
      validatePublisher(),
      validateTotalCopies(),
      validateAvailableCopies(),
    ].every(Boolean); // runs ALL validators so all errors show at once

    if (!isValid) {
      event.preventDefault();
      // Scroll to first visible error
      const firstError = form.querySelector(".field-error:not(:empty)");
      if (firstError) firstError.scrollIntoView({ behavior: "smooth", block: "center" });
      return;
    }

    form.classList.add("submitted");
    setTimeout(() => form.classList.remove("submitted"), 700);
  });

  /* ────────────────────────────────────────────
     LIVE PREVIEW
  ──────────────────────────────────────────── */
  function applyPreview() {
    previewTitle.textContent          = titleInput.value.trim()           || "Untitled Book";
    previewAuthor.textContent         = authorInput.value.trim()          || "Unknown Author";
    previewCategory.textContent       = categoryInput.value               || "-";
    previewIsbn.textContent           = isbnInput.value.trim()            || "-";
    previewPublisher.textContent      = publisherInput.value.trim()       || "-";
    previewTotalCopies.textContent    = totalCopiesInput.value.trim()     || "-";
    previewAvailableCopies.textContent = availableCopiesInput.value.trim() || "-";
  }

  /* ────────────────────────────────────────────
     COMPLETION BAR
  ──────────────────────────────────────────── */
  const trackedFields = [
    titleInput, authorInput, categoryInput,
    isbnInput, publisherInput, totalCopiesInput, availableCopiesInput,
  ];

  function updateCompletion() {
    const filled  = trackedFields.filter(f => f.value.trim() !== "").length;
    const percent = Math.round((filled / trackedFields.length) * 100);
    completionText.textContent  = `${percent}%`;
    completionBar.style.width   = `${percent}%`;
  }

  form.addEventListener("input", () => {
    applyPreview();
    updateCompletion();
  });

  form.addEventListener("reset", () => {
    requestAnimationFrame(() => {
      applyPreview();
      updateCompletion();
      // Clear all error messages on reset
      [titleError, authorError, categoryError, isbnError,
       publisherError, totalCopiesError, availableCopiesError]
        .forEach(el => el.textContent = "");
    });
  });

  /* ────────────────────────────────────────────
     SCROLL REVEAL
  ──────────────────────────────────────────── */
  const revealObserver = new IntersectionObserver(
    (entries) => entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add("visible");
        revealObserver.unobserve(entry.target);
      }
    }),
    { threshold: 0.15 }
  );

  reveals.forEach((item, i) => {
    item.style.setProperty("--delay", `${i * 85}ms`);
    revealObserver.observe(item);
  });

  /* ────────────────────────────────────────────
     PAGE LOADER
  ──────────────────────────────────────────── */
  window.addEventListener("load", () => {
    setTimeout(() => {
      document.body.classList.add("loaded");
      loader.setAttribute("aria-hidden", "true");
      applyPreview();
      updateCompletion();
    }, 980);
  });

});
