-- Check for duplicate users
SELECT user_id, COUNT(*)
FROM users
GROUP BY user_id
HAVING COUNT(*) > 1;

-- Check for duplicate products
SELECT product_id, COUNT(*)
FROM product
GROUP BY product_id
HAVING COUNT(*) > 1;

-- Check for invalid product prices
SELECT *
FROM product
WHERE retail_price < 0
   OR cost < 0;

-- Check for missing category references
SELECT p.*
FROM product p
LEFT JOIN category c
    ON p.category_id = c.category_id
WHERE p.category_id IS NOT NULL
  AND c.category_id IS NULL;

-- Check for inventory records without products
SELECT i.*
FROM inventory i
LEFT JOIN product p
    ON i.product_id = p.product_id
WHERE p.product_id IS NULL;

-- Check for orders without users
SELECT o.*
FROM orders o
LEFT JOIN users u
    ON o.user_id = u.user_id
WHERE u.user_id IS NULL;

-- Check for order items without orders
SELECT oi.*
FROM order_items oi
LEFT JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Check for order items without inventory records
SELECT oi.*
FROM order_items oi
LEFT JOIN inventory i
    ON oi.inventory_id = i.inventory_id
WHERE i.inventory_id IS NULL;

-- Check for invalid shipping timelines
SELECT *
FROM orders
WHERE shipped_at IS NOT NULL
  AND shipped_at < created_at;

-- Check for invalid delivery timelines
SELECT *
FROM orders
WHERE delivered_at IS NOT NULL
  AND shipped_at IS NOT NULL
  AND delivered_at < shipped_at;

-- Check for invalid return timelines
SELECT *
FROM orders
WHERE returned_at IS NOT NULL
  AND delivered_at IS NOT NULL
  AND returned_at < delivered_at;

-- Check for invalid sale prices
SELECT *
FROM order_items
WHERE sale_price < 0;