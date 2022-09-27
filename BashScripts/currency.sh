#!/bin/bash
#wget -O currency-page.html https://myfin.by/currency/minsk
PS3='Please choose currency: '
select currency in "USD" "EUR" "RUB" "PLN" "UAH"; do
  case $currency in
    USD)
      echo "Доллар"
      #Доллар США </a></td><td>
      #exit
      ;;
    EUR)
      echo "Евро"
      #exit
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
