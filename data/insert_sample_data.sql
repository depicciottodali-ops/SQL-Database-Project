-- =============================================================
-- FILE: data/insert_sample_data.sql
-- PROJECT: Retail Sales Database
-- DESCRIPTION: Populates all tables with realistic sample data.
--              Run schema/create_tables.sql first.
-- =============================================================


-- -------------------------------------------------------------
-- categories
-- -------------------------------------------------------------
INSERT INTO categories (category_id, category_name, description) VALUES
(1, 'Electronics',    'Devices, gadgets, and accessories'),
(2, 'Clothing',       'Apparel for men, women, and children'),
(3, 'Home & Kitchen', 'Furniture, appliances, and kitchenware'),
(4, 'Books',          'Fiction, non-fiction, and educational titles'),
(5, 'Sports & Outdoors', 'Equipment and gear for outdoor activities');


-- -------------------------------------------------------------
-- products
-- -------------------------------------------------------------
INSERT INTO products (product_id, product_name, category_id, unit_price, stock_qty) VALUES
(1,  'Wireless Bluetooth Headphones', 1, 79.99,  45),
(2,  'USB-C Charging Cable (6ft)',    1, 12.99, 200),
(3,  'Portable Power Bank 20000mAh', 1, 49.99,  60),
(4,  'Smart LED Desk Lamp',          1, 34.99,  80),
(5,  'Men''s Classic Crewneck Sweatshirt', 2, 39.99, 120),
(6,  'Women''s Yoga Leggings',       2, 44.99,  95),
(7,  'Kids'' Rain Jacket',           2, 29.99,  55),
(8,  'Stainless Steel Water Bottle', 3, 24.99, 150),
(9,  'Non-Stick Frying Pan Set',     3, 59.99,  40),
(10, 'Bamboo Cutting Board',         3, 19.99,  90),
(11, 'The Data Science Handbook',    4, 34.99,  70),
(12, 'SQL for Beginners',            4, 27.99, 110),
(13, 'Yoga Mat (6mm Thick)',         5, 29.99, 130),
(14, 'Adjustable Resistance Bands',  5, 21.99, 180),
(15, 'Hiking Backpack 40L',          5, 89.99,  35);


-- -------------------------------------------------------------
-- customers
-- -------------------------------------------------------------
INSERT INTO customers (customer_id, first_name, last_name, email, phone, city, state, created_at) VALUES
(1,  'Alice',   'Johnson',  'alice.johnson@email.com',  '555-0101', 'Austin',      'TX', '2023-01-15'),
(2,  'Bob',     'Martinez', 'bob.martinez@email.com',   '555-0102', 'Denver',      'CO', '2023-02-20'),
(3,  'Carol',   'White',    'carol.white@email.com',    '555-0103', 'Portland',    'OR', '2023-03-05'),
(4,  'David',   'Kim',      'david.kim@email.com',      '555-0104', 'Chicago',     'IL', '2023-03-18'),
(5,  'Eva',     'Brown',    'eva.brown@email.com',      '555-0105', 'Miami',       'FL', '2023-04-02'),
(6,  'Frank',   'Garcia',   'frank.garcia@email.com',   '555-0106', 'Phoenix',     'AZ', '2023-04-27'),
(7,  'Grace',   'Lee',      'grace.lee@email.com',      '555-0107', 'Seattle',     'WA', '2023-05-10'),
(8,  'Henry',   'Wilson',   'henry.wilson@email.com',   '555-0108', 'Atlanta',     'GA', '2023-06-01'),
(9,  'Isabelle','Thomas',   'isabelle.thomas@email.com','555-0109', 'Boston',      'MA', '2023-06-22'),
(10, 'James',   'Anderson', 'james.anderson@email.com', '555-0110', 'Nashville',   'TN', '2023-07-14');


-- -------------------------------------------------------------
-- employees
-- -------------------------------------------------------------
INSERT INTO employees (employee_id, first_name, last_name, job_title, hire_date, hourly_rate) VALUES
(1, 'Maria',   'Lopez',   'Sales Associate',  '2021-06-01', 17.50),
(2, 'Noah',    'Davis',   'Senior Associate', '2019-03-15', 22.00),
(3, 'Olivia',  'Harris',  'Store Manager',    '2018-01-10', 30.00),
(4, 'Patrick', 'Clark',   'Sales Associate',  '2022-09-05', 17.50),
(5, 'Quinn',   'Robinson','Sales Associate',  '2023-02-20', 17.50);


-- -------------------------------------------------------------
-- orders
-- -------------------------------------------------------------
INSERT INTO orders (order_id, customer_id, employee_id, order_date, status) VALUES
(1001, 1,  2, '2024-01-05', 'delivered'),
(1002, 2,  1, '2024-01-12', 'delivered'),
(1003, 3,  3, '2024-01-20', 'delivered'),
(1004, 4,  4, '2024-02-03', 'delivered'),
(1005, 5,  2, '2024-02-14', 'delivered'),
(1006, 6,  1, '2024-02-25', 'shipped'),
(1007, 7,  5, '2024-03-02', 'shipped'),
(1008, 8,  2, '2024-03-10', 'processing'),
(1009, 9,  3, '2024-03-18', 'processing'),
(1010, 10, 4, '2024-04-01', 'pending'),
(1011, 1,  1, '2024-04-05', 'pending'),
(1012, 3,  2, '2024-04-08', 'pending'),
(1013, 5,  5, '2024-04-10', 'pending'),
(1014, 2,  3, '2024-04-15', 'pending');


-- -------------------------------------------------------------
-- order_items
-- unit_price is recorded at the time of purchase (snapshot pricing)
-- -------------------------------------------------------------
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price) VALUES
-- Order 1001: Headphones + Charging Cable
(1,  1001, 1,  1, 79.99),
(2,  1001, 2,  2, 12.99),
-- Order 1002: Yoga Mat + Resistance Bands
(3,  1002, 13, 1, 29.99),
(4,  1002, 14, 2, 21.99),
-- Order 1003: Frying Pan Set + Cutting Board + Water Bottle
(5,  1003, 9,  1, 59.99),
(6,  1003, 10, 1, 19.99),
(7,  1003, 8,  2, 24.99),
-- Order 1004: SQL Book + Data Science Book
(8,  1004, 12, 1, 27.99),
(9,  1004, 11, 1, 34.99),
-- Order 1005: Power Bank + Desk Lamp
(10, 1005, 3,  1, 49.99),
(11, 1005, 4,  1, 34.99),
-- Order 1006: Women's Leggings + Kids' Rain Jacket
(12, 1006, 6,  2, 44.99),
(13, 1006, 7,  1, 29.99),
-- Order 1007: Hiking Backpack
(14, 1007, 15, 1, 89.99),
-- Order 1008: Sweatshirt x2 + Charging Cable x3
(15, 1008, 5,  2, 39.99),
(16, 1008, 2,  3, 12.99),
-- Order 1009: Wireless Headphones + Power Bank
(17, 1009, 1,  1, 79.99),
(18, 1009, 3,  1, 49.99),
-- Order 1010: Yoga Mat + Water Bottle
(19, 1010, 13, 2, 29.99),
(20, 1010, 8,  1, 24.99),
-- Order 1011: SQL Book
(21, 1011, 12, 1, 27.99),
-- Order 1012: Resistance Bands + Hiking Backpack
(22, 1012, 14, 1, 21.99),
(23, 1012, 15, 1, 89.99),
-- Order 1013: Desk Lamp + Cutting Board
(24, 1013, 4,  1, 34.99),
(25, 1013, 10, 2, 19.99),
-- Order 1014: Frying Pan Set
(26, 1014, 9,  1, 59.99);
