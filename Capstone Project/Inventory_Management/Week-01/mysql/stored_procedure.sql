DELIMITER $$

CREATE TRIGGER update_stock_movement
AFTER INSERT ON stock_movements
FOR EACH ROW
BEGIN
    -- Update stock for 'IN' movements
    IF NEW.movement_type = 'IN' THEN
        UPDATE products
        SET quantity_in_stock = quantity_in_stock + NEW.quantity
        WHERE product_id = NEW.product_id;
    END IF;

    -- Update stock for 'OUT' movements
    IF NEW.movement_type = 'OUT' THEN
        UPDATE products
        SET quantity_in_stock = quantity_in_stock - NEW.quantity
        WHERE product_id = NEW.product_id;
    END IF;
END$$

DELIMITER ;