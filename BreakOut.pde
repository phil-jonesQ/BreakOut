ArrayList<Brick> wall = new ArrayList<Brick>();
public int scl = 30;
boolean adj;

Ball ball;


void mousePressed() {
    noLoop();
}


void setup () {
  size (600, 200);
  adj=false;
  adj = true;
  buildWall();
  ball = new Ball();
  frameRate(50);
}



void draw () {

  background(0);
  drawWall();
  drawBall();
  moveBall();
}


void buildWall() {
  float x = 0;
  float y = 0;
  int wallRow = 5;
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

void moveBall() {
   
  ball.move(adj);
  adj=false;
}