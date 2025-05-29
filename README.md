# 🛒 E-Commerce SQL Analytics Project


## 📖 Overview
This project demonstrates advanced SQL techniques for analyzing an e-commerce database, developed as part of a Data Analyst Internship assessment. The solution covers database design, complex queries, performance optimization, and real-world business analysis scenarios.

## 🗃️ Database Schema
**4 Normalized Tables:**
- `customers` (Customer demographics)
- `products` (Product catalog)
- `orders` (Transaction records)
- `order_items` (Line items)

```mermaid
erDiagram
    customers ||--o{ orders : places
    orders ||--|{ order_items : contains
    products ||--|{ order_items : includes
