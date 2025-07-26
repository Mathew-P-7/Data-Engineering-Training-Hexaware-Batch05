#Quick Practice Tasks

# 1. Create a string variable movie = "The Lion King"
movie = "The Lion King"
# Print only "Lion" using slicing.
print(movie[4:8])

# 1.Make a list of your 4 favorite foods.
foods = ["Biriyani", "Ramen", "Veg Meals", "Kimchi"]
print(foods)
# Add one more.
foods.append("Sambar rice")
print(foods)
# Remove the 2nd item.
foods.remove("Veg Meals")
print(foods)
# Print the final list
for food in foods:
    print(food)


#Create a tuple of 3 numbers
Numbers = (3.14,17,369)
# Try accessing the last number
print(Numbers[0])
print(Numbers[1])
print(Numbers[2])
print(Numbers[1:])
print(Numbers[-1:])
