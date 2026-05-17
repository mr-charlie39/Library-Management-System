-- Create Users Table
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
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create Books Table
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
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Sample data for users table (optional)
INSERT INTO users (first_name, last_name, email, password, address, phone_no, role) 
VALUES 
('Admin', 'User', 'admin@library.com', 'admin123', '123 Library Street', '555-0001', 'admin'),
('John', 'Doe', 'john@library.com', 'john123', '456 Book Lane', '555-0002', 'librarian');