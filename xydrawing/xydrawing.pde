int y = 100;
int x = 100;
// The statements in the setup() function 
// execute once when the program begins
void setup() {
  size(640, 360);  // Size must be the first statement
  stroke(128);     // Set line drawing color to white
  frameRate(60);
}
// The statements in draw() are executed until the 
// program is stopped. Each statement is executed in 
// sequence and after the last line is read, the first 
// line is executed again.
void draw() { 
//  background(0);   // Clear the screen with a black background
  
  stroke(102, 204, 0) ;
  
  y = y - 1; 
  if (y < 0) { 
    y = height; 
  } 
  line(0, y, width, y);
  
  stroke(204, 102, 0) ;
  
  x = x - 1; 
  if (x < 0) { 
    x = width; 
  } 
  line(x, 0, x , height);  
  
} 

