import processing.video.*; 
Capture     cam; 
PrintWriter output;

int   xOffset       =  70 ;
int   yOffset       =  52 ;

int   digitsWidth   = 512 ;
int   digitsHeight  = 118 ;

float xGrid []      = {0.015625,   0.02734375, 0.0703125,  0.115234375,0.126953125,
                       0.171875,   0.185546875,0.23046875, 0.2734375,  0.283203125,
                       0.33203125, 0.345703125,0.38671875, 0.42578125, 0.439453125,
                       0.572265625,0.583984375,0.62109375, 0.658203125,0.671875,
                       0.73046875, 0.7421875,  0.775390625,0.814453125,0.826171875,
                       0.884765625,0.896484375,0.931640625,0.970703125,0.982421875} ;
float yGrid []      = {0.076271186,0.296610169,0.5,0.703389831,0.923728814} ;

int   bottomLeft [] = {0,240} ;
int   topRight   [] = {640,0} ;

int   xMax          = 640 ;
int   yMax          = 480 ; 

int   value         = 0 ;

char  position      = 'l' ;

int   xValues []       = new int [30];
int   yValues []       = new int [5];

int   lightLevels [][] = new int [6][10] ;

boolean autoMode    = false ;

String  lastCode    = "######" ;
String  code        = "######" ;
int     frames      = 0 ;

boolean newCode = false ;

void setup() {
  println("Setup Start") ;
  size(640, 480);
  frameRate(10);

  String[] cameras = Capture.list();
  output = createWriter("codelist.txt");
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(">>",cameras[i],"<<");
    }
  }

  cam = new Capture(this,cameras[0]); // "name=USB2.0 Camera,size=640x480,fps=30"
  cam.start(); 

  println("Setup End") ;
} 
 
void draw() {
  if (cam.available()) { cam.read() ; }
  set(0, 0, cam) ;
//drawXYLines () ;
  noFill() ;
  stroke(color(255,255,255));      
  quad(bottomLeft[0], topRight[1], topRight[0], topRight[1], topRight[0], bottomLeft[1], bottomLeft[0], bottomLeft[1]) ;  
  drawTargets () ;
  if (autoMode) {
    String code = decodeDisplay() ;
    String [] match = match(code, "#" ) ;
    if (match == null) { // if no invalid characters are detected
      if (!code.equals(lastCode)) { // has the code changed ?
        println ("?? ",code," ??") ; // show possibly invalid code <<<< 
        newCode = true ;
        frames = 0 ;  // yes - start settle period
        lastCode = code ;
      } else {
        frames++ ; 
        if ( frames > 20 && newCode == true) {
          // yes - display and write out the new code
          println("Time ",nf(hour(),2),":",nf(minute(),2),":",nf(second(),2)," Code :",code) ;
          String lineOut = "Time " + nf(hour(),2) + ":" + nf(minute(),2) + ":" + nf(second(),2) + " " + code ;
          output.println(lineOut) ; 
          output.flush(); // Writes the remaining data to the file
          newCode = false ;
        }
      }
    } else { // else display duff code <<<<<<<<<<<<<<<<<
      println ("## ",code," ##") ; // show possibly invalid code <<<<
    }
  }
} 

void keyPressed() {
  switch(keyCode) {

    case 65 :   // 'a' = set to automatic
      autoMode   = true ;  // switch to automatic 
      println("Automatic") ;
    break ;

    case 77 :   // 'm' = set to manual
      autoMode   = false ; // switch to manual 
      println("Manual") ;
    break ;

    case 76 :   // 'l'
      position        = 'l' ;  // select bottom left position
      println("adjust position of the bottom left of the display") ;
    break ;
    case 82 :   // 'r'
      position        = 'r' ;  // select top right position
      println("adjust position of the top right of the display") ;
    break ;

    case 37 :  // left  cursor key
      if (position == 'l') {
        if (--bottomLeft[0] < 1 ) {bottomLeft[0] = 1 ; }
      }
      if (position == 'r') {
        if (--topRight[0]   < 1 ) {topRight[0]   = 1 ; }
      }
    break ;
     
    case 40 :    // down cursor key 
      if (position == 'l') {
        if (++bottomLeft[1] > yMax) { bottomLeft[1] = yMax ; }
      }
      if (position == 'r') {
        if (++topRight[1]   > yMax) { topRight[1]   = yMax ; }
      }
    break ;

    case 38 :    // up    cursor key
      if (position == 'l') {
        if (--bottomLeft[1] < 1 ) { bottomLeft[1] = 1 ; }
      }
      if (position == 'r') {
        if (--topRight[1]   < 1 ) { topRight[1]   = 1 ; }
      }
    break ;

    case 39 :    // right cursor key
      if (position == 'l') {
        if (++bottomLeft[0] > xMax) { bottomLeft[0] = xMax  ; }  
      }
      if (position == 'r') {
        if (++topRight[0]   > xMax) { topRight[0]   = xMax  ; }  
      }
    break ;
    
    case 67 :              // 'c' = calculate pixel read detect positions
      for (int x = 0 ; x <= 29 ; x++ ) {
//      xValues[x] = (int)(digitsWidth * xGrid[x] + xOffset) ;
        xValues[x] = (int)((topRight[0]-bottomLeft[0]) * xGrid[x] + bottomLeft[0]) ;        
        println (x,xValues[x]) ;
      }  
      for (int y = 0 ; y <= 4 ; y++ ) {
//      yValues[y] = (int)(digitsHeight * yGrid[y] + yOffset) ;
        yValues[y] = (int)((bottomLeft[1]-topRight[1]) * yGrid[y] + topRight[1]) ;
       println (y,yValues[y]) ;
      }  
    break ;

    case 80 : // 'p' = dump selected variables 
      println("Variable dump Start"," ",nf(hour(),2),":",nf(minute(),2),":",nf(second(),2)) ;

      for (int x = 0; x <= 29 ; x++) {
         print (xValues [x]," ") ;
      }
      println() ;
      for (int y = 0; y <= 4 ; y++) {
         print (yValues [y]," ") ;
      }
      println() ;
      println ("value(",value,")") ; 
      println ("position(",position,")") ;
      println ("last code ",lastCode) ;
      println ("code      ",code) ;
      
      println("Variable dump End") ; 
    break ;

    case 90 : // 'z' = dumps light levels 
      for (int d = 0 ; d <= 5 ; d++ ) {
        for (int lle = 0; lle <= 8 ; lle++) {
          print (lightLevels[d][lle]," ") ; 
        }
        println() ;
      }
    break ;
    
    case 68 :  // 'd' = dump segment info for each digit 
      println(decodeDisplay ()) ;
    break;

    default :
      println("key:",keyCode) ;
    break ;  
  }
}

void drawTargets () {
  rectMode(CENTER);  // Set rectMode to CENTER
  for (int d = 0 ; d <= 5 ; d++ ) {
    // segment a 
    rect(xValues[2+5*d],yValues[0],6,6) ;
    // segment b  
    rect(xValues[4+5*d],yValues[1],6,6) ;
    // segment c  
    rect(xValues[3+5*d],yValues[3],6,6) ;
    // segment d  
    rect(xValues[2+5*d],yValues[4],6,6) ;
    // segment e  
    rect(xValues[0+5*d],yValues[3],6,6) ;
    // segment f  
    rect(xValues[1+5*d],yValues[1],6,6) ;
    // segment g  
    rect(xValues[2+5*d],yValues[2],6,6) ;
    // white space 1  
    rect(xValues[2+5*d],yValues[1],6,6) ;
    // white space 1  
    rect(xValues[2+5*d],yValues[3],6,6) ;

  }  
}

String decodeDisplay () {
  boolean dbug = false ;
  String code = "" ;
  for (int d = 0 ; d <= 5 ; d++ ) {
    
    
    for (int lle = 0 ; lle <=8 ; lle++) {
      lightLevels[d][lle] = 0 ;
    }
    for (int llx = -2; llx <= 2 ; llx++) {
      for (int lly = -2; lly <= 2 ; lly++) { 
       
        lightLevels[d][0] += (int)brightness(get(xValues[2+5*d]+llx,yValues[0]+lly)) ; // segment a
        lightLevels[d][1] += (int)brightness(get(xValues[4+5*d]+llx,yValues[1]+lly)) ; // segment b  
        lightLevels[d][2] += (int)brightness(get(xValues[3+5*d]+llx,yValues[3]+lly)) ; // segment c   
        lightLevels[d][3] += (int)brightness(get(xValues[2+5*d]+llx,yValues[4]+lly)) ; // segment d 
        lightLevels[d][4] += (int)brightness(get(xValues[0+5*d]+llx,yValues[3]+lly)) ; // segment e 
        lightLevels[d][5] += (int)brightness(get(xValues[1+5*d]+llx,yValues[1]+lly)) ; // segment f 
        lightLevels[d][6] += (int)brightness(get(xValues[2+5*d]+llx,yValues[2]+lly)) ; // segment g 
        lightLevels[d][7] += (int)brightness(get(xValues[2+5*d]+llx,yValues[1]+lly)) ; // white space 1  
        lightLevels[d][8] += (int)brightness(get(xValues[2+5*d]+llx,yValues[3]+lly)) ; // white space 2  
      }
    }
    
    if (dbug) { print("Digit(",d,") ") ; }
    int whiteLevel = min(lightLevels[d][7],lightLevels[d][8]) / 4 * 3 ;
    if (dbug) { print("whiteLevel(",whiteLevel,") ") ; }
    int segsBitMap = 0x00 ;
    for (int segment = 0 ; segment <= 6 ; segment++) {
      if (dbug) { print(lightLevels[d][segment]," ") ; }
      if ( lightLevels[d][segment] > whiteLevel ) {
        segsBitMap = segsBitMap << 1 ;
      } else {
        segsBitMap = segsBitMap << 1 ;
        segsBitMap = segsBitMap | 0x01 ;
      }
    }
    if (dbug) { print(binary(segsBitMap, 8)," ") ; }
    if (dbug) { println(decodeSegs(segsBitMap)) ; }
    code += decodeSegs(segsBitMap) ;
  }
  return code ;
}

String decodeSegs (int segsBitMap) {
  switch (segsBitMap) {
    case 0x7E : // 0111 1110 :
      return "0" ;
    case 0x30 : // 0011 0000 :
      return"1" ;
    case 0x6D : //  0110 1101 :
      return "2" ;
    case 0x79 : //  0111 1001 :
      return "3" ;
    case 0x33 : // 0011 0011 :
      return "4" ;
    case 0x5B :  // 0101 1011 :
      return "5" ;
    case 0x5F :  // 0101 1111 :
      return "6" ;
    case 0x72 :  // 0111 0010 :
      return "7" ;
    case 0x7F :  // 0111 1111 :
      return "8" ;
    case 0x7B :  // 0111 1011 :
      return "9" ;
    default :
      return "#" ;
  }
}
void drawXYLines() {
  if (false) {
    for (int x = 0 ; x <= 29 ; x++) {
      stroke(color(255,000,000));
      line(xValues[x], 0, xValues[x], 480) ;
    }  
    for (int y = 0 ; y <= 4 ; y++) {
      stroke(color(000,255,000));
      line(0, yValues[y], 640, yValues[y]) ;
    }  
  }
}