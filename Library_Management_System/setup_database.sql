-- ============================================
-- Library Management System Database Setup
-- ============================================
-- This script creates all necessary tables for the LMS application
-- Author: Muhammad Ali Abid
-- Date: 2026

-- Drop existing tables if they exist (comment out if you want to preserve data)
-- DROP TABLE IF EXISTS books;
-- DROP TABLE IF EXISTS users;

-- ============================================
-- Users Table
-- ============================================
CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    phone_no VARCHAR(20),
    role VARCHAR(50) DEFAULT 'user',
    date_of_birth DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email),
    INDEX idx_role (role)
);

-- ============================================
-- Books Table
-- ============================================
CREATE TABLE IF NOT EXISTS books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(250) NOT NULL,
    author VARCHAR(250) NOT NULL,
    category VARCHAR(120),
    isbn VARCHAR(30),
    publisher VARCHAR(250),
    total_copies INT NOT NULL,
    available_copies INT NOT NULL,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_title (title),
    INDEX idx_isbn (isbn),
    INDEX idx_category (category)
);

-- ============================================
-- Sample Data (Uncomment to use)
-- ============================================

-- Insert sample users
INSERT INTO users (first_name, last_name, email, password, address, phone_no, role) 
VALUES 
('Admin', 'User', 'admin@library.com', 'admin123', '123 Library Street', '555-0001', 'admin'),
('John', 'Doe', 'john@library.com', 'john123', '456 Book Lane', '555-0002', 'librarian'),
('Jane', 'Smith', 'jane@library.com', 'jane123', '789 Read Avenue', '555-0003', 'user');

-- Insert sample books
INSERT INTO books (title, author, category, isbn, publisher, total_copies, available_copies) 
VALUES 
('Atomic Habits', 'James Clear', 'Business', '9780735211292', 'Penguin Random House', 5, 3),
('The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', '9780743273565', 'Scribner', 4, 2),
('To Kill a Mockingbird', 'Harper Lee', 'Fiction', '9780061120084', 'Harper Perennial', 3, 1),
('1984', 'George Orwell', 'Science Fiction', '9780451524935', 'Signet Classics', 6, 4),
('The Catcher in the Rye', 'J.D. Salinger', 'Fiction', '9780316769174', 'Little Brown', 2, 1);

-- ============================================
-- Verification Queries
-- ============================================
-- Run these to verify the tables were created correctly:
-- SELECT COUNT(*) as user_count FROM users;
-- SELECT COUNT(*) as book_count FROM books;
-- SELECT * FROM users;
-- SELECT * FROM books;

-- ============================================
-- Table Structure Verification
-- ============================================
-- Run these to check table columns:
-- DESCRIBE users;
-- DESCRIBE books;