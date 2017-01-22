//Break Out V3.0
//Working Game with average collision detection
//To do: Win and Levels
//Sound - maybe colour but quite like the BW retro feel
//phil.jones.24.4@gmail.com


ArrayList<Brick> wall = new ArrayList<Brick>();
public int scl = 30;
boolean adj;
boolean dead;
boolean start;
Ball ball;
Bat bat;


void mousePressed() {
  noLoop();
  init();
  loop();
}


void setup () {
  size (600, 400);
  frameRate(50);
  buildWall();
  removeBricks();
  ball = new Ball();
  bat = new Bat();
  adj=true;
  dead=false;
  start=false;
}



void draw () {
  if (!start) {
    noLoop();
  }
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
  if (key == CODED && keyPressed) {
    if (keyCode == RIGHT) {
      bat.move(1);
    }
    if (keyCode == LEFT && keyPressed) {
      bat.move(-1);
    }
    if (keyCode == CONTROL) {

      noLoop();
    }
  }
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
    if (x == width/2-scl || x == width/2 || x == width-scl-(scl*2) || x == scl*2) {
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
  start=true;
}