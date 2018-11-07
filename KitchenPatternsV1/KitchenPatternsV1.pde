

int  fCount   = 0 ;
int  fCount2  = 0 ;
float offset  = 0 ;

int mode     = 1 ;

void setup() {
  size(1000, 1000) ;
  frameRate(60);

}


void draw() { 

  background(0,0,10);   // Clear the screen 
 
  if (++fCount > 59) {
    fCount = 0 ;
    println(frameCount);
  }  
  
//  translate(500,500) ;


  if (++fCount2 > 1 ) {
    fCount2 = 0 ;
    if (++offset > 100 ) {
      offset = 0 ;
    } 
  }


  if (mode == 1) {
      for (float xpos = -1 ; xpos <= 1.001; xpos += 0.05) {
        for (float ypos = -1 ; ypos <= 1.001; ypos += 0.05) {
          int brightness = int( sin(  sqrt( xpos*xpos + ypos*ypos ) )* 200) ;
      //    int brightness = 1 ;
          strokeWeight(1);
          stroke(brightness);
          fill(brightness) ;
          println(brightness);
          ellipse(xpos * 400 + 500, ypos * 400 + 500 , 10, 10);
        }
      }
   }
}


/*
          int brightness = int(
            ( 
              ( 
                cos( xpos * 2 * PI + offset/100 * 2 * PI ) 
                + 
                cos( ypos * 2 * PI + offset/100 * 2 * PI ) 
                + 
                2
              )  
            / 4 * 255
            )   
          ) ;

*/

