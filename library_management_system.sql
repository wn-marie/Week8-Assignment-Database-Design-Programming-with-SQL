-- Question 1
-- Create the database
CREATE DATABASE library_management_system;
USE library_management_system;

-- Table: categories
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- Table: authors
CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_year YEAR,
    nationality VARCHAR(50)
);

-- Table: books
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    title VARCHAR(255) NOT NULL,
    publication_year YEAR NOT NULL,
    author_id INT NOT NULL,
    category_id INT NOT NULL,
    total_copies INT DEFAULT 1 NOT NULL CHECK (total_copies >= 0),
    available_copies INT DEFAULT 1 NOT NULL CHECK (available_copies >= 0),
    FOREIGN KEY (author_id) REFERENCES authors(author_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Table: members
CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE,
    join_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    membership_status ENUM('Active', 'Inactive', 'Suspended') DEFAULT 'Active'
);

-- Table: membership_cards (One-to-One with members)
CREATE TABLE membership_cards (
    card_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL UNIQUE,
    card_number VARCHAR(20) UNIQUE NOT NULL,
    issue_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    expiry_date DATE NOT NULL,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table: loans (Many-to-Many between members and books)
CREATE TABLE loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    book_id INT NOT NULL,
    loan_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    due_date DATE NOT NULL,
    return_date DATE NULL,
    status ENUM('Borrowed', 'Returned', 'Overdue') DEFAULT 'Borrowed',
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE ON UPDATE CASCADE,
    INDEX idx_member_book (member_id, book_id),
    CHECK (due_date > loan_date)
);

-- ===== INSERT SAMPLE DATA =====

-- Categories
INSERT INTO categories (category_name, description) VALUES
('Fiction', 'Novels and fictional stories'),
('Science', 'Scientific books and research'),
('History', 'Historical events and biographies');

-- Authors
INSERT INTO authors (first_name, last_name, birth_year, nationality) VALUES
('George', 'Orwell', 1903, 'British'),
('Carl', 'Sagan', 1934, 'American'),
('Yuval Noah', 'Harari', 1976, 'Israeli');

-- Books
INSERT INTO books (isbn, title, publication_year, author_id, category_id, total_copies, available_copies) VALUES
('978-0-452-28423-4', '1984', 1949, 1, 1, 5, 3),
('978-0-345-37211-4', 'Cosmos', 1980, 2, 2, 3, 2),
('978-0-06-231609-7', 'Sapiens', 2011, 3, 3, 4, 4);

-- Members
INSERT INTO members (first_name, last_name, email, phone, join_date, membership_status) VALUES
('Alice', 'Johnson', 'alicej@gmail.com', '+254734897706', '2024-01-15', 'Active'),
('Bob', 'Smith', 'bobsm21@gmail.com', '+254798532411', '2024-02-20', 'Active');

-- Membership Cards (One-to-One)
INSERT INTO membership_cards (member_id, card_number, issue_date, expiry_date) VALUES
(1, 'LIB2024001', '2025-01-15', '2026-01-15'),
(2, 'LIB2024002', '2025-02-20', '2026-02-20');

-- Loans (Many-to-Many)
INSERT INTO loans (member_id, book_id, loan_date, due_date, return_date, status) VALUES
(1, 1, '2025-09-01', '2025-09-15', NULL, 'Borrowed'),
(2, 2, '2025-09-02', '2025-09-16', '2025-04-10', 'Returned');