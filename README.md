# E-Commerce Logistics Management System

## Overview

This project is a relational database system designed to manage core e-commerce logistics data, including products, inventory, customers, orders, and distribution centers.

The database uses SQL relationships, constraints, structured datasets, reusable views, analytics queries, performance indexes, data-quality checks, and database automation to organize and manage different parts of an e-commerce workflow.

A Streamlit dashboard is also included to provide a simple analytics layer on top of the PostgreSQL database.

## Features

- Product and category management
- Distribution center management
- Inventory tracking
- Customer and address management
- Order and order-item tracking
- Primary and foreign key relationships
- Data integrity constraints
- CSV-based data loading
- Business-focused SQL analytics
- Reusable database views
- Query performance optimization with indexes
- Data-quality validation queries
- PostgreSQL trigger-based order timeline validation
- Streamlit analytics dashboard
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

![ER Diagram](diagrams/ER%20diagram.png)

## SQL Analytics

The project includes business-focused SQL queries for analyzing:

- Top-selling products
- Revenue by product
- Order status distribution
- Monthly order trends
- Return rates
- Inventory availability
- Top-performing categories
- Average order size

The queries are available in:

`queries/business_queries.sql`

## Database Views

Reusable PostgreSQL views were created for:

- Order summaries
- Product sales performance
- Inventory status

See:

`queries/views.sql`

## Performance Optimization

Indexes were added to frequently joined and filtered columns, including:

- Product category
- Distribution center
- Inventory product
- Order user
- Order creation date
- Order references
- Inventory references
- Order-item status

See:

`queries/indexes.sql`

## Data Quality Checks

SQL validation queries are included to identify:

- Duplicate users and products
- Invalid product prices
- Missing foreign-key relationships
- Orders without valid users
- Inventory without valid products
- Invalid shipping timelines
- Invalid delivery timelines
- Invalid return timelines
- Invalid order-item prices

See:

`queries/data_quality_checks.sql`

## Database Automation

A PostgreSQL trigger and PL/pgSQL function are included to validate order timelines.

The trigger prevents invalid records such as:

- Shipment dates earlier than order creation dates
- Delivery dates earlier than shipment dates
- Return dates earlier than delivery dates

See:

`queries/triggers_and_functions.sql`

## Analytics Dashboard

A Streamlit dashboard provides a simple analytics layer on top of the PostgreSQL database.

The dashboard displays:

- Total orders
- Total items ordered
- Completed-order revenue
- Orders by status
- Top categories by sales
- Monthly order trends

Dashboard files are available in:

`dashboard/`

## Repository Structure

```text
.
├── dashboard/
│   ├── app.py
│   └── requirements.txt
│
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
│   └── ER diagram.png
│
├── queries/
│   ├── business_queries.sql
│   ├── data_quality_checks.sql
│   ├── indexes.sql
│   ├── triggers_and_functions.sql
│   └── views.sql
│
├── schema/
│   ├── create_tables.sql
│   └── load_data.sql
│
├── .gitattributes
└── README.md
