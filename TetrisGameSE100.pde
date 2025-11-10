// this version has a comment

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


int[][] floorBlocks = new int[COLS][ROWS];  // One int per grid cell

Shape currentShape;

int initalShape = int(random(7));

void setup() {
  size(800, 800);
  currentShape = new Shape(initalShape, 3, 0);
}


void draw() {
  background(155); // light gray background
  drawGrid();

  blockPhysics(level);
  buttonLogic();


  greenRectangle();

  //randomize shape ID
  // drawShape(2, 0 + shapeX, 0 + shapeY);

  drawFloor();

  // Draw current shape
  if (currentShape != null) {
    currentShape.display();
    currentShape.drawTestBox();
    currentShape.displayGhost();
  }


  debug();
  clearHeldButtons();
}

void drawGrid() {



  noFill();
  stroke(180);

  for (int j = 0; j < ROWS; j++) {


    int y = startY + (j * GRIDSIZE);
    for (int i = 0; i < COLS; i++) {
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



void blockPhysics(int level) {
  switch (level) {
  case 0:
    if (frameCount % 60 == 0) {               // every second
      // ---- NEW ----
      if (currentShape.canMove(0, 1, 0)) {    // can we move DOWN?
        currentShape.move(0, 1);
      } else {
        lockShape();
        currentShape = newRandomShape();
      }
    }
    break;
  }

  // Manual down press
  if (downPressed == 1) {
    if (currentShape.canMove(0, 1, 0)) {
      currentShape.move(0, 1);
    }
  }
}

void clearHeldButtons() {
  upPressed = 0;
  downPressed = 0;
  leftPressed = 0;
  rightPressed = 0;
  dropPressed = 0;
}

void buttonLogic() {
  if (leftPressed == 1) {
    if (currentShape.canMove(-1, 0, 0)) {  // Check if left move is possible
      currentShape.move(-1, 0);
    }
  }
  if (rightPressed == 1) {
    if (currentShape.canMove(1, 0, 0)) {  // Check if right move is possible
      currentShape.move(1, 0);
    }
  }
  if (upPressed == 1) {
    if (currentShape.canMove(0, 0, 1)) {  // Check if rotation is possible
      currentShape.rotate();
    }
  }

  if (dropPressed == 1) {
    // Drop as far as possible
    while (currentShape.canMove(0, 1, 0)) {
      currentShape.move(0, 1);
    }
    lockShape();  // Lock immediately after dropping
    currentShape = newRandomShape();
    dropPressed = 0;  // Reset to prevent repeat drops
  }
}

void lockShape() {
  int[][] grid = currentShape.getGrid();
  for (int row = 0; row < 4; row++) {
    for (int col = 0; col < 4; col++) {
      if (grid[row][col] == 1) {
        int gridX = currentShape.x + col;
        int gridY = currentShape.y + row;
        // Only lock if ON SCREEN (safety)
        if (gridX >= 0 && gridX < COLS && gridY >= 0 && gridY < ROWS) {
          floorBlocks[gridX][gridY] = currentShape.id + 1;
        }
      }
    }
  }
}

Shape newRandomShape() {
  int id = (int)random(7);  // 0-6
  return new Shape(id, 3, 0);  // Start near center-top
}





void debug() {

  fill(0);
  stroke(0);
  text("frameCount: " + frameCount, 10, 10);
  text("frameRate: "  +  frameRate, 10, 30);
  text("ticks: "  +  ticks, 10, 50);

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





class Shape {
  int id;           // 0-6 for each piece
  int rot;          // 0-3
  int x, y;         // Grid position (top-left of 4x4 bounding box)
  color col;        // Color of the piece

  Shape(int id, int startX, int startY) {
    this.id = id;
    this.x = startX;
    this.y = startY;
    this.rot = 0;
    this.col = getColor(id);
  }

  // Get current rotation grid
  int[][] getGrid() {
    return TETROMINOES[id][rot];
  }

  // Move in grid units
  void move(int dx, int dy) {
    x += dx;
    y += dy;
  }



  // Rotate clockwise
  void rotate() {
    rot = (rot + 1) % 4;
  }

  // Draw the shape
  void display() {
    int[][] grid = getGrid();
    for (int row = 0; row < 4; row++) {
      for (int col = 0; col < 4; col++) {
        if (grid[row][col] == 1) {
          int px = startX + (x + col) * GRIDSIZE;
          int py = startY + (y + row) * GRIDSIZE;
          fill(getColor(id));
          stroke(0);
          rect(px, py, GRIDSIZE, GRIDSIZE);
        }
      }
    }
  }

  void drawTestBox() {
    noFill();
    stroke(255, 0, 0);
    rect(startX + (x*GRIDSIZE), startY + (y*GRIDSIZE), GRIDSIZE*4, GRIDSIZE*4);
    text("x: " + x + " ; y: " + y, startX + (x * GRIDSIZE), startY + (y * GRIDSIZE) - 10);
  }


  // Helper: get color by ID
  color getColor(int id) {
    color[] colors = {
      color(0, 255, 255), // I: Cyan
      color(255, 255, 0), // O: Yellow
      color(255, 0, 255), // T: Purple
      color(0, 0, 255), // J: Blue
      color(255, 165, 0), // L: Orange
      color(0, 255, 0), // S: Green
      color(255, 0, 0)      // Z: Red
    };
    return colors[id];
  }

  // Returns true if the move/rotation is VALID (no collision)
  boolean canMove(int dx, int dy, int drot) {

    int testX = x + dx;
    int testY = y + dy;
    int testRot = (rot + drot + 4) % 4;  // +4 prevents negative

    int[][] testGrid = TETROMINOES[id][testRot];

    // Check all 16 cells of the shape
    for (int row = 0; row < 4; row++) {
      for (int col = 0; col < 4; col++) {
        if (testGrid[row][col] == 1) {
          int gridX = testX + col;
          int gridY = testY + row;

          // WALL collision
          if (gridX < 0 || gridX >= COLS) return false;
          if (gridY >= ROWS) {
            println("gridY: " + gridY);
            return false;  // FLOOR
          }
          // BLOCK collision (with floorBlocks)
          if (gridY >= 0 && floorBlocks[gridX][gridY] > 0) {
            return false;
          }
        }
      }
    }
    return true;
  }


  int getDropDistance() {
    int distance = 0;
    while (canMove(0, 1, 0)) {
      move(0, 1);
      distance++;
    }
    // Move back up
    move(0, -distance);
    return distance;
  }

  void displayGhost() {
    int dropDist = getDropDistance();
    int ghostY = y + dropDist;

    int[][] grid = getGrid();
    for (int row = 0; row < 4; row++) {
      for (int col = 0; col < 4; col++) {
        if (grid[row][col] == 1) {
          int px = startX + (x + col) * GRIDSIZE;
          int py = startY + (ghostY + row) * GRIDSIZE;

          // Semi-transparent ghost (50% opacity)
          fill(red(col), green(col), blue(col), 100);
          stroke(255, 255, 255, 150);  // White outline
          rect(px, py, GRIDSIZE, GRIDSIZE);
        }
      }
    }
  }
}



final int[][][][] TETROMINOES = {
  // 0: I-piece (Cyan)
  {
    {{0, 0, 0, 0}, {1, 1, 1, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}}, // flat
    {{0, 0, 1, 0}, {0, 0, 1, 0}, {0, 0, 1, 0}, {0, 0, 1, 0}}, // upright
    {{0, 0, 0, 0}, {1, 1, 1, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}}, // flat
    {{0, 0, 1, 0}, {0, 0, 1, 0}, {0, 0, 1, 0}, {0, 0, 1, 0}}  // upright
  },
  // 1: O-piece (Yellow) - all rotations identical
  {
    {{0, 0, 0, 0}, {0, 1, 1, 0}, {0, 1, 1, 0}, {0, 0, 0, 0}},
    {{0, 0, 0, 0}, {0, 1, 1, 0}, {0, 1, 1, 0}, {0, 0, 0, 0}},
    {{0, 0, 0, 0}, {0, 1, 1, 0}, {0, 1, 1, 0}, {0, 0, 0, 0}},
    {{0, 0, 0, 0}, {0, 1, 1, 0}, {0, 1, 1, 0}, {0, 0, 0, 0}}
  },
  // 2: T-piece (Purple)
  {
    {{0, 1, 0, 0}, {1, 1, 1, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, // point up
    {{0, 1, 0, 0}, {0, 1, 1, 0}, {0, 1, 0, 0}, {0, 0, 0, 0}}, // point right
    {{0, 0, 0, 0}, {1, 1, 1, 0}, {0, 1, 0, 0}, {0, 0, 0, 0}}, // point down
    {{0, 1, 0, 0}, {1, 1, 0, 0}, {0, 1, 0, 0}, {0, 0, 0, 0}}  // point left
  },
  // 3: S-piece (Green)
  {
    {{0, 1, 1, 0}, {1, 1, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, // flat (right skew)
    {{0, 1, 0, 0}, {0, 1, 1, 0}, {0, 0, 1, 0}, {0, 0, 0, 0}}, // upright
    {{0, 0, 0, 0}, {0, 1, 1, 0}, {1, 1, 0, 0}, {0, 0, 0, 0}}, // flat (left skew)
    {{1, 0, 0, 0}, {1, 1, 0, 0}, {0, 1, 0, 0}, {0, 0, 0, 0}}  // upright
  },
  // 4: Z-piece (Red)
  {
    {{1, 1, 0, 0}, {0, 1, 1, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, // flat (left skew)
    {{0, 0, 1, 0}, {0, 1, 1, 0}, {0, 1, 0, 0}, {0, 0, 0, 0}}, // upright
    {{0, 0, 0, 0}, {1, 1, 0, 0}, {0, 1, 1, 0}, {0, 0, 0, 0}}, // flat (right skew)
    {{0, 1, 0, 0}, {1, 1, 0, 0}, {1, 0, 0, 0}, {0, 0, 0, 0}}  // upright
  },
  // 5: J-piece (Blue)
  {
    {{1, 0, 0, 0}, {1, 1, 1, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, // point up
    {{0, 1, 1, 0}, {0, 1, 0, 0}, {0, 1, 0, 0}, {0, 0, 0, 0}}, // point right
    {{0, 0, 0, 0}, {1, 1, 1, 0}, {0, 0, 1, 0}, {0, 0, 0, 0}}, // point down
    {{0, 1, 0, 0}, {0, 1, 0, 0}, {1, 1, 0, 0}, {0, 0, 0, 0}}  // point left
  },
  // 6: L-piece (Orange)
  {
    {{0, 0, 1, 0}, {1, 1, 1, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, // point up
    {{0, 1, 0, 0}, {0, 1, 0, 0}, {0, 1, 1, 0}, {0, 0, 0, 0}}, // point right
    {{0, 0, 0, 0}, {1, 1, 1, 0}, {1, 0, 0, 0}, {0, 0, 0, 0}}, // point down
    {{1, 1, 0, 0}, {0, 1, 0, 0}, {0, 1, 0, 0}, {0, 0, 0, 0}}  // point left
  }
};

color getPieceColor(int id) {
  color[] colors = {
    color(0, 255, 255), // I: Cyan
    color(255, 255, 0), // O: Yellow
    color(255, 0, 255), // T: Purple
    color(0, 0, 255), // J: Blue
    color(255, 165, 0), // L: Orange
    color(0, 255, 0), // S: Green
    color(255, 0, 0)      // Z: Red
  };
  return colors[id];
}

void drawFloor() {
  for (int x = 0; x < COLS; x++) {
    for (int y = 0; y < ROWS; y++) {
      if (floorBlocks[x][y] > 0) {
        int pieceId = floorBlocks[x][y] - 1;
        fill(getPieceColor(pieceId));
        stroke(0);
        rect(startX + x * GRIDSIZE, startY + y * GRIDSIZE, GRIDSIZE, GRIDSIZE);
      }
    }
  }
}
