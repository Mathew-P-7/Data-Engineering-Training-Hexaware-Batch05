import mysql.connector

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="12345678",
    database="simple_sql"
)


cursor = conn.cursor()

# # Step 2: Create a table
#
# create_table_query = """
#
# CREATE TABLE IF NOT EXISTS employees(
#     id INT AUTO_INCREMENT PRIMARY KEY,
#     name VARCHAR(100),
#     department VARCHAR(100),
#     salary FLOAT
# );
# """
# cursor.execute(create_table_query)
# print("Table 'employees'  created successfully")
#
# # Step 3: Insert sample data
# insert_query = """
# INSERT INTO employees (name, department, salary)
# VALUES ('Rahul Sharma', 'Engineering', 75000),
#        ('Priya Verma', 'Marketing', 60000),
#        ('Anil Kapoor', 'HR', 50000);
#                """
#
# cursor.execute(insert_query)
# conn.commit()


# ✅ Step 4: UPDATE a record (e.g., change salary for 'Priya Verma')
update_query = """
UPDATE employees
SET salary = 65000
WHERE name = 'Priya Verma';
"""
cursor.execute(update_query)
print("Updated Priya Verma's salary successfully")

# ✅ Step 5: DELETE a record (e.g., remove 'Anil Kapoor')
delete_query = """
DELETE FROM employees
WHERE name = 'Anil Kapoor';
"""
cursor.execute(delete_query)
print("Deleted Anil Kapoor successfully")


conn.commit()
#  Step 6: Close connection
cursor.close()
conn.close()