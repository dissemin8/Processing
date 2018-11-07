import processing.video.*; 
Capture cam; 

int[][][] corners = new int[7][2][2];
int digitSelect ;

void setup() {
  println("Setup Start") ;
  size(640, 480);
  frameRate(10);
  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(">>",cameras[i],"<<");
    }
    //  exit() ;
  }

  for (int digit = 1 ; digit <=6 ; ++digit ) {
    for (int x = 0 ; x <= 1 ; x++ ) {
      for (int y = 0 ; y <= 1 ; y++ ) {
        corners [digit][x][y] = 0 ;
      }
    }
  }
//cam = new Capture(this,640,480,30); // "name=USB2.0 Camera,size=640x480,fps=30"
  cam = new Capture(this,cameras[0]); // "name=USB2.0 Camera,size=640x480,fps=30"
//cam = new Capture(this,cameras[1]); // "name=USB2.0 Camera,size=320x240,fps=30"
  cam.start(); 
  stroke(color(255,255,255));
  digitSelect = 1 ;
  println("Left click bottom left of digits then\n","Right click top right") ;
  println("Setup End") ;
} 
 
void draw() {
//  println("draw Start") ;
  if (cam.available()) { 
    // Reads the new frame
    cam.read(); 
  }
  
  
//  image(cam, 0, 0);
//    image(cam, 0, 0, width/2, height/2);
   set(0, 0, cam) ;
   noFill() ;
   for (int digit = 1 ; digit <= 6 ; ++digit ) {
     rect(corners [digit][0][0],corners [digit][0][1],corners [digit][1][0] - corners [digit][0][0] ,corners [digit][1][1] - corners [digit][0][1]) ;
     text(frameRate,20,250) ;
     text(corners[digit][0][0],20+(digit*40),265) ;
     text(corners[digit][0][1],20+(digit*40),280) ;
     text(corners[digit][1][0],20+(digit*40),295) ;
     text(corners[digit][1][1],20+(digit*40),310) ;
   }
   
   text(digitSelect,20,330) ;
   stroke(color(255,0,0));
   /*
   rect(20,40,600,20) ;
   rect(20,92,600,20) ;
   rect(20,142,600,20) ;
   stroke(color(0,255,0));
   int xx1 = 76 ; int xx2 = 160 ; int xx3 = 239 ;
   int xx4 = 368 ; int xx5 = 449 ; int xx6 = 530 ; 
   rect(xx1,43,14,14) ;
   rect(xx2,43,14,14) ;
   rect(xx3,43,14,14) ;
   rect(xx4,43,14,14) ;
   rect(xx5,43,14,14) ;
   rect(xx6,43,14,14) ;
   
   rect(xx1,95,14,14) ;
   rect(xx2,95,14,14) ;
   rect(xx3,95,14,14) ;
   rect(xx4,95,14,14) ;
   rect(xx5,95,14,14) ;
   rect(xx6,95,14,14) ;

   rect(xx1,145,14,14) ;
   rect(xx2,145,14,14) ;
   rect(xx3,145,14,14) ;
   rect(xx4,145,14,14) ;
   rect(xx5,145,14,14) ;
   rect(xx6,145,14,14) ;
   
   int xl = corners [1][0][0] ;
   int xr = corners [1][1][0] ;
   int digitsWidth = xr - xl ;
   
   if (xl > 0 & xr > 0 ) {
   ellipseMode(CENTER) ;
     ellipse(xl + digitsWidth *  83 / 1000, 43 + 7, 5, 5); 
     ellipse(xl + digitsWidth * 249 / 1000, 43 + 7, 5, 5);
     ellipse(xl + digitsWidth * 405 / 1000, 43 + 7, 5, 5);
     ellipse(xl + digitsWidth * 660 / 1000, 43 + 7, 5, 5);
     ellipse(xl + digitsWidth * 800 / 1000, 43 + 7, 5, 5);
     ellipse(xl + digitsWidth * 960 / 1000, 43 + 7, 5, 5);
   }
*/
   stroke(color(255,255,255));
//  print("draw End\n") ;
} 

void keyPressed() {
  switch(key) {
    case '1' :
      digitSelect = 1 ;
    break ;
    case '2' :
      digitSelect = 2 ;
    break ;
    case '3' :
      digitSelect = 3 ;
    break ;
    case '4' :
      digitSelect = 4 ;
    break ;
    case '5' :
      digitSelect = 5 ;
    break ;
    case '6' :
      digitSelect = 6 ;
    break ;
  }
}

void mousePressed() {
  switch(mouseButton) {
    case LEFT :
      corners [digitSelect][0][0] = mouseX ;
      corners [digitSelect][0][1] = mouseY ;
      print("Bottom Left Set\n") ;
    break;  
    case RIGHT :
      corners [digitSelect][1][0] = mouseX ;
      corners [digitSelect][1][1] = mouseY ;
      print("Top Right Set\n") ;
    break;  
   }
   if ((corners [digitSelect][0][0] != 0 ) && (corners [digitSelect][1][0] != 0)) {
     print("Display (Digit, Width, Height) : (",digitSelect,corners [digitSelect][1][0] - corners [digitSelect][0][0],",",corners [digitSelect][0][1] - corners [digitSelect][1][1],")\n") ;
   }
}


/*

//  Get the top left, top right, bottom right and bottom left coordinates of the display digits
//  This only needs to be done once
   // rect(leftedge + 20
   // rect(leftedge, topedge, leftedge + displaywidth, topedge + displayheight);
   // across, down, across, down
   int digitLocations [][] = {{75,53},{160,53},{245,53},{365,53},{445,53},{525,53}} ;
   for (int digits = 0 ; digits < 6 ; ++digits) {
   //  rect(digitLocations[digits][0], digitLocations[digits][1], 80, 140); 
   
   //   rect(85, 35, 80, 140);
   
   int ox = digitLocations[digits][0] ;
   int oy = digitLocations[digits][1] ;
   int lx = 74 ;
   int ly = 120 ;
   int phigh = 0 ;
   int plow  = 255 ; 

   for (int x= ox ; x < (ox + lx) ; x++ ) {
     for (int y = oy ; y < (oy + ly) ; y++ ) {
       color c = get(x,y) ;
       int redchan = (int)(green(c)) ; 
       if ( redchan < plow ) { plow = redchan ; }
       if ( redchan > phigh ) { phigh = redchan ; }

     }
   }
   
     
   int pthresh = plow + (phigh - plow ) / 2 ;
   println("plow:",plow,"\nphigh:",phigh,"\npthresh:",pthresh) ;



   for (int x= ox ; x < (ox + lx) ; x++ ) {
     for (int y = oy ; y < (oy + ly) ; y++ ) {
       color c = get(x,y) ;
       int redchan = (int)(green(c)) ;
       int grey = 0 ;
     if ( redchan > (plow - 15 + (phigh - plow) /2 ) ) {
//       if ( redchan > 90) { 
         grey = 255 ;
       }
       color Color =color(grey,grey,grey);
       set(x,y+140,Color);
     }
   }
 } 
//   rect(85, 35, 80, 140);
      
   int leftedge      = 72 ;
   int displaywidth  = 463 ;
   int topedge       = 50 ;
   int displayheight = 76 ;
   int digitwidth    = 83 ;

   for (int j = 0 ; j < 6 ; j++ ) {

     int offset = 13 ;
     if (j > 2 ) { offset += 44 ; } 
     int x2 = leftedge + offset + (j * digitwidth ) ;

     // white space

     // int getx = get(x2 + 27 , topedge+36)
     int greenchan = 0 ;
     int xorg = x2 + 27 ;
     int yorg = topedge + 36 ;
     for (int x = xorg ; x < (xorg + 2) ; ++x ) {
       for (int y = yorg ; y < (yorg + 2) ; ++y ) {
         color cp = get(x,y) ;
         greenchan += (int)(green(cp)) ;
       }
     }  
     greenchan = greenchan / 4 ;
     println("j:",j,"white avg",greenchan) ;
     rect(x2 + 27 , topedge+36, 4, 4);
     
     
     // A segments
     rect(x2 + 30 , topedge+10, 4, 4);
     
     // B segments
     rect(x2 + 50 , topedge+35, 4, 4);

     // C segments
     rect(x2 + 45 , topedge+90, 4, 4);

     // D segments
     rect(x2 + 20 , topedge+114, 4, 4);
     
     // E segments
     rect(x2 -  5 , topedge+90, 4, 4);
     
     // F segments
     rect(x2      , topedge+35, 4, 4);

     // G segments
     rect(x2 + 25 , topedge+62, 4, 4);
   }   
//  for(int x=0; x<width; x++) {
//    for(int y=0; y<height; y++) {
//       color c = get(x,y);
//       float red = red(c);
//       int grey = (int)(red);
//       if (grey < 110) {
//         grey = 0 ; 
//       }
//       if (grey > 160) {
//         grey = 255 ; 
//       }
//
//       color Color =color(grey,grey,grey);
//       set(x,y,Color);
//     }
//  }
*/