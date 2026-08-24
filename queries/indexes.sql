-- Indexes for frequently used foreign keys and filtering columns

CREATE INDEX IF NOT EXISTS idx_product_category
ON product(category_id);

CREATE INDEX IF NOT EXISTS idx_product_distribution_center
ON product(distribution_center_id);

CREATE INDEX IF NOT EXISTS idx_inventory_product
ON inventory(product_id);

CREATE INDEX IF NOT EXISTS idx_orders_user
ON orders(user_id);

CREATE INDEX IF NOT EXISTS idx_orders_created_at
ON orders(created_at);

CREATE INDEX IF NOT EXISTS idx_order_items_order
ON order_items(order_id);

CREATE INDEX IF NOT EXISTS idx_order_items_inventory
ON order_items(inventory_id);

CREATE INDEX IF NOT EXISTS idx_order_items_status
ON order_items(status);
