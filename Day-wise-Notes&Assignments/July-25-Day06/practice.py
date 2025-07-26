# Declaring a string
greeting = "Hello, Mathew"

# Accessing characters
print(greeting[0])             #H
print(greeting[-1])            #r

#Slicing
print(greeting[0:5])
print(greeting[7:])

#String methods
print(greeting.upper())
print(greeting.lower())
print(greeting.replace("Mathew","Captain"))

#Declaring a List
fruits = ["apple","banana","orange"]

#Accessing elements
print(fruits[1])

#Adding elements
fruits.append("Cheery")
print(fruits)

#Removing elements
fruits.remove("banana")
print(fruits)

#Slicing
print(fruits[1:])

#Looping
for fruit in fruits:
    print(fruit)


#Declaring a tuple
colors = ("red","blue","green")  #immutable, can be used for constant

#Accessing elements
print(colors[0])

#  Slicing
print(colors[1:3])

# Conditional statement
age = int(input("How old are you?"))

if age >= 18:
    print("You are old enough")
else:
    print("You are not old enough")

marks = int(input("How many marks do you have?"))

if marks >= 90:
    print("Grade A")
elif marks >= 80:
    print("Grade B")
elif marks >= 70:
    print("Grade C")
else:
    print("Fail")


#  While loop

count = 1
while count < 5:
    print(count)
    count += 1

#  for loop

for i in range(5):  # 0 to 4
    print("Number:", i)

for i in range(1,6): # 1 to 5
    print(i)

for i in range(1,10):
    if i == 5:
        continue    # skips 5
    if i == 8:
        break   #skips at 8
    print(i)

#Functions
def greet_user(name):
    print(f"Hello, {name}! Welcome.")

greet_user("Prem Kumar")

# Parameterized
def add(a,b):
    return a+b

result = add(197,234)

# dynamic parameter values
def power(base, exponent=2):
    return base ** exponent
print(power(3))
print(power(3,3))

# Built-in function
# Type Converter
print(type(5))
print(type("Hello"))

age = "12"
print(int(age))
print(type(age))

# Statistics module's built-in functions
nums = [1,2,3,4,5,6,7,8,9]
print(sum(nums))
print(max(nums))
print(min(nums))
print(len(nums))

names = ["Zara", "Amin", "Lina"]
print(sorted(names))
"""
Note: list.sort() and sorted(iterable) are different,
list.sort() is a list method, whereas sorted(iterable) is a built-in function.
"""

print(abs(-9))
print(round(3.75))
print(round(3.7567, 2))

"""
Pre build Modules
Modules: collection of functions
"""
# 1. Math module
import math

print(math.ceil(3.75))
print(math.floor(3.75))
print(math.sqrt(16))
print(math.pow(2,3))
print(math.pi)

# 2. Datetime module
import datetime as dt

today = dt.date.today()
print("Today:", today)

now = dt.datetime.now()
print("Current time:", now.strftime("%H:%M:%S"))


# importing my user defined module
import mymath
print("Addition: ",mymath.add(3,4))
print("Multiplication: ", mymath.mul(4,3))
print("Division: ", mymath.div(4,3))
print("Subtraction: ", mymath.sub(3,4))
print("Remainder: ", mymath.mod(3,4))

