class Ball {

  float x;
  float y;
  float r;
  float speed;
  boolean topEdge;
  boolean bottomEdge;
  boolean rightEdge;
  boolean leftEdge;
  boolean down; 
  boolean up; 
  boolean right;
  boolean left;

  Ball() {

    x=width/2;
    y=height/2;
    r=20;
    speed =10;
  }



  void show() {

    noStroke();
    fill(255);
    ellipse(x, y, r, r);
  }


  void move(boolean adj) {
    //Start or adjust ball bounce point
    if (adj) {
      down=true;
      up=false;
      left=false;
      right=false;
    }   
    if (down && !bottomEdge) {
      y=y+speed;
    }

    if (up && !topEdge) {
      y=y-speed;
    }

    if (right && !rightEdge) {
      x=x+speed;
    }

    if (left && !leftEdge) {
      x=x-speed;
    }

    // Constraint

    if (x>width) {
      rightEdge=true;
      leftEdge=false;
      left=true;
      up=true;
    }

    if (x<0) {
      leftEdge=true;
      rightEdge=false;
      right=true;
      down=true;
    }

    if (y>height) {
      bottomEdge=true;
      up=true;
      right=true;
      topEdge=false;
    }

    if (y<0) {
      topEdge=true;
      down=true;
      bottomEdge=false;
    }

    //Does the ball hit a wall element, if so, remove it and react
    for (int i=0; i < wall.size(); i++) {
      float brickX = wall.get(i).getX();
      float brickY = wall.get(i).getY();
      float d = dist(x+r/2, y, brickX+scl/2, brickY);
      //println (d);
      if (d < 10) {
        wall.remove(i);
        topEdge=true;
        down=true;
        bottomEdge=false;
        x=x+0.55;
      }
    }
  }
}