-- ============================================================
--  insert_data.sql
--  Purpose : Populate the retail_store database with realistic
--            sample data for testing and analysis.
--  Run this file THIRD, after tables.sql.
--  Usage   : SOURCE sql/insert_data.sql;
-- ============================================================

USE retail_store;

-- ------------------------------------------------------------
--  Categories (6 rows)
-- ------------------------------------------------------------
INSERT INTO categories (category_name, description) VALUES
    ('Electronics',     'Gadgets, devices, and tech accessories'),
    ('Clothing',        'Men''s, women''s, and children''s apparel'),
    ('Home & Kitchen',  'Cookware, furniture, and home essentials'),
    ('Sports',          'Fitness equipment and outdoor gear'),
    ('Books',           'Fiction, non-fiction, and educational titles'),
    ('Beauty',          'Skincare, haircare, and personal care products');

-- ------------------------------------------------------------
--  Products (18 rows, 3 per category)
-- ------------------------------------------------------------
INSERT INTO products (product_name, category_id, price, stock_qty) VALUES
    -- Electronics (category_id = 1)
    ('Wireless Bluetooth Headphones',  1,  79.99, 120),
    ('USB-C Charging Hub',             1,  34.99, 200),
    ('Portable Power Bank 20000mAh',   1,  49.99, 150),
    -- Clothing (category_id = 2)
    ('Classic White T-Shirt',          2,  19.99, 500),
    ('Slim Fit Chino Pants',           2,  44.99, 300),
    ('Athletic Running Jacket',        2,  89.99, 175),
    -- Home & Kitchen (category_id = 3)
    ('Non-Stick Fry Pan Set',          3,  59.99, 80),
    ('Bamboo Cutting Board',           3,  24.99, 220),
    ('Stainless Steel Water Bottle',   3,  29.99, 400),
    -- Sports (category_id = 4)
    ('Adjustable Dumbbell Set',        4, 149.99, 60),
    ('Yoga Mat with Carrying Strap',   4,  27.99, 180),
    ('Resistance Band Kit',            4,  21.99, 250),
    -- Books (category_id = 5)
    ('SQL for Beginners',              5,  29.99, 350),
    ('Data Analytics Handbook',        5,  34.99, 200),
    ('Python Crash Course',            5,  31.99, 310),
    -- Beauty (category_id = 6)
    ('Vitamin C Serum 30ml',           6,  22.99, 430),
    ('Moisturizing Face Cream',        6,  18.99, 380),
    ('Natural Shampoo & Conditioner',  6,  16.99, 290);

-- ------------------------------------------------------------
--  Customers (10 rows)
-- ------------------------------------------------------------
INSERT INTO customers (first_name, last_name, email, city, state, created_at) VALUES
    ('Alice',   'Johnson',   'alice.johnson@email.com',   'New York',    'NY', '2023-01-15'),
    ('Bob',     'Martinez',  'bob.martinez@email.com',    'Los Angeles', 'CA', '2023-02-20'),
    ('Carol',   'Williams',  'carol.williams@email.com',  'Chicago',     'IL', '2023-03-05'),
    ('David',   'Lee',       'david.lee@email.com',       'Houston',     'TX', '2023-03-18'),
    ('Emma',    'Brown',     'emma.brown@email.com',      'Phoenix',     'AZ', '2023-04-22'),
    ('Frank',   'Garcia',    'frank.garcia@email.com',    'Philadelphia','PA', '2023-05-10'),
    ('Grace',   'Kim',       'grace.kim@email.com',       'San Antonio', 'TX', '2023-06-01'),
    ('Henry',   'Davis',     'henry.davis@email.com',     'San Diego',   'CA', '2023-07-14'),
    ('Isla',    'Wilson',    'isla.wilson@email.com',     'Dallas',      'TX', '2023-08-30'),
    ('James',   'Taylor',    'james.taylor@email.com',    'San Jose',    'CA', '2023-09-12');

-- ------------------------------------------------------------
--  Orders (15 rows across several months)
-- ------------------------------------------------------------
INSERT INTO orders (customer_id, order_date, status) VALUES
    (1,  '2023-10-03', 'Delivered'),
    (2,  '2023-10-11', 'Delivered'),
    (3,  '2023-10-19', 'Delivered'),
    (1,  '2023-11-02', 'Delivered'),
    (4,  '2023-11-15', 'Delivered'),
    (5,  '2023-11-27', 'Delivered'),
    (2,  '2023-12-05', 'Shipped'),
    (6,  '2023-12-10', 'Shipped'),
    (7,  '2024-01-07', 'Delivered'),
    (8,  '2024-01-20', 'Delivered'),
    (3,  '2024-02-02', 'Delivered'),
    (9,  '2024-02-14', 'Processing'),
    (10, '2024-03-01', 'Pending'),
    (4,  '2024-03-15', 'Pending'),
    (5,  '2024-03-22', 'Pending');

-- ------------------------------------------------------------
--  Order Items (28 rows)
--  unit_price is recorded at time of purchase (may differ from
--  current product price — intentional for realistic data).
-- ------------------------------------------------------------
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
    -- Order 1 (Alice, Oct 3)
    (1,  1, 1,  79.99),   -- Wireless Headphones
    (1,  3, 1,  49.99),   -- Power Bank
    -- Order 2 (Bob, Oct 11)
    (2,  4, 2,  19.99),   -- White T-Shirt x2
    (2,  5, 1,  44.99),   -- Chino Pants
    -- Order 3 (Carol, Oct 19)
    (3,  7, 1,  59.99),   -- Fry Pan Set
    (3,  8, 1,  24.99),   -- Cutting Board
    -- Order 4 (Alice, Nov 2)
    (4, 13, 2,  29.99),   -- SQL for Beginners x2
    (4, 14, 1,  34.99),   -- Data Analytics Handbook
    -- Order 5 (David, Nov 15)
    (5, 10, 1, 149.99),   -- Dumbbell Set
    (5, 11, 1,  27.99),   -- Yoga Mat
    -- Order 6 (Emma, Nov 27)
    (6,  6, 1,  89.99),   -- Running Jacket
    (6,  2, 1,  34.99),   -- USB-C Hub
    -- Order 7 (Bob, Dec 5)
    (7, 15, 1,  31.99),   -- Python Crash Course
    (7, 16, 2,  22.99),   -- Vitamin C Serum x2
    -- Order 8 (Frank, Dec 10)
    (8,  9, 3,  29.99),   -- Water Bottle x3
    (8, 12, 1,  21.99),   -- Resistance Band Kit
    -- Order 9 (Grace, Jan 7)
    (9,  1, 1,  79.99),   -- Wireless Headphones
    (9, 17, 1,  18.99),   -- Face Cream
    -- Order 10 (Henry, Jan 20)
    (10,  3, 2,  49.99),  -- Power Bank x2
    (10,  4, 3,  19.99),  -- White T-Shirt x3
    -- Order 11 (Carol, Feb 2)
    (11,  5, 2,  44.99),  -- Chino Pants x2
    (11, 18, 2,  16.99),  -- Shampoo & Conditioner x2
    -- Order 12 (Isla, Feb 14)
    (12, 13, 1,  29.99),  -- SQL for Beginners
    (12, 14, 1,  34.99),  -- Data Analytics Handbook
    -- Order 13 (James, Mar 1)
    (13,  7, 1,  59.99),  -- Fry Pan Set
    -- Order 14 (David, Mar 15)
    (14, 11, 2,  27.99),  -- Yoga Mat x2
    (14, 12, 1,  21.99),  -- Resistance Band Kit
    -- Order 15 (Emma, Mar 22)
    (15,  6, 1,  89.99);  -- Running Jacket
