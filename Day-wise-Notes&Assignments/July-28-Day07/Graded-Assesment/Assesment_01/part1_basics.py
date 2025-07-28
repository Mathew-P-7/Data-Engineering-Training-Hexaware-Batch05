# Part 1: Basics

# 1. Check Prime
from math import sqrt
def is_prime(n):

    if n <= 1:
        return False
    for i in range(2, int(sqrt(n)) + 1 ):
        if n % i == 0:
            return False
    return True


# 2.Reverse string and Palindrome
def check_palindrome(string):
    reversed_string = string[::-1]
    if string == reversed_string:
        print(f"The given string '{string}' is a Palindrome")
    else:
        print(f"The given string '{string}' is not a Palindrome")

# driver code
mystring = input("Enter a string: ")
check_palindrome(mystring)

# 3.List of numbers
# Getting numbers list from users
numList = list(map(int, input("Enter the list of numbers: ").split()))
print("The Number List: ", numList)

# To remove the duplicates, I convert the list into a set
uniqueList = list(set(numList))
print("The List without duplicates: ", uniqueList)

# sorting the list:
sortedList = sorted(uniqueList)
print("Sorted List: ", sortedList)

# The Second Largest number
print("Second Largest Number: ", sortedList[-2])





