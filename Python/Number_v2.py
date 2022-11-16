# Урок 27: Python 2
import random

def game():
    x = int(random.randint(1,10))
    user_number = int(input("Enter number: "))
    if user_number == x :
        print ("Congratulations, you guessed number!")
        new_round()
    elif user_number < x:
        print ("Guessed wrong! You number is less!")
        new_round()
    else:
        print ("Guessed wrong! You number is higher!")
        new_round()
    return x

def new_round():
    yesno = str(input("Do you want to try again? [Enter \ n]: "))
    if yesno == "":
        game()
    else:
        y = game
        print (f"This number was {y}.")        

game()