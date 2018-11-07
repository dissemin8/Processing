
int xoffset = 5;
int yoffset = 5;
int xsize   = 613 ;
int ysize   = 409 ;
int margin  = 15 ; 
int mult = 2 ;

// The statements in the setup() function 
// execute once when the program begins
void setup() {
  size((xsize + margin * 2) * mult , (ysize + margin * 2) * mult);  // Size must be the first statement
  stroke(255);     // Set line drawing color to white
  frameRate(60);
  
}
// The statements in draw() are executed until the 
// program is stopped. Each statement is executed in 
// sequence and after the last line is read, the first 
// line is executed again.
void draw() { 
  background(128);   // Clear the screen with a black background

  stroke(0, 0, 0) ;
  strokeWeight(1);
  translate(0, 0) ;
  translate(margin * mult, margin * mult) ;

  // String1  23 pixels    Fridge/cooker run
  // String2  13 pixels    Wall Unit run
  // String3  69 pixels    Extractor run
  // String4  39 pixels    Dining Room run
  // String5  11 pixels    Display Cupboard run
  // String6  14 pixels    TV Backlight run 
  
  // rectangle representing light

  //translate((335*2)-10+10, 10) ;


  // String 1 Fridge/Cooker 
  for (int ypos = 22 ; ypos >= 0 ; ypos = ypos - 1 ) {
    rect(50*mult, (8.3*mult*ypos)+214*mult, 20*mult, 8.3*mult);
    // rect(0, 0, 20, 20) ;
  }  

  // String 2 Wall unit
  for (int ypos = 12 ; ypos >= 0 ; ypos = ypos - 1 ) {
    rect(22*mult, (8.3*mult*ypos)+(7.5*mult), 20*mult, 8.3*mult);
    // rect(0, 0, 20, 20) ;
  }  


  // String 3 part 1  Extractor run
  for (int ypos = 18 ; ypos >= 0 ; ypos = ypos - 1 ) {
    rect(249*mult, (8.3*mult*ypos)+248*mult, 20*mult, 8.3*mult);
    // rect(0, 0, 20, 20) ;
  }  

  // String 3 part 2  Extractor run

  for (int xpos = 10 ; xpos >=  0 ; xpos = xpos - 1 ) {
    rect(161 * mult + (8.3*mult*xpos), 242*mult, 8.3*mult, 20*mult);
    // rect(0, 0, 20, 20) ;
  }  

  // String 3 part 3  Extractor run

  for (int ypos = 8 ; ypos >=  0 ; ypos = ypos - 1 ) {
    rect(151*mult, (8.3*mult*ypos)+166*mult, 20*mult, 8.3*mult);
    // rect(0, 0, 20, 20) ;
  }  


  // String 3 part 4  Extractor run

  for (int xpos = 10 ; xpos >=  0 ; xpos = xpos - 1 ) {
    rect(161 * mult + (8.3*mult*xpos), 147*mult, 8.3*mult, 20*mult);
    // rect(0, 0, 20, 20) ;
  }  


  // String 3 part 5  Extractor run 
  for (int ypos = 18 ; ypos >= 0 ; ypos = ypos - 1 ) {
    rect(249*mult, (8.3*mult*ypos)+(5*mult), 20*mult, 8.3*mult);
    // rect(0, 0, 20, 20) ;
  }  


  // String 4 Dining Room
  for (int ypos = 0 ; ypos < 39 ; ypos = ypos + 1 ) {
    rect((325*mult), (8.3*mult*ypos)+(2.5*mult), 20*mult, 8.3*mult);
    // rect(0, 0, 20, 20) ;
  }  






  strokeWeight(4);
  
  // ouline of kitchen/diner
  line(  0 * mult,   0 * mult,   0 * mult, 409 * mult) ;
  line(  0 * mult, 409 * mult, 303 * mult, 409 * mult) ;
  line(303 * mult, 409 * mult, 303 * mult, 329 * mult) ;
  line(303 * mult, 329 * mult, 613 * mult, 329 * mult) ;
  line(613 * mult, 329 * mult, 613 * mult,   0 * mult) ;
  line(613 * mult,   0 * mult,   0 * mult,   0 * mult) ;
  
  // ouline of Fridge/Cooker run
  stroke(16, 16, 16) ;
  strokeWeight(2);  
  line( 60 * mult, 409 * mult,  60 * mult, 209 * mult) ;  
  line( 60 * mult, 209 * mult,   0 * mult, 209 * mult) ;  

  // ouline of wall cabinet
  stroke(16, 16, 16) ;
  strokeWeight(2);  
  line( 32 * mult,   0 * mult,  32 * mult, 124 * mult) ;  
  line( 32 * mult, 124 * mult,   0 * mult, 124 * mult) ;  

  // ouline of ceiling divider
  stroke(16, 16, 16) ;
  strokeWeight(2);
    // Dining room  
  line(335 * mult,  0 * mult,335 * mult,329 * mult) ;
    // kitchen side  
  line(259 * mult,409 * mult,259 * mult,252 * mult) ;  
  line(259 * mult,  0 * mult,259 * mult,157 * mult) ;
  line(161 * mult,252 * mult,161 * mult,157 * mult) ;  
  line(161 * mult,252 * mult,259 * mult,252 * mult) ;
  line(161 * mult,157 * mult,259 * mult,157 * mult) ;
  

  
//  line(0,0,243*2,0) ;
//  line(243*2,0,243*2,80*2) ;
//  line(243*2,80*2,553*2,80*2) ;
  
//  y = y - 1; 
//  if (y < 0) { 
//    y = height; 
//  } 
//  line(0, y, width, y);
//  
//  stroke(204, 102, 0) ;
  
//  x = x - 1; 
//  if (x < 0) { 
//    x = width; 
//  } 
//  line(x, 0, x , height);  
  
} 

