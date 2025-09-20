# 📚 Library Management System — Database Schema

## 🎯 Objective
Design and implement a full-featured relational database for a **Library Management System** using MySQL.

## 🧩 Schema Includes
- Well-structured, normalized tables
- Proper constraints: `PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL`, `UNIQUE`, `CHECK`, `ENUM`
- Relationships:
  - **One-to-One**: `members` ↔ `membership_cards`
  - **One-to-Many**: `authors → books`, `categories → books`, `members → loans`, `books → loans`
  - **Many-to-Many**: `members ↔ books` (via `loans` junction table)

## 📂 Files Included
- `library_management_system.sql` — Complete SQL schema with sample data

## 🚀 How to Use

### 1. Requirements
- MySQL Server (v8.0+ recommended)
- MySQL Client (e.g., MySQL Workbench, phpMyAdmin, or command line)

### 2. Import the Database

#### Option A: Command Line
```bash
mysql -u your_username -p < library_management_system.sql
```

#### Option B: MySQL Workbench / phpMyAdmin
- Open your MySQL client
- Create new schema (optional — script creates it)
- Run the entire .sql file
  
###3. Verify Installation
Connect to MySQL and run:
```bash
USE library_management_system;
SHOW TABLES;
SELECT * FROM books LIMIT 3;
SELECT * FROM members;
SELECT * FROM loans;
```

#### Sample queries
```bash
-- Find all borrowed books
SELECT m.first_name, m.last_name, b.title, l.loan_date, l.due_date
FROM loans l
JOIN members m ON l.member_id = m.member_id
JOIN books b ON l.book_id = b.book_id
WHERE l.status = 'Borrowed';
```
```bash
-- Find books by category
SELECT b.title, a.first_name, a.last_name
FROM books b
JOIN authors a ON b.author_id = a.author_id
JOIN categories c ON b.category_id = c.category_id
WHERE c.category_name = 'Fiction';
```

