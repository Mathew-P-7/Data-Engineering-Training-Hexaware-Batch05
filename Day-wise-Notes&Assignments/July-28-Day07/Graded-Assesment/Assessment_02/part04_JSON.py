# 6
import json

# 6.a
with open('data/inventory.json', 'r') as f:
    inventory  = json.load(f)
print("JSON Read: \n", inventory)

# 6.b
for item in inventory:
    if item['stock'] > 0:
        item['status'] = 'In Stock'
    else:
        item['status'] = 'Out of Stock'
print('\nAfter updation of status field:\n ',inventory)

# 6.c
with open('data/inventory_updated.json', 'w') as f:
    json.dump(inventory, f, indent = 4)

print("\nJSON written to inventory_updated.json: \n")