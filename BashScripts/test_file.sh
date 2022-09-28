#!/bin/bash
rm 13.html

echo -n "Enter email address: "; read web_login;
echo -n "Enter password: "; read -s web_password;

curl -s -o 13.html 'http://seasonvar.ru/?mod=login' \
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
  --data-raw 'login=bokhanych%40gmail.com&password=$web_password' \
  --compressed \
  --insecure

if [ -s 13.html ]; 
    then
    echo "Wrong credentials!"
    else
    echo "Correct credentials!"
fi




# %40
# <div class="pgs-msg full error">Логин или пароль указан не верно.</div>