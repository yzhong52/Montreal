

// Open a serial connection and flash LED when input is received
#include"Servo.h"
int value;
int servo1;
servo1 Servo;
bool toggle = 0;
void setup(){
  // Open serial connection.
  Serial.begin(9600);
  servo1.attach(servo1);
  //pinMode(12, OUTPUT);
  //pinMode(11, OUTPUT);
  Serial.write('1'); 
}

void loop(){
  toggle = !toggle;
  if(toggle && Serial.available() > 0){      // if data present, blink
    value = Serial.read(); // 0, 100
    if( value == '1'){
      analogWrite(servo1, HIGH);
    } else if (value == '2'){
      digitalWrite(12, HIGH);
    }
  }  
} 


    //delay(500);            
      //digitalWrite(12, LOW);
      //delay(500); 
      //digitalWrite(12, HIGH);
      //delay(500);            
      //digitalWrite(12, LOW);
      //Serial.write('0');
