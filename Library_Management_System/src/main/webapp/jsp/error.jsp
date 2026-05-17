<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Error | LMS</title>
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@400;500;600;700&display=swap" rel="stylesheet" />
  <style>
    :root {
      --iris-900: #20112f;
      --iris-700: #46256a;
      --iris-500: #7f46c0;
      --iris-400: #9a6bff;
      --iris-200: #e9dcf7;
      --iris-100: #f4edff;
      --amber-500: #c98547;
      --snow: #fbf8ff;
      --ink: #1d1822;
      --ink-soft: #6b5a7d;
      --line: #e5daef;
      --card-radius: 20px;
      --ease-smooth: cubic-bezier(0.22, 1, 0.36, 1);
      --ease-gentle: cubic-bezier(0.2, 0.75, 0.2, 1);
    }

    * { box-sizing: border-box; }
    html, body { margin: 0; min-height: 100%; }

    body {
      font-family: "Space Grotesk", sans-serif;
      color: var(--ink);
      background:
        radial-gradient(circle at 10% 16%, rgba(127,70,192,0.33), transparent 34%),
        radial-gradient(circle at 86% 84%, rgba(154,107,255,0.24), transparent 36%),
        linear-gradient(140deg, #120a18, #27123a 52%, #1a1230);
      display: grid;
      place-items: center;
      padding: 1.5rem;
    }

    .error-shell {
      width: min(94vw, 780px);
      background: linear-gradient(180deg, rgba(251,247,255,0.96), rgba(242,234,250,0.96));
      border: 1px solid rgba(227,216,239,0.95);
      border-radius: var(--card-radius);
      box-shadow: 0 28px 64px rgba(11,8,18,0.4), 0 0 0 1px rgba(255,255,255,0.35) inset;
      overflow: hidden;
      position: relative;
      isolation: isolate;
    }

    .error-shell::before {
      content: "";
      position: absolute;
      inset: -40% -20% auto auto;
      width: 260px;
      height: 260px;
      border-radius: 50%;
      background: radial-gradient(circle, rgba(127,70,192,0.18), rgba(127,70,192,0));
      animation: aura-shift 12s var(--ease-gentle) infinite;
      z-index: 0;
    }

    .error-topbar {
      padding: 1.1rem 1.3rem 1rem;
      color: #f9f4ff;
      background:
        linear-gradient(110deg, #2a123f, #4c2372 46%, #7f46c0),
        repeating-linear-gradient(45deg, rgba(255,255,255,0.08) 0, rgba(255,255,255,0.08) 6px, rgba(255,255,255,0) 6px, rgba(255,255,255,0) 12px);
      position: relative;
      z-index: 1;
    }

    .error-topbar small {
      display: block;
      font-weight: 700;
      letter-spacing: 0.08em;
      text-transform: uppercase;
      color: #decdf5;
      font-size: 0.72rem;
    }

    .error-topbar h1 {
      margin: 0.35rem 0 0;
      font-size: clamp(1.3rem, 2.7vw, 1.7rem);
      display: flex;
      align-items: center;
      gap: 0.6rem;
    }

    .error-badge {
      width: 34px;
      height: 34px;
      border-radius: 11px;
      display: grid;
      place-items: center;
      background: rgba(255,255,255,0.2);
      border: 1px solid rgba(255,255,255,0.35);
    }

    .error-badge svg {
      width: 18px;
      height: 18px;
      stroke: #fff;
      stroke-width: 1.8;
      stroke-linecap: round;
      stroke-linejoin: round;
      fill: none;
    }

    .error-body {
      padding: 1.3rem 1.4rem 1.6rem;
      display: grid;
      gap: 1.1rem;
      position: relative;
      z-index: 1;
    }

    .error-code {
      font-size: clamp(2.5rem, 8vw, 3.6rem);
      font-weight: 700;
      color: #7f46c0;
      line-height: 1;
    }

    .error-title {
      margin: 0;
      font-size: 1.5rem;
    }

    .error-message {
      margin: 0;
      color: var(--ink-soft);
      line-height: 1.6;
    }

    .error-panel {
      border-radius: 16px;
      border: 1px solid #e1d2f5;
      background: linear-gradient(180deg, #fff, #f7f1ff);
      padding: 0.95rem 1rem;
      display: grid;
      gap: 0.45rem;
    }

    .error-panel span {
      font-size: 0.84rem;
      font-weight: 700;
      letter-spacing: 0.06em;
      text-transform: uppercase;
      color: #6a3aa3;
    }

    .error-actions {
      display: flex;
      flex-wrap: wrap;
      gap: 0.7rem;
    }

    .btn-primary,
    .btn-secondary {
      display: inline-flex;
      align-items: center;
      gap: 0.35rem;
      padding: 0.6rem 0.95rem;
      border-radius: 12px;
      font: inherit;
      font-weight: 700;
      font-size: 0.88rem;
      text-decoration: none;
      transition: transform 220ms var(--ease-gentle), box-shadow 220ms var(--ease-gentle), background-color 220ms var(--ease-gentle);
    }

    .btn-primary {
      color: #fff;
      background: linear-gradient(130deg, #3a1f5f, #7f46c0 55%, #9a6bff);
      border: 0;
      box-shadow: 0 10px 26px rgba(74,34,110,0.35);
    }

    .btn-secondary {
      color: #5a2c8a;
      background: #f3ecff;
      border: 1px solid #d5c1f2;
    }

    .btn-primary:hover,
    .btn-secondary:hover {
      transform: translateY(-1px);
      box-shadow: 0 14px 30px rgba(74,34,110,0.4);
    }

    .btn-primary svg,
    .btn-secondary svg {
      width: 14px;
      height: 14px;
      stroke: currentColor;
      stroke-width: 2;
      stroke-linecap: round;
      stroke-linejoin: round;
      fill: none;
    }

    .footer-note {
      margin-top: 0.4rem;
      font-size: 0.78rem;
      color: #7a6a8a;
    }

    @keyframes aura-shift {
      0%, 100% { transform: translate3d(0, 0, 0) scale(1); }
      50% { transform: translate3d(10px, -8px, 0) scale(1.08); }
    }

    @media (max-width: 520px) {
      .error-body { padding: 1.1rem; }
      .error-actions { flex-direction: column; }
      .btn-primary, .btn-secondary { width: 100%; justify-content: center; }
    }

    @media (prefers-reduced-motion: reduce) {
      *, *::before, *::after { animation: none !important; transition: none !important; }
    }
  </style>
</head>
<body>
  <main class="error-shell" role="main">
    <header class="error-topbar">
      <small>Library Management System</small>
      <h1>
        <span class="error-badge" aria-hidden="true">
          <svg viewBox="0 0 24 24"><path d="M12 9v4m0 4h.01M4 5h16v14H4z"/></svg>
        </span>
        Something went wrong
      </h1>
    </header>

    <section class="error-body">
      <div class="error-code">404</div>
      <h2 class="error-title">Page Not Found</h2>
      <p class="error-message">We cannot locate the page you are looking for. It may have moved or been removed. Use the shortcuts below to continue your work.</p>

      <div class="error-panel">
        <span>Quick actions</span>
        <div class="error-actions">
          <a class="btn-primary" href="${pageContext.request.contextPath}/Authentication?action=showLoginPage">
            <svg viewBox="0 0 24 24"><path d="M3 12l9-9 9 9M5 10v10h14V10"/></svg>
            Back to Login
          </a>
        </div>
      </div>

      <div class="footer-note">Developed by Muhammad Ali Abid · Copyright © 2026</div>
    </section>
  </main>
</body>
</html>
