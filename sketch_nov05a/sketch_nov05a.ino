#include <Servo.h>

// create servo object to control a servo
// twelve servo objects can be created on most boards
Servo myservo; 
Servo myservo2;

void setup() {
  Serial.begin(9600);

  pinMode(11, OUTPUT);
  
  // attaches the servo on pin to the servo objects
  myservo.attach(12);  
  myservo2.attach(13);
  
  Serial.write('1');
  
}

unsigned char reader; 
bool toggle = false;

void loop() {
 if(Serial.available() > 0){ //Checks if chip is sending data
    toggle = !toggle;
    
    reader = Serial.read(); // Reads the data

    if (toggle) {
      myservo.write((int)reader);
    } else {
      myservo2.write((int)reader);
    }

    if ( reader >= 'A') {
      digitalWrite(11, HIGH);
      delay(200);
      digitalWrite(11, LOW);
    } 
  }
}
