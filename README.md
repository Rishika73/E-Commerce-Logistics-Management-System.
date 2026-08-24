# E-Commerce Logistics Management System

## Overview

This project is a relational database system designed to manage core e-commerce logistics data, including products, inventory, customers, orders, and distribution centers.

The database uses SQL relationships, constraints, and structured datasets to organize and connect different parts of an e-commerce workflow.

## Features

- Product and category management
- Distribution center management
- Inventory tracking
- Customer and address management
- Order and order-item tracking
- Primary and foreign key relationships
- Data integrity constraints
- CSV-based data loading
- Entity Relationship Diagram

## Database Tables

The database contains the following tables:

- `category`
- `distribution_center`
- `product`
- `inventory`
- `users`
- `address`
- `orders`
- `order_items`

## ER Diagram

![ER Diagram](diagrams/er_diagram.png)

## Repository Structure

```text
.
├── data/
│   ├── address.csv
│   ├── category.csv
│   ├── distribution_centers.csv
│   ├── inventory_items.csv
│   ├── order_items.csv
│   ├── orders.csv
│   ├── products.csv
│   └── users.csv
│
├── diagrams/
│   └── er_diagram.png
│
├── schema/
│   ├── create_tables.sql
│   └── load_data.sql
│
├── .gitattributes
└── README.md
