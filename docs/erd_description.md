# Entity Relationship Diagram (ERD)

This document describes the relationships between the five tables in the `retail_store` database.

---

## Tables and Columns

### `categories`
| Column | Type | Notes |
|---|---|---|
| `category_id` | INT | Primary Key, Auto Increment |
| `category_name` | VARCHAR(100) | NOT NULL |
| `description` | VARCHAR(255) | Optional |

### `products`
| Column | Type | Notes |
|---|---|---|
| `product_id` | INT | Primary Key, Auto Increment |
| `product_name` | VARCHAR(150) | NOT NULL |
| `category_id` | INT | Foreign Key → `categories.category_id` |
| `price` | DECIMAL(10,2) | NOT NULL |
| `stock_qty` | INT | Default 0 |

### `customers`
| Column | Type | Notes |
|---|---|---|
| `customer_id` | INT | Primary Key, Auto Increment |
| `first_name` | VARCHAR(75) | NOT NULL |
| `last_name` | VARCHAR(75) | NOT NULL |
| `email` | VARCHAR(150) | NOT NULL, Unique |
| `city` | VARCHAR(100) | Optional |
| `state` | CHAR(2) | Optional |
| `created_at` | DATE | Default current date |

### `orders`
| Column | Type | Notes |
|---|---|---|
| `order_id` | INT | Primary Key, Auto Increment |
| `customer_id` | INT | Foreign Key → `customers.customer_id` |
| `order_date` | DATE | NOT NULL, Default current date |
| `status` | VARCHAR(20) | Constrained to allowed values |

### `order_items`
| Column | Type | Notes |
|---|---|---|
| `order_item_id` | INT | Primary Key, Auto Increment |
| `order_id` | INT | Foreign Key → `orders.order_id` |
| `product_id` | INT | Foreign Key → `products.product_id` |
| `quantity` | INT | Must be > 0 |
| `unit_price` | DECIMAL(10,2) | Price at time of purchase |

---

## Relationships

```
categories
    │
    │  (one category has many products)
    │
    ▼
products ──────────────────────┐
                               │
                    (one product appears in many order lines)
                               │
                               ▼
customers                 order_items
    │                          ▲
    │  (one customer           │
    │   places many orders)    │
    ▼                          │
orders ────────────────────────┘
    (one order has many order lines)
```

### Cardinalities

| Relationship | Type |
|---|---|
| `categories` → `products` | One-to-Many |
| `customers` → `orders` | One-to-Many |
| `orders` → `order_items` | One-to-Many |
| `products` → `order_items` | One-to-Many |
| `orders` ↔ `products` (via `order_items`) | Many-to-Many |

---

## Design Decisions

- **`unit_price` in `order_items`** — The price is stored at the time of purchase so that historical order totals remain accurate even if product prices are updated later.
- **`status` CHECK constraint** — Only valid order statuses are permitted (`Pending`, `Processing`, `Shipped`, `Delivered`, `Cancelled`), preventing bad data at the database level.
- **Unique email constraint** — Ensures no two customers can register with the same email address.
