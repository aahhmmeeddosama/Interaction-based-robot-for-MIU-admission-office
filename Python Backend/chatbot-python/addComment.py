from flask import Flask,request
import time

app = Flask(__name__)

@app.route('/bot', methods=['GET','POST'])
def comment():
    local_time = time.ctime()
    name = str(request.args['name'])
    comment = str(request.args['comment'])
    timetaken = local_time.replace(':','_')
    file_name = name+' '+timetaken
    file1 = open('applicant comments/'+ file_name+'.txt', 'w')
    file1.write(comment + '\n Edited at' + local_time)
    file1.close()
    return comment

if __name__ == '__main__':
    app.run(host='192.168.1.6', port=8002)
