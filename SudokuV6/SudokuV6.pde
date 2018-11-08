
/*

terminology

sqr =  a 1 by 1 square on the grid    
row =  a 9 by 1 horizontal bar on the grid made from 9 squares  
col =  a 1 by 9 vertical bar on the grid made from 9 squares 
box =  a 3 by 3 box on the grid made from squares)
grid = the 9 by 9 grid of 81 squares 


Pseudo Code  (* = real code written)

* rotate array so the entry grid displays right
* initialise the workGrid array

* drawGrid 
*  draw 81  1 by 1 outlines
*  draw  9  3 by 3 outlines
*  draw  1  9 by 9 outline
* 
* drawNumbers
*  draw the non blank numbers from the grid array
*  in the blank squares display a mini 3x3 grid of the current possibles numbers from the workgrid array   

check each horizontal line to remove any numbers already correct for that line
*  hilite horizontal line being processed
*  hilite 1x1 box being processed
*  check workGrid candidate numbers in this line against each entry that is non zero the grid array 
*    remove any numbers that appear elsewhere in the same line in grid

check each vertical line to remove any numbers already correct for that line
*  hilite vertical line being processed
*  hilite 1x1 box being processed
*  check workGrid candidate numbers in this line against each entry that is non zero the grid array 
*  remove any numbers that appear elsewhere in the same line in grid


check each 3x3 box to remove any numbers already correct for that square
*  hilite 3x3 box being processed
*  hilite 1x1 square being processed
*  check workGrid candidate numbers in this box against each entry that is non zero the grid array 
*  remove any numbers that appear elsewhere in the same box in grid

*check each square in the 9x9 workgrid for single candidate squares
*  hilite 1x1 square being processed
*  check workGrid candidate numbers in this square so see if only one cadidate remains
*    insert the single number in the relevant grid array location as cadidate number + 10  

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

*/
 

/* the sudoku to solve */

int[][] entryGrid = { 
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

int[][] grid = new int[9][9]; // [x]  [y] 

/* the sudoku work grid with the current candidate numbers */
boolean [][][] workGrid = new boolean[9][9][10]; // [x]  [y] [nums]

int offset    =  50 ;  /* from top and left of screen */
int boxsize   = 100 ;  /* size of 1x1 box */

int xx        = 0   ;
int yy        = 0   ;
int sx        = 0   ;
int sy        = 0   ;
int checkStep = 0   ;
boolean newCheck = true ;
boolean solved = false ;

void setup() {
  println("Setup Started");
  println("  Size");
  size(1000, 1000);
  frameRate(15);
  println("  Background");
  background(0);
  rotateArray() ;
  workGridInit() ;
  println("Setup Ended");
  //noLoop() ;   //////////////////////////////////
}

void mouseClicked() {
  redraw() ; 
}

void rotateArray() {
  for (int x = 0 ; x < 9 ; x++) {
    for (int y = 0 ; y < 9 ; y++) {
      grid[y][x] = entryGrid[x][y] ;
    }
  }
}

void workGridInit() {
  println("workGridInit Started");
  for (int x = 0; x < 9 ; x++) {
    for (int y = 0; y < 9 ;y++) {
      if (grid[x][y] == 0 ) {
        for (int z = 1 ; z <= 9 ;z++) {
          println("x,y,z = ",x,y,z);
          workGrid[x][y][z] = true ;
        }
      }
    }
  }
  println("workGridInit Ended");
}

 
void drawGrid() {
  println("drawgrid Started");
  /* 1x1 boxes */
  stroke(255) ;
  fill(0) ;
  strokeWeight(4) ;

  for (int x = 0 ; x < 9 ; x++) { 
    for (int y = 0 ; y < 9 ; y++) {
      if ( (x/3 + y/3 * 3) % 2 == 0 ) { 
        if ( (x + y * 9) % 2 == 0 ) { 
          fill(180,160,160) ; 
        } else {
          fill(180,180,160) ;
        }
      } else {
        if ( (x + y * 9) % 2 == 0 ) { 
          fill(160,160,180) ; 
        } else {
          fill(160,180,180) ;
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
  println("drawGrid Ended");
}

void drawNumbers() {
  println("drawNumbers Started");
  int solvedCount = 0 ;
  for (int gridx = 0 ; gridx < 9 ; gridx++) {
    for (int gridy = 0 ; gridy < 9 ; gridy++) {
      textSize(100) ;
      int number = grid[gridx][gridy] ;
      if (number > 10) {
        solvedCount++ ;
        fill(10,10,255) ;
        String num = str(number - 10) ;
        text(num, gridx * boxsize + 68, gridy * boxsize + 138 ) ;
      } else if (number > 0) {
        solvedCount++ ;
        fill(10) ;
        String num = str(number) ;
        text(num, gridx * boxsize + 68, gridy * boxsize + 138 ) ;
      } else {
        textSize(28) ;
        fill(80) ;
        for (int x = 0 ; x < 3 ; x++) {
          for (int y = 0 ; y < 3 ; y++) {
            int candidate = y * 3 + x + 1 ;
            // println("gridx,gridy,candidate = ",gridx,gridy,candidate);
            String boxnum = str(candidate) ;
            if (workGrid[gridx][gridy][candidate] == true) {
              fill(10,10,255) ; // candidate is true so it is still a possibilty 
            } else {
              fill(220) ; // candidate is false so it has been eliminated  
            }
            text(boxnum, gridx * boxsize + 60 + x * 30, gridy * boxsize + 80 + y * 30 ) ;
          }
        }
      }
    }
  }
  if (solvedCount == 81 ) solved = true ;
  if (solved) noLoop() ;
  println("drawNumbers Ended");
}



void checkRow(int x, int y) {
  // [col][y]  is the location of the source square
  //   [x][y]  is the location of the target square (the hilighted one)
  for (int col = 0 ; col < 9 ; col ++) {
    if (grid[col][y] != 0) {       // only check source squares that are solved
      if (col != x) {         // don't check aginst self 
        int solved = grid[col][y] ;
        if (solved > 9) solved = solved - 10 ;  
        workGrid[x][y][solved] = false ; // remove candidate
      }
    }
  }
}

void checkCol(int x, int y) {
  // [x][row]  is the location of the source square
  // [x][y]    is the location of the target square (the hilighted one)
  for (int row = 0 ; row < 9 ; row ++) {
    if (grid[x][row] != 0) {  // only check source squares that are solved
      if (row != y) {         // don't check aginst self 
        int solved = grid[x][row] ;
        if (solved > 9) solved = solved - 10 ;  
        workGrid[x][y][solved] = false ; // remove candidate
      }
    }
  }
}

void checkBox(int x, int y) {
  // x and y are the actual position of the square to check
  // col and row need to be calculated from x and y
  // [col][row]  is the location of the source square
  // [x][y]      is the location of the target square (the hilighted one)
  int rowStart = floor(y * 1.0 / 3) * 3 ;
  int colStart = floor(x * 1.0 / 3) * 3 ;
  for (int row = rowStart ; row < (rowStart + 3) ; row++) {
    for (int col = colStart ; col < (colStart + 3) ; col++) {
      if (grid[col][row] != 0) {  // only check source squares that are solved
        if ((row != y) && (col != x)) {         // don't check aginst self 
          int solved = grid[col][row] ;
          if (solved > 9) solved = solved - 10 ;  
          workGrid[x][y][solved] = false ; // remove candidate
        }
      }      
    }
  }
}

void checkSqr(int x, int y) {
  int candCount = 0 ;
  int currentCand = 0 ;
  for (int candidate = 1 ; candidate < 10 ; candidate++ ) {
    if (workGrid[x][y][candidate] == true) {
      currentCand = candidate ;
      candCount++ ;
    }
  }
  // println("x,y,currentCand,candCount",x,y,currentCand,candCount) ;
  if (candCount == 1) {
    grid[x][y] = 10 + currentCand ;
  }
}

void hilite(int htype, int hx, int hy) {
  println("hilite Started");
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
    case 2:    // hilite box 3x3
      stroke(100,100,255) ;
      rect(offset +  boxsize * hx * 3, offset +  boxsize * hy * 3 , boxsize * 3 , boxsize * 3  ) ;
      break;
  }
  println("hilite Ended");
}

void hiliteSqr(int hx, int hy) {
      stroke(255,100,255) ;
      noFill() ;
      rect(offset +  boxsize * hx , offset +  boxsize * hy , boxsize , boxsize ) ;
}

void draw() {
  println("   ");  
  println("draw Started");
  background(0) ;
  drawGrid() ;
  drawNumbers() ;

  switch(checkStep) {
    case 0:    // hilite row
    hilite(checkStep,0,yy) ;
    if (newCheck) {
      sx = 0 ;
      newCheck = false ;
    }
    if (grid[sx][yy] == 0) {   // dont hilite or check this square if it is already solved 
      hiliteSqr(sx, yy) ; // hilite 1x1
      // check candidates against rest of square here
      checkRow(sx, yy)  ; //check square against all other squares in this row
    }
    sx++ ;
    if (sx > 8) {
      newCheck = true ;
      yy++ ;
      if (yy > 8) {
        yy = 0 ;
        checkStep++ ;
      } 
    }
    break ;

    case 1:    // hilite column
    hilite(checkStep,xx,0) ;
    if (newCheck) {
      sy = 0 ;
      newCheck = false ;
    }
    if (grid[xx][sy] == 0) {   // dont hilite or check this square if it is already solved    
      hiliteSqr(xx, sy) ; // hilite 1x1
      // check candidates against rest of square here ?
      checkCol(xx, sy)  ; //check square against all other squares in this col
    }
    sy++ ;
    if (sy > 8) {
      newCheck = true ;
      xx++ ;
      if (xx > 8) {
        xx = 0 ;
        checkStep++ ;
      } 
    }
    break ;

    case 2:    // hilite 3x3  
    hilite(checkStep,xx,yy) ;
    if (newCheck) {
      sx = 0 ;
      sy = 0 ;
      newCheck = false ;
    }
    if (grid[xx * 3 + sx][yy * 3 + sy] == 0) {   // dont hilite or check this square if it is already solved
      hiliteSqr(xx * 3 + sx, yy * 3 + sy) ; // hilite 1x1
      // check candidates against rest of square here ? 
      checkBox(xx * 3 + sx, yy * 3 + sy) ; //check square against all other squares in this box
    }
    sx++ ;
    if (sx > 2) {
      sx = 0 ;
      sy++ ;
      if (sy > 2) {
        sy = 0 ;
        newCheck = true ;
        xx++ ;
        if (xx > 2) {
          xx = 0 ;
          yy++ ;
          if (yy > 2) {
            yy = 0 ;
            checkStep++ ;
            newCheck = true ;
          }
        }
      }
    }
    break ;
    
    
    case 3:    // hilite 1x1  
    // hilite(checkStep,xx,yy) ;
    if (newCheck) {
      sx = 0 ;
      sy = 0 ;
      newCheck = false ;
    }
    if (grid[sx][sy] == 0) {   // dont hilite or check this square if it is already solved    
      hiliteSqr(sx, sy) ; // hilite 1x1
      // check to see if any square contains a single candidate (ie this square is solved)  
      checkSqr(sx, sy) ;  
    }
    sx++ ;
    if (sx > 8) {
      sx = 0 ;
      sy++ ;
      if (sy > 8) {
        sy = 0 ;
        checkStep++ ;
        newCheck = true ;
      }
    }
    break ;
    
  }
  if (checkStep > 3) {
    checkStep = 0 ;
    // noLoop() ;
  }
  if (solved) {
    checkStep = 9 ;
  }
  println("checkStep,newCheck,xx,yy,sx,sy",checkStep,newCheck,xx,yy,sx,sy) ;
  println("draw Ended");
}
