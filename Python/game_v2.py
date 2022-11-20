# Урок 27: Python 2
# Вариант 2
import random

def game(random_number):
    user_number = int(input("Enter number: "))
    if user_number == random_number :
        print ("WIN! You guessed number", random_number)
        answer(random_number)
    elif user_number < random_number:
        print ("LOSE! You number is less!")
        answer(random_number)
    else:
        print ("LOSE! You number is higher!")
        answer(random_number)
    return random_number

def answer(y):
    yn = str(input("Play again? [y/n]"))
    if yn == "y":
        menu()
    else:
        print("Win number was", y)
    return y

def menu():
    x = int(random.randint(1,10))
    game(x)

menu()