# Урок 27: Python 2
# Вариант 2
import random

def game(random_number):
    user_number = int(input("Enter number: "))
    if user_number == int(random_number) :
        print ("WIN! You guessed number")
        return True
    elif user_number < int(random_number):
        print ("LOSE! You number is less!")
    else:
        print ("LOSE! You number is higher!")
    return random_number

def menu():
    exit_button = "y"
    while exit_button == "y":
        x = random.randint(1,3)
        new_game = False
        while new_game == False:
            y = game(x)
            if y == True:
                new_game= True
                break
            yesno = input("Try again? [y/n]: ")
            if yesno == "y":
                continue
            else:
                print (f"Win number was {y}.")
                new_game=True
        exit_button = input("Play again? [y/n]")

menu()