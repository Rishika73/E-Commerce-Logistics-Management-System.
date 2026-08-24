-- 1. Top selling products
SELECT
    p.product_name,
    COUNT(oi.order_items_id) AS total_sales
FROM order_items oi
JOIN inventory i
    ON oi.inventory_id = i.inventory_id
JOIN product p
    ON i.product_id = p.product_id
WHERE oi.status = 'Complete'
GROUP BY p.product_name
ORDER BY total_sales DESC
LIMIT 10;


-- 2. Revenue by product
SELECT
    p.product_name,
    SUM(oi.sale_price) AS total_revenue
FROM order_items oi
JOIN inventory i
    ON oi.inventory_id = i.inventory_id
JOIN product p
    ON i.product_id = p.product_id
WHERE oi.status = 'Complete'
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 10;


-- 3. Orders by status
SELECT
    status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY status
ORDER BY total_orders DESC;


-- 4. Monthly order trend
SELECT
    DATE_TRUNC('month', created_at) AS month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY DATE_TRUNC('month', created_at)
ORDER BY month;


-- 5. Return rate
SELECT
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE returned_at IS NOT NULL)
        / COUNT(*),
        2
    ) AS return_rate_percentage
FROM order_items;


-- 6. Inventory sold vs available
SELECT
    COUNT(*) FILTER (WHERE sold_at IS NOT NULL) AS sold_inventory,
    COUNT(*) FILTER (WHERE sold_at IS NULL) AS available_inventory
FROM inventory;


-- 7. Top categories by sales
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


-- 8. Average order size
SELECT
    ROUND(AVG(total_items), 2) AS average_items_per_order
FROM orders;