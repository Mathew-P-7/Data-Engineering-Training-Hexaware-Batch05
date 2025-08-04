-- Synthetic Data
-- Products
INSERT INTO products (name, category, unit_price, recorder_level, target_stock_level) VALUES
('Laptop Pro X1', 'Electronics', 899.99, 5, 20),
('Wireless Mouse', 'Accessories', 19.99, 15, 50),
('Mechanical Keyboard', 'Accessories', 79.99, 10, 30),
('27" Monitor', 'Electronics', 249.99, 8, 25),
('Noise-Canceling Headphones', 'Audio', 199.99, 6, 18),
('USB-C Cable', 'Accessories', 12.99, 25, 100),
('External SSD 1TB', 'Storage', 129.99, 7, 22),
('Webcam HD', 'Electronics', 59.99, 12, 35),
('Laptop Stand', 'Accessories', 29.99, 20, 60),
('Bluetooth Speaker', 'Audio', 89.99, 8, 25);

-- warehouses
INSERT INTO warehouses (name, location, capacity) VALUES
('North Distribution Center', 'Chicago, IL', 10000),
('West Coast Hub', 'Los Angeles, CA', 15000),
('East Regional', 'New York, NY', 8000),
('South Central', 'Dallas, TX', 12000),
('Midwest Storage', 'Kansas City, MO', 9000),
('Pacific Northwest', 'Seattle, WA', 7000),
('Northeast Storage', 'Boston, MA', 6000),
('Southeast Hub', 'Atlanta, GA', 11000),
('Rocky Mountain', 'Denver, CO', 5000),
('Southwest Regional', 'Phoenix, AZ', 7500);

-- suppliers
INSERT INTO suppliers (name, contact_person, email, phone) VALUES
('TechGadgets Inc.', 'John Smith', 'john@techgadgets.com', '800-555-1001'),
('ElectroWorld Ltd.', 'Sarah Johnson', 'sarah@electroworld.com', '800-555-1002'),
('Global Components', 'Mike Chen', 'mike@globalcomp.net', '800-555-1003'),
('Digital Warehouse', 'Emily Wilson', 'emily@digitalwh.com', '800-555-1004'),
('Peripheral Pros', 'David Kim', 'david@peripheralpros.com', '800-555-1005'),
('Audio Solutions', 'Jessica Brown', 'jessica@audiosol.com', '800-555-1006'),
('Cable Masters', 'Robert Taylor', 'robert@cablemasters.com', '800-555-1007'),
('Monitor Experts', 'Lisa Wong', 'lisa@monitorexperts.com', '800-555-1008'),
('Storage Systems', 'James Miller', 'james@storagesys.com', '800-555-1009'),
('Accessory World', 'Patricia Clark', 'patricia@accessoryworld.com', '800-555-1010');

-- stock movemnts
-- for stock, i excplicitly made missing values for uncleaned data collection for ETL process.
INSERT INTO stock_movements (product_id, warehouse_id, quantity, movement_type, movement_date, reference_number, reason) VALUES
(101, 201, 15, 'IN', '2025-01-05 09:15:00', 'PO-1001', 'Initial stock'),
(102, 202, 50, 'IN', '2025-01-05 10:30:00', 'PO-1002', 'Bulk order'),
(103, 203, 30, 'IN', '2025-01-06 11:45:00', 'PO-1003', 'Quarterly restock'),
(104, 204, 25, 'IN', '2025-01-06 14:20:00', 'PO-1004', 'New product line'),
(105, 205, 18, 'IN', '2025-01-07 08:10:00', 'PO-1005', 'Pre-holiday stock'),
(106, 206, 100, 'IN', NULL, 'PO-1006', NULL), -- Missing date and reason
(107, 207, NULL, 'IN', '2025-01-08 16:45:00', 'PO-1007', 'Quantity not recorded'), 
(108, NULL, 35, 'IN', '2025-01-09 10:30:00', NULL, 'Warehouse not specified'), 
(NULL, 209, 60, 'IN', '2025-01-10 13:15:00', 'PO-1009', 'Product ID missing'), 
(109, 210, 25, NULL, '2025-01-11 09:00:00', 'PO-1010', 'Movement type missing'), 
(101, 201, 5, 'OUT', '2025-01-12 11:20:00', 'SO-2001', 'Customer order #1001'),
(102, 202, 10, 'OUT', '2025-01-13 14:35:00', 'SO-2002', 'Store transfer'),
(103, 203, 8, 'OUT', '2025-01-14 10:10:00', NULL, 'Damaged goods return'), 
(104, 204, 3, 'OUT', '2025-01-15 15:45:00', 'SO-2004', NULL), 
(105, 205, 2, 'OUT', NULL, 'SO-2005', 'Date not recorded'); 

