from flask import Flask
from flask import request
import serial
app = Flask(__name__)
connected = False
ser = serial.Serial("/dev/cu.usbmodem1421", 9600)
while not connected:
    serin = ser.read()
    connected = True
#Arduino connection set up finished

@app.route("/")
def hello():
	global ser
	x = request.args.get('x', '') # get x and y angles from input in server
	y = request.args.get('y', '')

	ser.write(bytes(x,encoding='utf-8'))
	ser.write(bytes(y,encoding='utf-8'))

	return "Hello World Luis!" + x + ", " + y

