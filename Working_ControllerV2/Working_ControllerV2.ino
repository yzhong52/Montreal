// Open a serial connection and flash LED when input is received
int value;
int value2;
bool toggle = 0;
void setup(){
  // Open serial connection.
  Serial.begin(9600);
  pinMode(12, OUTPUT);
  pinMode(11, OUTPUT);
  Serial.write('1'); 
}

void loop(){
  toggle = !toggle;
  if(toggle && Serial.available() > 0){      // if data present, blink

    value = Serial.read(); // 0, 100
    if( value == '1'){
      digitalWrite(11, HIGH);
      
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

