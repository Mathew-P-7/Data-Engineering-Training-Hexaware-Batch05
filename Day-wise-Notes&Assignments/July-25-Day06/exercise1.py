
def fizzBuzz():
    for i in range(1,51):
        if i % 3 == 0 and i % 5 == 0:
            print("FizzBuzz")
        elif i % 3 == 0:
            print("Fizz")
        elif i % 5 == 0:
            print("Buzz")
        else:
            print(i)
def login():
    count = 0
    while count < 3:
        username = input("Enter Username: ")
        password = input("Enter Password: ")
        if username == "admin" and password == "1234":
            print("Login Successfully")
        else:
            print("Incorrect Try again")
            count += 1
    print("Account Locked")

def checkPalindrome():
    word = input("Enter Word: ")
    word = word.lower()
    if word == word[::-1]:
        print(f" The given word: {word} is a Palindrome")
    else:
        print(f" The given word: {word} is not a Palindrome")

def prime():
    n = int(input("Enter the range: "))
    for number in range(1,n+1):
        is_prime = True
        if number < 2:
            is_prime = False
        else:
            for i in range(2,number):
                if number % i == 0:
                    is_prime = False
                    break
        if is_prime:
            print(number)



def starPyramid():
    n = int(input("Enter the range: "))
    for i in range(1,n+1):
        for j in range(1, i+1):
            print("*", end=" ")
        print()

# 6. Sum of Digits
def sumofdigits():
    num = input("Enter the number: ")
    total = 0
    for digit in num:
        total = total + int(digit)
    print(f"The sum of digits is: {total}")






# 7. Multiplication Table Generator
def multiplicationtable():
    num = int(input("Enter the number for multiplication table: "))
    for i in range(1,11):
        print(f"{num} x {i} = {num*i}")

# 8. Count Vowels in a String
def vowelscount():
    string = input("Enter the sentence: ").lower()
    count = 0
    for letter in string:
        if letter in "aeiou":
            count += 1
    print(f"The total vowels present in the sentence is: {count}")





def main():
    while True:
        print("Exercise 1")
        print("Choose from the following options:")
        print("\n1. FizzBuzz")
        print("2. Login")
        print("3. Check Palindrome")
        print("4. Prime")
        print("5. StarPyramid")
        print("6. SumofDigits")
        print("7. MultiplicationTable")
        print("8. VowelsCount")
        print("9. Exit")
        choice = input("Enter your choice: ")
        if choice == "1":
            fizzBuzz()
        elif choice == "2":
            login()
        elif choice == "3":
            checkPalindrome()
        elif choice == "4":
            prime()
        elif choice == "5":
            starPyramid()
        elif choice == "6":
            sumofdigits()
        elif choice == "7":
            multiplicationtable()
        elif choice == "8":
            vowelscount()
        elif choice == "9":
            print("Thank You")
            break
        else:
            print("Invalid Choice")

        # fizzBuzz()
        # login()
        # checkPalindrome()
        # prime()
        # starPyramid()
        # sumofdigits()
        # multiplicationtable()
        # vowelscount()

if __name__ == '__main__':
    main()
