select deposit, withdrawal, overall_account_sum from money_report
where rep_year = '$in_year' and rep_month = '$in_month';