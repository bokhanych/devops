#file_path = "hosts.txt"
#required = input("Enter Hostname to search: ")

with open("hosts.txt", "r") as file:
    line = file.readlines()
 
for i in line:
    i = line.index(i)
    print(line[i])