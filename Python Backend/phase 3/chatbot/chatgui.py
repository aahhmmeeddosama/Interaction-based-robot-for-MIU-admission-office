import nltk
from nltk.stem import WordNetLemmatizer

lemmatizer = WordNetLemmatizer()
import pickle
import numpy as np
from keras.models import load_model
import json
import random
import os
import jsonify

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


@app.route('/bot', methods=['GET', 'POST'])
# To restore the sentence location  by empty
def chatbot():
    sentence = str(request.args['message'])

    def clean_up_sentence(sentence):
        sentence_words = nltk.word_tokenize(sentence)
        sentence_words = [lemmatizer.lemmatize(word.lower()) for word in sentence_words]
        return sentence_words

    def clean_up_sentence_en(sentence):
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
        return res

    def chatbot_response(msg):
        ints = predict_class(msg, model)
        res = getResponse(ints, intents)
        return res

    import arabic_reshaper
    import sys
    received = sentence
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
        a = result.encode('utf-8')
        #d['message'] = [t.encode('utf-8') for t in res]
        return a
    else:
        res = chatbot_response_en(msg)
        d['message'] = res
        return res


if __name__ == '__main__':
    app.run(host='192.168.96.87', port=5000)