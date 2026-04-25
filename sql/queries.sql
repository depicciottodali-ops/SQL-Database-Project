-- ============================================================
--  queries.sql
--  Purpose : Analytical queries that answer real business
--            questions using the retail_store database.
--  Run this file LAST, after insert_data.sql.
--  Usage   : SOURCE sql/queries.sql;
-- ============================================================

USE retail_store;

-- ============================================================
--  QUERY 1
--  Which customers have placed the most orders?
--  Shows customer loyalty and order frequency.
-- ============================================================
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.city,
    c.state,
    COUNT(o.order_id)                       AS total_orders
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city,
    c.state
ORDER BY total_orders DESC;

-- ============================================================
--  QUERY 2
--  What are the top 5 best-selling products by total revenue?
--  Helps identify the highest-earning items in the catalog.
-- ============================================================
SELECT
    p.product_id,
    p.product_name,
    cat.category_name,
    SUM(oi.quantity)                          AS total_units_sold,
    SUM(oi.quantity * oi.unit_price)          AS total_revenue
FROM products p
INNER JOIN order_items oi ON p.product_id    = oi.product_id
INNER JOIN categories  cat ON p.category_id  = cat.category_id
GROUP BY
    p.product_id,
    p.product_name,
    cat.category_name
ORDER BY total_revenue DESC
LIMIT 5;

-- ============================================================
--  QUERY 3
--  What is the total revenue per product category?
--  Reveals which categories drive the most sales.
-- ============================================================
SELECT
    cat.category_name,
    COUNT(DISTINCT oi.order_id)          AS orders_including_category,
    SUM(oi.quantity)                     AS total_units_sold,
    SUM(oi.quantity * oi.unit_price)     AS total_revenue
FROM categories cat
INNER JOIN products    p  ON cat.category_id = p.category_id
INNER JOIN order_items oi ON p.product_id    = oi.product_id
GROUP BY cat.category_name
ORDER BY total_revenue DESC;

-- ============================================================
--  QUERY 4
--  Which orders exceeded $200 in total value?
--  Identifies high-value orders for VIP treatment.
-- ============================================================
SELECT
    o.order_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    o.order_date,
    o.status,
    SUM(oi.quantity * oi.unit_price)        AS order_total
FROM orders o
INNER JOIN customers   c  ON o.customer_id = c.customer_id
INNER JOIN order_items oi ON o.order_id    = oi.order_id
GROUP BY
    o.order_id,
    c.first_name,
    c.last_name,
    o.order_date,
    o.status
HAVING order_total > 200
ORDER BY order_total DESC;

-- ============================================================
--  QUERY 5
--  What is the average order value per customer?
--  Measures spending behavior per customer.
-- ============================================================
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name)   AS customer_name,
    COUNT(DISTINCT o.order_id)                AS total_orders,
    SUM(oi.quantity * oi.unit_price)          AS lifetime_spend,
    ROUND(
        SUM(oi.quantity * oi.unit_price)
        / COUNT(DISTINCT o.order_id),
        2
    )                                          AS avg_order_value
FROM customers c
INNER JOIN orders      o  ON c.customer_id = o.customer_id
INNER JOIN order_items oi ON o.order_id    = oi.order_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY avg_order_value DESC;

-- ============================================================
--  QUERY 6
--  Which products have never been ordered?
--  Flags slow-moving or unlisted inventory.
-- ============================================================
SELECT
    p.product_id,
    p.product_name,
    cat.category_name,
    p.price,
    p.stock_qty
FROM products p
INNER JOIN categories cat ON p.category_id = cat.category_id
LEFT JOIN order_items oi  ON p.product_id  = oi.product_id
WHERE oi.order_item_id IS NULL
ORDER BY cat.category_name, p.product_name;

-- ============================================================
--  QUERY 7
--  What is the monthly order count and revenue trend?
--  Shows growth (or decline) in sales over time.
-- ============================================================
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m')       AS order_month,
    COUNT(DISTINCT o.order_id)               AS total_orders,
    COUNT(DISTINCT o.customer_id)            AS unique_customers,
    SUM(oi.quantity * oi.unit_price)         AS monthly_revenue
FROM orders o
INNER JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY order_month
ORDER BY order_month ASC;
