# 8
# 8.a
import pandas as pd
import numpy as np

df = pd.read_csv('data/students_cleaned.csv')
print("Before adding new column: \n", df)

df['Status'] = np.where(df['Score'] >= 85, 'Distinction', np.where(df['Score'] >= 60, 'Passed', 'Failed'))
print("After adding new column ' Status ': \n", df)

# 8.b
df['Tax_ID'] = 'TAX-'+df['ID'].astype(str)
print("After adding new column ' Tax_ID ': \n", df)
