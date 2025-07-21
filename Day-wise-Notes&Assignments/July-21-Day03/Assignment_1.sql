-- ---------------------------------------------------------------------
-- ASSIGNMENT: 01
-- Database Creation
CREATE DATABASE assignment1;
USE assignment1;

-- Table Creation
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    department VARCHAR(50),
    salary INT,
    age INT
);

CREATE TABLE departments(
dept_id INT PRIMARY KEY,
dept_name VARCHAR(100),
location VARCHAR(50)
);

-- Table Insertion.
INSERT INTO employees VALUES
(101, 'Amit Sharma','Engineering', 60000, 30),
(102, 'Neha Reddy','Marketing', 45000, 28),
(103, 'Faizan Ali', 'Engineering' , 58000, 32),
(104, 'Divya Mehta', 'HR', 40000, 29),
(105, 'Ravi Verma', 'Sales', 35000, 26);

INSERT INTO departments VALUES
(1, 'Engineering', 'Bangalore'),
(2, 'Marketing', 'Mumbai'),
(3, 'HR', 'Delhi'),
(4, 'Sales', 'Chennai');

-- SECTION A: BASIC SQL 
-- 1. Display all employees
SELECT * FROM employees;

-- 2. Show only emp_name and salary of all employees
SELECT emp_name , salary
FROM employees; 

-- 3. Find employees with a salary  greater than 40,000
SELECT *
FROM employees
WHERE salary > 40000;

-- 4. Find employees between age 28 and 32 (inclusive)
SELECT *
FROM employees
WHERE age BETWEEN 28 AND 32;

-- 5. Show employees who are not in the HR department
SELECT *
FROM employees
WHERE department NOT IN ('HR');

-- 6. Sort employees by salary in descending order.
SELECT * 
FROM employees
ORDER BY salary DESC;

-- 7. Count the number of employees in the table.
SELECT  Count(*) AS Employee_Count
From employees;

-- 8. Find the employee with the highest salary.
SELECT * 
FROM employees
WHERE salary = (SELECT  MAX(salary) FROM employees);

-- SECTION B: JOINS & AGGREGATIONS
-- 1. Display employee names along with their department locations (using JOIN).
SELECT e.emp_name, d.location
FROM  employees e
JOIN departments d
ON e.department = d.dept_name;

-- 2. List departments and count of employees in each department.
SELECT d.dept_name, COUNT(e.emp_name) AS employee_count
FROM employees e
JOIN departments d
ON e.department = d.dept_name
GROUP BY d.dept_name;

-- 3. Show average salary per department.
SELECT d.dept_name, AVG(e.salary) average_salary
FROM employees e
JOIN departments d
ON e.department =  d.dept_name
GROUP BY d.dept_name;

-- 4. Find departments that have no employees (use LEFT JOIN).
-- Since each department is having a employee in current table, we will add another department with no employee enrolled.
INSERT INTO departments VALUES(5, 'R&D', 'Chennai');

SELECT * 
FROM departments d
LEFT JOIN employees e
ON d.dept_name = e.department
WHERE e.emp_id IS NULL ;

-- 5. Find total salary paid by each department.
SELECT d.dept_name, SUM(e.salary) AS Total_Salary
FROM employees e
JOIN departments d
ON e.department = d.dept_name
GROUP BY d.dept_name;

-- 6. Display departments with average salary > 45,000.
SELECT d.dept_name, AVG(e.salary) AS average_salary
FROM employees e
JOIN departments d
ON e.department = d.dept_name
GROUP BY d.dept_name
HAVING average_salary > 45000;

-- 7. Show employee name and department for those earning more than 50,000.
SELECT e.emp_name, d.dept_name, e.salary
FROM employees e
JOIN departments d
ON e.department = d.dept_name
WHERE e.salary > 50000;






















