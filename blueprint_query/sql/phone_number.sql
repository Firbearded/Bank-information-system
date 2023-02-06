select surname, name, second_name, date_of_birth, address, phone_numb, date_of_deal, end_of_deal from client
where phone_numb >= $input_number1 and phone_numb <= $input_number2