

// String1  23 pixels    Fridge/cooker run
// String2  13 pixels    Wall Unit run
// String3  69 pixels    Extractor run
// String4  39 pixels    Dining Room run
// String5  11 pixels    Display Cupboard run
// String6  14 pixels    TV Backlight run 

int   xsize   = 613   ;
int   ysize   = 409   ;
int   margin  =  15   ; 
int   mult    =   2   ;
float beam    =   8.3 ;

int String1NumPixels = 23 ;  
int String2NumPixels = 13 ;
int String3NumPixels = 69 ;
int String4NumPixels = 39 ;


float [][] ledString1xy = new float [String1NumPixels][2] ;     
float [][] ledString2xy = new float [String2NumPixels][2] ;   
float [][] ledString3xy = new float [String3NumPixels][2] ;
float [][] ledString4xy = new float [String4NumPixels][2] ;

int ledPixel = 0 ;
int fCount   = 0 ;
int fCount2  = 0 ;
int fCount3  = 0 ;
int rbowj    = 0 ;

int mode     = 2 ;

// The statements in the setup() function 
// execute once when the program begins
void setup() {
  size((xsize + margin * 2) * mult , (ysize + margin * 2) * mult);  // Size must be the first statement
  stroke(255);     // Set line drawing color to white
  fill(255);     // Set line drawing color to white
  frameRate(60);
  
  // String 1 Fridge/Cooker
  
  ledPixel = 0 ;
  for (int ypos = 22 ; ypos >= 0 ; ypos = ypos - 1 ) {
    ledString1xy [ledPixel][0] = 55*mult ;
    ledString1xy [ledPixel][1] = 8.3 * mult * ypos + 219 * mult ;  
    ledPixel++ ;
  }  

  // String 2 Wall unit

  ledPixel = 0 ;
  for (int ypos = 12 ; ypos >= 0 ; ypos = ypos - 1 ) {
    ledString2xy [ledPixel][0] = 27*mult ;
    ledString2xy [ledPixel][1] = 8.3 * mult * ypos + 12 * mult ; 
    ledPixel++ ;
  }  

// String 3 part 1  Extractor run
  ledPixel = 0 ;
  for (int ypos = 18 ; ypos >= 0 ; ypos = ypos - 1 ) {
    ledString3xy [ledPixel][0] = 264 * mult ;
    ledString3xy [ledPixel][1] = 8.3 * mult * ypos + 255 * mult ; 
    ledPixel++ ;
  }  

// String 3 part 2  Extractor run
  for (int xpos = 10 ; xpos >=  0 ; xpos = xpos - 1 ) {
    ledString3xy [ledPixel][0] = 172 * mult + 8.3*mult*xpos ;
    ledString3xy [ledPixel][1] = 247*mult ; 
    ledPixel++ ;
  }  

// String 3 part 3  Extractor run
  for (int ypos = 8 ; ypos >=  0 ; ypos = ypos - 1 ) {
    ledString3xy [ledPixel][0] = 166 * mult ;
    ledString3xy [ledPixel][1] = 8.3 * mult * ypos + 171 * mult ; 
    ledPixel++ ;
  }  

// String 3 part 4  Extractor run
  for (int xpos = 0 ; xpos <  11 ; xpos = xpos + 1 ) {
    ledString3xy [ledPixel][0] = 172 * mult + 8.3 * mult * xpos ;
    ledString3xy [ledPixel][1] = 162 * mult ; 
    ledPixel++ ;
  }  

// String 3 part 5  Extractor run 
  for (int ypos = 18 ; ypos >= 0 ; ypos = ypos - 1 ) {
    ledString3xy [ledPixel][0] = 264 * mult ;
    ledString3xy [ledPixel][1] = 8.3 * mult * ypos + 5 * mult ; 
    ledPixel++ ;
  }  

// String 4 Dining Room
  ledPixel = 0 ;
  for (int ypos = 38 ; ypos >= 0 ; ypos = ypos - 1 ) {
    ledString4xy [ledPixel][0] = 330 * mult ;
    ledString4xy [ledPixel][1] = 8.3 * mult * ypos + 6 * mult ;
    ledPixel++ ; 
  }  
  
}
// The statements in draw() are executed until the 
// program is stopped. Each statement is executed in 
// sequence and after the last line is read, the first 
// line is executed again.
void draw() { 

 if (++fCount > 59) {
   fCount = 0 ;
//    long color24bit = Color(1,2,3) ;
//    int bLevel = int(color24bit & 255) ;
//    color24bit >>= 8 ;
//    int gLevel = int(color24bit & 255) ;
//    color24bit >>= 8 ;
//    int rLevel = int(color24bit) ;
   println(frameCount);
 }  
 
  
  translate(margin * mult, margin * mult) ;

  drawBackground() ;

  // String 1 23 pixels Fridge/Cooker
  
//  for (int i = 0 ; i < 23 ; i++ ) { 
//     drawPixel(ledString1xy [i][0], ledString1xy [i][1], 255, 255, 128);
//  }

  // String2  13 pixels    Wall Unit run
  
//  for (int i = 0 ; i < 13 ; i++ ) { 
//     drawPixel(ledString2xy [i][0], ledString2xy [i][1], 255, 255, 128);
//  }


  // String3  69 pixels Extractor run

//  for (int i = 0 ; i < 69 ; i++ ) { 
//     drawPixel(ledString3xy [i][0], ledString3xy [i][1], 255, 255, 128);
//  }

  // String4  39 pixels    Dining Room run
  
//  for (int i = 0 ; i < 39 ; i++ ) { 
//     drawPixel(ledString4xy [i][0], ledString4xy [i][1], 255, 255, 128);
//  }
 if (mode == 1) {
   if (++fCount2 > 6 ) {
     fCount2 = 0 ;
     if (++rbowj > 255) {
       rbowj = 0 ; 
     }
   }  

   for (int i=0; i < String1NumPixels; i++) {
     strip1setPixelColor(i, Wheel( (i + rbowj) % 255));
   }  

   for (int i=0; i < String2NumPixels; i++) {
     strip2setPixelColor(i, Wheel( (i + rbowj) % 255));
   }  
    

   for (int i=0; i < String3NumPixels; i++) {
     strip3setPixelColor(i, Wheel( (i + rbowj) % 255));
   }  

   for (int i=0; i < String4NumPixels; i++) {
     strip4setPixelColor(i, Wheel( (i + rbowj) % 255));
   }  
 }
 
 if ( mode == 2 ) {
   // rainbowCycle

   if (++fCount3 > 6 ) {
     fCount3 = 0 ;
     if (++rbowj > 256 * 5) {
       rbowj = 0 ; 
     }
   }

   for (int i=0; i < String1NumPixels; i++) {
     strip1setPixelColor(i, Wheel( ((i * 256 / String1NumPixels) + rbowj) % 256) );
   }
   for (int i=0; i < String2NumPixels; i++) {
     strip2setPixelColor(i, Wheel( ((i * 256 / String2NumPixels) + rbowj) % 256) );
   }
   for (int i=0; i < String3NumPixels; i++) {
     strip3setPixelColor(i, Wheel( ((i * 256 / String3NumPixels) + rbowj) % 256) );
   }
   for (int i=0; i < String4NumPixels; i++) {
     strip4setPixelColor(i, Wheel( ((i * 256 / String4NumPixels) + rbowj) % 256) );
   }
 }

}

void drawBackground() {

  background(240);   // Clear the screen 
  stroke(0);
  strokeWeight(4);
  
  // ouline of kitchen/diner
  line(  0 * mult,   0 * mult,   0 * mult, 409 * mult) ;
  line(  0 * mult, 409 * mult, 303 * mult, 409 * mult) ;
  line(303 * mult, 409 * mult, 303 * mult, 329 * mult) ;
  line(303 * mult, 329 * mult, 613 * mult, 329 * mult) ;
  line(613 * mult, 329 * mult, 613 * mult,   0 * mult) ;
  line(613 * mult,   0 * mult,   0 * mult,   0 * mult) ;
  
  // ouline of Fridge/Cooker run
  strokeWeight(2);
  stroke(172) ;  
  line( 60 * mult, 409 * mult,  60 * mult, 209 * mult) ;  
  line( 60 * mult, 209 * mult,   0 * mult, 209 * mult) ;  

  // ouline of wall cabinet
  line( 32 * mult,   0 * mult,  32 * mult, 124 * mult) ;  
  line( 32 * mult, 124 * mult,   0 * mult, 124 * mult) ;  

  // ouline of ceiling divider
    // Dining room  
  line(335 * mult,  0 * mult,335 * mult,329 * mult) ;
    // kitchen side  
  line(259 * mult,409 * mult,259 * mult,252 * mult) ;  
  line(259 * mult,  0 * mult,259 * mult,157 * mult) ;
  line(161 * mult,252 * mult,161 * mult,157 * mult) ;  
  line(161 * mult,252 * mult,259 * mult,252 * mult) ;
  line(161 * mult,157 * mult,259 * mult,157 * mult) ;
} 


void drawPixel(float stringXpos, float stringYpos, int pRed, int pGreen, int pBlue ) {
   pRed   = pRed   / 2 + 128 ;
   pGreen = pGreen / 2 + 128 ;
   pBlue  = pBlue  / 2 + 128 ;
   strokeWeight(1);
   stroke(pRed, pGreen, pBlue);
   fill(pRed, pGreen, pBlue) ;
   ellipse(stringXpos, stringYpos , beam*mult, beam*mult);
}

void strip1setPixelColor(int pixel, long colour) {
    int bLevel = int(colour & 255) ;
    colour >>= 8 ;
    int gLevel = int(colour & 255) ;
    colour >>= 8 ;
    int rLevel = int(colour) ;
    drawPixel(ledString1xy [pixel][0], ledString1xy [pixel][1], rLevel, gLevel, bLevel);
}

void strip2setPixelColor(int pixel, long colour) {
    int bLevel = int(colour & 255) ;
    colour >>= 8 ;
    int gLevel = int(colour & 255) ;
    colour >>= 8 ;
    int rLevel = int(colour) ;
    drawPixel(ledString2xy [pixel][0], ledString2xy [pixel][1], rLevel, gLevel, bLevel);
}
void strip3setPixelColor(int pixel, long colour) {
    int bLevel = int(colour & 255) ;
    colour >>= 8 ;
    int gLevel = int(colour & 255) ;
    colour >>= 8 ;
    int rLevel = int(colour) ;
    drawPixel(ledString3xy [pixel][0], ledString3xy [pixel][1], rLevel, gLevel, bLevel);
}



void strip4setPixelColor(int pixel, long colour) {
    int bLevel = int(colour & 255) ;
    colour >>= 8 ;
    int gLevel = int(colour & 255) ;
    colour >>= 8 ;
    int rLevel = int(colour) ;
    drawPixel(ledString4xy [pixel][0], ledString4xy [pixel][1], rLevel, gLevel, bLevel);
}


//       Testing only beyond here

long Wheel(int WheelPos)
{
  if (WheelPos < 85) {
   return Color(WheelPos * 3, 255 - WheelPos * 3, 0);
  } else if (WheelPos < 170) {
   WheelPos -= 85;
   return Color(255 - WheelPos * 3, 0, WheelPos * 3);
  } else {
   WheelPos -= 170; 
   return Color(0, WheelPos * 3, 255 - WheelPos * 3);
  }
}

long Color(int r, int g, int b)
{
  long c;
  c = r;
  c <<= 8;
  c |= g;
  c <<= 8;
  c |= b;
  return c;
}


