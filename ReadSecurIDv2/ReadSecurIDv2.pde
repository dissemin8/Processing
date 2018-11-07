  
import processing.video.*; 
Capture cam; 
 
void setup() { 
  print("Setup Start") ;
  size(640, 320); 
  cam = new Capture(this);
  cam.start(); 
  stroke(color(255,100,255));
  frameRate(5);
  int tlxy [] = {0,0} ;  
  int trxy [] = {0,0} ;  
  int blxy [] = {0,0} ;  
  int brxy [] = {0,0} ;
  print("Setup End") ;
} 
 
void draw() {
  println("draw Start") ;
  if (cam.available()) { 
    // Reads the new frame
    cam.read(); 
  }
  
  
//  image(cam, 0, 0);
//    image(cam, 0, 0, width/2, height/2);
   set(0, 0, cam) ;
   fill(0,0,0,0) ;

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
  print("draw End\n") ;
   
} 