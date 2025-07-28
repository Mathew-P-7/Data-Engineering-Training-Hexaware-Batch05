# 3.a
class BankAccount:
    def __init__(self, holder_name, balance=0):
        self.holder_name = holder_name
        self.balance = balance

    def deposit(self, amount):
        self.balance += amount
        return self
    def withdraw(self, amount):
        if amount > self.balance:
            raise ValueError('Insufficient balance')
        else:
            self.balance -= amount
            return self

# 3.b
class SavingsAccount(BankAccount):
    def __init__(self, holder_name, balance=0, interest_rate=0.5):
        super().__init__(holder_name, balance)
        self.interest_rate = interest_rate

    def apply_interest(self):
        interest = self.balance * self.interest_rate
        self.balance += interest
        return self

