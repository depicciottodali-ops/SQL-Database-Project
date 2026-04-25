-- ============================================================
--  tables.sql
--  Purpose : Define all tables, columns, and constraints for
--            the retail_store database.
--  Run this file SECOND, after schema.sql.
--  Usage   : SOURCE sql/tables.sql;
-- ============================================================

USE retail_store;

-- ------------------------------------------------------------
--  Table: categories
--  Stores the high-level product groupings (e.g., Electronics).
-- ------------------------------------------------------------
CREATE TABLE categories (
    category_id   INT            NOT NULL AUTO_INCREMENT,
    category_name VARCHAR(100)   NOT NULL,
    description   VARCHAR(255)       NULL,
    PRIMARY KEY (category_id)
);

-- ------------------------------------------------------------
--  Table: products
--  Stores individual items for sale.
--  Each product belongs to exactly one category.
-- ------------------------------------------------------------
CREATE TABLE products (
    product_id    INT             NOT NULL AUTO_INCREMENT,
    product_name  VARCHAR(150)    NOT NULL,
    category_id   INT             NOT NULL,
    price         DECIMAL(10, 2)  NOT NULL,
    stock_qty     INT             NOT NULL DEFAULT 0,
    PRIMARY KEY (product_id),
    CONSTRAINT fk_product_category
        FOREIGN KEY (category_id) REFERENCES categories (category_id)
);

-- ------------------------------------------------------------
--  Table: customers
--  Stores customer contact and registration information.
-- ------------------------------------------------------------
CREATE TABLE customers (
    customer_id   INT          NOT NULL AUTO_INCREMENT,
    first_name    VARCHAR(75)  NOT NULL,
    last_name     VARCHAR(75)  NOT NULL,
    email         VARCHAR(150) NOT NULL,
    city          VARCHAR(100)     NULL,
    state         CHAR(2)          NULL,
    created_at    DATE         NOT NULL DEFAULT (CURRENT_DATE),
    PRIMARY KEY (customer_id),
    CONSTRAINT uq_customer_email UNIQUE (email)
);

-- ------------------------------------------------------------
--  Table: orders
--  Stores the order header — who ordered and when.
--  Detailed line items are stored in order_items.
-- ------------------------------------------------------------
CREATE TABLE orders (
    order_id      INT          NOT NULL AUTO_INCREMENT,
    customer_id   INT          NOT NULL,
    order_date    DATE         NOT NULL DEFAULT (CURRENT_DATE),
    status        VARCHAR(20)  NOT NULL DEFAULT 'Pending',
    PRIMARY KEY (order_id),
    CONSTRAINT fk_order_customer
        FOREIGN KEY (customer_id) REFERENCES customers (customer_id),
    CONSTRAINT chk_order_status
        CHECK (status IN ('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled'))
);

-- ------------------------------------------------------------
--  Table: order_items
--  Stores each product line within an order (the "order lines").
--  Links orders and products in a many-to-many relationship.
-- ------------------------------------------------------------
CREATE TABLE order_items (
    order_item_id INT             NOT NULL AUTO_INCREMENT,
    order_id      INT             NOT NULL,
    product_id    INT             NOT NULL,
    quantity      INT             NOT NULL DEFAULT 1,
    unit_price    DECIMAL(10, 2)  NOT NULL,
    PRIMARY KEY (order_item_id),
    CONSTRAINT fk_item_order
        FOREIGN KEY (order_id)   REFERENCES orders   (order_id),
    CONSTRAINT fk_item_product
        FOREIGN KEY (product_id) REFERENCES products (product_id),
    CONSTRAINT chk_item_quantity
        CHECK (quantity > 0),
    CONSTRAINT chk_item_unit_price
        CHECK (unit_price >= 0)
);
