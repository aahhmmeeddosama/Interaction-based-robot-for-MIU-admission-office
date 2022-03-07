import json
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
#delete a set
for intent in intents['intents']:
    del intent['patterns']
#new_string=json.dumps(intents,indent=4)
#print(new_string)
"""
with open('intents.json') as f:
    data=json.load(f)
for intent in data['intents']:
    del intent['response']

with open('nn.json','w')as f:
    json.dump(data,f,indent=4)
"""
def view_data():
    with open('intents.json',"r") as f:
        temp=json.load(f)
        i=0
        for entry in temp['intents']:
            tag=entry['tag']
            pattern=entry['patterns']
            response=entry['responses']
            print('index:',i)
            print(tag)
            print(pattern)
            print(response)
            i=i+1
#view_data()
def add_data():
    item={}
    with open('intents.json','r') as f:
        temp=json.load(f)
        a=temp["intents"]
    item['tag']=input("tag ")
    item['pattern']=input('pattern ')
    item['response']=input('response ')
    a.append(item)

    with open('intents.json','w')as f:
        json.dump({'intents':temp},f,indent=4)
#add_data()
"""
Tag = input("Enter Title of your new input :")
input_pattern = input('Enter Patterns of a list separated by star * ')
Pattern_list = input_pattern.split('*')
input_response = input('Enter Responses of a list separated by star * ')
Response_list = input_response.split('*')


with open("intents.json") as json_file:
    data = json.load(json_file)
    # specify the data part which will be added in it
    temp = data["intents"]
    # pass the title , pattern and responses
    y = {"tag": Tag, "patters": Pattern_list, "responses": Response_list}
    # append the y that is holding the data
    temp.append(y)

with open('intents.json','w')as f:
    json.dump(a,f,indent=4)

"""
def delete_data():
    view_data()
    new_data=[]
    with open('intents.json')as f:
        temp=json.load(f)
        data_length=len(temp['intents'])-1
    delete_option=input('index to be deleted: ')
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
        json.dump({'intents':data}, f, indent=4)
#delete_data()
def edit_data():
    view_data()
    new_data=[]
    with open('intents.json')as f:
        temp=json.load(f)
        data_length=len(temp['intents'])-1
    edit_option=input('index to be edited: ')
    if int(edit_option) > data_length:
        print('You should enter number from 0 to '+ str(data_length))
        edit_option = input('index to be edited: ')
    i=0
    for entry in temp['intents']:
        if i == int(edit_option):
            tag=entry['tag']
            tag=input('tag new name')
            if tag=='no':
                tag=entry['tag']
            pattern=entry['patterns']

            response=entry['responses']
            pattern=input('pattern')
            if pattern=='no':
                pattern=entry['patterns']
                Pattern_list = pattern
            else:
                Pattern_list = pattern.split('*')
            response = input('response')
            if response == 'no':
                response = entry['responses']
                response_list = response
            else:
                response_list = response.split('*')
            new_data.append({'tag': tag,'patterns':Pattern_list,'response':response_list})
            i=i+1
        else:
            new_data.append(entry)
            i=i+1
    data={}
    data=new_data
    with open('intents.json', 'w')as f:
        json.dump({'intents':data}, f, indent=4)
edit_data()
"""
def write_json(data):
    with open("intents.json", "w") as f:
        f.write(json.dumps(data,indent=4))

with open('intents.json') as json_file:
    data = json.loads(data_file)
    temp = data["intents"]
    for intent in intents['intents']:
        for tag in intent['tag']:
            if intent['tag'] == 'greeting':
                intent['tag'] = 'greet'
        # pass the title , pattern and respon
            for pattern in intent["patterns"]:
                if pattern == 'Hi there':
                    pattern = 'hi ther'
                #m=pattern
                prev=intent['tag']
                if intent['tag']!=intent['tag'][0]:
                    if pattern not in pp:
                        pp.append(pattern)
        temp.append({'tag': intent['tag'], 'patterns': pp, 'response': [""]})
        #y={"intents":[{'tag':intent['tag'],'patterns':pp,'response':[" "]}]}
        y=temp
        #temp.append(y)
        write_json({"intents":y})       # append the y that is holding the data
print(y)
"""



"""
with open('intents.json') as json_file:
    data = json.load(json_file)
    # specify the data part which will be added in it
    temp = data["intents"]
    for intent in data['intents']:
        for pattern in intent["patterns"]:
            if pattern == 'Hi there':
                pattern = 'hi ther'
            for tag in intent['tag']:
                if intent['tag'] == 'greeting':
                    intent['tag'] = 'greet'
            # pass the title , pattern and responses
        z.append({"tag": intent['tag'], "patterns": [pattern]})
            # append the y that is holding the data
    temp.append(z)
write_json(data)
"""

#open("intents.json", "w").write(json.dumps(z, indent=4))
#aa=classes.index('Hi there')
#classes.pop(aa)
#print(classes)

#!/usr/bin/python

# Load the JSON module and use it to load your JSON file.
# I'm assuming that the JSON file contains a list of objects.

"""
# Iterate through the objects in the JSON and pop (remove)
# the obj once we find it.
for intent in intents['intents']:
    for pattern in intent['patterns']:
        for i in intent["tag"]:
            if data_file[i]["tag"] == "greeting":
                data_file.pop(i)
                break

# Output the updated file with pretty JSON
open("updated-file.json", "w").write(
    json.dumps(data_file, sort_keys=True, indent=4, separators=(',', ': '))
)
"""
