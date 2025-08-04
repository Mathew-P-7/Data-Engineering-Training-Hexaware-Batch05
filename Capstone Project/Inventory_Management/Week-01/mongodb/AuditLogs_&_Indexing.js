use inventoryManagementDB
switched to db inventoryManagementDB
db.stock_movements.insertMany([
  {
    movement_id: 101,
    product_id: 1,
    warehouse_id: 1,
    supplier: "ABC Suppliers",
    quantity: 20,
    movement_type: "IN",
    movement_date: ISODate("2025-08-01T09:00:00Z"),
    reason: "Initial stock from supplier"
  },
  {
    movement_id: 102,
    product_id: 2,
    warehouse_id: 1,
    supplier: "Global Traders",
    quantity: -5,
    movement_type: "OUT",
    movement_date: ISODate("2025-08-01T11:30:00Z"),
    reason: "Damaged goods removed"
  },
  {
    movement_id: 103,
    product_id: 3,
    warehouse_id: 2,
    supplier: "SupplyCo Ltd",
    quantity: 15,
    movement_type: "IN",
    movement_date: ISODate("2025-08-02T10:00:00Z"),
    reason: "Restocked after low inventory alert"
  },
  {
    movement_id: 104,
    product_id: 4,
    warehouse_id: 3,
    supplier: "XYZ Traders",
    quantity: -3,
    movement_type: "OUT",
    movement_date: ISODate("2025-08-03T14:45:00Z"),
    reason: "Stock moved to another warehouse"
  },
  {
    movement_id: 105,
    product_id: 5,
    warehouse_id: 2,
    supplier: "WarehouseOps",
    quantity: 10,
    movement_type: "IN",
    movement_date: ISODate("2025-08-03T16:15:00Z"),
    reason: "Returned items added back to stock"
  },
  {
    movement_id: 106,
    product_id: 6,
    warehouse_id: 4,
    supplier: "TechLine Distributors",
    quantity: -7,
    movement_type: "OUT",
    movement_date: ISODate("2025-08-04T09:00:00Z"),
    reason: "Shipped for urgent order"
  },
  {
    movement_id: 107,
    product_id: 1,
    warehouse_id: 1,
    supplier: "ABC Suppliers",
    quantity: 5,
    movement_type: "IN",
    movement_date: ISODate("2025-08-04T10:30:00Z"),
    reason: "Top-up due to fast-moving item"
  }
]);
{
  acknowledged: true,
  insertedIds: {
    '0': ObjectId('6890b6b44e6add5904dbf432'),
    '1': ObjectId('6890b6b44e6add5904dbf433'),
    '2': ObjectId('6890b6b44e6add5904dbf434'),
    '3': ObjectId('6890b6b44e6add5904dbf435'),
    '4': ObjectId('6890b6b44e6add5904dbf436'),
    '5': ObjectId('6890b6b44e6add5904dbf437'),
    '6': ObjectId('6890b6b44e6add5904dbf438')
  }
}
db.stock_movements.createIndex({ product_id: 1 });
product_id_1
db.stock_movements.createIndex({ warehouse_id: 1 });
warehouse_id_1
db.stock_movements.createIndex({ movement_date: -1 });
movement_date_-1