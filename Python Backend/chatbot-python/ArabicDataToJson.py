import json
import os
#import train_chatbot_Copy as training
from flask import Flask,request

aa = {}
app = Flask(__name__)
c={}

@app.route('/bot/view', methods=['GET'])
def view_data():
    represent=[]
    with open('arabic intents.json',encoding='utf-8')as f:
        temp=json.load(f)
        i=0
        for entry in temp['intents']:
            tag=entry['tag']
            pattern=entry['patterns']
            response=entry['responses']
            data={'index':i,'tag':tag,'Patterns':pattern,'Responses':response}
            i=i+1
            represent.append(data)
        final_output={'intents':represent}
        return final_output
#view_data()
@app.route('/add',methods=['GET','POST'])
def add_data():
    item={}
    with open('arabic intents.json',encoding='utf-8')as f:
        temp=json.load(f)
        a=temp["intents"]
    item['tag']=str(request.args['tag'])
    item['patterns']=str(request.args['patterns'])
    Pattern_list = item['patterns'].split('*')
    item['patterns'] = Pattern_list
    item['responses']=str(request.args['responses'])
    Response_list = item['responses'].split('*')
    item['responses'] = Response_list
    a.append(item)

    with open("arabic intents.json", "w", encoding='utf-8')as f:
        json.dump(temp,f,indent=4,ensure_ascii = False)
    #training.a()
    return view_data()
#add_data()
@app.route('/bot',methods=['GET'])
def delete_data():
    new_data=[]
    with open('arabic intents.json',encoding='utf-8')as f:
        temp=json.load(f)
        data_length=len(temp['intents'])-1
    delete_option=int(request.args['delete'])
    if int(delete_option) > int(data_length):
        print('You should enter number from 0 to '+ int(data_length))
        delete_option = input('index to be edited: ')
    i=0
    for entry in temp['intents']:
        if i == int(delete_option):
            pass
            i=i+1
        else:
            new_data.append(entry)
            i=i+1
    data=new_data
    with open("arabic intents.json", "w", encoding='utf-8')as f:
        json.dump({"intents":data}, f, indent=4,ensure_ascii = False)
    return view_data()
#delete_data()
@app.route('/edit',methods=['GET'])
def edit_data():
    new_data=[]
    with open('arabic intents.json',encoding='utf-8')as f:
        temp=json.load(f)
        data_length=len(temp['intents'])-1
    edit_option=int(request.args['edit'])
    if int(edit_option) > int(data_length):
        print('You should enter number from 0 to '+ str(data_length))
        edit_option = int(request.args['edit'])
    i=0
    for entry in temp['intents']:
        if i == int(edit_option):
            tag=str(request.args['tag'])
            if tag=='لا':
                tag=entry['tag']
            pattern=str(request.args['pattern'])
            if pattern=='لا':
                pattern=entry['patterns']
                Pattern_list = pattern
            else:
                Pattern_list = pattern.split('*')
            response = str(request.args['response'])
            if response == 'لا':
                response = entry['responses']
                response_list = response
            else:
                response_list = response.split('*')
            new_data.append({'tag': tag,'patterns':Pattern_list,'responses':response_list})
            i=i+1
        else:
            new_data.append(entry)
            i=i+1
    data=new_data
    with open("arabic intents.json", "w", encoding='utf-8')as f:
        json.dump({"intents":data}, f, indent=4,ensure_ascii = False)
    return view_data()
#edit_data()
if __name__ == '__main__':
    app.run(host='192.168.1.19', port=8005)
#http://127.0.0.1:5000/bot?delete=0
#http://127.0.0.1:5000/add?tag=شa