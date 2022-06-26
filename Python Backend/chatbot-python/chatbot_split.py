from datetime import time, datetime

import nltk
from nltk.stem import WordNetLemmatizer

from chatbot.constants.constants import ip

lemmatizer = WordNetLemmatizer()
import pickle
import numpy as np
from keras.models import load_model
import json
import random
import os
import jsonify

import pyrebase
from firebase_admin import credentials, initialize_app, storage
# Init firebase with your credentials
cred = credentials.Certificate("miu-pepper-robot-d8f39457bf23.json")
initialize_app(cred, {'storageBucket': 'pepper-robot-miu.appspot.com'})

model = load_model('chatbot_model.h5')
model_en = load_model('chatbot_model_en.h5')

intents = json.loads(open('arabic intents.json', encoding="utf8").read())
words = pickle.load(open('words.pkl', 'rb'))
classes = pickle.load(open('classes.pkl', 'rb'))
en_intents = json.loads(open('intents.json').read())
en_words = pickle.load(open('words_en.pkl', 'rb'))
en_classes = pickle.load(open('classes_en.pkl', 'rb'))
from langdetect import detect
from flask import Flask, request

app = Flask(__name__)

def iniate_storedchats():
    #counter of questions to show where i am
    global storedchat_counter
    storedchat_counter = 0

    #counter of saved chat
    global storedchat_number
    storedchat_number = 0

    #current question now
    global storedchat_currentquestion
    storedchat_currentquestion = ""

    #current response now
    global stored_res
    stored_res = ""

    #Save Chat file name that is going to be uploaded
    global uploadfilename
    uploadfilename = ""

    #Logs File
    global Logsfilename
    Logsfilename = "Logs" + ".txt"

    #Downloaded Chat file name that was uploaded before from our firebase
    global selectedfilename
    selectedfilename = ""

    #Chosen Chat file by the user that needs to be download from our firebase
    global filechosen
    filechosen = ""

    #Dictonary where the Q/A are saved in
    global storedchat_Dict
    storedchat_Dict = {}

    #Dictonary where the chats url are saved in
    global chats_url_Dict
    chats_url_Dict = {}

def storedchats(stored_ress):
    #counter specifies in which item am i now
    #then the dictonary takes the current question as a key and the answer as the value
    if (storedchat_currentquestion != "Bye"):
        storedchat_Dict[storedchat_currentquestion] = stored_ress
        global storedchat_counter
        storedchat_counter+=1

def storedfilechats():
    global storedchat_Dict
    now = datetime.now()
    timenow = now.strftime("%d-%m-%Y-%H_%M_%S")
    global uploadfilename
    if receive == 'ar':
        uploadfilename = timenow+"_ar.txt"
    else:
        uploadfilename = timenow + "_en.txt"
    with open(uploadfilename, "w") as outfile:
        for key, value in storedchat_Dict.items():
            outfile.write('%s$#%s\n' % (key, value+"$#"))

#firebase configuratioins
def iniate_firebase():
    config = {
        'apiKey': "AIzaSyBS23_IIgaBzmFBzRczFYlWY2jbCBKrJ9Y",
        'authDomain': "pepper-robot-miu-4a3e5.firebaseapp.com",
        'projectId': "pepper-robot-miu-4a3e5",
        'storageBucket': "pepper-robot-miu-4a3e5.appspot.com",
        'messagingSenderId': "1055558150882",
        'appId': "1:1055558150882:web:2097132973d1f546624cbb",
        'measurementId': "G-7S7YDV6SP5",
        'serviceAccount': "serviceAccount.json", #serviceaccountkey
        'databaseURL': "https://pepper-robot-miu-4a3e5-default-rtdb.firebaseio.com/" #databaseURL
    };
    return config

def uploadchat_firebase():
    config = iniate_firebase()
    firebase = pyrebase.initialize_app(config)
    storage = firebase.storage()
    #upload saved chat file to our firebase
    #first filename that will be saved in our storage
    #then the file itself
    storage.child(uploadfilename).put(uploadfilename)
    #upload updated logs file to our firebase
    storage.child(Logsfilename).put(Logsfilename)

def update_logs_firebase():
    config = iniate_firebase()
    firebase = pyrebase.initialize_app(config)
    storage = firebase.storage()
    #checks if Logsfile exits locally, if it is it will delete it
    if os.path.exists(Logsfilename):
        os.remove(Logsfilename)
    #downloads our logs file from our firebase
    storage.child(Logsfilename).download(Logsfilename, Logsfilename)
    #downloads our logs file from our firebase
    storage.child(Logsfilename).delete(Logsfilename,Logsfilename)
    #updates our logs file
    with open(Logsfilename, "a") as Logfile:
        Logfile.write('\n' + uploadfilename)

#delete files that has been uploaded to our firebase
def destruct_local_files():
    if os.path.exists(Logsfilename):
        os.remove(Logsfilename)
    if os.path.exists(uploadfilename):
        os.remove(uploadfilename)

#reads all file names which are stored in our logs file
#so the admin can choose which file name he wanna view
def selectchat_firebase():
    config = iniate_firebase()
    firebase = pyrebase.initialize_app(config)
    storage = firebase.storage()
    #checks if Logsfile exits locally, if it is it will delete it
    if os.path.exists(Logsfilename):
        os.remove(Logsfilename)
    #downloads our logs file from our firebase
    storage.child(Logsfilename).download(Logsfilename, Logsfilename)
    #reads the logs file
    with open(Logsfilename, "r") as Logfile:
        files_listt = Logfile.readlines()
        files_list = []
        #removes \n from the list
        for i in files_listt:
            files_list.append(i.strip())
    print(files_list)
    print(files_list)
    #returns the list which contains the file names
    return files_list

def readchat_firebase():
    config = iniate_firebase()
    firebase = pyrebase.initialize_app(config)
    storage = firebase.storage()
    #download saved chat file from our firebase
    #first filename that was saved in our storage
    #then the file itself
    selectedfilename = uploadfilename
    downloadfilename = "chat" + selectedfilename
    storage.child(selectedfilename).download(selectedfilename, downloadfilename)

    def each_chunk(stream, separator):
        buffer = ''
        while True:  # until EOF
            chunk = stream.read(4096)  # I propose 4096 or so
            if not chunk:  # EOF?
                yield buffer
                break
            buffer += chunk
            while True:  # until no separator is found
                try:
                    part, buffer = buffer.split(separator, 1)
                except ValueError:
                    break
                else:
                    yield part

    listt = []
    list = []
    with open(selectedfilename, "r") as downloadedfile:
        for chunk in each_chunk(downloadedfile, separator='$#'):
            listt.append(chunk)
        for i in listt:
            list.append(i.strip())
    print(list)

@app.route('/bot', methods=['GET', 'POST'])
# To restore the sentence location  by empty
def chatbot():
    sentence = str(request.args['message'])

    # when the user presses the back button, it automatically ends bye message
    # then it store all of the chat (user's dictonairy) in txt file
    # then it rests the dictonairy
    if (sentence == "Bye"):
        storedfilechats()
        update_logs_firebase()
        uploadchat_firebase()
        # selectchat_firebase()
        readchat_firebase()
        time.sleep(1)
        destruct_local_files()
        # allchats_firebase()
        storedchat_number + 1
        # upload_stored_chat(uploadfilename)
        iniate_storedchats()

    def clean_up_sentence(sentence):
        # current arabic question
        global storedchat_currentquestion
        storedchat_currentquestion = sentence
        sentence_words = nltk.word_tokenize(sentence)
        sentence_words = [lemmatizer.lemmatize(word.lower()) for word in sentence_words]
        return sentence_words

    def clean_up_sentence_en(sentence):
        # current arabic question
        global storedchat_currentquestion
        storedchat_currentquestion = sentence
        sentence_words = nltk.word_tokenize(sentence)
        sentence_words = [lemmatizer.lemmatize(word_en.lower()) for word_en in sentence_words]

        return sentence_words
        # stem each word - create short form for word

    # return bag of words array: 0 or 1 for each word in the bag that exists in the sentence
    def bow_en(sentence, en_words, show_details=True):
        # tokenize the pattern
        sentence_rec = detect(sentence)

        sentence_words = clean_up_sentence_en(sentence)

        # bag of words - matrix of N words, vocabulary matrix
        bag = [0] * len(en_words)
        for s in sentence_words:
            for i, w in enumerate(en_words):
                if w == s:
                    # assign 1 if current word is in the vocabulary position
                    bag[i] = 1
                    if show_details:
                        print("found in bag: %s" % w)
        return (np.array(bag))

    def bow(sentence, words, show_details=True):
        # tokenize the pattern
        sentence_rec = detect(sentence)
        reshaped_text = arabic_reshaper.reshape(sentence_rec)
        sentence_words = clean_up_sentence(sentence)

        # bag of words - matrix of N words, vocabulary matrix
        bag = [0] * len(words)
        for s in sentence_words:
            for i, w in enumerate(words):
                if w == s:
                    # assign 1 if current word is in the vocabulary position
                    bag[i] = 1
                    if show_details:
                        print("found in bag: %s" % w)
        return (np.array(bag))

    def predict_class(sentence, model):  # ******
        # filter out predictions below a threshold

        p = bow(sentence, words, show_details=False)
        res = model.predict(np.array([p]))[0]

        ERROR_THRESHOLD = 0.25
        results = [[i, r] for i, r in enumerate(res) if r > ERROR_THRESHOLD]
        # sort by strength of probability
        results.sort(key=lambda x: x[1], reverse=True)
        return_list = []
        for r in results:
            return_list.append({"intent": classes[r[0]], "probability": str(r[1])})
        return return_list

    def predict_class_en(sentence, model_en):  # ******
        p = bow_en(sentence, en_words, show_details=False)
        res = model_en.predict(np.array([p]))[0]
        ERROR_THRESHOLD = 0.25
        results = [[i, r] for i, r in enumerate(res) if r > ERROR_THRESHOLD]
        # sort by strength of probability
        results.sort(key=lambda x: x[1], reverse=True)
        return_list = []
        for r in results:
            return_list.append({"intent": en_classes[r[0]], "probability": str(r[1])})
        return return_list

    def getResponse(ints, intents_json):
        tag = ints[0]['intent']
        list_of_intents = intents_json['intents']
        for i in list_of_intents:
            if (i['tag'] == tag):
                result = random.choice(i['responses'])
                break
        return result

    def getResponse_en(ints, intents_json):
        tag = ints[0]['intent']
        list_of_intents = intents_json['intents']
        for i in list_of_intents:
            if (i['tag'] == tag):
                result = random.choice(i['responses'])
                break
        return result

    def chatbot_response_en(msg):
        ints = predict_class_en(msg, model_en)
        res = getResponse_en(ints, en_intents)
        for key, value in storedchat_Dict.items():
            print('User:', key, '\nBot:', value)
        return res

    def chatbot_response(msg):
        ints = predict_class(msg, model)
        res = getResponse(ints, intents)
        return res

    import arabic_reshaper
    import sys
    received = sentence
    global receive
    receive = detect(received)
    msg = received
    print(receive)
    if receive == 'ar':
        reshaped_text = arabic_reshaper.reshape(msg)
        rec_text = reshaped_text[::-1]
        result_msg = rec_text
        print('you:' + result_msg)
    else:
        print('you:' + msg)
    print("Source:" + msg)
    trya = detect(msg)
    d = {}
    if trya == 'ar':
        res = chatbot_response(msg)
        result = arabic_reshaper.reshape(res)
        a = result.encode('UTF-8')
        d['message'] = a
        return result+'+ar-SA'
    else:
        res = chatbot_response_en(msg)

        return res+'+en-AU'


if __name__ == '__main__':
    app.run(host=ip, port=5000)
