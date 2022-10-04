#!/bin/bash

# создаем файл запроса
cat << EOF > request.sh
curl -s -o LOGIN_ERROR.html 'http://seasonvar.ru/?mod=login' \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
  -H 'Accept-Language: ru-RU,ru;q=0.9,en-US;q=0.8,en;q=0.7' \
  -H 'Cache-Control: max-age=0' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Cookie: cs=1; cs1=1' \
  -H 'Origin: http://seasonvar.ru' \
  -H 'Referer: http://seasonvar.ru/?mod=reg' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36' \
  --data-raw 'login=CHANGE_LOGIN&password=CHANGE_PASSWORD' \
  --compressed \
  --insecure
EOF

# запрашиваем пользовательские креды
echo -n "Enter email address: "; read user_login;
echo $user_login > credentials.txt

# заметил, что конкретно на этом сайте в запросе ящика знак собаки @ меняется на %40. приводим ящик в соответсвие, чтобы запрос прошел
sed -i "s/\@/\%40/g" credentials.txt;
user_login=$(head -n 1 credentials.txt)
echo -n "Enter password: "; read -s user_password;
echo $user_password >> credentials.txt

# меняем креды в запросе
sed -i "s/CHANGE_LOGIN/$user_login/g" request.sh;
sed -i "s/CHANGE_PASSWORD/$user_password/g" request.sh;

# выполняем запрос
bash request.sh

# если не не вернулась ошибка, то логин успешный
if [ -s LOGIN_ERROR.html ]; 
    then
    echo "ERROR! Credentials aren't correct!"
    else
    echo "ALL OK! Credentials is correct!"
fi

# cleaning
rm credentials.txt request.sh LOGIN_ERROR.html