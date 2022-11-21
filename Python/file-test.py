file_path = "hosts.txt"
required = input("Enter Hostname to search: ")
string_numbers = []

# Функция для поиска номера строки
def find_string_number(path_to_file, required):
    with open(path_to_file) as file:
        for num_line, line in enumerate(file):
            if required in line:
                print(line)
                return(num_line)
    return('Ни одного hostname с заданным содержанием не нашлось. Sorry. Это котик виноват')
 
string_number = (int(find_string_number(file_path, required))+1)
print(string_number)