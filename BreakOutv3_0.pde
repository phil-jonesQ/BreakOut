//Break Out V3.02
//Working Game with average collision detection
//phil.jones.24.4@gmail.com


ArrayList<Brick> wall = new ArrayList<Brick>();
public int scl = 30;
public int level;
public int rowAmnt=8;
public int lives;
boolean adj;
boolean dead;
boolean start;
Ball ball;
Bat bat;
PFont f;


void mousePressed() {
  noLoop();
  init();
  loop();
}


void setup () {
  size (600, 400);
  frameRate(50);
  level=1;
  buildWall();
  removeBricks();
  ball = new Ball();
  bat = new Bat();
  adj=true;
  dead=false;
  start=false;
  f = createFont("Arial", 50, true);
  lives=4;
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
  checkWon();
}


void buildWall() {
  float x = 0;
  float y = 0;
  int wallRow = level+rowAmnt;
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
  }
}

void checkGameOver() {
  if (ball.checkDead()) {
    lives=lives-1;
    start=false;
    partialInit();    
  } 
  if (lives <=0 ) {
    pushMatrix();
    textFont(f, 12);                  
    fill(255, 0, 0);
    textAlign(CENTER);
    text("GAME OVER!!", width/2, height/2);
    text("CLICK TO TRY AGAIN!!", width/2, height/2-scl*2);
    stroke(255);
    noLoop();
    popMatrix();
  }
}

// This can be developed into some kind of level system / pattern generation
void removeBricks() {
  for (int i=wall.size()-1; i >=0; i--) {
    float x = wall.get(i).getX();
    float y = wall.get(i).getY();
    if (level <= 1) {
      if (x == width/2-scl || x == width/2 || x == width-scl-(scl*2) || x == scl*2) {
        wall.remove(i);
      }
    }
    if (level > 1) {
      for (int j=0; j <= width-scl/scl; j++) {
        if (x == scl*j && y>scl && y<scl*2) {
          wall.remove(i);
        }
      }
    }
  }
}

void destroyWall() {
  for (int i=wall.size()-1; i >=0; i--) {
    wall.remove(i);
  }
}

void checkWon() {
  if (wall.size() == 0) {
    destroyWall();
    level=level+1;
    buildWall();
    removeBricks();
    adj=true;
    ball = new Ball();
    bat = new Bat();
    start=true;
  }
}

void init() {
  destroyWall();
  level=1;
  lives=4;
  buildWall();
  removeBricks();
  adj=true;
  ball = new Ball();
  bat = new Bat();
  start=true;
}

void partialInit() {
  ball = new Ball();
  bat = new Bat();
  start=true;
  adj=true;
}