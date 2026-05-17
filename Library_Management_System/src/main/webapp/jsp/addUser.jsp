<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Add User | LMS</title>
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link
    href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@400;500;600;700&display=swap"
    rel="stylesheet"
  />
  <style>
  :root {
  --iris-900: #20112f;
  --iris-700: #46256a;
  --iris-500: #7f46c0;
  --mint-500: #2ca388;
  --amber-500: #c98547;
  --sky-500: #3a90c8;
  --snow: #fbf8ff;
  --ink: #1d1822;
  --ink-soft: #655a72;
  --line: #e5daef;
  --card-radius: 18px;
  --ease-smooth: cubic-bezier(0.22, 1, 0.36, 1);
  --ease-gentle: cubic-bezier(0.2, 0.75, 0.2, 1);
}

* {
  box-sizing: border-box;
}

html,
body {
  margin: 0;
  min-height: 100%;
}

body {
  font-family: "Space Grotesk", sans-serif;
  color: var(--ink);
  background:
    radial-gradient(circle at 10% 16%, rgba(127, 70, 192, 0.33), transparent 34%),
    radial-gradient(circle at 86% 84%, rgba(44, 163, 136, 0.22), transparent 36%),
    linear-gradient(140deg, #120a18, #27123a 52%, #1a2d39);
  overflow-x: hidden;
}

/* ==================== ENTRY LOADER ==================== */

.entry-loader {
  position: fixed;
  inset: 0;
  z-index: 1400;
  display: grid;
  place-items: center;
  background:
    radial-gradient(circle at 20% 20%, rgba(127, 70, 192, 0.2), transparent 33%),
    rgba(9, 6, 14, 0.88);
  transition: opacity 560ms var(--ease-smooth), visibility 560ms var(--ease-smooth);
}

body.loaded .entry-loader {
  opacity: 0;
  visibility: hidden;
  pointer-events: none;
}

.loader-card {
  width: min(92vw, 365px);
  border-radius: 22px;
  border: 1px solid rgba(196, 161, 235, 0.32);
  background: linear-gradient(160deg, rgba(36, 21, 52, 0.93), rgba(42, 31, 70, 0.92));
  padding: 1.2rem;
  text-align: center;
  box-shadow: 0 24px 58px rgba(9, 6, 15, 0.55);
}

.loader-icon {
  width: 72px;
  height: 72px;
  margin: 0 auto 0.9rem;
  border-radius: 16px;
  border: 1px solid rgba(255, 255, 255, 0.18);
  position: relative;
  background: linear-gradient(145deg, rgba(127, 70, 192, 0.32), rgba(44, 163, 136, 0.22));
}

.loader-icon::before,
.loader-icon::after {
  content: "";
  position: absolute;
  border-radius: 12px;
  inset: 12px;
  border: 2px solid rgba(247, 241, 255, 0.82);
  animation: pulse-ring 1.8s var(--ease-gentle) infinite;
}

.loader-icon::after {
  inset: 21px;
  animation-delay: 240ms;
  border-color: rgba(127, 70, 192, 0.95);
}

.loader-card h1 {
  margin: 0;
  font-size: 1.08rem;
  color: #f8f1ff;
}

.loader-card p {
  margin: 0.42rem 0 0.85rem;
  color: #d5c6e8;
  font-size: 0.89rem;
}

.loader-bars {
  display: grid;
  gap: 0.4rem;
}

.loader-bars span {
  display: block;
  height: 8px;
  width: 100%;
  border-radius: 999px;
  transform-origin: left;
  background: linear-gradient(90deg, rgba(191, 156, 255, 0.88), rgba(44, 163, 136, 0.68));
  animation: loader-wave 1.2s var(--ease-gentle) infinite;
}

.loader-bars span:nth-child(2) {
  width: 88%;
  animation-delay: 100ms;
}

.loader-bars span:nth-child(3) {
  width: 72%;
  animation-delay: 200ms;
}

/* ==================== ANIMATIONS ==================== */

@keyframes pulse-ring {
  0%,
  100% {
    transform: scale(1);
    opacity: 1;
  }
  50% {
    transform: scale(1.08);
    opacity: 0.6;
  }
}

@keyframes loader-wave {
  0% {
    transform: scaleX(0);
    opacity: 0.4;
  }
  50% {
    opacity: 1;
  }
  100% {
    transform: scaleX(1);
    opacity: 0.4;
  }
}

@keyframes aura-shift {
  0%,
  100% {
    transform: translate(0, 0) scale(1);
  }
  25% {
    transform: translate(12px, -8px) scale(1.05);
  }
  50% {
    transform: translate(0, 12px) scale(0.95);
  }
  75% {
    transform: translate(-12px, -4px) scale(1.08);
  }
}

@keyframes float-mark {
  0%,
  100% {
    transform: translateY(0px);
  }
  50% {
    transform: translateY(-4px);
  }
}

@keyframes shimmer {
  0% {
    transform: translateX(-110%);
  }
  100% {
    transform: translateX(110%);
  }
}

@keyframes pulse-card {
  0% {
    transform: scale(1);
  }
  50% {
    transform: scale(1.01);
  }
  100% {
    transform: scale(1);
  }
}

@keyframes glow-border {
  0%,
  100% {
    box-shadow: 0 0 0 0 rgba(127, 70, 192, 0.4);
  }
  50% {
    box-shadow: 0 0 0 8px rgba(127, 70, 192, 0);
  }
}

@keyframes slide-in-left {
  from {
    opacity: 0;
    transform: translateX(-20px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

@keyframes fade-in-up {
  from {
    opacity: 0;
    transform: translateY(12px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* ==================== AMBIENT ORBS ==================== */

.ambient {
  position: fixed;
  inset: 0;
  pointer-events: none;
  z-index: -1;
}

.orb {
  position: absolute;
  border-radius: 50%;
  filter: blur(60px);
  opacity: 0.6;
  animation: aura-shift 15s var(--ease-gentle) infinite;
}

.orb-a {
  width: 380px;
  height: 380px;
  left: -100px;
  top: 20%;
  background: radial-gradient(circle, rgba(127, 70, 192, 0.58), rgba(127, 70, 192, 0));
}

.orb-b {
  width: 320px;
  height: 320px;
  right: -90px;
  top: 60%;
  background: radial-gradient(circle, rgba(44, 163, 136, 0.5), rgba(44, 163, 136, 0));
  animation-delay: 4s;
}

.orb-c {
  width: 180px;
  height: 180px;
  right: 28%;
  top: 8%;
  background: radial-gradient(circle, rgba(201, 133, 71, 0.5), rgba(201, 133, 71, 0));
  animation-delay: 7s;
}

/* ==================== APP SHELL ==================== */

.app-shell {
  width: min(100%, 1320px);
  min-height: 100vh;
  margin-inline: auto;
  padding: 1rem;
  display: grid;
  grid-template-columns: 250px minmax(0, 1fr);
  gap: 1rem;
  opacity: 0;
  transform: translateY(14px) scale(0.99);
  filter: blur(4px);
  transition:
    opacity 760ms var(--ease-smooth),
    transform 760ms var(--ease-smooth),
    filter 760ms var(--ease-smooth);
  will-change: opacity, transform, filter;
}

body.loaded .app-shell {
  opacity: 1;
  transform: translateY(0) scale(1);
  filter: blur(0);
}

/* ==================== SIDEBAR ==================== */

.sidebar {
  border-radius: 22px;
  background: linear-gradient(180deg, rgba(32, 19, 45, 0.95), rgba(24, 18, 34, 0.93));
  border: 1px solid rgba(196, 161, 235, 0.26);
  box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.08);
  padding: 1rem 0.75rem;
  color: #efe4fa;
  position: sticky;
  top: 1rem;
  height: calc(100vh - 2rem);
  overflow-y: auto;
}

.brand {
  display: flex;
  align-items: center;
  gap: 0.65rem;
  padding: 0.4rem 0.55rem 1rem;
}

.brand-mark {
  width: 42px;
  height: 42px;
  border-radius: 12px;
  display: grid;
  place-items: center;
  font-size: 1.1rem;
  background: linear-gradient(145deg, rgba(127, 70, 192, 0.3), rgba(44, 163, 136, 0.2));
  border: 1px solid rgba(196, 161, 235, 0.34);
}

.brand-text strong {
  display: block;
  color: #faf5ff;
  font-size: 1rem;
}

.brand-text span {
  color: #bcacd3;
  font-size: 0.78rem;
}

.nav-section {
  margin-top: 0.25rem;
  display: grid;
  gap: 0.3rem;
}

.nav-link {
  border: 0;
  width: 100%;
  text-align: left;
  display: flex;
  align-items: center;
  gap: 0.65rem;
  padding: 0.68rem 0.74rem;
  border-radius: 12px;
  font: inherit;
  font-weight: 600;
  font-size: 0.92rem;
  color: #cfbddf;
  background: transparent;
  cursor: pointer;
  text-decoration: none;
  transition:
    background-color 260ms var(--ease-gentle),
    color 260ms var(--ease-gentle),
    transform 260ms var(--ease-gentle);
}

.nav-icon {
  width: 22px;
  height: 22px;
  border-radius: 8px;
  display: grid;
  place-items: center;
  background: rgba(255, 255, 255, 0.08);
  border: 1px solid rgba(196, 161, 235, 0.25);
  flex: none;
}

.nav-icon svg {
  width: 14px;
  height: 14px;
  stroke: currentColor;
  stroke-width: 1.8;
  stroke-linecap: round;
  stroke-linejoin: round;
  fill: none;
}

.nav-link:hover {
  background: rgba(255, 255, 255, 0.06);
  color: #f5edff;
  transform: translateX(2px);
}

.nav-link.active {
  color: #ffffff;
  background: linear-gradient(130deg, #60349a, #8657c2 52%, #2ca388);
  box-shadow: 0 10px 24px rgba(28, 16, 45, 0.38);
}

/* ==================== MAIN CONTENT ==================== */

.main {
  border-radius: 22px;
  background: linear-gradient(180deg, rgba(251, 247, 255, 0.96), rgba(242, 234, 250, 0.96));
  border: 1px solid rgba(227, 216, 239, 0.95);
  box-shadow:
    0 24px 56px rgba(11, 8, 18, 0.34),
    0 0 0 1px rgba(255, 255, 255, 0.35) inset;
  overflow: hidden;
}

.topbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 0.9rem;
  padding: 0.95rem 1.08rem;
  color: #f9f4ff;
  background:
    linear-gradient(110deg, #2b1340, #61379a 46%, #2d7f93),
    repeating-linear-gradient(
      45deg,
      rgba(255, 255, 255, 0.08) 0,
      rgba(255, 255, 255, 0.08) 6px,
      rgba(255, 255, 255, 0) 6px,
      rgba(255, 255, 255, 0) 12px
    );
}

.topbar-title {
  font-size: 0.83rem;
  letter-spacing: 0.08em;
  text-transform: uppercase;
  color: #ded0f0;
}

.heading-with-icon {
  margin: 0.2rem 0 0;
  display: inline-flex;
  align-items: center;
  gap: 0.52rem;
  font-size: clamp(1.18rem, 2.5vw, 1.58rem);
}

.dashboard-logo {
  width: 31px;
  height: 31px;
  border-radius: 10px;
  display: grid;
  place-items: center;
  background: rgba(255, 255, 255, 0.2);
  border: 1px solid rgba(255, 255, 255, 0.34);
}

.dashboard-logo svg {
  width: 16px;
  height: 16px;
  stroke: #ffffff;
  stroke-width: 1.8;
  stroke-linecap: round;
  stroke-linejoin: round;
  fill: none;
}

.topbar-actions {
  display: flex;
  align-items: center;
  gap: 0.6rem;
  flex-wrap: wrap;
}

.ghost-link {
  text-decoration: none;
  color: #ffffff;
  font-weight: 700;
  font-size: 0.86rem;
  border-radius: 10px;
  padding: 0.52rem 0.75rem;
  border: 1px solid rgba(255, 255, 255, 0.45);
  background: rgba(255, 255, 255, 0.16);
  transition: transform 240ms var(--ease-gentle), background-color 240ms var(--ease-gentle);
  display: inline-flex;
  align-items: center;
  gap: 0.45rem;
  letter-spacing: 0.02em;
}

.ghost-link:hover {
  transform: translateY(-1px);
  background: rgba(255, 255, 255, 0.26);
}

.welcome-pill {
  display: inline-flex;
  align-items: center;
  gap: 0.35rem;
  border-radius: 999px;
  padding: 0.36rem 0.75rem;
  border: 1px solid rgba(255, 255, 255, 0.4);
  background: rgba(255, 255, 255, 0.16);
  font-weight: 700;
  font-size: 0.82rem;
  color: #ffffff;
}

.pill-icon {
  font-size: 1rem;
  line-height: 1;
}

.content {
  padding: 1rem;
  display: grid;
  gap: 1rem;
}

.reveal {
  opacity: 0;
  transform: translateY(14px);
  transition: transform 680ms var(--ease-smooth), opacity 680ms var(--ease-smooth);
  transition-delay: var(--delay, 0ms);
  will-change: transform, opacity;
}

body.loaded .reveal.visible {
  opacity: 1;
  transform: translateY(0);
}

/* ==================== CARD STYLES ==================== */

.card {
  border-radius: var(--card-radius);
  border: 1px solid var(--line);
  background: linear-gradient(180deg, #ffffff, #fbf7ff);
  box-shadow: 0 12px 30px rgba(29, 21, 41, 0.08);
}

.form-card {
  position: relative;
  isolation: isolate;
  overflow: hidden;
}

.form-card::before,
.form-card::after {
  content: "";
  position: absolute;
  z-index: 0;
  pointer-events: none;
}

.form-card::before {
  width: 230px;
  height: 230px;
  right: -70px;
  top: -88px;
  border-radius: 50%;
  background: radial-gradient(circle, rgba(127, 70, 192, 0.2), rgba(127, 70, 192, 0));
  animation: aura-shift 11s var(--ease-gentle) infinite;
}

.form-card::after {
  width: 200px;
  height: 200px;
  left: -62px;
  bottom: -98px;
  border-radius: 50%;
  background: radial-gradient(circle, rgba(44, 163, 136, 0.17), rgba(44, 163, 136, 0));
  animation: aura-shift 13s var(--ease-gentle) reverse infinite;
}

.card-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 0.6rem;
  padding: 0.88rem 0.92rem 0.75rem;
  border-bottom: 1px solid #ede3f6;
}

.card-header h3 {
  margin: 0;
  font-size: 1.04rem;
}

.card-header p {
  margin: 0.2rem 0 0;
  color: var(--ink-soft);
  font-size: 0.85rem;
}

.chip {
  border-radius: 999px;
  font-size: 0.75rem;
  font-weight: 700;
  color: #4b2f72;
  background: #eedeff;
  border: 1px solid #dbc4f5;
  padding: 0.34rem 0.64rem;
}

/* ==================== FORM STYLES ==================== */

.user-form {
  padding: 0.95rem;
  display: grid;
  gap: 0.8rem;
  position: relative;
  z-index: 1;
}

.form-section {
  display: grid;
  gap: 0.75rem;
  padding: 0.95rem;
  border-radius: 14px;
  background: linear-gradient(180deg, rgba(255, 255, 255, 0.6), rgba(251, 247, 255, 0.5));
  border: 1px solid rgba(229, 218, 239, 0.6);
  position: relative;
  overflow: hidden;
}

.form-section::before {
  content: "";
  position: absolute;
  inset: 0;
  background: 
    radial-gradient(circle at 100% 0%, rgba(127, 70, 192, 0.05), transparent 60%),
    radial-gradient(circle at 0% 100%, rgba(44, 163, 136, 0.04), transparent 70%);
  pointer-events: none;
  z-index: 0;
}

.form-section > * {
  position: relative;
  z-index: 1;
}

.section-title {
  margin: 0;
  font-size: 0.95rem;
  font-weight: 800;
  color: #2d1840;
  text-transform: uppercase;
  letter-spacing: 0.08em;
  padding: 0.65rem 0.75rem;
  border-bottom: 2px solid #e5daef;
  position: relative;
  display: flex;
  align-items: center;
  gap: 0.6rem;
}

.section-title::before {
  content: "";
  display: inline-block;
  width: 4px;
  height: 4px;
  border-radius: 50%;
  background: linear-gradient(135deg, #7f46c0, #2ca388);
  box-shadow: 0 0 8px rgba(127, 70, 192, 0.4);
}

.section-title::after {
  content: "";
  flex: 1;
  height: 2px;
  background: linear-gradient(90deg, transparent, #7f46c0, transparent);
  margin-left: 0.6rem;
  opacity: 0.5;
}

.field-grid {
  display: grid;
  gap: 0.65rem;
}

.field-grid.two-col {
  grid-template-columns: repeat(2, minmax(0, 1fr));
}

.field-grid.three-col {
  grid-template-columns: repeat(3, minmax(0, 1fr));
}

.field {
  display: grid;
  gap: 0.4rem;
  position: relative;
}

.field span {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  font-weight: 700;
  color: #2d1840;
  font-size: 0.87rem;
  letter-spacing: 0.01em;
  text-transform: capitalize;
}

.field-icon {
  width: 16px;
  height: 16px;
  stroke: currentColor;
  stroke-width: 2.2;
  stroke-linecap: round;
  stroke-linejoin: round;
  fill: none;
  filter: drop-shadow(0 1px 2px rgba(0, 0, 0, 0.08));
}

.field input,
.field select,
.field textarea {
  width: 100%;
  border: 2px solid #e0d5f0;
  border-radius: 12px;
  background: linear-gradient(180deg, #ffffff, #fbf8ff);
  color: var(--ink);
  font: inherit;
  font-size: 0.92rem;
  padding: 0.62rem 0.75rem;
  box-shadow: 
    0 2px 0 rgba(127, 70, 192, 0.06),
    inset 0 1px 0 rgba(255, 255, 255, 0.8);
  transition:
    border-color 280ms var(--ease-smooth),
    box-shadow 280ms var(--ease-smooth),
    transform 280ms var(--ease-smooth),
    background-color 280ms var(--ease-smooth);
  position: relative;
}

.field textarea {
  resize: vertical;
  min-height: 104px;
  font-family: inherit;
}

.field input:focus,
.field select:focus,
.field textarea:focus {
  outline: none;
  border-color: #7f46c0;
  background-color: #fffdff;
  box-shadow:
    0 0 0 4px rgba(127, 70, 192, 0.2),
    0 12px 28px rgba(96, 54, 144, 0.18),
    inset 0 1px 0 rgba(255, 255, 255, 0.9);
  transform: translateY(-2px);
}

.field input:hover,
.field select:hover,
.field textarea:hover {
  border-color: #d0c4e8;
  box-shadow: 
    0 4px 12px rgba(127, 70, 192, 0.12),
    inset 0 1px 0 rgba(255, 255, 255, 0.8);
}

/* ==================== ROLE SELECTION ==================== */

.role-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  gap: 1rem;
  margin: 0.6rem 0;
}

.role-card {
  position: relative;
  cursor: pointer;
  group: role-option;
}

.role-card input {
  position: absolute;
  opacity: 0;
  width: 100%;
  height: 100%;
  cursor: pointer;
  z-index: 10;
}

.role-card input:checked + .role-content {
  border-color: transparent;
  background: linear-gradient(135deg, rgba(127, 70, 192, 0.16), rgba(44, 163, 136, 0.12));
  box-shadow: 
    0 0 0 2px rgba(127, 70, 192, 0.3),
    0 0 20px rgba(127, 70, 192, 0.35),
    0 12px 32px rgba(63, 34, 100, 0.22);
  transform: translateY(-2px) scale(1.02);
}

.role-card input:checked + .role-content::before {
  opacity: 1;
  transform: scale(1);
}

.role-card input:checked + .role-content .role-badge {
  opacity: 1;
  transform: scale(1) translateY(0);
}

.role-card input:checked + .role-content .role-icon-wrapper {
  background: linear-gradient(135deg, #7f46c0, #2ca388);
  box-shadow: 0 8px 20px rgba(127, 70, 192, 0.4);
}

.role-card input:checked + .role-content .role-icon {
  stroke: #ffffff;
  filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.15));
}

.role-content {
  display: flex;
  align-items: flex-start;
  gap: 0.75rem;
  padding: 1rem;
  border: 2px solid #e0d5f0;
  border-radius: 16px;
  background: linear-gradient(145deg, rgba(255, 255, 255, 0.95), rgba(251, 247, 255, 0.9));
  transition: all 340ms var(--ease-smooth);
  position: relative;
  overflow: hidden;
  backdrop-filter: blur(4px);
}

.role-content::before {
  content: "";
  position: absolute;
  inset: 0;
  background: 
    radial-gradient(circle at 100% 0%, rgba(127, 70, 192, 0.08), transparent 60%),
    radial-gradient(circle at 0% 100%, rgba(44, 163, 136, 0.06), transparent 60%);
  opacity: 0;
  transition: opacity 340ms var(--ease-smooth);
  pointer-events: none;
}

.role-content::after {
  content: "";
  position: absolute;
  inset: 0;
  border-radius: 14px;
  background: repeating-linear-gradient(
    45deg,
    transparent,
    transparent 2px,
    rgba(255, 255, 255, 0.4) 2px,
    rgba(255, 255, 255, 0.4) 4px
  );
  opacity: 0;
  transition: opacity 340ms var(--ease-smooth);
  pointer-events: none;
}

.role-card input:checked + .role-content::after {
  opacity: 0.6;
}

.role-card:hover .role-content {
  border-color: #d0c4e8;
  background: linear-gradient(145deg, rgba(255, 255, 255, 0.98), rgba(255, 252, 255, 0.95));
  box-shadow: 0 8px 20px rgba(127, 70, 192, 0.1);
  transform: translateY(-1px);
}

.role-card:hover .role-icon-wrapper {
  box-shadow: 0 6px 16px rgba(127, 70, 192, 0.25);
  transform: scale(1.08);
}

.role-icon-wrapper {
  width: 56px;
  height: 56px;
  border-radius: 14px;
  display: grid;
  place-items: center;
  flex: none;
  background: linear-gradient(135deg, rgba(127, 70, 192, 0.15), rgba(44, 163, 136, 0.1));
  border: 2px solid rgba(127, 70, 192, 0.25);
  box-shadow: 0 4px 12px rgba(127, 70, 192, 0.12);
  transition: all 340ms var(--ease-smooth);
  position: relative;
}

.role-icon-wrapper::before {
  content: "";
  position: absolute;
  inset: -2px;
  border-radius: 14px;
  background: linear-gradient(135deg, rgba(127, 70, 192, 0.3), rgba(44, 163, 136, 0.2));
  opacity: 0;
  animation: aura-shift 6s var(--ease-gentle) infinite;
  z-index: -1;
}

.role-icon {
  width: 28px;
  height: 28px;
  stroke: #7f46c0;
  stroke-width: 1.8;
  stroke-linecap: round;
  stroke-linejoin: round;
  fill: none;
  transition: all 340ms var(--ease-smooth);
  position: relative;
  z-index: 2;
}

.role-content div {
  min-width: 0;
  position: relative;
  z-index: 2;
  flex: 1;
}

.role-content strong {
  display: block;
  font-size: 0.95rem;
  font-weight: 700;
  color: #2d1840;
  margin-bottom: 0.24rem;
  letter-spacing: 0.02em;
}

.role-content p {
  margin: 0;
  font-size: 0.78rem;
  color: #735f8f;
  line-height: 1.5;
  font-weight: 500;
}

.role-badge {
  position: absolute;
  top: -8px;
  right: 8px;
  background: linear-gradient(135deg, #7f46c0, #2ca388);
  color: #ffffff;
  font-size: 0.65rem;
  font-weight: 800;
  padding: 0.32rem 0.56rem;
  border-radius: 999px;
  letter-spacing: 0.06em;
  opacity: 0;
  transform: scale(0.8) translateY(2px);
  transition: all 340ms var(--ease-smooth);
  box-shadow: 0 4px 12px rgba(127, 70, 192, 0.3);
  border: 1px solid rgba(255, 255, 255, 0.4);
  text-transform: uppercase;
  z-index: 3;
}

/* ==================== PASSWORD STRENGTH ==================== */

.password-strength {
  display: grid;
  gap: 0.5rem;
  padding: 0.85rem;
  border-radius: 13px;
  background: linear-gradient(135deg, rgba(127, 70, 192, 0.08), rgba(44, 163, 136, 0.06));
  border: 1px solid rgba(127, 70, 192, 0.2);
  box-shadow: 
    0 4px 12px rgba(127, 70, 192, 0.08),
    inset 0 1px 0 rgba(255, 255, 255, 0.6);
  position: relative;
  overflow: hidden;
}

.password-strength::before {
  content: "";
  position: absolute;
  inset: 0;
  background: radial-gradient(circle at 100% 0%, rgba(127, 70, 192, 0.1), transparent 60%);
  pointer-events: none;
}

.strength-label {
  display: flex;
  justify-content: space-between;
  font-size: 0.79rem;
  font-weight: 700;
  color: #493f57;
  letter-spacing: 0.03em;
  text-transform: uppercase;
  position: relative;
  z-index: 1;
}

.strength-bar {
  height: 8px;
  background: linear-gradient(90deg, rgba(220, 53, 69, 0.2), rgba(255, 152, 0, 0.15), rgba(76, 175, 80, 0.15));
  border-radius: 999px;
  overflow: hidden;
  box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.08);
  position: relative;
  z-index: 1;
}

.strength-fill {
  height: 100%;
  width: 0;
  border-radius: inherit;
  background: linear-gradient(90deg, #dc3545 0%, #ff9800 40%, #ffc107 70%, #4caf50 100%);
  transition: width 320ms var(--ease-smooth), box-shadow 320ms var(--ease-smooth);
  box-shadow: 0 0 12px rgba(220, 53, 69, 0.4);
  position: relative;
}

.strength-fill::after {
  content: "";
  position: absolute;
  inset: 0;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
  animation: shimmer 2.8s var(--ease-gentle) infinite;
}

/* ==================== FORM FOOTER ==================== */

.form-footer {
  display: grid;
  gap: 0.9rem;
  border-top: 2px dashed rgba(229, 218, 239, 0.8);
  padding-top: 0.9rem;
  margin-top: 0.5rem;
}

.completion-wrap {
  display: grid;
  gap: 0.5rem;
  background: linear-gradient(135deg, rgba(127, 70, 192, 0.04), rgba(44, 163, 136, 0.03));
  padding: 0.8rem;
  border-radius: 12px;
  border: 1px solid rgba(229, 218, 239, 0.5);
}

.completion-label {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 0.65rem;
}

.completion-label strong {
  font-size: 0.88rem;
  color: #2d1840;
  font-weight: 700;
  letter-spacing: 0.02em;
}

.completion-label span {
  font-size: 0.85rem;
  font-weight: 800;
  background: linear-gradient(135deg, #7f46c0, #2ca388);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  letter-spacing: 0.05em;
}

.progress {
  height: 12px;
  background: linear-gradient(90deg, rgba(220, 53, 69, 0.12), rgba(255, 152, 0, 0.1), rgba(76, 175, 80, 0.12));
  border-radius: 999px;
  overflow: hidden;
  position: relative;
  box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.06);
}

.progress::before {
  content: "";
  position: absolute;
  inset: 0;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
  z-index: 2;
}

.progress span {
  display: block;
  height: 100%;
  width: 0;
  border-radius: inherit;
  background: linear-gradient(90deg, #7f46c0 0%, #2ca388 50%, #c98547 100%);
  transition: width 580ms var(--ease-smooth);
  box-shadow: 
    0 0 8px rgba(127, 70, 192, 0.4),
    inset 0 1px 0 rgba(255, 255, 255, 0.3);
  position: relative;
}

/* ==================== BUTTONS ==================== */

.actions {
  display: flex;
  align-items: center;
  justify-content: flex-end;
  gap: 0.65rem;
  flex-wrap: wrap;
}

.btn {
  border: 0;
  border-radius: 12px;
  font: inherit;
  font-weight: 800;
  font-size: 0.87rem;
  padding: 0.64rem 1.1rem;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  transition:
    transform 260ms var(--ease-smooth),
    box-shadow 260ms var(--ease-smooth),
    background-color 260ms var(--ease-smooth),
    filter 260ms var(--ease-smooth);
  position: relative;
  overflow: hidden;
  letter-spacing: 0.03em;
  text-transform: uppercase;
}

.btn::before {
  content: "";
  position: absolute;
  inset: 0;
  background: linear-gradient(135deg, rgba(255, 255, 255, 0.2), transparent);
  opacity: 0;
  transition: opacity 260ms var(--ease-smooth);
}

.btn:hover {
  transform: translateY(-3px);
  filter: brightness(1.08);
}

.btn:hover::before {
  opacity: 1;
}

.btn:active {
  transform: translateY(-1px);
}

.btn:focus {
  outline: 2px solid rgba(127, 70, 192, 0.4);
  outline-offset: 2px;
}

.btn-icon {
  width: 18px;
  height: 18px;
  stroke: currentColor;
  stroke-width: 2;
  stroke-linecap: round;
  stroke-linejoin: round;
  fill: none;
  transition: transform 260ms var(--ease-smooth);
}

.btn:hover .btn-icon {
  transform: scale(1.15);
}

.btn-soft {
  background: linear-gradient(135deg, #f3e8ff, #ebf9f6, #fef3e2);
  color: #472c6e;
  box-shadow: 0 4px 12px rgba(127, 70, 192, 0.1);
  border: 1px solid rgba(127, 70, 192, 0.15);
}

.btn-soft:hover {
  box-shadow: 0 8px 20px rgba(127, 70, 192, 0.2);
  background: linear-gradient(135deg, #f0e0ff, #e8f7f4, #fdefd6);
}

.btn-primary {
  color: #ffffff;
  background: linear-gradient(125deg, #7346b5, #2ca388 58%, #d49855);
  box-shadow: 
    0 12px 28px rgba(63, 34, 100, 0.35),
    inset 0 1px 0 rgba(255, 255, 255, 0.15);
  border: 1px solid rgba(255, 255, 255, 0.2);
  position: relative;
}

.btn-primary::after {
  content: "";
  position: absolute;
  inset: 0;
  border-radius: 12px;
  background: radial-gradient(circle at 100% 0%, rgba(255, 255, 255, 0.3), transparent 60%);
  opacity: 0;
  transition: opacity 260ms var(--ease-smooth);
  pointer-events: none;
}

.btn-primary:hover {
  box-shadow: 
    0 16px 36px rgba(63, 34, 100, 0.45),
    inset 0 1px 0 rgba(255, 255, 255, 0.25);
}

.btn-primary:hover::after {
  opacity: 1;
}

.user-form.submitted {
  animation: pulse-card 820ms var(--ease-smooth);
}

/* ==================== FORM SIGNATURE ==================== */

.form-signature {
  display: flex;
  align-items: center;
  gap: 0.95rem;
  border-radius: 16px;
  border: 1.5px solid rgba(127, 70, 192, 0.25);
  background:
    linear-gradient(135deg, rgba(127, 70, 192, 0.08), rgba(44, 163, 136, 0.06), rgba(201, 133, 71, 0.05)),
    #fffdff;
  padding: 0.95rem 1rem;
  position: relative;
  overflow: hidden;
  box-shadow: 
    0 12px 32px rgba(53, 31, 84, 0.12),
    inset 0 1px 0 rgba(255, 255, 255, 0.8);
}

.form-signature::before {
  content: "";
  position: absolute;
  inset: 0;
  background: radial-gradient(circle at 100% 50%, rgba(127, 70, 192, 0.1), transparent 60%);
  pointer-events: none;
}

.form-signature::after {
  content: "";
  position: absolute;
  inset: 0;
  transform: translateX(-110%);
  background: linear-gradient(95deg, rgba(255, 255, 255, 0), rgba(255, 255, 255, 0.5), rgba(255, 255, 255, 0));
  animation: shimmer 3s var(--ease-gentle) infinite;
  pointer-events: none;
}

.signature-mark {
  width: 60px;
  height: 60px;
  border-radius: 16px;
  display: grid;
  place-items: center;
  flex: none;
  border: 1.5px solid rgba(255, 255, 255, 0.5);
  background: linear-gradient(138deg, #6c3ba5, #2f8a91 55%, #d49855);
  box-shadow: 
    0 14px 32px rgba(53, 30, 85, 0.32),
    inset 0 1px 0 rgba(255, 255, 255, 0.3),
    0 0 20px rgba(127, 70, 192, 0.25);
  animation: float-mark 4.6s var(--ease-gentle) infinite;
  position: relative;
  z-index: 2;
  overflow: hidden;
}

.signature-mark::before {
  content: "";
  position: absolute;
  inset: -1px;
  background: linear-gradient(135deg, rgba(255, 255, 255, 0.2), transparent);
  border-radius: 16px;
}

.signature-mark svg {
  width: 28px;
  height: 28px;
  stroke: #ffffff;
  stroke-width: 1.6;
  stroke-linecap: round;
  stroke-linejoin: round;
  fill: none;
  position: relative;
  z-index: 3;
  filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.15));
}

.signature-copy {
  min-width: 0;
  position: relative;
  z-index: 2;
  flex: 1;
}

.signature-copy h4 {
  margin: 0;
  font-size: 0.85rem;
  letter-spacing: 0.08em;
  text-transform: uppercase;
  color: #5d4180;
  font-weight: 800;
  text-shadow: 0 1px 2px rgba(0, 0, 0, 0.04);
}

.form-signature blockquote {
  margin: 0.32rem 0 0;
  color: #2d1840;
  font-weight: 600;
  font-size: 0.88rem;
  line-height: 1.5;
  letter-spacing: 0.01em;
}

/* ==================== RESPONSIVE DESIGN ==================== */

@media (max-width: 968px) {
  .app-shell {
    grid-template-columns: 1fr;
  }

  .sidebar {
    position: fixed;
    left: 1rem;
    top: 1rem;
    width: 250px;
    max-height: calc(100vh - 2rem);
    transform: translateX(-110%);
    transition: transform 300ms var(--ease-gentle);
    z-index: 100;
  }

  .sidebar.mobile-open {
    transform: translateX(0);
  }

  .role-grid {
    grid-template-columns: 1fr;
  }

  .field-grid.two-col {
    grid-template-columns: 1fr;
  }

  .role-icon-wrapper {
    width: 50px;
    height: 50px;
  }

  .role-icon {
    width: 24px;
    height: 24px;
  }
}

@media (max-width: 480px) {
  .topbar {
    padding: 0.8rem 0.9rem;
  }

  .heading-with-icon {
    font-size: 1.2rem;
  }

  .content {
    padding: 0.8rem;
  }

  .card-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 0.4rem;
  }

  .user-form {
    padding: 0.75rem;
  }

  .section-title {
    font-size: 0.85rem;
    padding: 0.55rem 0.6rem;
  }

  .actions {
    flex-direction: column;
    gap: 0.5rem;
  }

  .btn {
    width: 100%;
    justify-content: center;
    padding: 0.58rem 0.8rem;
  }

  .form-signature {
    flex-direction: column;
    gap: 0.6rem;
    padding: 0.8rem;
  }

  .signature-copy {
    width: 100%;
  }

  .role-content {
    padding: 0.8rem;
    gap: 0.6rem;
  }

  .role-icon-wrapper {
    width: 48px;
    height: 48px;
  }

  .role-content strong {
    font-size: 0.88rem;
  }

  .role-badge {
    font-size: 0.6rem;
    padding: 0.28rem 0.5rem;
    top: -6px;
    right: 6px;
  }

  .field-grid.two-col {
    grid-template-columns: 1fr;
  }

  .field input,
  .field select,
  .field textarea {
    padding: 0.55rem 0.6rem;
  }

  .form-footer {
    gap: 0.7rem;
    padding-top: 0.7rem;
  }

  .completion-wrap {
    padding: 0.7rem;
  }

  .progress {
    height: 10px;
  }

  .signature-mark {
    width: 54px;
    height: 54px;
  }

  .signature-mark svg {
    width: 26px;
    height: 26px;
  }
}

/* ==================== SCROLLBAR STYLING ==================== */

.sidebar::-webkit-scrollbar {
  width: 6px;
}

.sidebar::-webkit-scrollbar-track {
  background: rgba(255, 255, 255, 0.05);
}

.sidebar::-webkit-scrollbar-thumb {
  background: rgba(127, 70, 192, 0.4);
  border-radius: 3px;
}

.sidebar::-webkit-scrollbar-thumb:hover {
  background: rgba(127, 70, 192, 0.6);
}
  
  </style>
</head>
<body>
  <!-- Entry Loader with Buffering Animation -->
  <div
    class="entry-loader"
    id="entryLoader"
    aria-live="polite"
    aria-label="Loading add user page"
  >
    <div class="loader-card">
      <div class="loader-icon" aria-hidden="true"></div>
      <h1>Preparing User Registration</h1>
      <p>Loading member registry and credential system.</p>
      <div class="loader-bars" aria-hidden="true">
        <span></span>
        <span></span>
        <span></span>
      </div>
    </div>
  </div>

  <!-- Ambient Orbs Background -->
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
        <a class="nav-link" href="${pageContext.request.contextPath}/UserController?action=showUserList">
          <span class="nav-icon" aria-hidden="true">
            <svg viewBox="0 0 24 24">
              <path d="M16 19v-1a4 4 0 00-8 0v1M12 11a3 3 0 100-6 3 3 0 000 6z" />
            </svg>
          </span>
          <span>Users</span>
        </a>
        <a class="nav-link active" href="${pageContext.request.contextPath}/UserController?action=showAddUser">
          <span class="nav-icon" aria-hidden="true">
            <svg viewBox="0 0 24 24">
              <path d="M16 19v-1a4 4 0 00-8 0v1M12 11a3 3 0 100-6 3 3 0 000 6zM21 13a1 1 0 01-1-1v-2a1 1 0 012 0v2a1 1 0 01-1 1z" />
            </svg>
          </span>
          <span>Add User</span>
        </a>
      </nav>
    </aside>

    <!-- Main Content -->
    <main class="main reveal" data-reveal data-delay="140">
      <div class="topbar">
        <div>
          <div class="topbar-title">User Management</div>
          <div class="heading-with-icon">
            <div class="dashboard-logo" aria-hidden="true">
              <svg viewBox="0 0 24 24">
                <path d="M16 19v-1a4 4 0 00-8 0v1M12 11a3 3 0 100-6 3 3 0 000 6z" />
              </svg>
            </div>
            <h1>Register New User</h1>
          </div>
        </div>
        <div class="topbar-actions">
          <a href="${pageContext.request.contextPath}/DashboardController?action=viewDashboard" class="ghost-link">
            <svg viewBox="0 0 24 24" style="width: 16px; height: 16px; stroke: currentColor; stroke-width: 2; fill: none; stroke-linecap: round; stroke-linejoin: round;">
              <path d="M19 12H5M12 19l-7-7 7-7" />
            </svg>
            Back to Dashboard
          </a>
          <div class="welcome-pill">
            <span class="pill-icon" aria-hidden="true">📚</span>
            Library Hub
          </div>
        </div>
      </div>

      <div class="content">
        <article class="card form-card reveal" data-reveal data-delay="280">
          <div class="card-header">
            <div>
              <h3>User Registration Form</h3>
              <p>Create a new library member or staff account</p>
            </div>
            <span class="chip">New</span>
          </div>
          <c:set var="flashSuccessMessage" value="${sessionScope.flashSuccess}" />
          <c:remove var="flashSuccess" scope="session" />
          <c:if test="${not empty flashSuccessMessage}">
            <div class="flash-message flash-success">
              <span>${flashSuccessMessage}</span>
            </div>
          </c:if>
          <c:if test="${not empty successMessage}">
            <div class="flash-message flash-success">
              <span>${successMessage}</span>
            </div>
          </c:if>
          <c:if test="${not empty errorMessage}">
            <div class="flash-message flash-error">
              <span>${errorMessage}</span>
            </div>
          </c:if>
          <form id="userForm" class="user-form" action="${pageContext.request.contextPath}/UserController?action=addUser" method="post">
            <!-- Personal Information Section -->
            <div class="form-section">
              <h5 class="section-title">Personal Information</h5>

              <!-- Name Fields -->
              <div class="field-grid two-col">
                <div class="field">
                  <span>
                    <svg viewBox="0 0 24 24" class="field-icon">
                      <path d="M20 21v-2a4 4 0 00-4-4H8a4 4 0 00-4 4v2" />
                      <circle cx="12" cy="7" r="4" />
                    </svg>
                    First Name
                  </span>
                  <input
                    type="text"
                    id="firstName"
                    name="firstName"
                    placeholder="John"
                    required
                  />
                </div>
                <div class="field">
                  <span>
                    <svg viewBox="0 0 24 24" class="field-icon">
                      <path d="M20 21v-2a4 4 0 00-4-4H8a4 4 0 00-4 4v2" />
                      <circle cx="12" cy="7" r="4" />
                    </svg>
                    Last Name
                  </span>
                  <input
                    type="text"
                    id="lastName"
                    name="lastName"
                    placeholder="Doe"
                    required
                  />
                </div>
              </div>

              <!-- Contact Fields -->
              <div class="field-grid two-col">
                <div class="field">
                  <span>
                    <svg viewBox="0 0 24 24" class="field-icon">
                      <rect x="2" y="4" width="20" height="16" rx="2" />
                      <path d="M2 6l10 7 10-7" />
                    </svg>
                    Email Address
                  </span>
                  <input
                    type="email"
                    id="email"
                    name="email"
                    placeholder="john.doe@example.com"
                    required
                  />
                </div>
                <div class="field">
                  <span>
                    <svg viewBox="0 0 24 24" class="field-icon">
                      <path d="M22 16.92v3a2 2 0 01-2.18 2 19.79 19.79 0 01-8.63-3.07 19.5 19.5 0 01-6-6 19.79 19.79 0 01-3.07-8.67A2 2 0 014.11 2h3a2 2 0 012 1.72 12.84 12.84 0 00.7 2.81 2 2 0 01-.45 2.11L8.09 9.91a16 16 0 006 6l1.27-1.27a2 2 0 012.11-.45 12.84 12.84 0 002.81.7A2 2 0 0122 16.92z" />
                    </svg>
                    Phone Number
                  </span>
                  <input
                    type="tel"
                    id="phone"
                    name="phoneNo"
                    placeholder="+1 (555) 123-4567"
                    required
                  />
                </div>
              </div>

              <!-- Date of Birth -->
             
              <!-- Address -->
              <div class="field">
                <span>
                  <svg viewBox="0 0 24 24" class="field-icon">
                    <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0118 0z" />
                    <circle cx="12" cy="10" r="3" />
                  </svg>
                  Address
                </span>
                <textarea
                  id="address"
                  name="address"
                  placeholder="Enter your full address"
                ></textarea>
              </div>
            </div>

            <!-- User Role Section -->
            <div class="form-section">
              <h5 class="section-title">Account Type</h5>

              <div class="role-grid">
                <label class="role-card">
                  <input type="radio" name="role" value="member" required />
                  <div class="role-content">
                    <svg viewBox="0 0 24 24" class="role-icon">
                      <path d="M20 21v-2a4 4 0 00-4-4H8a4 4 0 00-4 4v2" />
                      <circle cx="12" cy="7" r="4" />
                    </svg>
                    <div>
                      <strong>Library Member</strong>
                      <p>Student or community member</p>
                    </div>
                  </div>
                </label>

                <label class="role-card">
                  <input type="radio" name="role" value="librarian" />
                  <div class="role-content">
                    <svg viewBox="0 0 24 24" class="role-icon">
                      <path d="M4 19.5h16M6 12.5h12M4 5.5h16" />
                      <circle cx="12" cy="12.5" r="8" fill="none" stroke-width="2" />
                    </svg>
                    <div>
                      <strong>Librarian</strong>
                      <p>Library staff member</p>
                    </div>
                  </div>
                </label>

                <label class="role-card">
                  <input type="radio" name="role" value="admin" />
                  <div class="role-content">
                    <svg viewBox="0 0 24 24" class="role-icon">
                      <circle cx="12" cy="12" r="1" />
                      <circle cx="19" cy="12" r="1" />
                      <circle cx="5" cy="12" r="1" />
                    </svg>
                    <div>
                      <strong>Administrator</strong>
                      <p>System administrator</p>
                    </div>
                  </div>
                </label>
              </div>
            </div>

            <!-- Credentials Section (shown for librarian/admin) -->
            <div class="form-section" id="credentialsSection" style="display: none;">
              <h5 class="section-title">Account Credentials</h5>

              <div class="field-grid two-col">
                <div class="field">
                  <span>
                    <svg viewBox="0 0 24 24" class="field-icon">
                      <rect x="3" y="11" width="18" height="11" rx="2" ry="2" />
                      <path d="M7 11V7a5 5 0 0110 0v4" />
                    </svg>
                    Password
                  </span>
                  <input
                    type="password"
                    id="password"
                    name="password"
                    placeholder="••••••••"
                  />
                </div>
                <div class="field">
                  <span>
                    <svg viewBox="0 0 24 24" class="field-icon">
                      <rect x="3" y="11" width="18" height="11" rx="2" ry="2" />
                      <path d="M7 11V7a5 5 0 0110 0v4" />
                    </svg>
                    Confirm Password
                  </span>
                  <input
                    type="password"
                    id="confirmPassword"
                    name="confirmPassword"
                    placeholder="••••••••"
                  />
                </div>
              </div>

              <div class="password-strength" id="passwordStrength" style="display: none;">
                <div class="strength-label">
                  <span>Password Strength:</span>
                  <span id="strengthText">Weak</span>
                </div>
                <div class="strength-bar">
                  <div class="strength-fill" id="strengthFill"></div>
                </div>
              </div>
            </div>

            <!-- Form Footer -->
            <div class="form-footer">
              <div class="completion-wrap">
                <div class="completion-label">
                  <strong>Form Completion</strong>
                  <span id="completionPercent">0%</span>
                </div>
                <div class="progress">
                  <span id="progressBar"></span>
                </div>
              </div>

              <div class="actions">
                <button type="reset" class="btn btn-soft">
                  <svg viewBox="0 0 24 24" class="btn-icon">
                    <polyline points="23 4 23 10 17 10" />
                    <path d="M20.49 15a9 9 0 11-18 0m15-9l-6-6" />
                  </svg>
                  Clear
                </button>
                <button type="submit" class="btn btn-primary">
                  <svg viewBox="0 0 24 24" class="btn-icon">
                    <path d="M16 19v-1a4 4 0 00-4-4H8a4 4 0 00-4 4v1" />
                    <circle cx="12" cy="7" r="4" />
                    <line x1="12" y1="12" x2="12" y2="18" />
                    <line x1="9" y1="15" x2="15" y2="15" />
                  </svg>
                  Register User
                </button>
              </div>
            </div>

            <!-- Form Signature -->
            <div class="form-signature" style="margin-top: 1rem;">
              <div class="signature-mark" aria-hidden="true">
                <svg viewBox="0 0 24 24">
                  <path d="M16 19v-1a4 4 0 00-8 0v1M12 11a3 3 0 100-6 3 3 0 000 6z" />
                </svg>
              </div>
              <div class="signature-copy">
                <h4>New Member Addition</h4>
                <blockquote>Register new library members to access our comprehensive collection and services.</blockquote>
              </div>
            </div>
          </form>
        </article>
      </div>
    </main>
  </div>

  <script>
    // Simulate page load with buffering
    document.addEventListener('DOMContentLoaded', function() {
      setTimeout(() => {
        document.body.classList.add('loaded');
        initializeForm();
        initializeRevealAnimations();
      }, 1200);
    });

    // Initialize form interactivity
    function initializeForm() {
      const form = document.getElementById('userForm');
      const userRoleRadios = document.querySelectorAll('input[name="role"]');
      const credentialsSection = document.getElementById('credentialsSection');
      const passwordField = document.getElementById('password');
      const confirmPasswordField = document.getElementById('confirmPassword');
      const progressBar = document.getElementById('progressBar');
      const completionPercent = document.getElementById('completionPercent');
      const passwordStrength = document.getElementById('passwordStrength');
      const strengthFill = document.getElementById('strengthFill');
      const strengthText = document.getElementById('strengthText');

      // Handle user role selection
      userRoleRadios.forEach(radio => {
        radio.addEventListener('change', function() {
          if (this.value === 'librarian' || this.value === 'admin') {
            credentialsSection.style.display = 'block';
            passwordField.required = true;
            confirmPasswordField.required = true;
          } else {
            credentialsSection.style.display = 'none';
            passwordField.required = false;
            confirmPasswordField.required = false;
          }
        });
      });

      // Password strength indicator
      passwordField.addEventListener('input', function() {
        if (this.value.length > 0) {
          passwordStrength.style.display = 'block';
          updatePasswordStrength(this.value);
        } else {
          passwordStrength.style.display = 'none';
        }
      });

      // Password confirmation validation
      confirmPasswordField.addEventListener('input', validatePasswords);
      passwordField.addEventListener('input', validatePasswords);

      function validatePasswords() {
        if (passwordField.value && confirmPasswordField.value) {
          if (passwordField.value !== confirmPasswordField.value) {
            confirmPasswordField.style.borderColor = '#c94242';
            confirmPasswordField.style.boxShadow = '0 0 0 3px rgba(201, 66, 66, 0.18)';
          } else {
            confirmPasswordField.style.borderColor = '#2ca388';
            confirmPasswordField.style.boxShadow = '0 0 0 3px rgba(44, 163, 136, 0.18)';
          }
        }
      }

      function updatePasswordStrength(password) {
        let strength = 0;
        if (password.length >= 8) strength++;
        if (/[a-z]/.test(password) && /[A-Z]/.test(password)) strength++;
        if (/\d/.test(password)) strength++;
        if (/[^a-zA-Z\d]/.test(password)) strength++;

        const strengthLevels = ['Weak', 'Fair', 'Good', 'Strong', 'Very Strong'];
        const strengthColors = ['#dc3545', '#ff9800', '#ffc107', '#4caf50', '#2ca388'];
        
        strengthText.textContent = strengthLevels[strength];
        strengthFill.style.width = ((strength + 1) / 5 * 100) + '%';
        strengthFill.style.background = strengthColors[strength];
      }

      // Form completion tracker
      function updateCompletion() {
        const inputs = form.querySelectorAll('input[required], textarea[required]');
        let filled = 0;
        const countedRadioGroups = new Set();
        
        inputs.forEach(input => {
          if (input.type === 'radio') {
            if (countedRadioGroups.has(input.name)) {
              return;
            }
            countedRadioGroups.add(input.name);
            const checked = form.querySelector('input[name="' + input.name + '"]:checked');
            if (checked) {
              filled++;
            }
            return;
          }

          if (input.value.trim() !== '') {
            filled++;
          }
        });

        const percentage = Math.round((filled / inputs.length) * 100);
        completionPercent.textContent = percentage + '%';
        progressBar.style.width = percentage + '%';
      }

      form.addEventListener('input', updateCompletion);
      form.addEventListener('change', updateCompletion);

      // Form submission
      form.addEventListener('submit', function(e) {
        if (passwordField.value !== confirmPasswordField.value && credentialsSection.style.display !== 'none') {
          e.preventDefault();
          alert('Passwords do not match!');
        }
      });
    }

    // Initialize reveal animations
    function initializeRevealAnimations() {
      const revealElements = document.querySelectorAll('[data-reveal]');
      revealElements.forEach((element, index) => {
        element.classList.add('visible');
        const delay = element.getAttribute('data-delay') || 0;
        element.style.transitionDelay = delay + 'ms';
      });
    }
  </script>
</body>
</html>