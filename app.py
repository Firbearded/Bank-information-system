import json

from flask import Flask, render_template, redirect, session, url_for, request
from auth.route import blueprint_auth
from blueprint_edit_exch_rate.route import blueprint_edit_exch_rate
from blueprint_query.route import blueprint_query
from client_accounts.route import blueprint_accounts
from blueprint_report.route import blueprint_report


app = Flask(__name__)
app.secret_key = 'SuperKey'

app.register_blueprint(blueprint_auth, url_prefix='/auth')
app.register_blueprint(blueprint_report, url_prefix='/report')
app.register_blueprint(blueprint_query, url_prefix='/queries')
app.register_blueprint(blueprint_accounts, url_prefix='/accounts')
app.register_blueprint(blueprint_edit_exch_rate, url_prefix='/edit_rates')

app.config['db_config'] = json.load(open('data_files/dbconfig.json'))
app.config['access_config'] = json.load(open('data_files/access.json'))
action_list = json.load(open('data_files/action_list.json', 'r', encoding='utf-8'))
action_url = json.load(open('data_files/action_url.json', 'r', encoding='utf-8'))


@app.route('/', methods=['GET', 'POST'])
def menu_choice():
    if 'user_id' in session:
        if request.method == 'GET':
            print(action_list[session.get('user_group')])
            return render_template('user_menu.html', action_list=action_list[session.get('user_group')],
                                   action_url=action_url)
        else:
            url = request.form.get('url')
            return redirect(url_for(url))
    else:
        return redirect(url_for('blueprint_auth.start_auth'))


@app.route('/exit')
def exit_func():
    if 'user_id' in session:
        session.clear()
    return render_template('exit.html')


if __name__ == '__main__':
    app.run(host='127.0.0.1', port=5001)

# Чем доступ внутр. отличается от внешних?
# Все внутренние - сотрудники компании
# Доступ регламентируется ролями
# По логину и паролю опредееляется роль
# Для внутреннего важна роль - все права доступа к обработчикам определена роль
# Это концепция внутренних пользователей - через роль
# Внешние пользователи могут достать только те записи, которые относятся к его ID
# Это концепция внешних пользовательей - через ID