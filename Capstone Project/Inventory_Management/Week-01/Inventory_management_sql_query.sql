create database inventory_management_db
use inventory_management_db
CREATE TABLE products (
    product_id INT PRIMARY KEY Identity(1,1),
    name VARCHAR(100),
    category VARCHAR(50),
    quantity_in_stock INT DEFAULT 0,
	reorder_level INT,
    price DECIMAL(10, 2)
);

CREATE TABLE warehouses (
    warehouse_id INT PRIMARY KEY Identity(1,1),
    location VARCHAR(100),
    capacity INT,
    manager_name VARCHAR(100)
);
CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY Identity(1,1),
    name VARCHAR(100),
    contact_email VARCHAR(100)
);

CREATE TABLE stock_movements (
    movement_id INT IDENTITY(1,1) PRIMARY KEY,
    product_id INT NOT NULL,
    warehouse_id INT NOT NULL,
    supplier_id INT NULL,
    quantity INT NOT NULL,
    movement_type VARCHAR(10) CHECK (movement_type IN ('IN', 'OUT')), 
    movement_date DATETIME DEFAULT GETDATE(),
    reason NVARCHAR(255),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

INSERT INTO products (name, category, quantity_in_stock, reorder_level, price) VALUES
('Notebook', 'Stationery', 100, 20, 45.50),
('Pen', 'Stationery', 300, 50, 10.00),
('Mouse', 'Electronics', 50, 15, 350.00),
('Keyboard', 'Electronics', 30, 10, 550.00),
('USB Drive', 'Electronics', 70, 25, 250.00),
('Office Chair', 'Furniture', 60, 10, 120.00),
('Table', 'Furniture', 20, 5, 750.00),
('File Folder', 'Stationery', 80, 20, 15.00),
('Charger', 'Electronics', 25, 10, 500.00),
('Sticky Notes', 'Stationery', 200, 50, 5.00);

-- Insert warehouses
INSERT INTO warehouses (location, capacity, manager_name) VALUES
('Chennai', 1000, 'Arun Kumar'),
('Bangalore', 800, 'Priya Sharma'),
('Hyderabad', 600, 'Rahul Nair'),
('Mumbai', 1200, 'Sneha Rao'),
('Delhi', 900, 'Karthik Iyer');

-- Insert suppliers
INSERT INTO suppliers (name, contact_email) VALUES
('OfficeSupplies Co.', 'contact@officesupplies.com'),
('TechGear Ltd.', 'support@techgear.com'),
('DailyUse Inc.', 'sales@dailyuse.com'),
('GadgetWorld', 'info@gadgetworld.com'),
('WriteWell Supplies', 'hello@writewell.com');

-- Insert stock movements
INSERT INTO stock_movements (product_id, warehouse_id, supplier_id, quantity, movement_type, reason) VALUES
(1, 1, 1, 50, 'IN', 'Initial stock from supplier'),
(2, 2, 5, 100, 'IN', 'Bulk order supply'),
(3, 1, 2, 20, 'IN', 'Restock'),
(4, 3, 2, 15, 'IN', 'Monthly purchase'),
(5, 4, 2, 30, 'IN', 'New shipment'),
(6, 1, 3, 25, 'IN', 'Utility restock'),
(7, 2, 2, 10, 'IN', 'New stock'),
(8, 5, 1, 50, 'IN', 'Promotional stock'),
(9, 3, 4, 10, 'IN', 'Reorder from supplier'),
(10, 1, 5, 100, 'IN', 'Quarterly supply'),
(1, 1, NULL, 20, 'OUT', 'Issued to office'),
(2, 2, NULL, 30, 'OUT', 'Used by staff'),
(3, 1, NULL, 5, 'OUT', 'Replacement needed'),
(6, 3, NULL, 10, 'OUT', 'Internal use'),
(7, 4, NULL, 3, 'OUT', 'Maintenance kit');

SELECT * FROM products;
SELECT * FROM warehouses;
SELECT * FROM suppliers;
SELECT * FROM stock_movements;

--Update 
-- Example: After inserting a stock movement
UPDATE products
SET quantity_in_stock = quantity_in_stock + 10
WHERE product_id = 1;
--Delete
Delete from stock_movements where product_id=10
--Stored Procedure
CREATE PROCEDURE GetProductsBelowReorderLevel
AS
BEGIN
    SET NOCOUNT ON;

    SELECT product_id,name,category,quantity_in_stock,reorder_level,price
    FROM products
    WHERE quantity_in_stock < reorder_level;
END;


CREATE TRIGGER update_stock_insert
ON stock_movements
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Update stock for 'IN' movements
    UPDATE p
    SET p.quantity_in_stock = p.quantity_in_stock + i.quantity
    FROM products p
    JOIN inserted i ON p.product_id = i.product_id
    WHERE i.movement_type = 'IN';

    -- Update stock for 'OUT' movements
    UPDATE p
    SET p.quantity_in_stock = p.quantity_in_stock - i.quantity
    FROM products p
    JOIN inserted i ON p.product_id = i.product_id
    WHERE i.movement_type = 'OUT';
END;
