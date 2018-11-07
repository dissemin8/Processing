/**
 * Simple Read
 * 
 * Read data from the serial port and change the color of a rectangle
 * when a switch connected to a Wiring or Arduino board is pressed and released.
 * This example works with the Wiring / Arduino program that follows below.
 */



	

// Play a sample once. 
// Notes: Make sure to include the specified audio file in your project's 'data' folder. 
 
Sample mySample; 
 
void setup() { 
  size(100,100); 
  Sonia.start(this); 
  mySample = new Sample("sine.aiff"); 
  mySample.play(); 
} 
 
public void stop(){ 
  Sonia.stop(); 
  super.stop(); 
} 
 







