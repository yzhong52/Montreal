'''
Created on 2011-12-02

@author: Bobby Wood
'''

## import the serial library
import serial

## Boolean variable that will represent 
## whether or not the arduino is connected
connected = False

## open the serial port that your ardiono 
## is connected to.
ser = serial.Serial("/dev/cu.usbmodem1421", 9600)

## loop until the arduino tells us it is ready
while not connected:
    serin = ser.read()
    connected = True

## Tell the arduino to blink!
input_b=bytes('2',encoding='utf-8')
ser.write(input_b)

## Wait until the arduino tells us it 
## is finished blinking
#while True:
## Wait until the arduino tells us it 
## is finished blinking

#dataRead = ser.read()
#print(dataRead)

while ser.read() == '2':
    dataRead = ser.read()
    print(dataRead)

## close the port and end the program
ser.close()
