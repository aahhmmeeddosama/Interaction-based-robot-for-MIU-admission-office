import json
import os
#Reading the Json file to check if the questions are properly loaded
data_file = open('intents.json').read()
intents = json.loads(data_file)
classes=[]
pp=[]
ee=[]
y={}
m=[]
z=[]
a=[]
"""
with open('intents.json') as f:
    data=json.load(f)
for intent in data['intents']:
    del intent['context']

with open('nn.json','w')as f:
    json.dump(data,f,indent=4)
"""
from flask import Flask,request,redirect,url_for,render_template

aa = {}
app = Flask(__name__)
c={}

@app.route('/bot/view', methods=['GET'])
def view_data():

    with open('intents.json',"r") as f:
        temp=json.load(f)
        i = 0
        bb=[]
        zz=[]
        gg=[]
        for entry in temp['intents']:
            tag = entry["tag"]
            pattern = entry["patterns"]
            re=entry["responses"]

            #print(i)
            #print(tag)
            #print(pattern)
            #print(re)
            qq={'index':i,'tag':tag,'pattern':pattern,'responses':re}
            i=i+1
            zz.append(qq)
        aa={'intents':zz}
    return aa

#view_data()
@app.route('/add',methods=['GET'])
#http://127.0.0.1:5000/add?tag=ppp&patterns=kk&responses=jhjkaaa*cc
def add_data():
    item={}
    with open('intents.json','r') as f:
        temp=json.load(f)
        a=temp["intents"]
    item['tag']=str(request.args['tag'])
    item['patterns']=str(request.args['patterns'])
    Pattern_list = item['patterns'].split('*')
    item['patterns']=Pattern_list
    item['responses'] = str(request.args['responses'])
    Response_list = item['responses'].split('*')
    item['responses']=Response_list
    a.append(item)

    with open('intents.json','w')as f:
        json.dump({'intents':a},f,indent=4)
    return view_data()
#add_data()
#http://127.0.0.1:5000/bot?delete=0
@app.route('/bot',methods=['GET'])
def delete_data():
    view_data()
    new_data=[]
    with open('intents.json')as f:
        temp=json.load(f)
        data_length=len(temp['intents'])-1
    delete_option=int(request.args['delete'])
    i=0
    for entry in temp['intents']:
        if i == int(delete_option):
            pass
            i=i+1
        else:
            new_data.append(entry)
            i=i+1
    data={}
    data=new_data

    with open('intents.json', 'w')as f:
        json.dump({'intents': data}, f, indent=4)
    return view_data()
#delete_data()
@app.route('/edit',methods=['GET'])
#http://127.0.0.1:5000/edit?edit=0&tag=ppp&pattern=kk&response=jhjk&context=kllkj
def edit_data():
    view_data()
    new_data=[]
    with open('intents.json')as f:
        temp=json.load(f)
        data_length=len(temp['intents'])-1
    edit_option=int(request.args['edit'])
    if int(edit_option) > data_length:
        print('You should enter number from 0 to '+ str(data_length))
        edit_option = int(request.args['edit'])
    i=0
    for entry in temp['intents']:
        if i == int(edit_option):
            tag=entry['tag']
            tag=str(request.args['tag'])
            if tag=='no':
                tag=entry['tag']

            pattern=str(request.args['pattern'])
            if pattern=='no':
                pattern=entry['patterns']
                Pattern_list = pattern
            else:
                Pattern_list = pattern.split('*')
            response=str(request.args['response'])
            if response=='no':
                response=entry['responses']
                response_list = response
            else:
                response_list = response.split('*')
            context=str(request.args['context'])
            new_data.append({'tag':tag,'patterns':Pattern_list,'responses':response_list,'context':context})
            i=i+1
        else:
            new_data.append(entry)
            i=i+1
    data={}
    data=new_data
    with open('intents.json', 'w')as f:
        json.dump({'intents':data}, f, indent=4)
    return view_data()
#edit_data()


if __name__ == '__main__':
    app.run(host='192.168.1.6', port=8002)
