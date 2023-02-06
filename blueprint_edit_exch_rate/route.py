import os.path

from flask import Blueprint, request, render_template, current_app

from access import login_required, group_required
from db_work import select_dict, select, update
from sql_provider import SQLProvider


blueprint_edit_exch_rate = Blueprint('bp_edit_exch_rate', __name__, template_folder='templates')
provider = SQLProvider(os.path.join(os.path.dirname(__file__), 'sql'))

@blueprint_edit_exch_rate.route('/', methods=['GET'])
@group_required
def start_edit():
    _sql = provider.get('get_currency1.sql')
    curr_list1 = select(current_app.config['db_config'], _sql)[0]
    _sql = provider.get('get_currency2.sql')
    curr_list2 = select(current_app.config['db_config'], _sql)[0]
    return render_template('curr_choice.html', curr_list1=curr_list1, curr_list2=curr_list2)


@blueprint_edit_exch_rate.route('/', methods=['POST'])
@group_required
def edit_rate():
    action = request.form.get('action')
    curr1 = request.form.get('input_curr1')
    curr2 = request.form.get('input_curr2')
    _sql = provider.get('get_currency1.sql')
    curr_list1 = select(current_app.config['db_config'], _sql)[0]
    _sql = provider.get('get_currency2.sql')
    curr_list2 = select(current_app.config['db_config'], _sql)[0]
    if curr1 and curr2 and action:
        if action == 'edit_trade':
            _sql = provider.get('get_exch_rates.sql', in_curr1=curr1, in_curr2=curr2)
            rate = select_dict(current_app.config['db_config'], _sql)[0]
            print(rate)
            return render_template('edit_rate.html', rate=rate)
        if action == 'updated_trade':
            new_rate = request.form.get('new_rate')
            if new_rate:
                _sql = provider.get('update_rate.sql', curr1=curr1, curr2=curr2, new_rate=new_rate)
                update(current_app.config['db_config'], _sql)
                print(_sql)
                return render_template('curr_choice.html', curr_list1=curr_list1, curr_list2=curr_list2,
                                       message=f"Обменный курс из {curr1} в {curr2} теперь {new_rate}.")
            else:
                return render_template('curr_choice.html', curr_list1=curr_list1, curr_list2=curr_list2,
                                       message=f"Ошибка ввода")
    else:
        return "Повторите ввод"

# @blueprint_edit.route('/insert_prod', methods=['POST'])
# def insert_prod():
#     message = 'Product has been inserted in data base'
#     return render_template('update_ok.html', message = message)