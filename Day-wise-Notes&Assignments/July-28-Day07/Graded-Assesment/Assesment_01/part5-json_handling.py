import json

# 9.a
with open('data/products.json', 'r') as f:
    products = json.load(f)
print("JSON Read: \n", products)

# 9.b
for p in products:
    p['price'] = round(p['price']*1.10, 2)

print("\n Price updated successfully: \n", products)

# 9.c
with open('data/products_updated.json', 'w') as f:
    json.dump(products , f, indent = 4)

print("\nJSON written to products_updated.json")