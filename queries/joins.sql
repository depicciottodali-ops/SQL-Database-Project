-- =============================================================
-- FILE: queries/joins.sql
-- PROJECT: Retail Sales Database
-- DESCRIPTION: Multi-table JOIN queries demonstrating how to
--              combine data from related tables.
-- =============================================================


-- -------------------------------------------------------------
-- 1. List every order with the customer's full name and order status
--    (INNER JOIN — only customers who have placed orders)
-- -------------------------------------------------------------
SELECT
    o.order_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    o.order_date,
    o.status
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
ORDER BY o.order_date;


-- -------------------------------------------------------------
-- 2. Show the full order details: customer, employee, and status
--    (Multiple INNER JOINs)
-- -------------------------------------------------------------
SELECT
    o.order_id,
    c.first_name || ' ' || c.last_name  AS customer_name,
    e.first_name || ' ' || e.last_name  AS processed_by,
    o.order_date,
    o.status
FROM orders o
INNER JOIN customers c  ON o.customer_id  = c.customer_id
INNER JOIN employees e  ON o.employee_id  = e.employee_id
ORDER BY o.order_date;


-- -------------------------------------------------------------
-- 3. Show all order line items with product names and prices
--    (Joining order_items to orders and products)
-- -------------------------------------------------------------
SELECT
    oi.order_id,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    oi.quantity * oi.unit_price AS line_total
FROM order_items oi
INNER JOIN products p ON oi.product_id = p.product_id
ORDER BY oi.order_id, p.product_name;


-- -------------------------------------------------------------
-- 4. Show each product alongside its category name
--    (INNER JOIN — products must have a category)
-- -------------------------------------------------------------
SELECT
    p.product_name,
    c.category_name,
    p.unit_price,
    p.stock_qty
FROM products p
INNER JOIN categories c ON p.category_id = c.category_id
ORDER BY c.category_name, p.product_name;


-- -------------------------------------------------------------
-- 5. List all customers and their orders, including customers
--    who have NOT placed any orders yet
--    (LEFT JOIN — keeps all customers regardless of order status)
-- -------------------------------------------------------------
SELECT
    c.first_name || ' ' || c.last_name AS customer_name,
    c.city,
    o.order_id,
    o.order_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
ORDER BY c.last_name;


-- -------------------------------------------------------------
-- 6. Find all products that have NEVER been ordered
--    (LEFT JOIN + NULL check)
-- -------------------------------------------------------------
SELECT
    p.product_name,
    p.unit_price,
    p.stock_qty
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;


-- -------------------------------------------------------------
-- 7. Full order receipt: customer, employee, items, and totals
--    (A comprehensive 5-table JOIN)
-- -------------------------------------------------------------
SELECT
    o.order_id,
    c.first_name || ' ' || c.last_name  AS customer_name,
    e.first_name || ' ' || e.last_name  AS employee_name,
    p.product_name,
    cat.category_name,
    oi.quantity,
    oi.unit_price,
    oi.quantity * oi.unit_price          AS line_total,
    o.order_date,
    o.status
FROM orders o
INNER JOIN customers   c   ON o.customer_id  = c.customer_id
INNER JOIN employees   e   ON o.employee_id  = e.employee_id
INNER JOIN order_items oi  ON o.order_id     = oi.order_id
INNER JOIN products    p   ON oi.product_id  = p.product_id
INNER JOIN categories  cat ON p.category_id  = cat.category_id
ORDER BY o.order_id, p.product_name;
