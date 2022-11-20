# Урок 28: Python 3
file_name = "hosts.txt"
file = open(file_name, mode='a+', encoding='utf_8')

def find_host_in_file():
    host = input("Enter Hostname to search: ")
    for i in file.readlines():
        if host in i:
            print(i.strip())

def find_host(): 
    f = input('enter file name:')
    w = input('enter word:')
    host = input("Enter Hostname to search: ")
    with file as fin:
        for s in fin.readlines():
            if s.find(host) > -1:
                print(s.strip())

def write_to_file():
    host = input("Enter Hostname: ")
    user = input("Enter Username: ")
    password = input("Enter Password: ")
    file.write(host + " " + user + " " + password + '\n')

start = input("Enter A to add credentials, F to find or Q to exit: [A/F/Q]")
if start == "A":
    write_to_file()
elif start == "F":
    find_host_in_file()

file.close()