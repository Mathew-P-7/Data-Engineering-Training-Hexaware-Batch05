use online_course_tracker;
switched to db online_course_tracker
db.feedback.drop();
true
db.feedback.insertMany([
  {
    feedback_id: 501,
    student_id: 101,
    course_id: 201,
    rating: 5,
    review: "Excellent course! Learned a lot.",
    submitted_on: new Date("2025-07-10")
  },
  {
    feedback_id: 502,
    student_id: 102,
    course_id: 202,
    rating: 4,
    review: "Very informative, but could use more examples.",
    submitted_on: new Date("2025-07-15")
  },
  {
    feedback_id: 503,
    student_id: 101,
    course_id: 202,
    rating: 3,
    review: "Content was average, but the instructor was good.",
    submitted_on: new Date("2025-07-20")
  },
  {
    feedback_id: 504,
    student_id: 103,
    course_id: 201,
    rating: 5,
    review: "Absolutely loved the structure and pacing!",
    submitted_on: new Date("2025-07-25")
  }
]);
{
  acknowledged: true,
  insertedIds: {
    '0': ObjectId('688a5df3dcf34a2acaf6df1b'),
    '1': ObjectId('688a5df3dcf34a2acaf6df1c'),
    '2': ObjectId('688a5df3dcf34a2acaf6df1d'),
    '3': ObjectId('688a5df3dcf34a2acaf6df1e')
  }
}
db.feedback.createIndex({ student_id: 1 });
student_id_1
db.feedback.createIndex({ course_id: 1 });
course_id_1


