# 5
import pandas as pd

df = pd.read_csv("data/orders.csv")
print("Data frame:\n ", df)

# 5.a
df['CustomerName'] = df['CustomerName'].fillna("Unknown")

# 5.b
df['Quantity'] = df['Quantity'].fillna(0)
df['Price'] = df['Price'].fillna(0)

# 5.c
df['TotalAmount'] = df['Quantity'] * df['Price']

# 5.d
df.to_csv("data/orders_cleaned.csv", index=False)
print("\nCleaned Data saved successfully")