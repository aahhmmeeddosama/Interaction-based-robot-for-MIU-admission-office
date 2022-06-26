import nltk
import pickle
import numpy as np
import json
import random
import os
import comment as comm
import arabic_reshaper
from keras.models import load_model
from nltk.stem import WordNetLemmatizer
from langdetect import detect
from flask import Flask, request

lemmatizer = WordNetLemmatizer()
model = load_model('chatbot_model.h5')
model_en = load_model('chatbot_model_en.h5')

arabic_dataset_intents = json.loads(open('arabic dataset.json', encoding="utf-8").read())
arabic_words = pickle.load(open('words.pkl', 'rb'))
arabic_classes = pickle.load(open('classes.pkl', 'rb'))

english_dataset_intents = json.loads(open('intents.json').read())
english_words = pickle.load(open('words_en.pkl', 'rb'))
english_classes = pickle.load(open('classes_en.pkl', 'rb'))

app = Flask(__name__)


@app.route('/bot', methods=['GET', 'POST'])

# To restore the sentence location  by empty
def chatbot():
    user_message = str(request.args['message'])
    def clean_up_sentence_ar(user_message):
        sentence_words = nltk.word_tokenize(user_message)
        sentence_words = [lemmatizer.lemmatize(word_en.lower()) for word_en in sentence_words]
        return sentence_words
    def clean_up_sentence(user_message):
        sentence_words = nltk.word_tokenize(user_message)
        sentence_words = [lemmatizer.lemmatize(word_en.lower()) for word_en in sentence_words]
        return sentence_words


        # stem each word - create short form for word

    # return bag of words array: 0 or 1 for each word in the bag that exists in the sentence
    def bow_en(user_message, english_words, show_details=True):
        sentence_words = clean_up_sentence(user_message)
        # bag of words - matrix of N words, vocabulary matrix
        bag_for_words = [0] * len(english_words)
        for every_word_in_sentence_list in sentence_words:
            for iterator, single_word in enumerate(english_words):
                if single_word == every_word_in_sentence_list:
                    # assign 1 if current word is in the vocabulary position
                    bag_for_words[iterator] = 1
                    if show_details:
                        print("found in bag: %s" % single_word)
        return np.array(bag_for_words)

    def bow_ar(user_message, arabic_words, show_details=True):
        sentence_words = clean_up_sentence_ar(user_message)
        # bag of words - matrix of N words, vocabulary matrix
        bag_for_words = [0] * len(arabic_words)
        for every_word_in_sentence_list in sentence_words:
            for iterator, single_word in enumerate(arabic_words):
                if single_word == every_word_in_sentence_list:
                    # assign 1 if current word is in the vocabulary position
                    bag_for_words[iterator] = 1
                    if show_details:
                        print("found in bag: %s" % single_word)
        return np.array(bag_for_words)

    def predict_class_ar(sentence, model):  # ******
        # filter out predictions below a threshold
        prediction_filtration = bow_ar(sentence, arabic_words, show_details=False)
        result = model.predict(np.array([prediction_filtration]))[0]
        error_threshold = 0.25
        results = [[i, r] for i, r in enumerate(result) if r > error_threshold]
        # sort by strength of probability
        results.sort(key=lambda x: x[1], reverse=True)
        return_list = []
        for iterator in results:
            return_list.append({"intent": arabic_classes[iterator[0]], "probability": str(iterator[1])})
        return return_list

    def predict_class_en(user_message, model_en):  # ******
        prediction_filtration = bow_en(user_message, english_words, show_details=False)
        result = model_en.predict(np.array([prediction_filtration]))[0]
        error_threshold = 0.25
        results = [[i, r] for i, r in enumerate(result) if r > error_threshold]
        # sort by strength of probability
        results.sort(key=lambda x: x[1], reverse=True)
        return_list = []
        for iterator in results:
            return_list.append({"intent": english_classes[iterator[0]], "probability": str(iterator[1])})
        return return_list

    def getResponse_ar(ints, intents_json):
        tag = ints[0]['intent']
        list_of_intents = intents_json['intents']
        for i in list_of_intents:
            if i['tag'] == tag:
                result = random.choice(i['responses'])
                break
        return result

    def getResponse_en(ints, intents_json):
        tag = ints[0]['intent']
        list_of_intents = intents_json['intents']
        for i in list_of_intents:
            if i['tag'] == tag:
                result = random.choice(i['responses'])
                break
        return result

    def chatbot_response_en(msg):
        ints = predict_class_en(msg, model_en)
        response_result = getResponse_en(ints, english_dataset_intents)
        return response_result

    def chatbot_response_ar(msg):
        ints = predict_class_ar(msg, model)
        response_result = getResponse_ar(ints, arabic_dataset_intents)
        return response_result

    received_message_from_user = user_message
    user_message_language = detect(received_message_from_user)
    copy_of_user_msg = received_message_from_user
    print("User message language: ", user_message_language)
    # Make some reshaping in case of message entered was arabic
    if user_message_language == 'ar':
        reshaped_arabic_message = arabic_reshaper.reshape(copy_of_user_msg)
        received_message_reshaped = reshaped_arabic_message[::-1]
        result_of_reshaping_msg = received_message_reshaped
        print('you:' + result_of_reshaping_msg)
    else:
        print('you:' + copy_of_user_msg)
    # Pass the message to the chatbot response for the arabic language and get the responses
    if user_message_language == 'ar':
        response_on_user_message_ar = chatbot_response_ar(copy_of_user_msg)
        return response_on_user_message_ar + '+ar'
    # Pass the message to the chatbot response for the english language and get the responses
    else:
        response_on_user_message_en = chatbot_response_en(copy_of_user_msg)
        return response_on_user_message_en + ' +en'


if __name__ == '__main__':
    port = int(os.environ.get("PORT", 8000))
    app.run(debug=True)
