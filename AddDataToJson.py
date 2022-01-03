import json

Tag = input("Enter Title of your new input :")
print(Tag)
input_pattern = input('Enter Patterns of a list separated by star * ')
Pattern_list = input_pattern.split('*')
# print Pattern list
print('list: ', Pattern_list)
input_response = input('Enter Responses of a list separated by star * ')
Response_list = input_response.split('*')
# print Responses list
print("Responses: ", Response_list)


# passing the data to be enterered and filepath
def write_json(data, filename='intents.json'):
    # here we are opening the file for writing
    with open(filename, "w") as f:
        json.dump(data, f, indent=4)


with open("intents.json") as json_file:
    data = json.load(json_file)
    # specify the data part which will be added in it
    temp = data["intents"]
    # pass the title , pattern and responses
    y = {"tag": Tag, "patters": Pattern_list, "responses": Response_list}
    # append the y that is holding the data
    temp.append(y)
write_json(data)
