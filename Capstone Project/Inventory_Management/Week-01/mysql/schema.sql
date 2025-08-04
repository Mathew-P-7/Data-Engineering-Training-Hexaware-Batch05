CREATE DATABASE inventory;
USE inventory;

-- products
CREATE TABLE products(
product_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100),
category VARCHAR(50),
unit_price DECIMAL(10,2),
recorder_level INT,
target_stock_level INT
) AUTO_INCREMENT = 101;

-- warehouse
CREATE TABLE warehouses (
warehouse_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) ,
location VARCHAR(100),
capacity INT
) AUTO_INCREMENT = 201;

-- suppliers
CREATE TABLE suppliers (
supplier_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) ,
contact_person VARCHAR(100),
email VARCHAR(100),
phone VARCHAR(20)
) AUTO_INCREMENT = 301;

-- stock movements
CREATE TABLE stock_movements (
movement_id INT AUTO_INCREMENT PRIMARY KEY,
product_id INT ,
warehouse_id INT ,
quantity INT ,
movement_type ENUM('IN', 'OUT') ,
movement_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
reference_number VARCHAR(50),
reason VARCHAR(255),
FOREIGN KEY (product_id) REFERENCES products(product_id),
FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id)
) AUTO_INCREMENT = 401;

