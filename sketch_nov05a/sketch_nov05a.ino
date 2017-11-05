#include <Servo.h>

Servo myservo;  // create servo object to control a servo
// twelve servo objects can be created on most boards

void setup() {
  Serial.begin(9600);
  myservo.attach(12);  // attaches the servo on pin 9 to the servo object
  Serial.write('1');
  pinMode(11, OUTPUT);
}

unsigned char reader; 

void loop() {
 if(Serial.available() > 0){ //Checks if chip is sending data
    reader = Serial.read(); // Reads the data

    // myservo.write(reader);

    if (reader == '2' || reader == '1') {
      digitalWrite(11, HIGH);
      delay(200);
      digitalWrite(11, LOW);
    } 
  }
}
