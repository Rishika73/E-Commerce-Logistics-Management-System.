-- 1. Check for duplicate users
SELECT user_id, COUNT(*)
FROM users
GROUP BY user_id
HAVING COUNT(*) > 1;


-- 2. Check for duplicate products
SELECT product_id, COUNT(*)
FROM product
GROUP BY product_id
HAVING COUNT(*) > 1;


-- 3. Check for invalid product prices
SELECT *
FROM product
WHERE retail_price < 0
   OR cost < 0;


-- 4. Check for products with missing category references
SELECT p.*
FROM product p
LEFT JOIN category c
    ON p.category_id = c.category_id
WHERE p.category_id IS NOT NULL
  AND c.category_id IS NULL;


-- 5. Check for inventory records without matching products
SELECT i.*
FROM inventory i
LEFT JOIN product p
    ON i.product_id = p.product_id
WHERE p.product_id IS NULL;


-- 6. Check for orders without matching users
SELECT o.*
FROM orders o
LEFT JOIN users u
    ON o.user_id = u.user_id
WHERE u.user_id IS NULL;


-- 7. Check for order items without matching orders
SELECT oi.*
FROM order_items oi
LEFT JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;


-- 8. Check for order items without matching inventory records
SELECT oi.*
FROM order_items oi
LEFT JOIN inventory i
    ON oi.inventory_id = i.inventory_id
WHERE i.inventory_id IS NULL;


-- 9. Check for invalid shipping timelines
SELECT *
FROM orders
WHERE shipped_at IS NOT NULL
  AND shipped_at < created_at;


-- 10. Check for invalid delivery timelines
SELECT *
FROM orders
WHERE delivered_at IS NOT NULL
  AND shipped_at IS NOT NULL
  AND delivered_at < shipped_at;


-- 11. Check for invalid return timelines
SELECT *
FROM orders
WHERE returned_at IS NOT NULL
  AND delivered_at IS NOT NULL
  AND returned_at < delivered_at;


-- 12. Check for zero or negative order item prices
SELECT *
FROM order_items
WHERE sale_price < 0;
