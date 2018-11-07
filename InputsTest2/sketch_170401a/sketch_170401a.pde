int dots [][] = new int [10][2] ;
int lastBar = -1;

void setup() {
  size(200, 200);
  colorMode(HSB, 100,100,100);
  noStroke();
  for (int r = 0 ; r <= 9 ; r++ ) {
    dots [r][0] =  (int)random(200) ;
    dots [r][1] =  (int)random(200) ;
  }
  for (int r = 0 ; r <= 9 ; r++ ) {
    println (dots [r][0], " ",  dots [r][1]) ;
  }
}
void draw() {
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int d = 500 ;
      for (int r = 0 ; r <= 9 ; r++ ) {
        d = (int)dist( dots [r][0],dots [r][1], x, y) ;
        println (x,y,d) ;
      }
      stroke(constrain(d,0,100),100,100);
      point(x, y);
    }
  }
  noLoop() ;
}