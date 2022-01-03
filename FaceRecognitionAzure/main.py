
#import from API
from azure.cognitiveservices.vision.face import FaceClient
from msrest.authentication import CognitiveServicesCredentials
from PIL import Image, ImageDraw, ImageFont

#API_KEY & ENDPOINT for API
API_KEY = '---'
ENDPOINT = '---'

#call FaceClient object fro API
face_client = FaceClient(ENDPOINT, CognitiveServicesCredentials(API_KEY))
#load image from folder images to use with face_client.face.detect_with_stream
img_file = open('.\Images\g2.jpg', 'rb')

#use detect_with_stream from face object and send main attribute to work with it
response_detection = face_client.face.detect_with_stream(
    image=img_file,
    detect_model='detection_01',
    return_face_attributes=['age', 'emotion', 'gender'],
    imagereturn_face_landmarks=True
)
#Attach some functions to variables to make them easier to call
img = Image.open(img_file)
draw = ImageDraw.Draw(img)
font = ImageFont.truetype('C:\Windows\Fonts\IMPRISHA.TTF', 25)

#detect some face features like face age emotion gender then ddraw it on picture
for face in response_detection:
    age = face.face_attributes.age
    emotion = face.face_attributes.emotion
    gender = face.face_attributes.gender

    neutral = '{0:.0f}%'.format(emotion.neutral * 100)
    happiness = '{0:.0f}%'.format(emotion.happiness * 100)
    anger = '{0:.0f}%'.format(emotion.anger * 100)
    sadness = '{0:.0f}%'.format(emotion.sadness * 100)

    rec = face.face_rectangle
    left = rec.left
    top = rec.top
    right = rec.width + left
    bottom = rec.height + top
    draw.rectangle(((left, top), (right, bottom)), outline='red', width=3)
    draw.text((right + 4, top), 'Gender: ' + gender, fill=(0, 0, 0), font=font)
    draw.text((right + 4, top + 35), 'Age: ' + str(int(age)), fill=(0, 0, 0), font=font)
    draw.text((right + 4, top + 70), 'Neutral: ' + neutral, fill=(0, 0, 0), font=font)
    draw.text((right + 4, top + 105), 'Happy: ' + happiness, fill=(0, 0, 0), font=font)
    draw.text((right + 4, top + 140), 'Angry: ' + anger, fill=(0, 0, 0), font=font)
    draw.text((right + 4, top + 175), 'Sad: ' + sadness, fill=(0, 0, 0), font=font)

#present image after previous detection
img.show()

print(vars(response_detection[0]))