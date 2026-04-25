-- =============================================================
-- FILE: queries/basic_queries.sql
-- PROJECT: Retail Sales Database
-- DESCRIPTION: Foundational SELECT queries demonstrating filtering,
--              sorting, aliasing, and pattern matching.
-- =============================================================


-- -------------------------------------------------------------
-- 1. List all products with their prices, sorted by price (high to low)
-- -------------------------------------------------------------
SELECT
    product_name,
    unit_price
FROM products
ORDER BY unit_price DESC;


-- -------------------------------------------------------------
-- 2. Find all products priced under $30
-- -------------------------------------------------------------
SELECT
    product_name,
    unit_price
FROM products
WHERE unit_price < 30.00
ORDER BY unit_price;


-- -------------------------------------------------------------
-- 3. List all customers from Texas or Florida
-- -------------------------------------------------------------
SELECT
    first_name,
    last_name,
    city,
    state
FROM customers
WHERE state IN ('TX', 'FL')
ORDER BY state, last_name;


-- -------------------------------------------------------------
-- 4. Find products that contain "yoga" in the name (case-insensitive)
-- -------------------------------------------------------------
SELECT
    product_name,
    unit_price,
    stock_qty
FROM products
WHERE LOWER(product_name) LIKE '%yoga%';


-- -------------------------------------------------------------
-- 5. Show all orders placed in January 2024
-- -------------------------------------------------------------
SELECT
    order_id,
    customer_id,
    order_date,
    status
FROM orders
WHERE order_date >= '2024-01-01'
  AND order_date <  '2024-02-01'
ORDER BY order_date;


-- -------------------------------------------------------------
-- 6. List all orders that have NOT yet been delivered
-- -------------------------------------------------------------
SELECT
    order_id,
    customer_id,
    order_date,
    status
FROM orders
WHERE status <> 'delivered'
ORDER BY order_date;


-- -------------------------------------------------------------
-- 7. Show the 5 most recently hired employees
-- -------------------------------------------------------------
SELECT
    first_name,
    last_name,
    job_title,
    hire_date
FROM employees
ORDER BY hire_date DESC
LIMIT 5;


-- -------------------------------------------------------------
-- 8. Display each customer's full name as a single column
-- -------------------------------------------------------------
SELECT
    customer_id,
    first_name || ' ' || last_name AS full_name,
    email,
    city
FROM customers
ORDER BY last_name;
