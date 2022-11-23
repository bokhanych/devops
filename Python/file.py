# Урок 28: Python 3
file = open("hosts.txt", mode='a+', encoding='utf_8')
file_path = "hosts.txt"

def find_in_file(credentials):
    with open(file_path) as file:
        finds=0
        for line in file:
            if credentials in line:
                finds+=1
                print(line)
            else:
                continue
        if finds == 0:
                print("Nothing found.")

def write_to_file():
    host = "HOSTNAME:" + input("Enter Hostname: ")
    user = "USERNAME:" + input("Enter Username: ")
    password = "PASSWORD:" + input("Enter Password: ")
    file.write(host + " " + user + " " + password + '\n')
    print("Entry added.")
    retry = input("Add one more entry? [y/n]")
    if retry == "y":
        write_to_file()
    else:
        file.close()

def menu():
    start = input("Enter ADD to add credentials, FH to find hostname or FU to find username: ")
    if start == "ADD":
        write_to_file()
    elif start == "FH":
        required_hostname = "HOSTNAME:" + input("Enter Hostname to search: ")
        find_in_file(required_hostname)
    elif start == "FU":
        required_username = "USERNAME:" + input("Enter Username to search: ")
        find_in_file(required_username)

menu()