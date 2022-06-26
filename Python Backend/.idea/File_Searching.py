import cv2 as cv
import os
pathin='C:/Users/Seif/Desktop/Python Oriented/Seif/'
img=cv.imread(pathin)
c=[]
updated_frame=cv.resize(img,(200,200))
cv.imwrite('C:/Users/Seif/Desktop/Python Oriented/Seif/resized_frame0.jpg',updated_frame)
for x in os.listdir(pathin):
    if x.startswith("frame"):
        img=cv.imread(pathin+x)
        updated_frame = cv.resize(img, (200, 200))
        cv.imwrite('C:/Users/Seif/Desktop/Python Oriented/Seif/resized_'+x+'.jpg', updated_frame)
"""for x in os.listdir(pathin):
    os.remove('C:/Users/Seif/Desktop/Python Oriented/Seif/'+x)"""