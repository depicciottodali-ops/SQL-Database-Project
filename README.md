# Retail Sales Database — SQL Portfolio Project

A relational database built from scratch in SQL, modeling the core operations of a retail store.  
Designed as a portfolio project to demonstrate database design, normalization, and analytical querying skills.

---

## 📌 Project Overview

This project simulates the back-end database of a small retail store. It covers the full lifecycle of a database project:

1. **Schema design** — defining tables, relationships, and constraints  
2. **Data population** — inserting realistic sample data  
3. **Analytical queries** — answering business questions with SQL  

---

## 🗂️ Folder Structure

```
SQL-Database-Project/
│
├── README.md                   ← You are here
│
├── schema/
│   └── create_tables.sql       ← DDL: CREATE TABLE statements with PKs, FKs, and constraints
│
├── data/
│   └── insert_sample_data.sql  ← DML: INSERT statements with realistic sample data
│
├── queries/
│   ├── basic_queries.sql       ← SELECT, WHERE, ORDER BY examples
│   ├── joins.sql               ← INNER JOIN and LEFT JOIN examples
│   └── aggregations.sql        ← GROUP BY, COUNT, SUM, AVG, HAVING examples
│
└── docs/
    └── er_diagram.md           ← Entity-Relationship diagram (text-based)
```

---

## 🗃️ Database Schema

The database contains **six related tables**:

| Table | Description |
|---|---|
| `categories` | Product categories (e.g., Electronics, Clothing) |
| `products` | Items for sale, linked to a category |
| `customers` | Store customers |
| `employees` | Store staff who process orders |
| `orders` | Customer orders, linked to a customer and employee |
| `order_items` | Individual line items within each order |

### Entity Relationships

```
categories ──< products
customers  ──< orders ──< order_items >── products
employees  ──< orders
```

---

## 🧠 Skills Demonstrated

| Skill | Where |
|---|---|
| Database design & normalization (1NF–3NF) | `schema/create_tables.sql` |
| Primary keys, foreign keys, and constraints | `schema/create_tables.sql` |
| Inserting and managing relational data | `data/insert_sample_data.sql` |
| Filtering, sorting, and aliasing | `queries/basic_queries.sql` |
| Multi-table JOINs (INNER, LEFT) | `queries/joins.sql` |
| Aggregation and grouping | `queries/aggregations.sql` |
| Subqueries | `queries/aggregations.sql` |

---

## 🚀 How to Run

These scripts are written in standard SQL and are compatible with **PostgreSQL**, **MySQL**, and **SQLite** with minor syntax adjustments.

1. Run `schema/create_tables.sql` to create the database structure.  
2. Run `data/insert_sample_data.sql` to populate the tables with sample data.  
3. Run any script in `queries/` to explore analytical examples.

### Quick start with SQLite (command line)

```bash
sqlite3 retail_store.db < schema/create_tables.sql
sqlite3 retail_store.db < data/insert_sample_data.sql
sqlite3 retail_store.db < queries/basic_queries.sql
```

---

## 💡 Sample Business Questions Answered

- Which products generate the most revenue?  
- What are the top 5 customers by total spend?  
- Which employee processed the most orders?  
- What is the average order value per month?  
- Which product categories have the highest sales volume?  

---

## 👤 Author

**Dali Depicciotto**  
Aspiring Data Analyst | SQL • Python • Data Visualization  

---

*This project was built for learning and portfolio purposes.*

