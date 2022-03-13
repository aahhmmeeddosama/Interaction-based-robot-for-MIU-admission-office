from datetime import datetime

import cv2 as cv
import time
import argparse
import os
import werkzeug
from flask import Flask, request

timeout = time.time() + 6  # 5 minutes from now

gender="non"
age=0
#img = cv.imread('girl1.jpg')
parser = argparse.ArgumentParser(description='Use this script to run age and gender recognition using OpenCV.')
parser.add_argument("--device", default="cpu", help="Device to inference on")

faceProto = "opencv_face_detector.pbtxt"
faceModel = "opencv_face_detector_uint8.pb"

ageProto = "age_deploy.prototxt"
ageModel = "age_net.caffemodel"

genderProto = "gender_deploy.prototxt"
genderModel = "gender_net.caffemodel"

MODEL_MEAN_VALUES = (78.4263377603, 87.7689143744, 114.895847746)
ageList = ['(0-2)', '(4-6)', '(8-12)', '(15-20)', '(25-32)', '(38-43)', '(48-53)', '(60-100)']
genderList = ['Male', 'Female']

# Load network
ageNet = cv.dnn.readNet(ageModel, ageProto)
genderNet = cv.dnn.readNet(genderModel, genderProto)
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



@app.route('/age', methods=['POST','GET'])
def age():

    if (request.method=="POST"):
        img=request.files['image']
        filename= werkzeug.utils.secure_filename(str(datetime.now())+img.filename)
        img.save("./ss/"+filename)
        img=cv.imread("./ss/"+filename)

    box = getFaceBox(faceNet, img)
    if not box:
        return "No face Detected"
    else:
        for bbox in box:
            # print(bbox)
            face = img[max(0, bbox[1]):min(bbox[3] , img.shape[0] - 1),
                   max(0, bbox[0]):min(bbox[2], img.shape[1] - 1)]

            blob = cv.dnn.blobFromImage(face, 1.0, (227, 227), MODEL_MEAN_VALUES, swapRB=False)
            ageNet.setInput(blob)
            agePreds = ageNet.forward()
            age = ageList[agePreds[0].argmax()]
            return age





@app.route('/gender', methods=['POST','GET'])
def gender():
    if (request.method=="POST"):
        img=request.files['image']
        filename= werkzeug.utils.secure_filename(str(datetime.now())+img.filename)
        img.save("./ss/"+filename)
        img=cv.imread("./ss/"+filename)

    def getFaceBox(net, conf_threshold=0.7):
        frameOpencvDnn = img.copy()
        os.remove("./ss/"+filename)
        frameHeight = frameOpencvDnn.shape[0]
        frameWidth = frameOpencvDnn.shape[1]
        blob = cv.dnn.blobFromImage(frameOpencvDnn, 1.0, (300, 300), [104, 117, 123], True, False)

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
                cv.rectangle(frameOpencvDnn, (x1, y1), (x2, y2), (0, 255, 0), int(round(frameHeight / 150)), 8)
        return frameOpencvDnn, bboxes

    padding = 20
    frameFace, bboxes = getFaceBox(faceNet)
    if not bboxes:
        return "No face Detected"

    for bbox in bboxes:
        # print(bbox)
        face = img[max(0, bbox[1] - padding):min(bbox[3] + padding, img.shape[0] - 1),
               max(0, bbox[0] - padding):min(bbox[2] + padding, img.shape[1] - 1)]

        blob = cv.dnn.blobFromImage(face, 1.0, (227, 227), MODEL_MEAN_VALUES, swapRB=False)
        genderNet.setInput(blob)
        genderPreds = genderNet.forward()
        gender = genderList[genderPreds[0].argmax()]
        # print("Gender Output : {}".format(genderPreds))
        return gender




if __name__ == '__main__':
    app.run(host='192.168.96.87', port=8000)