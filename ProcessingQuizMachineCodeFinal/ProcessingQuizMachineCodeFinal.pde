/*
 * Quiz Machine Audio Driver
 * 
 * Read data from the serial port and play aiff file depending on tema name received
 */

import processing.serial.*;
import pitaru.sonia_v2_9.*;

Serial myPort;  // Create object from Serial class
Sample mySample; 
int val;      // Data received from the serial port

void setup() 
{
  size(200, 200);

//  String portName = Serial.list()[0];
  String portName = "COM21" ;
//  String portName = "COM10" ;
  myPort = new Serial(this, portName, 9600);
  Sonia.start(this); 
}

void draw()
{
  while (myPort.available() > 0) {
    delay(150) ;
    String inBuffer = myPort.readString();   
    inBuffer = inBuffer.substring(0,inBuffer.length()-2) ;
//    print(inBuffer.length()) ;
//    print("   ") ;
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
}

public void stop(){ 
  Sonia.stop(); 
  super.stop(); 
} 


