import pandas as pd
import numpy as np

# Sample raw data (intentionally messy)
raw_data = {
    'EmpID': [201, 202, 203, 204, 205, 206],
    'Name': ['Aarav', 'Sanya', None, 'Karthik', 'Meera', None],  # Missing names
    'Age': [24, np.nan, 29, 22, 31, np.nan],                    # Missing ages
    'Department': ['Finance', 'Tech', 'HR', None, 'Marketing', None],  # Missing departments
    'Salary': ['52000', '73000', 'not available', '48000', '61000', None]  # Invalid and missing salary
}

df = pd.DataFrame(raw_data)
print("Raw Data: \n", df)

# -------------------- Cleaning -------------------------

#  Fill missing names with "Unknown"
df['Name'] = df['Name'].fillna('Unknown')

#  Fill missing departments with "Not Assigned"
df['Department'] = df['Department'].fillna('Not Assigned')

# Convert salary to numeric (handle non-numeric gracefully)
df['Salary'] = pd.to_numeric(df['Salary'], errors='coerce')

# Fill missing Age and Salary with their respective means
df['Age'] = df['Age'].fillna(df['Age'].mean())
df['Salary'] = df['Salary'].fillna(df['Salary'].mean())

print("\n Cleaned Data: \n", df)