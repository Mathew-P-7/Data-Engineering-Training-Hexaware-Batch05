-- CRUD Operations
-- Adding a new column to  the products table
ALTER TABLE products 
ADD COLUMN quantity_in_stock INT DEFAULT 0;

-- Inserting new product
INSERT INTO products (name, category, unit_price, recorder_level, target_stock_level, quantity_in_stock)
VALUES ('Wireless Earbuds', 'Audio', 79.99, 15, 50, 0);

-- Inserting stock movement
INSERT INTO stock_movements (product_id, warehouse_id, quantity, movement_type, reason)
VALUES (101, 201, 10, 'IN', 'Initial stock');

-- Update product details
UPDATE products 
SET unit_price = 84.99, recorder_level = 8 
WHERE product_id = 101;

-- Correcting a stock movement
UPDATE stock_movements 
SET quantity = 12 
WHERE movement_id = 1;

-- Deleting a stock movement
DELETE FROM stock_movements 
WHERE movement_id = 5;