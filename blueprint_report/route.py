import os.path, json
from flask import Blueprint, request, render_template, current_app, redirect, url_for
from access import login_required, group_required
from db_work import select, call_proc
from sql_provider import SQLProvider

# отчеты - это агрегированные данные, которые сохраняются в базе данных в отдельных таблицах, накапливаются там и постепенно начинают мешать поддерживать процессы

blueprint_report = Blueprint('bp_report', __name__, template_folder='templates')
provider = SQLProvider(os.path.join(os.path.dirname(__file__), 'sql'))

report_list = json.load(open('blueprint_report/data_files/report_list.json', 'r', encoding='utf-8'))
report_url = json.load(open('blueprint_report/data_files/report_url.json', 'r', encoding='utf-8'))


@blueprint_report.route('/', methods=['GET', 'POST'])
@group_required
def start_report():
    if request.method == 'GET':
        return render_template('menu_report.html', report_list=report_list)
    else:
        rep_id = request.form.get('rep_id')
        print('rep_id=', rep_id)
        if request.form.get('create_rep'):
            url_rep = report_url[rep_id]['create_rep']
        else:
            url_rep = report_url[rep_id]['view_rep']
        print('url_rep= ', url_rep)
    return redirect(url_for(url_rep))


@blueprint_report.route('/create_rep1', methods=['GET', 'POST'])
@group_required
def create_rep1():
    if request.method == 'GET':
        return render_template('create_curr_exch_rep.html')
    else:
        rep_date = request.form.get('input_date')
        rep_year, rep_month = rep_date.split('-')
        if rep_year and rep_month:
            _sql = provider.get('check_cur_exchange_rep.sql', in_month=rep_month, in_year=rep_year)

            check = select(current_app.config['db_config'], _sql)[0][0][0]
            print(check)
            if check == 0:
                res = call_proc(current_app.config['db_config'], 'currency_exchange_report', rep_month, rep_year)
                return render_template('report_created.html')
            else:
                return "Отчет уже существует"
        else:
            return "Ошибка ввода"


@blueprint_report.route('/view_rep1', methods=['GET', 'POST'])
@group_required
def view_rep1():
    if request.method == 'GET':
        _sql = provider.get('get_currency.sql')
        curr_list = select(current_app.config['db_config'], _sql)[0]
        print(curr_list)
        return render_template('view_curr_exch_rep.html', curr_list=curr_list)
    else:
        rep_date = request.form.get('input_date')
        rep_year, rep_month = rep_date.split('-')
        currency = request.form.get('input_curr')
        print(rep_year, rep_month)
        if rep_year and rep_month and currency:
            _sql = provider.get('cur_exchange_report.sql', in_year=rep_year, in_month=rep_month, in_currency=currency)
            print(_sql)
            report_result, schema = select(current_app.config['db_config'], _sql)
            schema = ['Рассчетная валюта (значения в ней)', 'Валюта для денежных операций',
                      'Переведено средств из второй валюты в первую',
                      'Вывод средств из первой валюты во вторую']
            return render_template('result_curr_exch_rep.html', schema=schema, result=report_result, in_month=rep_month,
                                   in_year=rep_year, in_currency=currency)
        else:
            return "Ошибка ввода"


@blueprint_report.route('/create_rep2', methods=['GET', 'POST'])
@group_required
def create_rep2():
    if request.method == 'GET':
        return render_template('create_money_report.html')
    else:
        rep_date = request.form.get('input_date')
        rep_year, rep_month = rep_date.split('-')
        if rep_year and rep_month:
            _sql = provider.get('check_money_report.sql', in_month=rep_month, in_year=rep_year)

            check = select(current_app.config['db_config'], _sql)[0][0][0]
            print(check)
            if check == 0:
                res = call_proc(current_app.config['db_config'], 'money_report', rep_month, rep_year)
                return render_template('report_created.html')
            else:
                return "Отчет уже существует"
        else:
            return "Ошибка ввода"


@blueprint_report.route('/view_rep2', methods=['GET', 'POST'])
@group_required
def view_rep2():
    if request.method == 'GET':
        return render_template('view_money_report.html')
    else:
        rep_date = request.form.get('input_date')
        rep_year, rep_month = rep_date.split('-')
        # print(rep_year, rep_month)
        if rep_year and rep_month:
            _sql = provider.get('money_report.sql', in_year=rep_year, in_month=rep_month)
            print(_sql)
            report_result, schema = select(current_app.config['db_config'], _sql)
            schema = ['Суммароно вложено (в рублях)', 'Суммарно снятно (в рублях)',
                      'Всего денег на счетах в банке (в рублях)']
            return render_template('result_money_report.html', schema=schema, result=report_result, in_month=rep_month,
                                   in_year=rep_year)
        else:
            return "Repeat input"
