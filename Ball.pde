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
    r=16;
    speed=5;
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

    //println("RightEdge is " + rightEdge + " LeftEdgeis " +leftEdge + " BottomEdge is " + bottomEdge + " TopEdge is " + topEdge);

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

    ballCollidesWithWall();
    if (ballCollidesWithBat()) {
      bottomEdge=true;
      up=true;
      right=true;
      topEdge=false;
      x=x+0.55;
    }
  }

  void ballCollidesWithWall() {
    //Does the ball hit a wall element, if so, remove it and react
    //Going Up Version
    if (bottomEdge) {
      for (int i=wall.size()-1; i > 0; i--) {
        float rectW=scl;
        float rectH=scl/3;
        float brickX = wall.get(i).getX();
        float brickY = wall.get(i).getY();
        float distX = Math.abs(x - brickX-(rectW/2));
        float distY = Math.abs(y - brickY-(rectH/2));
        float d;
        boolean wallRemove=false;
        //println (x, y, brickX, brickY);
        if (distX > (rectW/2 + r)) { 
          wallRemove=false;
        }
        if (distY > (rectH/2 + r)) { 
          wallRemove=false;
        }
        if (distY <= (rectH/2) && distX <= (rectW/2)) { 
          wallRemove=true;
        }
        if (wallRemove) {
          wall.remove(i);
          wallRemove=false;
          topEdge=true;
          down=true;
          bottomEdge=false;
          x=x+0.55;
        }
      }
    }
    if (topEdge) {
      for (int i=wall.size()-1; i >= 0; i--) {
        float rectW=scl;
        float rectH=scl/3;
        float brickX = wall.get(i).getX();
        float brickY = wall.get(i).getY();
        float distX = Math.abs(x - brickX-(rectW/2));
        float distY = Math.abs(y - brickY-(rectH/2));
        float d;
        boolean wallRemove=false;
        //println (x, y, brickX, brickY);
        if (distX > (rectW/2 + r)) { 
          wallRemove=false;
        }
        if (distY > (rectH/2 + r)) { 
          wallRemove=false;
        }
        if (distY <= (rectH/2) && distX <= (rectW/2)) { 
          wallRemove=true;
        }
        if (wallRemove) {
          wall.remove(i);
          bottomEdge=true;
          up=true;
          topEdge=false;
          x=x+0.55;
        }
      }
    }
  }

  boolean ballCollidesWithBat() {
    float rectW=scl*4;
    float rectH=scl/2;
    float batX = bat.getX();
    float batY = bat.getY();
    float distX = Math.abs(x - batX-rectW/2);
    float distY = Math.abs(y - batY-rectH/2);
    if (distX > (rectW/2 + r)) { 
      return false;
    }
    if (distY > (rectH/2 + r)) { 
      return false;
    }
    if (distX <= (rectW/2)) { 
      return true;
    } 
    if (distY <= (rectH/2)) { 
      return true;
    }
    return false;
  }
  boolean checkDead() {
    if (y>height) { 
      return true;
    }
    return false;
  }
}