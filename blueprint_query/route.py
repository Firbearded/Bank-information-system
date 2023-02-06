import json
import os  # работа с объектами операционной системы

from flask import Blueprint, request, render_template, current_app, url_for, \
    redirect  # глобальная переменная с конфигом app
from db_work import select
from sql_provider import SQLProvider
from access import login_required, group_required


blueprint_query = Blueprint('bp_query', __name__, template_folder='templates')  # создание blueprint'а

provider = SQLProvider(os.path.join(os.path.dirname(__file__), 'sql'))  # создание словаря для текущего blueprint'а

query_list = json.load(open('blueprint_query/data_files/query_list.json', 'r', encoding='utf-8'))
query_url = json.load(open('blueprint_query/data_files/query_url.json', 'r', encoding='utf-8'))


def search_failed():
    return "Ошибка ввода"


@blueprint_query.route('/queries', methods=['GET', 'POST'])
@group_required
def queries():
    if request.method == 'GET':
        return render_template('menu_requests.html', query_list=query_list)
    else:
        query_id = request.form.get('query_id')
        url_query = query_url[query_id]
        print(url_query)
        return redirect(url_for(url_query))


@blueprint_query.route('/query1', methods=['GET', 'POST'])
@group_required
def query1():
    if request.method == 'GET':
        return render_template('begin_of_deal_form.html')
    else:
        input_date1 = request.form.get('input_date1')
        input_date2 = request.form.get('input_date2')
        if input_date1 and input_date2:
            _sql = provider.get('begin_of_deal.sql', input_date1=input_date1, input_date2=input_date2)
            # print(_sql)
            account_result, schema = select(current_app.config['db_config'], _sql)
            schema = ['Фамилия', 'Имя', 'Отчество', 'Дата рождения', 'Адрес', 'Телефонный номер',
                      'Дата заключения контракта', 'Дата расторжения контракта']
            return render_template('db_result.html', schema=schema, result=account_result,
                                   result_title=f'Количество клиентов, заключивших договор с {input_date1} до {input_date2}')
        else:
            return search_failed()


@blueprint_query.route('/query2', methods=['GET', 'POST'])
@group_required
def query2():
    if request.method == 'GET':
        return render_template('bank_accounts_form.html')
    else:
        surname = request.form.get('input_surname')
        name = request.form.get('input_name')
        second_name = request.form.get('input_second_name')
        if name and surname and second_name:
            _sql = provider.get('bank_accounts.sql', input_surname=surname, input_name=name,
                                input_second_name= f'= \'{second_name}\'')
            account_result, schema = select(current_app.config['db_config'], _sql)
            schema = ['Номер счета', 'Баланс счета', 'Валюта счета', 'Дата последнего изменения баланса']
            #if not account_result:
            #    return search_failed()
            return render_template('db_result.html', schema=schema, result=account_result,
                                   result_title=f'Счета клиента {name} {surname} {second_name}')
        elif name and surname:
            _sql = provider.get('bank_accounts.sql', input_surname=surname, input_name=name,
                                input_second_name='is Null')
            account_result, schema = select(current_app.config['db_config'], _sql)
            schema = ['Номер счета', 'Баланс счета', 'Валюта счета', 'Дата последнего изменения баланса']
            return render_template('db_result.html', schema=schema, result=account_result,
                                   result_title=f'Счета клиента {name} {surname}')
        else:
            return search_failed()


@blueprint_query.route('/query3', methods=['GET', 'POST'])
@group_required
def query3():
    if request.method == 'GET':
        return render_template('end_of_deal_form.html')
    else:
        input_date1 = request.form.get('input_date1')
        input_date2 = request.form.get('input_date2')
        if input_date1 and input_date2:
            _sql = provider.get('end_of_deal.sql', input_date1=input_date1, input_date2=input_date2)
            # print(_sql)
            account_result, schema = select(current_app.config['db_config'], _sql)
            schema = ['Фамилия', 'Имя', 'Отчество', 'Дата рождения', 'Адрес', 'Телефонный номер',
                      'Дата заключения контракта', 'Дата расторжения контракта']
            return render_template('db_result.html', schema=schema, result=account_result,
                                   result_title=f'Информация о клиентах, расторгнувших контракт с {input_date1} до {input_date2}')
        else:
            return search_failed()


@blueprint_query.route('/query4', methods=['GET', 'POST'])
@group_required
def query4():
    if request.method == 'GET':
        return render_template('phone_number_form.html')
    else:
        input_number1 = request.form.get('input_date1')
        input_number2 = request.form.get('input_date2')
        if input_number1 and input_number2:
            _sql = provider.get('phone_number.sql', input_number1=input_number1, input_number2=input_number2)
            account_result, schema = select(current_app.config['db_config'], _sql)
            schema = ['Фамилия', 'Имя', 'Отчество', 'Дата рождения', 'Адрес', 'Телефонный номер',
                      'Дата заключения контракта', 'Дата расторжения контракта']
            return render_template('db_result.html', schema=schema, result=account_result,
                                   result_title=f'Информация о клиентах с номером в диапазоне от {input_number1} до {input_number2}')
        else:
            return search_failed()


@blueprint_query.route('/query5', methods=['GET', 'POST'])
@group_required
def query5():
    if request.method == 'GET':
        return render_template('account_history_form.html')
    else:
        input_account_number = request.form.get('input_account_number')
        if input_account_number:
            _sql = provider.get('account_history.sql', input_account_number=input_account_number)
            account_result, schema = select(current_app.config['db_config'], _sql)
            schema = ['Старый баланс', 'Новый баланс', 'Дата изменения баланса', 'Причина изменения баланса']
            return render_template('db_result.html', schema=schema, result=account_result,
                                   result_title=f'История счета {input_account_number}')
        else:
            return search_failed()
