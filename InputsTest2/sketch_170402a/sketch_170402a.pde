int rmax = 10 ;
int xmax = 800 ; 
int ymax = 600 ;

int dots [][] = new int [15][2] ;
int frameNum = 0 ;
int d = 0 ;
void setup() {
  size(800,600);
  colorMode(HSB, 1000,100,100);
  noStroke();
//  for (int r = 0 ; r < rmax ; r++ ) {
//    dots [r][0] =  (int)random(xmax) ;
//    dots [r][1] =  (int)random(ymax) ;
//  }
  for (int r = 0 ; r < rmax ; r++ ) {
    println (dots [r][0], " ",  dots [r][1]) ;
  }
  //frameRate(0.2) ;
  // noLoop() ;
}

void draw() {
  ++frameNum ;
  background(0,0,0) ;
  for (int r = 0 ; r < rmax ; r++ ) {
    dots [r][0] =  (int)random(xmax) ;
    dots [r][1] =  (int)random(ymax) ;
  }
  println("Start frame ",frameNum) ;
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      d = 1000 ;
      //int m = 100 ;
      for (int r = 0 ; r < rmax ; r++ ) {
          d -= (int) ((rmax - 1 ) * 1000 / dist( dots [r][0],dots [r][1], x, y)) ;
      }
//      stroke(constrain(d,0,100),100,100);
      stroke(d % 1000,100,100);
      //smooth() ;
      point(x, y);
    //  println (x,y,d) ;
      //d = d % 100 ;
    }
  }
  println("end frame ",frameNum) ;
//  stroke(0,0,0);

//  for (int r = 0 ; r < rmax ; r++ ) {
//    ellipseMode(CENTER) ;
//    ellipse( dots [r][0],dots [r][1], 3 ,3 ) ;
//  }
}