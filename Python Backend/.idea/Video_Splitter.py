import cv2
from flask import Flask, request
app = Flask(__name__)
@app.route('/Video_Split', methods=['GET', 'POST'])
def extractFrames():
    pathOut='C:/Users/Seif/Desktop/Python Oriented/Seif/'
    if(request.method['POST']):
        videofile = request.files['video']
        cap = videofile
        #cap = cv2.VideoCapture(pathIn)
        count = 0
        while (cap.isOpened()):
            cap.set(cv2.CAP_PROP_POS_MSEC, (count * 595))
            # Capture frame-by-frame
            ret, image = cap.read()
            if ret == True:
                print('Read %d frame: ' % count, ret)
                cv2.imwrite(pathOut + "\\frame%d.jpg" % count, image)# save frame as JPEG file
                count += 1
            else:
                break



if __name__ == '__main__':
    app.run(host='192.168.1.61', port=8003)

