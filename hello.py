from flask import Flask
from flask import request
import serial
app = Flask(__name__)

ser = serial.Serial("/dev/cu.usbmodem1421", 9600)

connected = False
while not connected:
    serin = ser.read()
    connected = True

print(connected)
#Arduino connection set up finished

@app.route("/")
def hello():
	global ser
	 # get x and y angles from input in server
	x = int(request.args.get('x', ''))
	y = int(request.args.get('y', ''))
	
	print("The angles: " + x  + ", " + y)
	
	ser.write(bytes(chr(x), encoding='utf-8'))

	return "Hello World Luis!"+x+y






## Tell the arduino to blink!


## Wait until the arduino tells us it 
## is finished blinking
#while True:
## Wait until the arduino tells us it 
## is finished blinking

#dataRead = ser.read()
#print(dataRead)


