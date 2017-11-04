from flask import Flask
from flask import request

app = Flask(__name__)

@app.route("/")
def hello():
	x = request.args.get('key', '')


	return "Hello World Luis!"