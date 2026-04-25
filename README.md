# 🛒 Retail Sales SQL Database

A beginner-friendly relational database project built from scratch using SQL. This project models a retail store's data environment — covering customers, products, orders, and sales — and demonstrates core data analyst skills including schema design, data insertion, and analytical querying.

---

## 📋 Table of Contents

- [Project Overview](#project-overview)
- [Database Schema](#database-schema)
- [Folder Structure](#folder-structure)
- [Getting Started](#getting-started)
- [Sample Queries & Insights](#sample-queries--insights)
- [Skills Demonstrated](#skills-demonstrated)
- [About](#about)

---

## Project Overview

This project simulates the back-end database of a small retail store. It was built to practice:

- Designing a normalized relational database schema
- Writing `CREATE TABLE` statements with primary and foreign keys
- Inserting realistic sample data
- Writing analytical SQL queries using `JOIN`, `GROUP BY`, `HAVING`, subqueries, and aggregate functions

**Database:** MySQL (compatible with PostgreSQL with minor adjustments)

---

## Database Schema

The database contains five related tables:

| Table | Description |
|---|---|
| `categories` | Product categories (e.g., Electronics, Clothing) |
| `products` | Product catalog with price and category |
| `customers` | Customer contact information |
| `orders` | Order header — which customer placed an order and when |
| `order_items` | Order line items — which products and quantities are in each order |

**Entity Relationships:**

```
categories ──< products ──< order_items >── orders >── customers
```

- One category has many products
- One product appears in many order items
- One order contains many order items
- One customer places many orders

---

## Folder Structure

```
SQL-Database-Project/
├── README.md                  # Project overview and documentation
├── sql/
│   ├── schema.sql             # Creates the database
│   ├── tables.sql             # Creates all tables with constraints
│   ├── insert_data.sql        # Inserts realistic sample data
│   └── queries.sql            # Analytical queries for data insights
└── docs/
    └── erd_description.md     # Entity Relationship Diagram description
```

---

## Getting Started

### Prerequisites

- [MySQL](https://dev.mysql.com/downloads/) 8.0+ or [MySQL Workbench](https://www.mysql.com/products/workbench/)

### Steps

1. **Clone this repository**
   ```bash
   git clone https://github.com/depicciottodali-ops/SQL-Database-Project.git
   cd SQL-Database-Project
   ```

2. **Open your SQL client** (MySQL Workbench, DBeaver, or the MySQL CLI)

3. **Run the scripts in order:**
   ```sql
   -- Step 1: Create the database
   SOURCE sql/schema.sql;

   -- Step 2: Create the tables
   SOURCE sql/tables.sql;

   -- Step 3: Insert sample data
   SOURCE sql/insert_data.sql;

   -- Step 4: Run analytical queries
   SOURCE sql/queries.sql;
   ```

---

## Sample Queries & Insights

The `queries.sql` file includes answers to real business questions:

| # | Business Question |
|---|---|
| 1 | Which customers have placed the most orders? |
| 2 | What are the top 5 best-selling products by revenue? |
| 3 | What is the total revenue per product category? |
| 4 | Which orders exceeded $200 in total value? |
| 5 | What is the average order value per customer? |
| 6 | Which products have never been ordered? |
| 7 | What is the month-over-month order count? |

---

## Skills Demonstrated

- ✅ Relational database design and normalization
- ✅ `CREATE TABLE` with `PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL`, `DEFAULT`
- ✅ `INSERT INTO` with realistic, consistent sample data
- ✅ `INNER JOIN`, `LEFT JOIN` across multiple tables
- ✅ Aggregate functions: `SUM()`, `COUNT()`, `AVG()`, `MAX()`
- ✅ `GROUP BY` and `HAVING` clauses
- ✅ Subqueries and derived tables
- ✅ `DATE` functions for time-based analysis

---

## About

This project was built as part of my data analytics portfolio to demonstrate foundational SQL skills. It reflects my ability to design a database schema, populate it with meaningful data, and extract actionable business insights through queries.

**Connect with me:** Update this section with your LinkedIn and GitHub profile links.

---

*Built with SQL | Beginner Data Analyst Portfolio Project*
