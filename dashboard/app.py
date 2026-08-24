import os
import pandas as pd
import streamlit as st
from sqlalchemy import create_engine

st.set_page_config(
    page_title="E-Commerce Logistics Dashboard",
    layout="wide"
)

st.title("E-Commerce Logistics Dashboard")

DATABASE_URL = os.getenv("DATABASE_URL")

if not DATABASE_URL:
    st.warning("Set the DATABASE_URL environment variable to connect to PostgreSQL.")
    st.stop()

engine = create_engine(DATABASE_URL)

orders_query = """
SELECT
    COUNT(*) AS total_orders,
    COALESCE(SUM(total_items), 0) AS total_items
FROM orders;
"""

revenue_query = """
SELECT
    COALESCE(SUM(sale_price), 0) AS total_revenue
FROM order_items
WHERE status = 'Complete';
"""

status_query = """
SELECT
    status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY status
ORDER BY total_orders DESC;
"""

category_query = """
SELECT
    c.category_name,
    COUNT(oi.order_items_id) AS total_sales
FROM order_items oi
JOIN inventory i
    ON oi.inventory_id = i.inventory_id
JOIN product p
    ON i.product_id = p.product_id
JOIN category c
    ON p.category_id = c.category_id
WHERE oi.status = 'Complete'
GROUP BY c.category_name
ORDER BY total_sales DESC
LIMIT 10;
"""

monthly_orders_query = """
SELECT
    DATE_TRUNC('month', created_at) AS month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY DATE_TRUNC('month', created_at)
ORDER BY month;
"""

orders_summary = pd.read_sql(orders_query, engine)
revenue_summary = pd.read_sql(revenue_query, engine)

col1, col2, col3 = st.columns(3)

col1.metric("Total Orders", int(orders_summary["total_orders"].iloc[0]))
col2.metric("Total Items Ordered", int(orders_summary["total_items"].iloc[0]))
col3.metric(
    "Completed Order Revenue",
    f"${revenue_summary['total_revenue'].iloc[0]:,.2f}"
)

st.subheader("Orders by Status")
status_df = pd.read_sql(status_query, engine)
st.bar_chart(status_df.set_index("status"))

st.subheader("Top Categories by Sales")
category_df = pd.read_sql(category_query, engine)
st.bar_chart(category_df.set_index("category_name"))

st.subheader("Monthly Order Trend")
monthly_df = pd.read_sql(monthly_orders_query, engine)
monthly_df["month"] = pd.to_datetime(monthly_df["month"])
st.line_chart(monthly_df.set_index("month"))