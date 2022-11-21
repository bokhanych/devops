# Урок 28: Python 3
file = open("hosts.txt", mode='a+', encoding='utf_8')

def find_host_in_file():
    host = "HOSTNAME:" + input("Enter Hostname to search: ")
    for i in file.readlines():
        if host in i:
            print(host)

def write_to_file():
    host = "HOSTNAME:" + input("Enter Hostname: ")
    user = "USERNAME:" + input("Enter Username: ")
    password = "PASSWORD:" + input("Enter Password: ")
    file.write(host + " " + user + " " + password + '\n')

start = input("Enter A to add credentials, F to find or Q to exit: ")
if start == "A":
    write_to_file()
elif start == "F":
    find_host_in_file()

file.close()