select count(*) from currency_report
where rep_month = '$in_month' and
       rep_year = '$in_year';