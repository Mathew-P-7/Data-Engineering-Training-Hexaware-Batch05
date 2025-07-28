import pandas as pd

# Read from a CSV file
df = pd.read_csv('employees.csv')

print("CSV Read:\n", df)

# Write to a new CSV file
df.to_csv('updated_employees.csv', index=False)

print("CSV written to updated_employees.csv")

