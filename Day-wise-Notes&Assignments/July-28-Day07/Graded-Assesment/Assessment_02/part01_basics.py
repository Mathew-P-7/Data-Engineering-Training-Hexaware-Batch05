# 1
def factorial(n):
    result = 1
    for i in range(1, n + 1):
        result *= i
    return result
n = int(input("Enter a number: "))
print(factorial(n))

# 2
students = [("Aarav", 80), ("Sanya", 65), ("Meera", 92), ("Rohan", 55)]
# 2.a
for name, score in students:
    if score > 75:
        print(f"Student Name: {name}")

# 2.b
total = 0
for _, score in students:
    total += score
avg = total / len(students)
print("Average score : ", avg)