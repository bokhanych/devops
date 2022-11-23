# Урок 28: Python 3
file = open("hosts.txt", mode='a+', encoding='utf_8')
file_path = "hosts.txt"

def find_host():
    required_hostname = "HOSTNAME:" + input("Enter Hostname to search: ")
    with open(file_path) as file:
        for line in file:
            if required_hostname in line:
                print(line)

def find_user():
    required_username = "USERNAME:" + input("Enter Username to search: ")
    with open(file_path) as file:
        for line in file:
            if required_username in line:
                print(line)

def write_to_file():
    host = "HOSTNAME:" + input("Enter Hostname: ")
    user = "USERNAME:" + input("Enter Username: ")
    password = "PASSWORD:" + input("Enter Password: ")
    file.write(host + " " + user + " " + password + '\n')
    file.close()
    print("Entry added")

start = input("Enter ADD to add credentials, FH to find hostname or FU to find username: ")
if start == "ADD":
    write_to_file()
elif start == "FH":
    find_host()
elif start == "FU":
    find_user()