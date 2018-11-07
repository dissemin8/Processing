/**
 * Simple Read
 * 
 * Read data from the serial port and change the color of a rectangle
 * when a switch connected to a Wiring or Arduino board is pressed and released.
 * This example works with the Wiring / Arduino program that follows below.
 */


import processing.serial.*;
import pitaru.sonia_v2_9.*;

Serial myPort;  // Create object from Serial class
Sample mySample; 
int val;      // Data received from the serial port

void setup() 
{
  size(200, 200);
  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[0];
  println(Serial.list()) ;
  myPort = new Serial(this, portName, 9600);
  
  Sonia.start(this); 
}

void draw()
{
  while (myPort.available() > 0) {
    delay(150) ;
    String inBuffer = myPort.readString();   
    inBuffer = inBuffer.substring(0,inBuffer.length()-2) ;
    println(inBuffer);
    if (inBuffer.equals("Team 1")) {
      mySample = new Sample("StuartR.aiff"); 
      mySample.play();
    }  
    if (inBuffer.equals("Team 2")) {
      mySample = new Sample("Roger.aiff"); 
      mySample.play();
    }  
    if (inBuffer.equals("Team 3")) {
      mySample = new Sample("Barbara.aiff"); 
      mySample.play();
    }  
    if (inBuffer.equals("Team 4")) {
      mySample = new Sample("StuartD.aiff"); 
      mySample.play();
    }  
    
  }

  
  
//  println(val) ;
  
//  String stur = "S";
  // Tests to see if str1 is equal to str2
//  if(val.equals(stur) == true) {
//    println(val) ;
//    val = "" ;
// }
//    mySample = new Sample("ShortStuartRnew.aiff"); 
//    mySample.play();
}

public void stop(){ 
  Sonia.stop(); 
  super.stop(); 
} 

/*

// Wiring / Arduino Code
// Code for sensing a switch status and writing the value to the serial port.

int switchPin = 4;                       // Switch connected to pin 4

void setup() {
  pinMode(switchPin, INPUT);             // Set pin 0 as an input
  Serial.begin(9600);                    // Start serial communication at 9600 bps
}

void loop() {
  if (digitalRead(switchPin) == HIGH) {  // If switch is ON,
    Serial.print(1, BYTE);               // send 1 to Processing
  } else {                               // If the switch is not ON,
    Serial.print(0, BYTE);               // send 0 to Processing
  }
  delay(100);                            // Wait 100 milliseconds
}

*/
