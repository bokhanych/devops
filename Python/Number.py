# Урок 27: Python 2
import random
x = int(random.randint(1,10))
def x_random():
    global x
    x = int(random.randint(1,10))
    return x
def number():
    user_number = int(input("Enter number: "))
    if user_number == x :
        print ("Congratulations, you guessed number!")
        try_again()
    elif user_number < x:
        print ("Guessed wrong! You number is less!")
        try_again()
    else:
        print ("Guessed wrong! You number is higher!")
        try_again()
def try_again():
    yesno = str(input("Do you want to try again? [Enter \ n]: "))
    if yesno == "" :
        print (f"This number was {x}. Generating the new number... Good luck!")
        x_random()
        number()
    else:
        print (f"This number was {x}.")
number()