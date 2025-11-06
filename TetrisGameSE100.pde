

int width = 800;
int height = 800;

int GRIDSIZE = 30;
int ROWS = 20;
int COLS = 10;

int level = 0;

int upPressed = 0;
int downPressed = 0;
int leftPressed = 0;
int rightPressed = 0;
int dropPressed = 0;

int ticks = 0;


// define upper left-corner of play area as startX,startY
int startX = (width/2) - ((COLS/2) * GRIDSIZE);
int startY = (height/2) - ((ROWS/2) * GRIDSIZE);

boolean shapeActive = true;
int shapeId = 2;
int shapeY = 0;
int shapeX = 0;


void setup() {
  size(800, 800);
}


void draw() {
  background(155); // light gray background

  updateTicks(level);
  drawGrid();
  greenRectangle();

  //randomize shape ID
  drawShape(2, 0 + shapeX, 0 + shapeY);
  buttonLogic();
  debug();
  
  
  
  clearHeldButtons();
 

  
}

void drawGrid() {



  noFill();
  stroke(180);

  for (int j = 0; j < ROWS - 1; j++) {


    int y = startY + (j * GRIDSIZE);
    for (int i = 0; i < COLS - 1; i++) {
      int x = startX + (i * GRIDSIZE);
      rect(x, y, GRIDSIZE, GRIDSIZE);
    }
  }
}

void greenRectangle() {
  //draw a green rectangle at 0,0
  noStroke();
  fill(0, 255, 0);
  rect(0, 0, 10, 10);
}

void updateTicks(int level) {
 
  switch (level) {
  case 0 :
    if (frameCount % 80 == 0) {
      ticks++;
      if (shapeY <= 17) {
        shapeY++;
      } else {
        shapeY = 0;
      }
    }
    break;
  
  }
}

void clearHeldButtons(){
 upPressed = 0;
 downPressed = 0;
 leftPressed = 0;
 rightPressed = 0;
 dropPressed = 0;
}

void buttonLogic() {
  
  if(leftPressed == 1 && shapeX >= 0) shapeX--;
  if(rightPressed == 1 && shapeX <= 5) shapeX++; 
  
}


void drawShape(int id, int x, int y) {

  switch(id) {
  case 0 :
    // draw test 3x3 square
    noFill();
    stroke(1);
    rect(startX + (x * GRIDSIZE), startY + (y * GRIDSIZE), GRIDSIZE * 3, GRIDSIZE * 3);
    break;

  case 1 :
    // draw test 4x4 square
    noFill();
    stroke(1);
    rect(startX + (x * GRIDSIZE), startY + (y * GRIDSIZE), GRIDSIZE * 4, GRIDSIZE * 4);
    break;

  case 2 :
    // draw test 2x2 block tile
    noFill();
    stroke(255, 0, 0);
    rect(startX + (x * GRIDSIZE), startY + (y * GRIDSIZE), GRIDSIZE * 4, GRIDSIZE * 3);

    stroke(0);
    fill(220, 220, 0);
    rect(startX + ((x+1) * GRIDSIZE), startY + ((y) * GRIDSIZE), GRIDSIZE, GRIDSIZE);
    rect(startX + ((x+1) * GRIDSIZE), startY + ((y+1) * GRIDSIZE), GRIDSIZE, GRIDSIZE);
    rect(startX + ((x+2) * GRIDSIZE), startY + ((y) * GRIDSIZE), GRIDSIZE, GRIDSIZE);
    rect(startX + ((x+2) * GRIDSIZE), startY + ((y+1) * GRIDSIZE), GRIDSIZE, GRIDSIZE);
    break;


  case 3 :
    // draw test 2x2 block tile
    noFill();
    stroke(255, 0, 0);
    rect(startX + (x * GRIDSIZE), startY + (y * GRIDSIZE), GRIDSIZE * 4, GRIDSIZE * 4);

    stroke(0);
    fill(220, 220, 0);
    rect(startX + (x+1 * GRIDSIZE), startY + ((y) * GRIDSIZE), GRIDSIZE, GRIDSIZE);
    rect(startX + (x+1 * GRIDSIZE), startY + ((y+1) * GRIDSIZE), GRIDSIZE, GRIDSIZE);
    rect(startX + (x+2 * GRIDSIZE), startY + ((y) * GRIDSIZE), GRIDSIZE, GRIDSIZE);
    rect(startX + (x+2 * GRIDSIZE), startY + ((y+1) * GRIDSIZE), GRIDSIZE, GRIDSIZE);
    break;
  }
}


void debug() {

  fill(0);
  stroke(0);
  text("frameCount: " + frameCount,10,10);
  text("frameRate: "  +  frameRate,10,30);
  text("ticks: "  +  ticks,10,50);
  
  // debug border
  noFill();
  stroke(0);
  rect(0, height - 200, 200, 200);

  // A button
  stroke(0);
  noFill();

  if (leftPressed != 0) {
    fill(0, 255, 0);
  } else {
    noFill();
  }
  rect(0, height-100, 50, 50);

  // S button
  stroke(0);
  noFill();

  if (downPressed != 0) {
    fill(0, 255, 0);
  } else {
    noFill();
  }
  rect(50, height-100, 50, 50);


  // D button
  noFill();
  stroke(0);
  if (rightPressed != 0) {
    fill(0, 255, 0);
  } else {
    noFill();
  }
  rect(100, height-100, 50, 50);

  // W button
  stroke(0);
  noFill();
  if (upPressed != 0) {
    fill(0, 255, 0);
  } else {
    noFill();
  }
  rect(50, height-150, 50, 50);

  // Space button
  stroke(0);
  noFill();
  if (dropPressed != 0) {
    fill(0, 255, 0);
  } else {
    noFill();
  }
  rect(0, height-50, 150, 50);
}



void keyPressed() {

  if (key == 'A' || key == 'a') {
    leftPressed = 1;
  }

  if (key == 'W' || key == 'w') {
    upPressed = 1;
  }

  if (key == 'S' || key == 's') {
    downPressed = 1;
  }

  if (key == 'D' || key == 'd') {
    rightPressed = 1;
  }

  if (key == ' ') {
    dropPressed = 1;
  }


  if (key == CODED) {
    if (keyCode == UP) {
      upPressed = 1;
    }

    if (keyCode == DOWN) {
      downPressed = 1;
    }

    if (keyCode == LEFT) {
      leftPressed = 1;
    }

    if (keyCode == RIGHT) {
      rightPressed = 1;
    }
  }
}


void keyReleased() {

  if (key == 'A' || key == 'a') {
    leftPressed = 0;
  }

  if (key == 'W' || key == 'w') {
    upPressed = 0;
  }

  if (key == 'S' || key == 's') {
    downPressed = 0;
  }

  if (key == 'D' || key == 'd') {
    rightPressed = 0;
  }

  if (key == ' ') {
    dropPressed = 0;
  }


  if (key == CODED) {
    if (keyCode == UP) {
      upPressed = 0;
    }

    if (keyCode == DOWN) {
      downPressed = 0;
    }

    if (keyCode == LEFT) {
      leftPressed = 0;
    }

    if (keyCode == RIGHT) {
      rightPressed = 0;
    }
  }
}
