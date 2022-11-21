with open("Вопросы.txt", "r") as file:
    line = file.readlines()
 
for i in line:
    i = line.index(i)
    print(line[i])