update inside_exchange_rate
set rate = '$new_rate', datetime = now()
where currency1 = '$curr1' and currency2 = '$curr2'
