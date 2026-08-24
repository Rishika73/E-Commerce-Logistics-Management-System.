-- View 1: Order summary
CREATE OR REPLACE VIEW order_summary AS
SELECT
    o.order_id,
    o.user_id,
    o.status AS order_status,
    o.created_at,
    o.total_items,
    COUNT(oi.order_items_id) AS line_items,
    COALESCE(SUM(oi.sale_price), 0) AS order_value
FROM orders o
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    o.order_id,
    o.user_id,
    o.status,
    o.created_at,
    o.total_items;


-- View 2: Product sales summary
CREATE OR REPLACE VIEW product_sales_summary AS
SELECT
    p.product_id,
    p.product_name,
    p.product_brand,
    c.category_name,
    COUNT(oi.order_items_id) AS units_sold,
    COALESCE(SUM(oi.sale_price), 0) AS total_revenue
FROM product p
LEFT JOIN category c
    ON p.category_id = c.category_id
LEFT JOIN inventory i
    ON p.product_id = i.product_id
LEFT JOIN order_items oi
    ON i.inventory_id = oi.inventory_id
    AND oi.status = 'Complete'
GROUP BY
    p.product_id,
    p.product_name,
    p.product_brand,
    c.category_name;


-- View 3: Inventory status
CREATE OR REPLACE VIEW inventory_status AS
SELECT
    p.product_id,
    p.product_name,
    COUNT(i.inventory_id) AS total_inventory,
    COUNT(i.inventory_id) FILTER (
        WHERE i.sold_at IS NOT NULL
    ) AS sold_items,
    COUNT(i.inventory_id) FILTER (
        WHERE i.sold_at IS NULL
    ) AS available_items
FROM product p
LEFT JOIN inventory i
    ON p.product_id = i.product_id
GROUP BY
    p.product_id,
    p.product_name;