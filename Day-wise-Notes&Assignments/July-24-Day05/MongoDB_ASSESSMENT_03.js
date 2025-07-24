// MongoDB Assessment 03 : JOB PORTAL


use jobportaldb

//Part 1: Create Collections and Insert Your Own Data

//jobs collection
db.jobs.insertMany([

{ job_id: 1,job_title: "Senior Software Engineer", company: "TechCorp", location: "Bangalore", salary: 1500000, job_type: "remote", posted_on: new Date("2023-10-01") },
{ job_id: 2, job_title: "Data Scientist", company: "DataWorks", location: "Hyderabad", salary: 1200000, job_type: "hybrid", posted_on: new Date("2023-10-15")},
{ job_id: 3, job_title: "Frontend Developer", company: "WebSolutions", location: "Mumbai", salary: 900000, job_type: "on-site", posted_on: new Date("2023-09-20") },
{ job_id: 4, job_title: "DevOps Engineer", company: "TechCorp", location: "Pune", salary: 1800000, job_type: "remote", posted_on: new Date("2023-10-05")},
{ job_id: 5, job_title: "Backend Developer", company: "TechCorp",  location: "Delhi", salary: 1100000, job_type: "hybrid", posted_on: new Date("2023-09-25")}

])

//applicants collection
db.applicants.insertMany([ 

{ applicant_id: 101, name: "Rahul Sharma", skills: ["MongoDB", "Node.js", "JavaScript"], experience: 5, city: "Bangalore", applied_on: new Date("2023-10-10")},
{ applicant_id: 102, name: "Priya Patel", skills: ["Python", "SQL", "Data Analysis"], experience: 3, city: "Hyderabad", applied_on: new Date("2023-10-12")},
{applicant_id: 103, name: "Amit Singh", skills: ["React", "JavaScript", "CSS"], experience: 4, city: "Mumbai", applied_on: new Date("2023-10-05") },
{ applicant_id: 104, name: "Neha Gupta", skills: ["MongoDB", "Express", "AWS"], experience: 6, city: "Bangalore", applied_on: new Date("2023-10-08")},
{ applicant_id: 105, name: "Suresh Kumar", skills: ["Java", "Spring", "Hibernate"], experience: 7, city: "Hyderabad", applied_on: new Date("2023-09-28")}

])

//applications collection
db.applications.insertMany([

{ application_id: 1001, applicant_id: 101, job_id: 1, application_status: "under review", interview_scheduled: false, feedback: ""},
{ application_id: 1002, applicant_id: 102, job_id: 2, application_status: "interview scheduled", interview_scheduled: true, feedback: "Technical interview scheduled for Oct 20"},
{ application_id: 1003, applicant_id: 103, job_id: 3, application_status: "rejected", interview_scheduled: false, feedback: "Not enough experience"},
{ application_id: 1004, applicant_id: 104, job_id: 1, application_status: "interview scheduled", interview_scheduled: true, feedback: "Technical interview scheduled for Oct 18" },
{ application_id: 1005, applicant_id: 105, job_id: 4, application_status: "under review", interview_scheduled: false, feedback: ""},
{ application_id: 1006, applicant_id: 101, job_id: 2, application_status: "under review", interview_scheduled: false, feedback: ""}

])

//Part 2: Write the Following Queries
//1. Find all remote jobs with a salary greater than 10,00,000.
db.jobs.find( { job_type: "remote", salary: { $gt: 1000000 } } )

//2. Get all applicants who know MongoDB.
db.applicants.find( { skills: "MongoDB" } )

//3. Show the number of jobs posted in the last 30 days.
db.jobs.countDocuments( { posted_on: { $gte: new Date ( new Date() - 30 * 24 * 60 * 60 * 1000) } } )

//4. List all job applications that are in ‘interview scheduled’ status.
db.applications.find.( { application_status: "interview scheduled" } )

//5. Find companies that have posted more than 2 jobs.
db.jobs.aggregate.([
{
$group: {
	_id: "$company",
	count: { $sum: 1 }
}
},

{
$match: { 
	count: { $gt: 2} 
}
}

])

//Part 3: Use $lookup and Aggregation
//6. Join applications with jobs to show job title along with the applicant’s name.
db.applications.aggregate([
{
$lookup: {
      from: "jobs",
      localField: "job_id",
      foreignField: "job_id",
      as: "job"
}
},

{
$lookup: {
      from: "applicants",
      localField: "applicant_id",
      foreignField: "applicant_id",
      as: "applicant"
}
},

{
$project: {
      "job.job_title": 1,
      "applicant.name": 1
}
}

])

//7. Find how many applications each job has received.
db.applications.aggregate([
{ 
$group: { 
	_id: "$job_id", 
	applicationCount: { $sum: 1 } 
} 
},

{
$sort: { 
	applicationCount: -1 
} 
}

])

//8. List applicants who have applied for more than one job.
db.applications.aggregate([
{ 
$group: { 
	_id: "$applicant_id", 
	jobCount: { $sum: 1 } 
} 
},

{ 
$match: { 
	jobCount: { $gt: 1 } 
} 
},

{
$lookup: {
      from: "applicants",
      localField: "_id",
      foreignField: "applicant_id",
      as: "applicant"
}
},

{ 
$unwind: "$applicant" 
},

{ 
$project: { 
	"applicant.name": 1, 
	jobCount: 1 
} 
}

])

//9. Show the top 3 cities with the most applicants.
db.applicants.aggregate([
{ 
$group: { 
	_id: "$city", 
	count: { $sum: 1 } 
} 
},

{ 
$sort: { count: -1 } 
},

{ $limit: 3 }
])


//10. Get the average salary for each job type (remote, hybrid, on-site).
db.jobs.aggregate([
{ 
$group: { 
	_id: "$job_type",
	avgSalary: { $avg: "$salary" } 
} 
}
])


//Part 4: Data Updates
//11. Update the status of one application to "offer made".
db.applications.updateOne(
  { application_id: 1004 },
  { $set: { application_status: "offer made" } }
)

//12. Delete a job that has not received any applications.
const jobWithApplication = db.applications.distinct("job_id")

db.jobs.deleteMany({ job_id: { $nin: jobWithApplication } })


//13. Add a new field shortlisted to all applications and set it to false.
db.applications.updateMany({}, { $set: { shortlisted: false } })

//14. Increment experience of all applicants from "Hyderabad" by 1 year.
db.applicants.updateMany(
{ city: "Hyderabad" }, { $inc: { experience: 1 } }
)


//15. Remove all applicants who haven’t applied to any job.
const appliedApplicants = db.applications.distinct("applicant_id")

db.applicants.deleteMany({ applicant_id: { $nin: appliedApplicants } })



