# 4.
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def display(self):
        print(f"Name: {self.name}",
              f"Age: {self.age}")

class Employee(Person):
    def __init__(self, name, age, employee_id, department ):
        super().__init__(name, age)
        self.employee_id = employee_id
        self.department = department

    def display(self):
        print(f"Name: {self.name}",
              f"Age: {self.age}",
              f"Employee ID: {self.employee_id}",
              f"Department: {self.department}")

# 5
class Vehicle:
    def drive(self):
        print("Driving vehicle")

class Car(Vehicle):
    def drive(self):
        print("Driving car")


