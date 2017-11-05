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
	print(x)
	
	input_b=bytes(x,encoding='utf-8')
	ser.write(input_b)
	#while ser.read() == '1':
	#	dataRead = ser.read()
	#	print(dataRead)
	#ser.close()
	print(y)
	return "Hello World Luis!"+x+y






## Tell the arduino to blink!


## Wait until the arduino tells us it 
## is finished blinking
#while True:
## Wait until the arduino tells us it 
## is finished blinking

#dataRead = ser.read()
#print(dataRead)


