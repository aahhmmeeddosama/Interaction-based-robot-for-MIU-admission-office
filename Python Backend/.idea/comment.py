import time
import os
from flask import Flask, request

app = Flask(__name__)

#http://127.0.0.1:5000/applicant_comment?name=Seif&comment=testing
@app.route('/applicant_comment', methods=['GET', 'POST'])
def applicant_comment():
    # take the time including date and current time
    local_time = time.ctime()
    user_name = str(request.args['name'])
    user_input = str(request.args['comment'])
    replace_special_character_in_time_taken = local_time.replace(':', '_')
    file_name = user_name + ' ' + replace_special_character_in_time_taken
    file_open = open('applicant comments/' + file_name + '.txt', 'w')
    file_open.write(user_input + '\n Edited at' + local_time)
    file_open.close()
    return user_input


if __name__ == '__main__':
    port = int(os.environ.get("PORT", 5000))
    app.run(debug=True)
