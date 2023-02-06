import os.path
from flask import Blueprint, request, render_template, current_app, session, redirect, url_for

from access import login_required, no_group_required
from db_work import select, select_dict, call_proc, update
from sql_provider import SQLProvider


blueprint_accounts = Blueprint('bp_accounts', __name__, template_folder='templates')

provider = SQLProvider(os.path.join(os.path.dirname(__file__), 'sql'))  # создание словаря для текущего blueprint'а


@blueprint_accounts.route('/', methods=['GET'])
@no_group_required
def all_accounts():
    _sql = provider.get('client_id.sql', get_user_id=session.get('user_id'))
    id_client, schema = select(current_app.config['db_config'], _sql)
    _sql = provider.get('all_accounts.sql', id_client=id_client[0][0])
    accounts = select_dict(current_app.config['db_config'], _sql)
    print(accounts)
    return render_template('all_accounts.html', accounts=accounts)


@blueprint_accounts.route('/', methods=['POST'])
@no_group_required
def account_action():
    action = request.form.get('action')
    number = request.form.get('number')
    currency = request.form.get('currency')
    balance = request.form.get('balance')
    id_c = request.form.get('id_c')

    if action == 'transact':
        if number and currency and balance:
            return render_template('transact_form.html', number=number, balance=balance,
                                   currency=currency)
        else:
            return "Ошибка передачи данных"
    elif action == 'transact_filled':
        number_transact = request.form.get('input_number')
        amount_transact = request.form.get('input_amount')
        if number_transact and amount_transact:
            if len(number_transact) != 12 or not number_transact.isdigit() or number_transact == number or \
                    float(amount_transact) > float(balance) or float(amount_transact) <= 0:
                return render_template('transact_form.html', number=number, balance=balance,
                                       currency=currency, message="Не корректный ввод")
            else:
                _sql = provider.get('transact_check.sql', input_number=number)
                check1 = select(current_app.config['db_config'], _sql)[0][0][0]
                call_proc(current_app.config['db_config'], 'transact', number, number_transact, amount_transact)
                check2 = select(current_app.config['db_config'], _sql)[0][0][0]
                if not check1 == check2:
                    return render_template('transact_form.html', number=number, balance=check2, currency=currency,
                                            message="Перевод совершен успешно")
                else:
                    return render_template('transact_form.html', number=number, balance=balance, currency=currency,
                                           message="Внутренняя ошибка")
        else:
            return render_template('transact_form.html', number=number, balance=balance, currency=currency,
                                   message="Ввод не выполнен")

    elif action == 'history':
        if number and currency:
            _sql = provider.get('account_history.sql', input_number=number)
            # print(_sql)
            account_result, schema = select(current_app.config['db_config'], _sql)
            schema = [f'Старый баланс ({currency})', f'Новый баланс ({currency})', 'Дата и время изменения',
                      'Причина изменения']
            return render_template('account_history.html', schema=schema, result=reversed(account_result), number=number)
        else:
            return "Ошибка передачи данных"

    elif action == 'new':
        _sql = provider.get('get_currency.sql')
        curr_list = select(current_app.config['db_config'], _sql)[0]
        return render_template('new_account_form.html', curr_list=curr_list, id_c=id_c)
    elif action == 'new_filled':
        new_curr = request.form.get('input_curr')
        id_c = request.form.get('id_c')
        if new_curr and id_c:
            _sql = provider.get('get_max_num.sql')
            max_num = select(current_app.config['db_config'], _sql)[0][0][0]
            max_num = str(int(max_num) + 1)
            max_num = '0' * (12 - len(max_num)) + max_num
            _sql = provider.get('new_account.sql', in_id_c=id_c, in_cur=new_curr, in_num=max_num)
            update(current_app.config['db_config'], _sql)
            #call_proc(current_app.config['db_config'], 'new_account', id_c, new_curr, max_num)
            return render_template('account_created.html', in_num=max_num, in_cur=new_curr)
        else:
            return "Ошибка передачи данных"
    else:
        return "Ошибка выбора действия"
