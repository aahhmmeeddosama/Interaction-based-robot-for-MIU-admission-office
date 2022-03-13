import os
from datetime import datetime
import cv2 as cv
import werkzeug
from keras.models import load_model
from keras.preprocessing.image import img_to_array
from flask import Flask, request
import numpy as np


id = 0
label="non"


recognizer = cv.face_LBPHFaceRecognizer.create()
recognizer.read('trainer/face-trainner.yml')
cascadePath = "haarcascade_frontalface_default.xml"
emotion_classifier = load_model('Emotion_Detection.h5')
faceCascade = cv.CascadeClassifier(cascadePath)

# names related to ids: example ==> Marcelo: id=1,  etc
names = ['None', 'Ahmed','Ahmed', 'Ahmed','ismail' , 'seif']
emotion_labels = ['Angry', 'Happy', 'Neutral', 'Sad', 'Surprise']

faceProto = "opencv_face_detector.pbtxt"
faceModel = "opencv_face_detector_uint8.pb"
faceNet = cv.dnn.readNet(faceModel, faceProto)


def getFaceBox(net,img, conf_threshold=0.7):
    frameHeight = img.shape[0]
    frameWidth = img.shape[1]
    blob = cv.dnn.blobFromImage(img, 1.0, (300, 300), [104, 117, 123], True, False)

    net.setInput(blob)
    detections = net.forward()
    bboxes = []
    for i in range(detections.shape[2]):
        confidence = detections[0, 0, i, 2]
        if confidence > conf_threshold:
            x1 = int(detections[0, 0, i, 3] * frameWidth)
            y1 = int(detections[0, 0, i, 4] * frameHeight)
            x2 = int(detections[0, 0, i, 5] * frameWidth)
            y2 = int(detections[0, 0, i, 6] * frameHeight)
            bboxes.append([x1, y1, x2, y2])
    return bboxes






app = Flask(__name__)

@app.route('/emotion', methods=['POST','GET'])
def emotion():

    if (request.method=="POST"):
        imagefile=request.files['image']
        filename= werkzeug.utils.secure_filename(str(datetime.now())+imagefile.filename)
        imagefile.save("./ss/"+filename)
        img = cv.imread("./ss/"+filename)
        gray = cv.cvtColor(img, cv.COLOR_BGR2GRAY)
        faces = faceCascade.detectMultiScale(gray, scaleFactor=1.2, minNeighbors=1)

    box = getFaceBox(faceNet, img)
    if not box:
        return "No face Detected"
    else:
        for (x, y, w, h) in faces:
            roi_gray = gray[y:y + h, x:x + w]
            roi_gray = cv.resize(roi_gray, (48, 48), interpolation=cv.INTER_AREA)
            roi = roi_gray.astype('float') / 255.0
            roi = img_to_array(roi)
            roi = np.expand_dims(roi, axis=0)
            preds = emotion_classifier.predict(roi)[0]
            label = emotion_labels[preds.argmax()]
            return label


@app.route('/reco', methods=['POST','GET'])
def reco():
    if (request.method=="POST"):
        imagefile=request.files['image']
        filename= werkzeug.utils.secure_filename(str(datetime.now())+imagefile.filename)
        imagefile.save("./ss/"+filename)
        img = cv.imread("./ss/"+filename)
        gray = cv.cvtColor(img, cv.COLOR_BGR2GRAY)
        faces = faceCascade.detectMultiScale(img, scaleFactor=1.3, minNeighbors=1)

    box = getFaceBox(faceNet, img)
    if not box:
        return "No face Detected"
    else:
        global id
        for (x, y, w, h) in faces:
            id, confidence = recognizer.predict(gray[y:y + h, x:x + w])
            # Check if confidence is less them 100 ==> "100" is perfect match
            if (confidence < 70):
                id = names[id]
            else:
                id = "unknown"
        if (id == 0):
            id = "no one"

        return id


if __name__ == '__main__':
    app.run(host='192.168.96.87', port=8003)