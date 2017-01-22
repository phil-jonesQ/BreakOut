ArrayList<Brick> wall = new ArrayList<Brick>();
public int scl = 30;
boolean adj;
boolean dead;
Ball ball;
Bat bat;


void mousePressed() {
  noLoop();
  init();
  loop();
}


void setup () {
  size (600, 400);
  buildWall();
  removeBricks();
  ball = new Ball();
  bat = new Bat();
  adj=true;
  dead=false;
  frameRate(50);
}



void draw () {
  background(0);
  drawWall();
  drawBall();
  moveBall();
  drawBat();
  moveBat();
  checkGameOver();
}


void buildWall() {
  float x = 0;
  float y = 0;
  int wallRow = 8;
  int wallCourse = width/scl;
  for (int j=0; j < wallRow; j++) {
    for (int i=0; i < wallCourse; i++) {
      wall.add(new Brick(x, y));
      x = x+scl;
    }
    if (x > width-scl) {
      x =0;
      y = y +scl/3;
    }
  }
}


void drawWall() {
  for (int i=0; i < wall.size(); i++) {
    wall.get(i).show();
  }
}

void drawBall() {
  ball.show();
}

void drawBat() {
  bat.show();
}

void moveBall() {
  ball.move(adj);
  adj=false;
}

void moveBat() {

  if (key == CODED) {
    if (keyCode == RIGHT) {
      bat.move(true);
    }
    if (keyCode == LEFT) {
      bat.move(false);
    }
  }

  //

  //if (mouseX > width/2-scl) {
  //  bat.move(true);
  //}
  //if (mouseX < width/2-scl) {

  //  bat.move(false);
  //}
}

void checkGameOver() {
  if (ball.checkDead()) {
    noLoop();
  }
}

// This can be developed into some kind of level system / pattern generation
void removeBricks() {
  for (int i=0; i < wall.size(); i++) {
    float x = wall.get(i).getX();
    float y = wall.get(i).getY();
    if (x == width/2 || x == width/4 || x == width-scl*2) {
      wall.remove(i);
    }
  }
}

void destroyWall() {
  for (int i=0; i < wall.size(); i++) {
    wall.remove(i);
  }
}

void init() {
  destroyWall();
  buildWall();
  removeBricks();
  adj=true;
  ball = new Ball();
  bat = new Bat();
}