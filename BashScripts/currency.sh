#!/bin/bash
PAGE=$(curl -s https://myfin.by/bank/kursy_valjut_nbrb)
PS3='Please choose currency: '
select currency in "USD" "EUR" "RUB" "PLN" "UAH"; do
  case $currency in
    USD)
      echo -n "1 Доллар = " 
      echo -n $PAGE |  grep 'a href="/bank/kursy_valjut_nbrb/' | sed 's:<a href="/bank/kursy_valjut_nbrb/:\n(&):g' | sed '1d' | sed 's:data-key="[0-9]*"><td>:(&)\n:g' | sed '$d' | sed '/^$/d' | grep -i 'Доллар' | awk -F"</td><td>" '{print $2}' | sed '2,4d'
      exit
      ;;
    EUR)
      echo -n "1 Евро = " 
      echo -n $PAGE |  grep 'a href="/bank/kursy_valjut_nbrb/' | sed 's:<a href="/bank/kursy_valjut_nbrb/:\n(&):g' | sed '1d' | sed 's:data-key="[0-9]*"><td>:(&)\n:g' | sed '$d' | sed '/^$/d' | grep -i 'Евро' | awk -F"</td><td>" '{print $2}'
      exit
      ;;
    RUB)
      echo -n "100 Российских рублей = "
      echo -n $PAGE |  grep 'a href="/bank/kursy_valjut_nbrb/' | sed 's:<a href="/bank/kursy_valjut_nbrb/:\n(&):g' | sed '1d' | sed 's:data-key="[0-9]*"><td>:(&)\n:g' | sed '$d' | sed '/^$/d' | grep -i 'Российский рубль' | awk -F"</td><td>" '{print $2}'
      exit
      ;;
    PLN)
      echo -n "10 Злотых = "
      echo -n $PAGE |  grep 'a href="/bank/kursy_valjut_nbrb/' | sed 's:<a href="/bank/kursy_valjut_nbrb/:\n(&):g' | sed '1d' | sed 's:data-key="[0-9]*"><td>:(&)\n:g' | sed '$d' | sed '/^$/d' | grep -i 'Польский злотый' | awk -F"</td><td>" '{print $2}'
      exit
      ;;
    UAH)
      echo -n "100 Гривен = "
      echo -n $PAGE |  grep 'a href="/bank/kursy_valjut_nbrb/' | sed 's:<a href="/bank/kursy_valjut_nbrb/:\n(&):g' | sed '1d' | sed 's:data-key="[0-9]*"><td>:(&)\n:g' | sed '$d' | sed '/^$/d' | grep -i 'Гривна' | awk -F"</td><td>" '{print $2}'
      exit
      ;;
    *) 
      echo "Invalid currency!"
      ;;
  esac
done