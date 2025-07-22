//MongoDB Assignment 01 - Bookstore Management

use bookstoreDB

//Part 1 & 2: Create Collection & Insert Sample Data.

//books
db.books.insertMany( [

{book_id: 101, title: "The AI Revolution", author: "Ray Kurzweil", genre: "Technology", price: 799, stock: 20},
{book_id: 102, title: "The Great Gatsby", author: "F. Scott Fitzgerald", genre: "Classic", price: 350, stock: 15},
{book_id: 103, title: "The Silent Patient", author: "Alex Michaelides", genre: "Thriller", price: 499, stock: 12},
{book_id: 104, title: "Atomic Habits", author: "James Clear", genre: "Self-Help", price: 599, stock: 25},
{book_id: 105, title: "Sapiens", author: "Yuval Noah Harari", genre: "History", price: 699, stock: 18}

] )

//customers
db.customers.insertMany( [

{ customer_id: 201, name: "Rahul Sharma", email: "rahul@gmail.com", city: "Hyderabad" },
{ customer_id: 202, name: "Priya Patel", email: "priya@gmail.com", city: "Mumbai" },
{ customer_id: 203, name: "Amit Singh", email: "amit@gmail.com", city: "Delhi" },
{ customer_id: 204, name: "Neha Gupta", email: "neha@gmail.com", city: "Bangalore" },
{ customer_id: 205, name: "Sandeep Reddy", email: "sandeep@gmail.com", city: "Hyderabad" }

] )

//orders
db.orders.insertMany( [
  
{ order_id: 301, customer_id: 201, book_id: 101, order_date: new Date("2023-01-15"), quantity: 2 },
{ order_id: 302, customer_id: 202, book_id: 102, order_date: new Date("2022-12-10"), quantity: 1 },
{ order_id: 303, customer_id: 203, book_id: 103, order_date: new Date("2023-02-20"), quantity: 3 },
{ order_id: 304, customer_id: 204, book_id: 104, order_date: new Date("2023-03-05"), quantity: 1 },
{ order_id: 305, customer_id: 205, book_id: 105, order_date: new Date("2023-01-25"), quantity: 2 },
{ order_id: 306, customer_id: 201, book_id: 102, order_date: new Date("2023-04-10"), quantity: 1 },
{ order_id: 307, customer_id: 203, book_id: 105, order_date: new Date("2023-05-15"), quantity: 1 }

] )



// PART 3: Write Queries

//Basic Queries:
//1. List all books priced above 500.

db.books.find({price: {$gt: 500}}); 

//2. Show all customers from ‘Hyderabad’.

db.customers.find({city: 'Hyderabad'});

//3. Find all orders placed after January 1, 2023.

db.orders.find({ order_date: { $gt: new Date("2023-01-01") } })


//4. Display order details with customer name and book title
db.orders.aggregate( [

 {
   $lookup: {
	from: "customers",
	localField: "customer_id",
	foreignField: "customer_id",
	as: "customer"

            }

 },
 
 {
   $lookup: {
	from: "books",
	localField: "book_id",
	foreignField: "book_id",
	as: "book"

            }

 },

 {
   $project: {
 
	_id: 0,
	order_id: 1,
	customer_name: { $arrayElemAt: [ "$customer.name", 0] },
	book_title: { $arrayElemAt: [ "$book.title", 0 ] },
	order_date: 1,
	quantity: 1
	     } 
 }

])


//5. Show total quanitity ordered for each book

db.orders.aggregate([

  {
    $group: {

	_id: "$book_id",
	total_quantity: { $sum: "$quantity" }

	}

  },
  {
   $lookup: {
	from: "books",
	localField: "_id",
	foreignField: "book_id",
	as: "book"
	}
  },

 {
  $project: {
	_id: 0,
	book_id: "$_id",
	book_title: { $arrayElemAt: ["$book.title", 0 ]},
	total_quantity: 1
	}
 }

])


//6.Show the total number of orders placed by each customer

db.orders.aggregate([
{
$group:{
_id: "$customer_id",
total_order: { $sum: 1}

}
},

{

$lookup:{
from: "customers",
localField: "_id",
foreignField: "customer_id",
as: "customer"

}
},

{
$project:{
_id: 0,
customer_id: "$_id",
customer_name: { $arrayElemAt: ["$customer.name", 0]},
total_order: 1
}
}

])


//7.Calvulate total revenue generated per book

db.orders.aggregate([
	{
	  $lookup: {
		from: "books",
		localField: "book_id",
		foreignField: "book_id",
		as: "book_info"

		}	

	},
	
	{
	  $unwind: "$book_info"
	},

	{
	  $group: {
		_id: "$book_id",
		book_title: { $first: "$book_info.title"},
		total_revenue: { $sum: { $multiply: ["$quantity" , "$book_info.price" ] } }
		}
	}


])


//8.Find the book with the highest total revenue
db.orders.aggregate([

	{
	  $lookup: {
		from: "books",
		localField: "book_id",
		foreignField: "book_id",
		as: "book_info"

		}	

	},
	
	{
	  $unwind: "$book_info"
	},

	{
	  $group: {
		_id: "$book_id",
		book_title: { $first: "$book_info.title"},
		total_revenue: { $sum: { $multiply: ["$quantity" , "$book_info.price" ] } }
		}
	},

	{
	  $sort: { total_revenue: -1 }
	},

	{
	  $limit: 1
	}

])


//9.List genres and total books sold in each genre

db.orders.aggregate([

	{
	  $lookup: {
		from: "books",
		localField: "book_id",
		foreignField: "book_id",
		as: "book_info"

		}	

	},
	
	{
	  $unwind: "$book_info"
	},

	{
	  $group: {
		_id: "$book_info.genre",
		Total_Quantity: { $sum: "$quantity"  }
		}
	},
	
	{
	$project: {
		_id: 0,
		Genre: "$_id",
		Total_Quantity: 1

	}
	}

])


//10.Show customers who ordered more than 2 different books
//Add one two more orders, to get desired output

db.orders.insertMany([
{ order_id: 308, customer_id: 201, book_id: 103, order_date: new Date("2023-06-10"), quantity: 1 },
{ order_id: 309, customer_id: 203,  book_id: 101, order_date: new Date("2023-06-15"), quantity: 1}
])


// Ans query

db.orders.aggregate([
  {
    $group: {
      _id: "$customer_id",
      unique_books: { $addToSet: "$book_id" }
    }
  },
  {
    $project: {
      customer_id: "$_id",
      book_count: { $size: "$unique_books" }
    }
  },
  {
    $match: {
      book_count: { $gt: 2 }
    }
  }
])
























 ] )