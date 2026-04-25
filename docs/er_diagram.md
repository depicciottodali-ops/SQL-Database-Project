# Entity-Relationship Diagram

This document describes the relationships between all tables in the Retail Sales Database.

---

## Tables & Columns

### `categories`
| Column | Type | Constraints |
|---|---|---|
| `category_id` | INTEGER | PRIMARY KEY |
| `category_name` | VARCHAR(100) | NOT NULL, UNIQUE |
| `description` | TEXT | |

---

### `products`
| Column | Type | Constraints |
|---|---|---|
| `product_id` | INTEGER | PRIMARY KEY |
| `product_name` | VARCHAR(150) | NOT NULL |
| `category_id` | INTEGER | NOT NULL, FK → categories |
| `unit_price` | DECIMAL(10,2) | NOT NULL, ≥ 0 |
| `stock_qty` | INTEGER | NOT NULL, ≥ 0, DEFAULT 0 |

---

### `customers`
| Column | Type | Constraints |
|---|---|---|
| `customer_id` | INTEGER | PRIMARY KEY |
| `first_name` | VARCHAR(75) | NOT NULL |
| `last_name` | VARCHAR(75) | NOT NULL |
| `email` | VARCHAR(150) | NOT NULL, UNIQUE |
| `phone` | VARCHAR(20) | |
| `city` | VARCHAR(100) | |
| `state` | VARCHAR(50) | |
| `created_at` | DATE | NOT NULL, DEFAULT CURRENT_DATE |

---

### `employees`
| Column | Type | Constraints |
|---|---|---|
| `employee_id` | INTEGER | PRIMARY KEY |
| `first_name` | VARCHAR(75) | NOT NULL |
| `last_name` | VARCHAR(75) | NOT NULL |
| `job_title` | VARCHAR(100) | |
| `hire_date` | DATE | NOT NULL |
| `hourly_rate` | DECIMAL(8,2) | ≥ 0 |

---

### `orders`
| Column | Type | Constraints |
|---|---|---|
| `order_id` | INTEGER | PRIMARY KEY |
| `customer_id` | INTEGER | NOT NULL, FK → customers |
| `employee_id` | INTEGER | FK → employees |
| `order_date` | DATE | NOT NULL, DEFAULT CURRENT_DATE |
| `status` | VARCHAR(20) | NOT NULL, CHECK (pending/processing/shipped/delivered/cancelled) |

---

### `order_items`
| Column | Type | Constraints |
|---|---|---|
| `order_item_id` | INTEGER | PRIMARY KEY |
| `order_id` | INTEGER | NOT NULL, FK → orders |
| `product_id` | INTEGER | NOT NULL, FK → products |
| `quantity` | INTEGER | NOT NULL, > 0 |
| `unit_price` | DECIMAL(10,2) | NOT NULL, ≥ 0 |

---

## Relationships

```
┌─────────────┐         ┌──────────────┐
│  categories │ 1 ──< * │   products   │
└─────────────┘         └──────┬───────┘
                                │ * (FK: product_id)
                                │
┌─────────────┐         ┌──────┴───────┐         ┌──────────────┐
│  customers  │ 1 ──< * │    orders    │ * >── 1  │  employees   │
└─────────────┘         └──────┬───────┘          └──────────────┘
                                │ 1
                                │
                         ┌──────┴───────┐
                         │ order_items  │  (junction table)
                         └─────────────-┘
```

### Relationship Summary

| Relationship | Type | Description |
|---|---|---|
| `categories` → `products` | One-to-Many | One category contains many products |
| `customers` → `orders` | One-to-Many | One customer can place many orders |
| `employees` → `orders` | One-to-Many | One employee can process many orders |
| `orders` → `order_items` | One-to-Many | One order contains many line items |
| `products` → `order_items` | One-to-Many | One product can appear in many line items |
| `orders` ↔ `products` | Many-to-Many | Resolved via `order_items` junction table |

---

## Design Notes

- **Snapshot pricing**: `order_items.unit_price` stores the price at the time of purchase, independent of `products.unit_price`. This preserves historical accuracy.
- **Nullable `employee_id` on `orders`**: Allows recording an order even if no employee is assigned (e.g., online orders).
- **`status` CHECK constraint**: Enforces a controlled vocabulary of valid order states at the database level.
- **Normalization**: The schema is in **Third Normal Form (3NF)** — all non-key attributes depend only on the primary key, with no transitive dependencies.
