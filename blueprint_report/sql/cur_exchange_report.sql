select currency1, currency2, sum_cur2_to_cur1, sum_cur1_to_cur2 from curr_exchange_report
where currency1 = '$in_currency' and rep_year = '$in_year' and rep_month = '$in_month';