
/*

Pseudo Code

display one 9x9 box
display nine 3x3 boxes
display eighty one 1x1 boxes
display contents of grid on screen
display number 1 thur 9 in each blank 1x1 box.  

check each horizontal line to remove any numbers already correct for that line
  hilite line being processed
  hilite 1x1 box being processed
   

check each horizontal line to remove any numbers already correct for that line
  hilite line being processed
  hilite 1x1 box being processed 

check each 3x3 square to remove any numbers already correct for that square
  hilite 3x3 box being processed
  hilite 1x1 box being processed

check each square in the 9x9 workgrid for single candidate squares
  hilite 1x1 box being processed

data array formats

grid [0..8][0..8] contains the puzzle. 
  0      = square is unsolved                   (draw as blank to start)
  1..9   = solved square was supplied at start  (number drawn in black )
  11..19 = square solved by this program        (number drawn in white )
  
workgrid [0..8]  [0..8]    [0..9]
         gridx    gridy  candidatelist
  0 = true (this square has been solved) false (there is more than one candidate for this square) 
  1 = true (1 is an option) false (1 has been dismissed)
  2 = true (2 is an option) false (2 has been dismissed)
  .
  .
  9 = true (9 is an option) false (9 has been dismissed)
  

Routines to write

*/
 


int[][] grid = { 
  {0,0,9,0,0,6,0,0,0}, 
  {3,0,0,0,7,0,2,0,6}, 
  {0,0,8,4,0,5,0,3,0},
  {0,3,1,9,0,0,0,6,0},
  {0,0,0,0,0,0,0,0,0},
  {0,4,0,0,0,3,9,8,0},
  {0,2,0,7,0,1,4,0,0},
  {4,0,7,0,5,0,0,0,9},
  {0,0,0,6,0,0,7,0,0}}
  ; 

  int offset  =  50 ;  /* from top and left of screen */
  int boxsize = 100 ;  /* size of 1x1 box */
 
void drawGrid() {
  /* 1x1 boxes */
  stroke(255) ;
  fill(0) ;
  strokeWeight(4) ;

  for (int x = 0 ; x < 9 ; x++) { 
    for (int y = 0 ; y < 9 ; y++) {
      if ( (x/3 + y/3 * 3) % 2 == 0 ) { 
        if ( (x + y * 9) % 2 == 0 ) { 
          fill(80) ; 
        } else {
          fill(100) ;
        }
      } else {
        if ( (x + y * 9) % 2 == 0 ) { 
          fill(140) ; 
        } else {
          fill(120) ;
        }
      }
      rect(offset + x * boxsize , offset + y * boxsize , boxsize , boxsize ) ;
    }
  }

  /* 3x3 boxes */
  stroke(255) ;
  noFill() ;
  strokeWeight(8) ;

  for (int x = 0 ; x < 3 ; x++) { 
    for (int y = 0 ; y < 3 ; y++) {
      rect(offset + x * boxsize * 3, offset + y * boxsize * 3, boxsize * 3, boxsize * 3) ;
    }
  }

  
  /* 9x9 box */
  stroke(255) ;
  noFill() ;
  strokeWeight(12) ;

  rect(offset, offset, boxsize * 9, boxsize * 9) ;

}

void setup() {
  size(1000, 1000);
  frameRate(2);
  background(0);
  noLoop();
  drawGrid();
  redraw() ;
}

void hilite(int htype, int hx, int hy) {

  strokeWeight(12) ;
  noFill() ;

  switch(htype) {
    case 0:    // hilite row
      stroke(255,100,100) ;
      rect(offset , offset +  boxsize * hy , boxsize * 9 , boxsize ) ;
      break;
    case 1:    // hilite column
      stroke(100,255,100) ;
      rect(offset + boxsize * hx, offset , boxsize , boxsize * 9  ) ;   
      break;
    case 2:    // hilite 3x3
      stroke(100,100,255) ;
      rect(offset +  boxsize * hx * 3, offset +  boxsize * hy * 3 , boxsize * 3 , boxsize * 3  ) ;
      break;
    case 3:    // hilite 1x1
      stroke(255,100,255) ;
      rect(offset +  boxsize * hx , offset +  boxsize * hy , boxsize , boxsize ) ;
      break;

}
  
  
  // hilite of row, column or 3x3 should go here

 // rect(offset + boxsize * 4, offset , boxsize , boxsize * 9 ) ;
 // rect(offset + boxsize * 6, offset + boxsize * 6, boxsize * 3, boxsize * 3 ) ; 
}

int xx  = 0 ;
int yy  = 0 ;
int xxx = 0 ;
int yyy = 0 ;
int xxxx = 0 ;
int yyyy = 0 ;
int htype = 0 ;

void draw() {
  drawGrid() ;

  switch(htype) {
    case 0:    // hilite row
      hilite(0,0,yy++) ;
      if (yy > 8) {
        yy = 0 ;
        htype++ ;
      }
      break ;

    case 1:    // hilite column
      hilite(1,xx++,0) ;
      if (xx > 8) {
        xx = 0 ;
        htype++ ;
      }
      break ;

    case 2:    // hilite 3x3  
      hilite(2,xxx++,yyy) ;
      if (xxx > 2) {
        xxx = 0 ;
        yyy++   ;
      }
      if (yyy > 2) {
        yyy = 0 ;
        htype++ ;
      }
      break ;
    case 3:    // hilite 1x1
      hilite(3,xx,yy) ;
      xx++ ;
      if (xx > 8) {
        xx = 0 ;
        yy++ ;
      }
      if (yy > 8) {
        yy = 0 ;
        htype = 0 ;
      }
      break ;
  }
}
  // stroke(255) ;
  // strokeWeight(2) ;

  ////weight() ;
  //for (int gridx = 0 ; gridx < 9 ; gridx++) { 
  //  for (int gridy = 0 ; gridy < 9 ; gridy++) {
  //    stroke(255) ;
  //    strokeWeight(2) ;
  //    fill(40) ;
  //    if (((gridx % 3) == 0) && ((gridy % 3) == 0)) {
  //      strokeWeight(8) ;
  //      stroke(255) ;
  //      fill(80) ;
  //      rect(
  //        offset + gridx * boxsize, 
  //        offset + gridy * boxsize, 
  //        boxsize * 3,  
  //        boxsize * 3
  //      ) ;
  //    }
  //  }
  //}

  //for (int gridx = 0 ; gridx < 9 ; gridx++) { 
  //  for (int gridy = 0 ; gridy < 9 ; gridy++) {
  //    stroke(255) ;
  //    strokeWeight(2) ;
  //    noFill() ;
  //    rect(
  //      offset + gridx * boxsize, 
  //      offset + gridy * boxsize, 
  //      boxsize,  
  //      boxsize
  //    ) ;
  //    textSize(100) ;
  //    fill(240) ;
  //    int number = grid[gridy][gridx] ;
  //    if (number > 0) {
  //      String num = str(number) ;
  //      text(num, gridx * boxsize + 68, gridy * boxsize + 138 ) ;
  //    } else {
  //      textSize(30) ;
  //      fill(200) ;
  //      for (int boxx = 0 ; boxx < 3 ; boxx++) {
  //        for (int boxy = 0 ; boxy < 3 ; boxy++) {
  //          String boxnum = str(boxy * 3 + boxx + 1) ;
  //          text(boxnum, gridx * boxsize + 60 + boxx * 30, gridy * boxsize + 80 + boxy * 30 ) ;
  //        }
  //      }
  //    }
  //  }
  // }

  //strokeWeight(2) ;
  //for (int grid = 0 ; grid <= 9 ; grid++) {
  //  if ((grid % 3) == 0) {
  //    strokeWeight(8) ;
  //    stroke(255) ;
  //  } else {
  //    strokeWeight(2) ;
  //  }
  //  line(
  //    offset + grid * boxsize,
  //    offset ,
  //    offset + grid * boxsize,
  //    offset + boxsize * 9
  //  ) ;
  //  line(
  //    offset,
  //    offset + grid * boxsize,
  //    offset + boxsize * 9,
  //    offset + grid * boxsize
  //  ) ;
  //}
  
  //for (int i = 0; i < width; i++) {
  //  for (int j = 0; j < height; j++) {
  //    int red = floor(j * 255 / height) ;
  //    int green = floor(i * 255 / width) ;
  //    color c = color(red, green, 0);
  //    set(i, j, c);
  //  }
  // }
