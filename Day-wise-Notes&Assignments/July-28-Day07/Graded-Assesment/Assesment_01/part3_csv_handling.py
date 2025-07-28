# 6
import pandas as pd

df = pd.read_csv('data/students.csv')
print("CSV Read:\n", df)

df['Age'] = df['Age'].fillna(df['Age'].mean())
print("\nCleaned Age Data with Average Age:\n ", df)

df['Score'] = df['Score'].fillna('0')
print("\nCleaned Data after Score filled:\n ", df)

# Saving the cleaned data
df.to_csv('data/students_cleaned.csv', index=False)
print(" Cleaned data is saved successfully ")

# 7
df =  pd.read_csv('data/students_cleaned.csv')
df.to_json('data/students_cleaned.json', orient='records', indent=4)
print("Converted to JSON file: students.json")