-- =============================================================
-- FILE: schema/create_tables.sql
-- PROJECT: Retail Sales Database
-- DESCRIPTION: Creates all tables with primary keys, foreign keys,
--              and data integrity constraints.
-- =============================================================

-- Drop tables in reverse dependency order to allow re-running this script cleanly.
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS employees;


-- -------------------------------------------------------------
-- TABLE: categories
-- Stores high-level product groupings.
-- -------------------------------------------------------------
CREATE TABLE categories (
    category_id   INTEGER      PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description   TEXT
);


-- -------------------------------------------------------------
-- TABLE: products
-- Each product belongs to one category (many-to-one).
-- -------------------------------------------------------------
CREATE TABLE products (
    product_id    INTEGER        PRIMARY KEY,
    product_name  VARCHAR(150)   NOT NULL,
    category_id   INTEGER        NOT NULL,
    unit_price    DECIMAL(10, 2) NOT NULL CHECK (unit_price >= 0),
    stock_qty     INTEGER        NOT NULL DEFAULT 0 CHECK (stock_qty >= 0),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);


-- -------------------------------------------------------------
-- TABLE: customers
-- People who place orders at the store.
-- -------------------------------------------------------------
CREATE TABLE customers (
    customer_id   INTEGER      PRIMARY KEY,
    first_name    VARCHAR(75)  NOT NULL,
    last_name     VARCHAR(75)  NOT NULL,
    email         VARCHAR(150) NOT NULL UNIQUE,
    phone         VARCHAR(20),
    city          VARCHAR(100),
    state         VARCHAR(50),
    created_at    DATE         NOT NULL DEFAULT CURRENT_DATE
);


-- -------------------------------------------------------------
-- TABLE: employees
-- Staff members who process orders.
-- -------------------------------------------------------------
CREATE TABLE employees (
    employee_id   INTEGER      PRIMARY KEY,
    first_name    VARCHAR(75)  NOT NULL,
    last_name     VARCHAR(75)  NOT NULL,
    job_title     VARCHAR(100),
    hire_date     DATE         NOT NULL,
    hourly_rate   DECIMAL(8, 2) CHECK (hourly_rate >= 0)
);


-- -------------------------------------------------------------
-- TABLE: orders
-- A transaction placed by a customer, handled by an employee.
-- Each order has one customer (many-to-one) and one employee (many-to-one).
-- -------------------------------------------------------------
CREATE TABLE orders (
    order_id      INTEGER      PRIMARY KEY,
    customer_id   INTEGER      NOT NULL,
    employee_id   INTEGER,
    order_date    DATE         NOT NULL DEFAULT CURRENT_DATE,
    status        VARCHAR(20)  NOT NULL DEFAULT 'pending'
                               CHECK (status IN ('pending', 'processing', 'shipped', 'delivered', 'cancelled')),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);


-- -------------------------------------------------------------
-- TABLE: order_items
-- Individual line items within an order (junction table between
-- orders and products — resolves the many-to-many relationship).
-- -------------------------------------------------------------
CREATE TABLE order_items (
    order_item_id INTEGER        PRIMARY KEY,
    order_id      INTEGER        NOT NULL,
    product_id    INTEGER        NOT NULL,
    quantity      INTEGER        NOT NULL CHECK (quantity > 0),
    unit_price    DECIMAL(10, 2) NOT NULL CHECK (unit_price >= 0),
    FOREIGN KEY (order_id)  REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
