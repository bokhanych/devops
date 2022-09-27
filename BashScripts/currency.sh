#!/bin/bash
PAGE=$(curl -s https://myfin.by/bank/kursy_valjut_nbrb)
PS3='Please choose currency: '
select currency in "USD" "EUR" "RUB" "PLN" "UAH"; do
  case $currency in
    USD)
      echo -n "1 Доллар = " 
      echo -n $PAGE |  grep 'a href="/bank/kursy_valjut_nbrb/' | sed 's:<a href="/bank/kursy_valjut_nbrb/:\n(&):g' | sed '1d' | sed 's:data-key="[0-9]*"><td>:(&)\n:g' | sed '$d' | sed '/^$/d' | grep -i 'Доллар' | awk -F"</td><td>" '{print $2}'
      exit
      ;;
    EUR)
      echo -n "1 Евро = " 
      echo -n $PAGE |  grep 'a href="/bank/kursy_valjut_nbrb/' | sed 's:<a href="/bank/kursy_valjut_nbrb/:\n(&):g' | sed '1d' | sed 's:data-key="[0-9]*"><td>:(&)\n:g' | sed '$d' | sed '/^$/d' | grep -i 'Евро' | awk -F"</td><td>" '{print $2}'
      exit
      ;;
    RUB)
      echo "100 Рублей"
      #exit
      ;;
    PLN)
      echo "10 Злотых"
      #exit
      ;;
    UAH)
      echo "100 Гривен"
      #exit
      ;;
    *) 
      echo "Invalid currency!"
      ;;
  esac
done
#end
#rm currency-page.html



# TMS_Homework/exchange_rate.sh at master · aguranchik/TMS_Homework