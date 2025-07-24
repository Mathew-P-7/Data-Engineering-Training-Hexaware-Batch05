// MongoDB Assessment 01 - E-Commerce Store Analytics

use ecomm

// Step 1: Create Collections and Insert Sample Data

//1.products
db.products.insertMany([
{ product_id: 1001, name: "Wireless Mouse", category: "Electronics", price: 750, stock: 120 },
{ product_id: 1002, name: "Bluetooth Speaker", category: "Electronics", price: 2200, stock: 80 },
{ product_id: 1003, name: "Yoga Mat", category: "Fitness", price: 599, stock: 150 },
{ product_id: 1004, name: "Office Chair", category: "Furniture", price: 7500, stock: 40 },
{ product_id: 1005, name: "Running Shoes", category: "Footwear", price: 3500, stock: 60 }
])

//2.orders
db.orders.insertMany([
{ order_id: 5001, customer: "Ravi Shah", product_id: 1001, quantity: 2, order_date: new Date("2024-07-01") },
{ order_id: 5002, customer: "Sneha Mehta", product_id: 1002, quantity: 1, order_date: new Date("2024-07-02") },
{ order_id: 5003, customer: "Arjun Verma", product_id: 1003, quantity: 3, order_date: new Date("2024-07-03") },
{ order_id: 5004, customer: "Neha Iyer", product_id: 1001, quantity: 1, order_date: new Date("2024-07-04") },
{ order_id: 5005, customer: "Mohit Jain", product_id: 1005, quantity: 2, order_date: new Date("2024-07-05") }
])

//Step 2: Query Challenges

//Basic Queries
//1. List all products in the Electronics category.
db.products.find( {category: "Electronics"} )

//2. Find all orders placed by Ravi Shah.
db.orders.find( { customer: "Ravi Shah"} )

//3. Show all orders placed after July 2, 2024.
db.orders.find( {order_date : { $gt: new Date( "2024-07-02" ) } } )

//4. Display the product with stock less than 50.
db.products.find( { stock: { $lt: 50 } } )

//5. Show all products that cost more than 2000.
db.products.find( { price: { $gt: 2000 } })


//Join-Like Queries with $lookup
//6. Use $lookup to show each order with the product name and price.
db.orders.aggregate([
{
$lookup: {
	from: "products",
	localField: "product_id",
	foreignField: "product_id",
	as: "product_info"

}
},


{
$unwind: "$product_info"
},

{
$project: {
	_id: 0,
	order_id: 1,
	customer: 1,
	Product_Name: "$product_info.name",
	Product_Price: "$product_info.price",
	quantity: 1,
	order_date: 1

}
}

])

//7. Find total amount spent by each customer (price × quantity).
db.orders.aggregate([

{
$lookup: {
	from: "products",
	localField: "product_id",
	foreignField: "product_id",
	as: "product_info"
}
},

{
$unwind: "$product_info"
},

{
$project: {
	_id: 0,
	customer: 1,
	quantity: 1,
	product_price: "$product_info.price"
}
},

{
$group: {

	_id: "$customer",
	totalAmount: { $sum: {$multiply: [ "$product_price" , "$quantity"] } }
}
},

])

//8. List all orders along with category of the product.
db.orders.aggregate.([
{
$lookup: {
	from: "products",
	localField: "product_id",
	foreignField: "product_id",
	as: "product_info"
}
},

{
$unwind: "$product_info"
},

{
$project: {
	_id: 0,
	order_id: 1,
	customer: 1,
	quantity: 1,
	order_date: 1,
	product_category: "$product_info.category"

}
},

])


//9. Find customers who ordered any Fitness product.
db.orders.aggregate([
{
$lookup: {
	from: "products",
	localField: "product_id",
	foreignField: "product_id",
	as: "product_info"
}
},

{
$unwind: "$product_info"
},

{
$project: {
	_id: 0,
	customer: 1,
	productCategory: "$product_info.category",
	productName: "$product_info.name"

}
},

{
$match: {
	"productCategory": "Fitness"
}
}

])

//10. Find the total sales per product category.
db.orders.aggregate([

{
$lookup: {
	from: "products",
	localField: "product_id",
	foreignField: "product_id",
	as: "product_info"
}
},

{
$unwind: "$product_info"
},

{
$project: {
	_id: 0,
	quantity: 1,
	category: "$product_info.category",
	price: "$product_info.price"
}
},

{
$group: {

	_id: "$category",
	totalSales: { $sum: {$multiply: [ "$price" , "$quantity"] } }
}
}

])


//Aggregations & Grouping
//11. Count how many units of each product have been sold.
db.orders.aggregate([
{
$group: {
	_id: "$product_id",
	total_units_sold: { $sum: "$quantity" }

}
},
])

//12. Calculate average price of products per category.
db.products.aggregate([
{
$group: {
	_id: "$category",
	avg: { $avg: "$price" }
}
},

{
$project: {
	_id: 0,
	Category: "$_id",
	Average_Price: "$avg"

}
}, 
])

//13. Find out which customer made the largest single order (by amount).
db.orders.aggregate([
{
$lookup: {
      from: "products",
      localField: "product_id",
      foreignField: "product_id",
      as: "product_details"	
}
},

{
$unwind: "$product_details"
},

{
$project: {
	_id: 0 ,
	customer: 1,
	Order_Amount: { $multiply: ["$quantity", "$product_details.price"] }
}
},

{
$sort: { Order_Amount: -1 }
},
{
$limit: 1
}

])


//14. List the top 3 products based on number of orders.
db.orders.aggreaget([
{
$group: {
	_id: "$product_id",
	orderCount: { $sum: 1}
}
},

{
$sort: { orderCount: -1}
},

{
$limit: 3
}

])

//15. Determine which day had the highest number of orders.
db.orders.aggregate([
{
$group: {
	_id: "$order_date",
	orderCount: { %sum: 1}
}
},

$sort: { orderCount: -1}
},

{
$limit: 1
}

])


//Advanced Use Cases

//16. Add a new customer who hasn't placed any orders. Write a query to list customers without orders (simulate this).
//Adding new customer
db.customers.insertOne({ name: "Mathew Peter" })

//customer without orders
db.customers.aggregate([
{
$lookup: {
      from: "orders",
      localField: "name",
      foreignField: "customer",
      as: "orders"
}
},

{
$match: {
	orders: { $size: 0}
}
},

])


//17. Add more orders and find customers who have placed more than one order.
// Adding mor orders
db.orders.insertMany([
  { order_id: 5006, customer: "Ravi Shah", product_id: 1004, quantity: 1, order_date: new Date("2024-07-06") },
  { order_id: 5007, customer: "Sneha Mehta", product_id: 1003, quantity: 2, order_date: new Date("2024-07-07") }
])

//Customers place more than one order.
db.orders.aggreagate([
{
$group: {
	_id: "$customer",
	order_count: {sum: 1}
}
},

{
$match: {
	order_count: { $gt: 1}
}
}

])

//18. Find all products that have never been ordered.
db.products.aggregate([
{
$lookup: {
      from: "orders",
      localField: "name",
      foreignField: "customer",
      as: "orders"
}
},

{
$match: {
	orders: { $size: 0}
}
},

])

//19. Display customers who placed orders for products with stock less than 100.
db.orders.aggregate([
{
$lookup: {
      from: "products",
      localField: "product_id",
      foreignField: "product_id",
      as: "product_details"
}
},
 
{
$unwind: "$product_details"
},

{
$match: {
      "product_details.stock": { $lt: 100 }
}
},

{
$group: {
      _id: "$customer"
}
}

])

//20. Show the total inventory value (price × stock) for all products.
db.products.aggregate([
{
$group: {
      _id: null,  
      total_inventory_value: {$sum: { $multiply: ["$price", "$stock"] }}
}
}

])
