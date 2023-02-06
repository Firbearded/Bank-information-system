select old_balance, new_balance, datetime_of_new_balance, reason
from account_history where id_a=(select id_a from bank_account where number = '$input_number')