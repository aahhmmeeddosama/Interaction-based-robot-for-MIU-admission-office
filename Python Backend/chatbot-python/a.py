from flask import Flask

app = Flask(__name__)


@app.route("/h")
def home():
    return "<h1>GFG is great platform to learn</h1>"


app.run()