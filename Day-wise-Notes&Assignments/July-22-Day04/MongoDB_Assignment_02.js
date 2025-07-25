//MongoDB Assignment 02 – Movie Streaming App

use assignment2DB

//PART 1: Create Collections
//users
db.users.insertMany([

  { user_id: 1, name: "raj", email: "raj@example.com", country: "india" },
  { user_id: 2, name: "emma", email: "emma@example.com", country: "usa" },
  { user_id: 3, name: "li", email: "li@example.com", country: "china" },
  { user_id: 4, name: "kumar", email: "kumar@example.com", country: "india" },
  { user_id: 5, name: "sofia", email: "sofia@example.com", country: "france" }

]);

//movies
db.movies.insertMany([

{ movie_id: 101, title: "dream beyond code", genre: "sci-fi", release_year: 2022, duration:120,},
{ movie_id: 102, title: "love in paris", genre: "romance", release_year: 2019, duration: 95 },
{ movie_id: 103, title: "battlefield", genre: "action", release_year: 2021, duration: 130 },
{ movie_id: 104, title: "silent whispers", genre: "drama", release_year: 2023, duration: 110 },
{ movie_id: 105, title: "future world", genre: "sci-fi", release_year: 2024, duration: 140 },
{ movie_id: 106, title: "ghost town", genre: "horror", release_year: 2020, duration: 90 }

]);

//watch_history
db.watch_history.insertMany([

  { watch_id: 301, user_id: 1, movie_id: 201, watched_on: ISODate("2023-01-10"), watch_time: 120 },
  { watch_id: 302, user_id: 1, movie_id: 202, watched_on: ISODate("2023-01-15"), watch_time: 90 },
  { watch_id: 303, user_id: 2, movie_id: 203, watched_on: ISODate("2023-02-01"), watch_time: 110 },
  { watch_id: 304, user_id: 2, movie_id: 204, watched_on: ISODate("2023-02-10"), watch_time: 130 },
  { watch_id: 305, user_id: 3, movie_id: 201, watched_on: ISODate("2023-03-05"), watch_time: 100 },
  { watch_id: 306, user_id: 3, movie_id: 201, watched_on: ISODate("2023-03-06"), watch_time: 110 },
  { watch_id: 307, user_id: 4, movie_id: 205, watched_on: ISODate("2023-04-01"), watch_time: 90 },
  { watch_id: 308, user_id: 5, movie_id: 206, watched_on: ISODate("2023-05-01"), watch_time: 140 }

]);

//PART 3: Query Tasks
//Basic

//1.Find all movies with duration > 100 minutes.
db.movies.find({ duration: { $gt: 100 } });

//2.List users from 'India'.
db.users.find({ country: "india" });

//3.Get all movies released after 2020.
db.movies.find({ release_year: { $gt: 2020 } });

//Intermediate
//4.Show full watch history: user name, movie title, watch time.
db.watch_history.aggregate([
  {
    $lookup: {
      from: "users",
      localField: "user_id",
      foreignField: "user_id",
      as: "user",
    },
  },
  { $unwind: "$user" },
  {
    $lookup: {
      from: "movies",
      localField: "movie_id",
      foreignField: "movie_id",
      as: "movie",
    },
  },
  { $unwind: "$movie" },
  {
    $project: {
      _id: 0,
      name: "$user.name",
      title: "$movie.title",
      watch_time: 1,
    },
  },
]);

//5.List each genre and number of times movies in that genre were watched.
db.watch_history.aggregate([
  {
    $lookup: {
      from: "movies",
      localField: "movie_id",
      foreignField: "movie_id",
      as: "movie",
    },
  },
  { $unwind: "$movie" },
  { $group: { _id: "$movie.genre", count: { $sum: 1 } } },
  { $project: { genre: "$_id", count: 1, _id: 0 } },
]);

//6.Display total watch time per user.
db.watch_history.aggregate([
  { $group: { _id: "$user_id", total_watch_time: { $sum: "$watch_time" } } },
  {
    $lookup: {
      from: "users",
      localField: "_id",
      foreignField: "user_id",
      as: "user",
    },
  },
  { $unwind: "$user" },
  { $project: { _id: 0, name: "$user.name", total_watch_time: 1 } },
]);

//Advanced
//7.Find which movie has been watched the most (by count).
db.watch_history.aggregate([
  { $group: { _id: "$movie_id", count: { $sum: 1 } } },
  { $sort: { count: -1 } },
  { $limit: 1 },
  {
    $lookup: {
      from: "movies",
      localField: "_id",
      foreignField: "movie_id",
      as: "movie",
    },
  },
  { $unwind: "$movie" },
  { $project: { _id: 0, title: "$movie.title", watch_count: "$count" } },
]);

//8.Identify users who have watched more than 2 movies.
db.watch_history.aggregate([
  { $group: { _id: "$user_id", unique_movies: { $addToSet: "$movie_id" } } },
  { $project: { user_id: "$_id", movie_count: { $size: "$unique_movies" } } },
  { $match: { movie_count: { $gt: 2 } } },
  {
    $lookup: {
      from: "users",
      localField: "user_id",
      foreignField: "user_id",
      as: "user",
    },
  },
  { $unwind: "$user" },
  { $project: { _id: 0, name: "$user.name", movie_count: 1 } },
]);

//9.Show users who watched the same movie more than once.
db.watch_history.aggregate([
  {
    $group: {
      _id: { user_id: "$user_id", movie_id: "$movie_id" },
      count: { $sum: 1 },
    },
  },
  { $match: { count: { $gt: 1 } } },
  {
    $lookup: {
      from: "users",
      localField: "_id.user_id",
      foreignField: "user_id",
      as: "user",
    },
  },
  { $unwind: "$user" },
  {
    $lookup: {
      from: "movies",
      localField: "_id.movie_id",
      foreignField: "movie_id",
      as: "movie",
    },
  },
  { $unwind: "$movie" },
  {
    $project: {
      _id: 0,
      user: "$user.name",
      movie: "$movie.title",
      watch_count: "$count",
    },
  },
]);

//10.Calculate percentage of each movie watched compared to its full duration( watch_time/duration * 100 ).
db.watch_history.aggregate([
  {
    $lookup: {
      from: "movies",
      localField: "movie_id",
      foreignField: "movie_id",
      as: "movie",
    },
  },
  { $unwind: "$movie" },
  {
    $project: {
      _id: 0,
      movie: "$movie.title",
      percentage: {
        $multiply: [{ $divide: ["$watch_time", "$movie.duration"] }, 100],
      },
    },
  },
]);
