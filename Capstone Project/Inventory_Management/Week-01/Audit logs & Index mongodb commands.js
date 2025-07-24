
test> use inventory_mangement_db
switched to db inventory_mangement_db

inventory_mangement_db>  db.stock_movements.insertMany([
...   {
...     "movement_id": 1,
...     "product_id": 1,
...     "warehouse_id": 1,
...     "supplier": "ABC Suppliers",
...     "quantity": 10,
...     "movement_type": "IN",
...     "movement_date": "2025-06-02T00:00:00Z",
...     "reason": "Initial stock from supplier"
...   },
...   {
...     "movement_id": 2,
...     "product_id": 2,
...     "warehouse_id": 2,
...     "supplier": "Global Traders",
...     "quantity": 30,
...     "movement_type": "IN",
...     "movement_date": "2025-06-02T00:00:00Z",
...     "reason": "Bulk order supply"
...   },
...   {
...     "movement_id": 3,
...     "product_id": 3,
...     "warehouse_id": 1,
...     "supplier": "SupplyCo Ltd",
...     "quantity": 20,
...     "movement_type": "IN",
...     "movement_date": "2025-06-02T00:00:00Z",
...     "reason": "Restock"
...   },
...   {
...     "movement_id": 4,
...     "product_id": 4,
...     "warehouse_id": 3,
...     "supplier": "SupplyCo Ltd",
...     "quantity": 15,
...     "movement_type": "IN",
...     "movement_date": "2025-06-02T00:00:00Z",
...     "reason": "Monthly purchase"
...   },
...   {
...     "movement_id": 5,
...     "product_id": 5,
...     "warehouse_id": 4,
...     "supplier": "SupplyCo Ltd",
...     "quantity": 8,
...     "movement_type": "OUT",
...     "movement_date": "2025-06-02T00:00:00Z",
...     "reason": "New shipment"
...   },
...   {
...     "movement_id": 6,
...     "product_id": 6,
...     "warehouse_id": 1,
...     "supplier": "TechLine Distributors",
...     "quantity": 25,
...     "movement_type": "IN",
...     "movement_date": "2025-06-02T00:00:00Z",
...     "reason": "Utility restock"
...   }
... ]
...
... )
{
  acknowledged: true,
  insertedIds: {
    '0': ObjectId('683d5392d2229ecb9a6c4bd6'),
    '1': ObjectId('683d5392d2229ecb9a6c4bd7'),
    '2': ObjectId('683d5392d2229ecb9a6c4bd8'),
    '3': ObjectId('683d5392d2229ecb9a6c4bd9'),
    '4': ObjectId('683d5392d2229ecb9a6c4bda'),
    '5': ObjectId('683d5392d2229ecb9a6c4bdb')
  }
}
//Create Indexing for quick search by product ID or warehouse
inventory_mangement_db> db.stock_movements.createIndex({ product_id: 1, warehouse_id: 1 });
product_id_1_warehouse_id_1
inventory_mangement_db> db.stock_movements.createIndex({ movement_date: -1 });
movement_date_-1