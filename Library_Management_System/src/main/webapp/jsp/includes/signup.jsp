<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>LMS Sign Up</title>
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@400;500;600;700&display=swap"
	rel="stylesheet" />
<style>
:root {
	--purple-dark: #2f1650;
	--purple-mid: #7343b4;
	--purple-light: #c7a8ff;
	--black: #171316;
	--brown: #755139;
	--grey-100: #f2eef5;
	--grey-300: #d5cedc;
	--grey-600: #6a6472;
	--white: #ffffff;
}

* {
	box-sizing: border-box;
}

body {
	margin: 0;
	min-height: 100vh;
	font-family: "Space Grotesk", sans-serif;
	color: var(--black);
	background: radial-gradient(circle at 12% 16%, rgba(199, 168, 255, 0.5),
		transparent 35%),
		radial-gradient(circle at 88% 84%, rgba(115, 67, 180, 0.5),
		transparent 38%),
		linear-gradient(135deg, #120d18, #2a133e 60%, #39174f);
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	gap: 0.5rem;
	padding: 0.8rem;
}

.page-shell {
	width: min(100%, 1080px);
	min-height: calc(100vh - 1.2rem);
	display: grid;
	place-items: center;
}

.page-credit {
	width: min(100%, 1080px);
	text-align: center;
	color: #cfc2df;
	font-size: 0.78rem;
	line-height: 1.35;
}

.page-credit p {
	margin: 0.05rem 0;
}

.auth-layout {
	width: min(100%, 1040px);
	display: grid;
	grid-template-columns: minmax(0, 1.1fr) minmax(320px, 470px);
	gap: 1.55rem;
	align-items: stretch;
	position: relative;
}

.auth-layout::before {
	content: "";
	position: absolute;
	width: 220px;
	height: 220px;
	border-radius: 50%;
	right: 20px;
	bottom: -70px;
	pointer-events: none;
	background: radial-gradient(circle, rgba(191, 156, 255, 0.28),
		transparent 72%);
	animation: orb-drift 10s ease-in-out infinite;
}

.visual-panel {
	position: relative;
	border-radius: 22px;
	padding: clamp(1rem, 2.2vw, 1.55rem);
	overflow: hidden;
	background: linear-gradient(160deg, rgba(23, 19, 22, 0.82),
		rgba(60, 33, 95, 0.88));
	border: 1px solid rgba(199, 168, 255, 0.28);
	box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.08);
	color: #ece4f8;
	animation: panel-breathe 8s ease-in-out infinite;
}

.visual-panel::before, .visual-panel::after {
	content: "";
	position: absolute;
	border-radius: 999px;
	filter: blur(1px);
}

.visual-panel::before {
	width: 230px;
	height: 230px;
	background: radial-gradient(circle, rgba(191, 156, 255, 0.3),
		transparent 70%);
	right: -70px;
	top: -50px;
	animation: orb-drift 7s ease-in-out infinite;
}

.visual-panel::after {
	width: 190px;
	height: 190px;
	background: radial-gradient(circle, rgba(117, 81, 57, 0.26), transparent
		68%);
	left: -55px;
	bottom: -45px;
	animation: orb-drift 9s ease-in-out infinite reverse;
}

.panel-badge {
	width: fit-content;
	font-size: 0.75rem;
	font-weight: 700;
	letter-spacing: 0.08em;
	text-transform: uppercase;
	color: #f7ecff;
	background: rgba(191, 156, 255, 0.18);
	border: 1px solid rgba(191, 156, 255, 0.35);
	border-radius: 999px;
	padding: 0.42rem 0.75rem;
	margin-bottom: 0.75rem;
}

.quick-stats {
	margin-top: 0.7rem;
	display: grid;
	grid-template-columns: repeat(3, minmax(0, 1fr));
	gap: 0.45rem;
}

.quick-stats article {
	border-radius: 10px;
	padding: 0.55rem 0.45rem;
	text-align: center;
	background: rgba(255, 255, 255, 0.04);
	border: 1px solid rgba(199, 168, 255, 0.24);
}

.quick-stats strong {
	display: block;
	color: #f8f2ff;
	font-size: 0.9rem;
}

.quick-stats span {
	display: block;
	margin-top: 0.2rem;
	color: #d2c5e3;
	font-size: 0.68rem;
	text-transform: uppercase;
	letter-spacing: 0.05em;
}

.visual-panel h2 {
	margin: 0;
	font-size: clamp(1.4rem, 3vw, 2rem);
	line-height: 1.05;
	max-width: 12ch;
}

.visual-panel p {
	margin: 0.75rem 0 0;
	max-width: 42ch;
	color: #d6cae5;
	line-height: 1.5;
}

.project-points {
	margin-top: 0.72rem;
	display: grid;
	gap: 0.52rem;
}

.project-points article {
	background: rgba(255, 255, 255, 0.05);
	border: 1px solid rgba(199, 168, 255, 0.23);
	border-radius: 12px;
	padding: 0.62rem 0.72rem;
	backdrop-filter: blur(2px);
	transition: transform 220ms ease, border-color 220ms ease,
		background-color 220ms ease;
}

.project-points article:hover {
	transform: translateY(-2px);
	border-color: rgba(199, 168, 255, 0.42);
	background: rgba(255, 255, 255, 0.08);
}

.project-points h3 {
	margin: 0;
	font-size: 0.95rem;
	color: #f2e9ff;
}

.project-points article p {
	margin-top: 0.35rem;
	font-size: 0.85rem;
	color: #d0c3df;
}

.project-meta {
	margin-top: 0.62rem;
	display: flex;
	flex-wrap: wrap;
	gap: 0.45rem;
}

.project-meta span {
	font-size: 0.72rem;
	letter-spacing: 0.04em;
	text-transform: uppercase;
	color: #efe4ff;
	border-radius: 999px;
	border: 1px solid rgba(191, 156, 255, 0.32);
	background: rgba(191, 156, 255, 0.16);
	padding: 0.33rem 0.58rem;
}

.book-stack {
	display: grid;
	gap: 0.36rem;
	margin-top: 0.72rem;
}

.book-stack span {
	height: 10px;
	border-radius: 999px;
	background: linear-gradient(90deg, rgba(191, 156, 255, 0.5),
		rgba(117, 81, 57, 0.5));
	border: 1px solid rgba(236, 228, 248, 0.25);
	transform-origin: left;
	animation: bar-wave 5s ease-in-out infinite;
}

.book-stack span:nth-child(2) {
	width: 88%;
	animation-delay: 0.4s;
}

.book-stack span:nth-child(3) {
	width: 74%;
	animation-delay: 0.8s;
}

.signup-card {
	width: min(100%, 470px);
	padding: 1.4rem 1.25rem 1.15rem;
	border-radius: 22px;
	background: linear-gradient(180deg, #ffffff 0%, #f7f2ff 100%);
	border: 1px solid rgba(213, 206, 220, 0.95);
	box-shadow: 0 24px 60px rgba(9, 6, 14, 0.58), 0 0 0 1px
		rgba(255, 255, 255, 0.45) inset;
	animation: card-pop 520ms ease-out both, card-float 7.5s ease-in-out
		620ms infinite;
}

.signup-card>* {
	animation: fade-rise 540ms ease-out both;
}

.signup-card>*:nth-child(1) {
	animation-delay: 110ms;
}

.signup-card>*:nth-child(2) {
	animation-delay: 180ms;
}

.signup-card>*:nth-child(3) {
	animation-delay: 240ms;
}

.signup-card>*:nth-child(4) {
	animation-delay: 300ms;
}

.top-logo {
	width: 76px;
	height: 76px;
	margin: 0 auto 0.68rem;
	display: grid;
	place-items: center;
	border-radius: 22px;
	background: linear-gradient(145deg, rgba(199, 168, 255, 0.28),
		rgba(117, 81, 57, 0.12));
	border: 1px solid rgba(117, 81, 57, 0.24);
}

.top-logo svg {
	width: 62px;
	height: 62px;
}

.brand-row {
	display: flex;
	justify-content: center;
	margin-bottom: 0.5rem;
}

.eyebrow {
	margin: 0;
	font-size: 0.74rem;
	letter-spacing: 0.09em;
	font-weight: 700;
	color: var(--grey-600);
	text-transform: uppercase;
	text-align: center;
}

h1 {
	margin: 0.2rem 0 0;
	font-size: 1.38rem;
	line-height: 1.15;
	text-align: center;
}

.subtitle {
	margin: 0.52rem 0 0.9rem;
	color: #5b5562;
	line-height: 1.45;
	text-align: center;
}

.trust-row {
	margin: -0.2rem 0 0.72rem;
	display: flex;
	justify-content: center;
	gap: 0.4rem;
	flex-wrap: wrap;
}

.trust-row span {
	font-size: 0.69rem;
	letter-spacing: 0.04em;
	text-transform: uppercase;
	color: #6c5f7d;
	background: #f3ecff;
	border: 1px solid #ddd2ee;
	border-radius: 999px;
	padding: 0.28rem 0.52rem;
}

.signup-form {
	display: grid;
	gap: 0.55rem;
}

.field-grid {
	display: grid;
	gap: 0.6rem;
}

.field-grid.two-col {
	grid-template-columns: repeat(2, minmax(0, 1fr));
}

.field {
	display: grid;
	gap: 0.35rem;
	font-size: 0.9rem;
	font-weight: 600;
	color: #332d38;
}

input, select, textarea {
	width: 100%;
	border: 1px solid var(--grey-300);
	border-radius: 12px;
	padding: 0.72rem 0.82rem;
	font: inherit;
	color: var(--black);
	background: var(--white);
	transition: border-color 180ms ease, box-shadow 180ms ease;
}

textarea {
	resize: vertical;
	min-height: 90px;
}

.password-wrap {
	position: relative;
}

.password-wrap input {
	padding-right: 2.8rem;
}

.toggle-password {
	position: absolute;
	right: 0.45rem;
	top: 50%;
	transform: translateY(-50%);
	width: 34px;
	height: 34px;
	border: 0;
	margin: 0;
	border-radius: 10px;
	background: transparent;
	color: #4a4360;
	display: grid;
	place-items: center;
	padding: 0;
	box-shadow: none;
	cursor: pointer;
}

.toggle-password svg {
	width: 20px;
	height: 20px;
}

.toggle-password .eye-off {
	display: none;
}

.toggle-password[aria-pressed="true"] .eye-open {
	display: none;
}

.toggle-password[aria-pressed="true"] .eye-off {
	display: block;
}

.toggle-password:hover {
	transform: translateY(-50%);
	background: rgba(199, 168, 255, 0.22);
}

input::placeholder, textarea::placeholder {
	color: #a29aa9;
}

input:focus, select:focus, textarea:focus {
	outline: none;
	border-color: var(--purple-mid);
	box-shadow: 0 0 0 4px rgba(115, 67, 180, 0.17);
}

input[readonly] {
	background: #f5f0fb;
	color: #6d6675;
}

.form-footer {
	display: grid;
	gap: 0.6rem;
	margin-top: 0.1rem;
}

.system-note {
	font-size: 0.78rem;
	color: #6f667a;
	text-align: center;
}

button {
	border: none;
	border-radius: 12px;
	padding: 0.74rem 0.9rem;
	font: inherit;
	font-weight: 700;
	color: var(--white);
	cursor: pointer;
	background: linear-gradient(135deg, #2a133d, #7443b6 58%, #8a58cf 100%);
	box-shadow: 0 12px 26px rgba(42, 19, 61, 0.44);
	transition: transform 160ms ease, box-shadow 160ms ease, filter 160ms
		ease;
}

.sign-up-btn {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	gap: 0.5rem;
	position: relative;
	overflow: hidden;
}

.sign-up-btn svg {
	width: 18px;
	height: 18px;
}

.sign-up-btn::after {
	content: "";
	position: absolute;
	top: -40%;
	left: -30%;
	width: 35%;
	height: 180%;
	background: linear-gradient(180deg, rgba(255, 255, 255, 0),
		rgba(255, 255, 255, 0.35), rgba(255, 255, 255, 0));
	transform: rotate(24deg);
	animation: btn-shine 3.8s ease-in-out infinite;
}

button:hover {
	transform: translateY(-1px);
	filter: brightness(1.06);
}

button:active {
	transform: translateY(0);
}

.support-links {
	margin-top: 0.55rem;
	text-align: center;
	display: grid;
	gap: 0.38rem;
}

.support-links p {
	margin: 0;
	font-size: 0.9rem;
	color: #615c68;
}

.text-link {
	color: #5f35a1;
	font-size: 0.92rem;
	font-weight: 600;
	text-decoration: none;
	transition: color 160ms ease;
}

.text-link:hover {
	color: #3d2168;
	text-decoration: underline;
}

.security-note {
	margin-top: 0.45rem;
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 0.4rem;
	color: #6f667a;
	font-size: 0.78rem;
	text-align: center;
}

.security-note svg {
	width: 16px;
	height: 16px;
	color: #5f35a1;
	flex: none;
}

.flash-message {
  display: flex;
  align-items: center;
  gap: 0.6rem;
  padding: 0.75rem 1rem;
  border-radius: 12px;
  font-weight: 700;
  font-size: 0.88rem;
  border: 1px solid transparent;
  box-shadow: 0 8px 18px rgba(29, 21, 41, 0.08);
}

.flash-success {
  background: rgba(44, 163, 136, 0.12);
  color: #0f6a59;
  border-color: rgba(44, 163, 136, 0.35);
}

.flash-error {
  background: rgba(220, 53, 69, 0.12);
  color: #8b1a25;
  border-color: rgba(220, 53, 69, 0.35);
}

@
keyframes card-pop { 0% {
	opacity: 0;
	transform: translateY(16px) scale(0.98);
}

100


%
{
opacity


:


1
;


transform


:


translateY
(


0


)


scale
(


1


)
;


}
}
@
keyframes card-float { 0%, 100% {
	transform: translateY(0);
}

50


%
{
transform


:


translateY
(


-6px


)
;


}
}
@
keyframes panel-breathe { 0%, 100% {
	filter: saturate(1);
}

50


%
{
filter


:


saturate
(


1
.14


)
;


}
}
@
keyframes orb-drift { 0%, 100% {
	transform: translate(0, 0);
}

50


%
{
transform


:


translate
(


10px
,
-8px


)
;


}
}
@
keyframes bar-wave { 0%, 100% {
	transform: scaleX(0.96);
}

50


%
{
transform


:


scaleX
(


1


)
;


}
}
@
keyframes btn-shine { 0%, 100% {
	left: -35%;
	opacity: 0;
}

30


%
{
opacity


:


1
;


}
55


%
{
left


:


115
%;


opacity


:


0
;


}
}
@
keyframes fade-rise {from { opacity:0;
	transform: translateY(10px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
@media ( max-width : 900px) {
	.auth-layout {
		grid-template-columns: 1fr;
		max-width: 520px;
		gap: 0.9rem;
	}
	.visual-panel {
		order: 2;
	}
	.signup-card {
		order: 1;
	}
	.quick-stats {
		grid-template-columns: repeat(3, minmax(0, 1fr));
	}
}

@media ( max-width : 720px) {
	.field-grid.two-col {
		grid-template-columns: 1fr;
	}
}

@media ( max-width : 540px) {
	.auth-layout {
		grid-template-columns: 1fr;
		gap: 0.75rem;
	}
	.visual-panel {
		padding: 1.3rem;
		border-radius: 18px;
	}
	.signup-card {
		border-radius: 18px;
		padding: 1.3rem 1.1rem 1.15rem;
	}
	.top-logo {
		width: 82px;
		height: 82px;
		margin-bottom: 0.85rem;
	}
	h1 {
		font-size: 1.28rem;
	}
	.subtitle {
		font-size: 0.94rem;
	}
	.trust-row {
		margin-top: -0.2rem;
		margin-bottom: 0.95rem;
	}
}

@media ( max-width : 420px) {
	body {
		padding: 0.75rem;
	}
	.page-credit {
		font-size: 0.72rem;
	}
	.quick-stats {
		grid-template-columns: 1fr;
	}
	.project-meta {
		gap: 0.35rem;
	}
	.trust-row span {
		font-size: 0.64rem;
	}
	.security-note {
		font-size: 0.74rem;
	}
}

@media ( min-width : 1200px) {
	.page-shell {
		width: min(100%, 1180px);
	}
	.auth-layout {
		width: min(100%, 1100px);
		grid-template-columns: minmax(0, 1.2fr) 470px;
		gap: 1.85rem;
	}
}

@media ( prefers-reduced-motion : reduce) {
	*, *::before, *::after {
		animation: none !important;
		transition: none !important;
	}
}
</style>
</head>
<body>
	<main class="page-shell">
		<section class="auth-layout">
			<aside class="visual-panel" aria-hidden="true">
				<div class="panel-badge">LMS Portal</div>
				<h2>Welcome to the Stack</h2>
				<p>Create a secure profile to access catalog tools, member
					services, and circulation controls.</p>

				<div class="quick-stats">
					<article>
						<strong>10k+</strong> <span>Books Managed</span>
					</article>
					<article>
						<strong>2.4k</strong> <span>Active Members</span>
					</article>
					<article>
						<strong>24/7</strong> <span>Secure Access</span>
					</article>
				</div>

				<div class="project-points">
					<article>
						<h3>Member Profiles</h3>
						<p>Track roles, status, and activity with clean records.</p>
					</article>
					<article>
						<h3>Controlled Access</h3>
						<p>Assign roles for librarians, admins, and members.</p>
					</article>
					<article>
						<h3>Reliable Records</h3>
						<p>Keep contact details aligned for faster operations.</p>
					</article>
				</div>

				<div class="project-meta">
					<span>Account Creation</span> <span>Role Assignment</span> <span>Secure
						Data</span>
				</div>

				<div class="book-stack">
					<span></span> <span></span> <span></span>
				</div>
			</aside>

			<section class="signup-card" aria-labelledby="signup-title">
				<div class="top-logo" aria-hidden="true">
					<svg viewBox="0 0 88 88" role="img">
              <defs>
                <linearGradient id="crestFill" x1="0%" y1="0%" x2="100%"
							y2="100%">
                  <stop offset="0%" stop-color="#bf9cff" />
                  <stop offset="100%" stop-color="#6d34c4" />
                </linearGradient>
              </defs>
              <path
							d="M44 6c13 8 24 9 33 10 0 35-7 51-33 66C18 67 11 51 11 16c9-1 20-2 33-10z"
							fill="url(#crestFill)" />
              <path
							d="M44 16c8 5 15 6 21 7 0 24-5 35-21 47-16-12-21-23-21-47 6-1 13-2 21-7z"
							fill="#f6efff" />
              <path d="M34 33h20M34 42h20M34 51h13" stroke="#443030"
							stroke-width="3" stroke-linecap="round" stroke-linejoin="round" />
              <path d="M55 52l8 8" stroke="#7f5f35" stroke-width="4"
							stroke-linecap="round" />
            </svg>
				</div>

				<div class="brand-row">
					<div class="brand-copy">
						<p class="eyebrow">Library Management System</p>
						<h1 id="signup-title">Create Account</h1>
					</div>
				</div>

				<p class="subtitle">Register a new user profile for staff or
					members of the library.</p>

				<div class="trust-row" aria-hidden="true">
					<span>Secure Storage</span> <span>Role Based</span> <span>Fast
						Setup</span>
				</div>

				<c:if test="${not empty errorMessage}">
					<div class="flash-message flash-error">
						<span>${errorMessage}</span>
					</div>
				</c:if>

				<form class="signup-form" action="${pageContext.request.contextPath}/UserController" method="post">
					<input type="hidden" name="action" value="signupAdmin" />
					<input type="hidden" name="role" value="Admin" />
					<div class="field-grid two-col">
						<label class="field"> <span>First Name</span> <input
							type="text" name="firstName" placeholder="John"
							autocomplete="given-name" required />
						</label> <label class="field"> <span>Last Name</span> <input
							type="text" name="lastName" placeholder="Doe"
							autocomplete="family-name" required />
						</label>
					</div>

					<div class="field-grid two-col">
						<label class="field"> <span>Email</span> <input
							type="email" name="email" placeholder="john.doe@example.com"
							autocomplete="email" required />
						</label> <label class="field"> <span>Phone Number</span> <input
							type="tel" name="phoneNo" placeholder="+1 (555) 123-4567"
							autocomplete="tel" required />
						</label>
					</div>

					<div class="field-grid two-col">
						<label class="field"> <span>Role</span>
							<input type="hidden" name="role" value="Admin">
							<select disabled>
								<option selected>Admin</option>
							</select>
						</label> <label class="field"> <span>Password</span>
							<div class="password-wrap">
								<input id="password" type="password" name="password"
									placeholder="Create a password" autocomplete="new-password"
									required />
								<button class="toggle-password" type="button"
									id="togglePassword" aria-label="Show password"
									aria-pressed="false">
									<svg class="eye-open" viewBox="0 0 24 24" aria-hidden="true">
                      <path
											d="M1.5 12s3.9-6.5 10.5-6.5S22.5 12 22.5 12s-3.9 6.5-10.5 6.5S1.5 12 1.5 12z"
											fill="none" stroke="currentColor" stroke-width="1.9"
											stroke-linecap="round" stroke-linejoin="round" />
                      <circle cx="12" cy="12" r="3.2" fill="none"
											stroke="currentColor" stroke-width="1.9" />
                    </svg>
									<svg class="eye-off" viewBox="0 0 24 24" aria-hidden="true">
                      <path
											d="M2 2l20 20M10.6 5.7A10.8 10.8 0 0112 5.5c6.6 0 10.5 6.5 10.5 6.5a17.3 17.3 0 01-4.1 4.8M6.7 6.7A17.5 17.5 0 001.5 12S5.4 18.5 12 18.5c1.4 0 2.7-.3 3.9-.7"
											fill="none" stroke="currentColor" stroke-width="1.9"
											stroke-linecap="round" stroke-linejoin="round" />
                    </svg>
								</button>
							</div>
						</label>
					</div>

					<label class="field"> <span>Address</span> <textarea
							name="address" placeholder="Enter full address" rows="3" required></textarea>
					</label>



					<div class="form-footer">
						<div class="system-note">System fields are generated
							automatically on save.</div>
						<button type="submit" class="sign-up-btn">
							<svg viewBox="0 0 24 24" aria-hidden="true">
                  <path d="M13 4.5l6.5 7.5-6.5 7.5M4.5 12h14"
									fill="none" stroke="currentColor" stroke-width="2"
									stroke-linecap="round" stroke-linejoin="round" />
                </svg>
							<span>Create Account</span>
						</button>
					</div>

					<div class="support-links">
						<p>
							Already have an account? <a
								href="${pageContext.request.contextPath}/BookController?action=showLogin"
								class="text-link"> Sign in here </a>
						</p>
					</div>

					<div class="security-note">
						<svg viewBox="0 0 24 24" aria-hidden="true">
                <path
								d="M12 3.2l7 2.9v5.1c0 5-2.9 8.8-7 10.6-4.1-1.8-7-5.6-7-10.6V6.1l7-2.9zm-2.2 8.7l1.6 1.6 2.9-3"
								fill="none" stroke="currentColor" stroke-width="1.8"
								stroke-linecap="round" stroke-linejoin="round" />
              </svg>
						<span>Encrypted signup with secure data handling.</span>
					</div>
				</form>
			</section>
		</section>
	</main>

	<footer class="page-credit">
		<p>Developed by Muhammad Ali Abid</p>
		<p>Copyright © 2026. All rights reserved.</p>
	</footer>

	<script>
		document.addEventListener("DOMContentLoaded", function() {
			const passwordInput = document.getElementById("password");
			const togglePassword = document.getElementById("togglePassword");
			const createdAtInput = document.getElementById("createdAt");

			if (createdAtInput) {
				const now = new Date();
				const timestamp = now.toISOString().slice(0, 19).replace("T",
						" ");
				createdAtInput.value = timestamp;
			}

			if (togglePassword && passwordInput) {
				togglePassword.addEventListener("click", function() {
					const shouldShow = passwordInput.type === "password";
					passwordInput.type = shouldShow ? "text" : "password";
					this.setAttribute("aria-pressed", String(shouldShow));
					this.setAttribute("aria-label",
							shouldShow ? "Hide password" : "Show password");
				});
			}
		});
	</script>
</body>
</html>