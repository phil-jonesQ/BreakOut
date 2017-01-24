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
  float randomizer;
  float randomizer1;

  Ball() {
    x=width/2;
    y=height/2;
    r=16;
    speed=3.5;
    randomizer=random(1.5, 1.9);
    randomizer1=random(1.5, 2.1);
  }
  void show() {
    noStroke();
    fill(255);
    ellipse(x, y, r, r);
  }
  void move(boolean adj) {   

    //println(randomizer);
    //Start or adjust ball bounce point
    if (adj) {
      down=true;
      up=false;
      left=false;
      right=false;
    } 
    if (down && !bottomEdge) {
      y=y+speed+randomizer;
    }

    if (up && !topEdge) {
      y=y-speed*randomizer1;
    }

    if (right && !rightEdge) {
      x=x+speed*randomizer;
    }

    if (left && !leftEdge) {
      x=x-speed*randomizer1;
    }
    //Debug
    //println("RightEdge is " + rightEdge + " LeftEdgeis " +leftEdge + " BottomEdge is " + bottomEdge + " TopEdge is " + topEdge);
    //println("go left=" + left + "go right=" + right + "go down=" + down + "go up " + up);
    if (x>width) {
      rightEdge=true;
      leftEdge=false;
      left=true;
      right=false;
      up=true;
    }

    if (x<0) {
      leftEdge=true;
      rightEdge=false;
      right=true;
      left=false;
      down=true;
    }

    if (y>height) {
      bottomEdge=true;
      up=true;
      right=true;
      left=false;
      topEdge=false;
    }

    if (y<0) {
      topEdge=true;
      down=true;
      up=false;
      bottomEdge=false;
    }

    ballCollidesWithWall();
    if (ballCollidesWithBat()) {
      randomizer=random(1.3, 2.1);
      randomizer1=random(1.5, 2.1);
      bottomEdge=true;
      up=true;
      down=false;
      float ballOnBatPos = getBallOnBatPos();
      //println (ballOnBatPos);
      if (ballOnBatPos > 60) { //Ball hits right part
        right=true;
        left=false;
        rightEdge=false;
        leftEdge=true;
        randomizer=randomizer+ballOnBatPos/100;
      } else if (ballOnBatPos < 45) { //Ball hits left part
        left=true;
        right=false;
        rightEdge=true;
        leftEdge=false;
        randomizer=randomizer+ballOnBatPos/100;
      } else { //Ball is about centre
        bottomEdge=true;
        up=true;
        right=true;
        left=false;
        topEdge=false;
        randomizer=randomizer+ballOnBatPos/100;
      }
      topEdge=false;
      //x=x-0.55;
    }
  }

  void ballCollidesWithWall() {
    //Does the ball hit a wall element, if so, remove it and react
    //Going Up Version
    if (bottomEdge) {
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
        if (distX > (rectW/2 + r) || distY > (rectH/2 + r)) { 
          wallRemove=false;
        }
        if (distY <= (rectH/2) && distX <= (rectW/2)) { 
          wallRemove=true;
        }
        if (wallRemove) {
          score=score+1;
          wall.remove(i);
          wallRemove=false;
          topEdge=true;
          down=true;
          up=false;
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
        if (distX > (rectW/2 + r) || distY > (rectH/2 + r)) { 
          wallRemove=false;
        }
        if (distY <= (rectH/2) && distX <= (rectW/2)) { 
          wallRemove=true;
        }
        if (wallRemove) {
          score=score+1;
          wall.remove(i);
          wallRemove=false;
          bottomEdge=true;
          up=true;
          down=false;
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
      //println("distX value= "+ distX);
      //noLoop();
      return true;
    } 
    if (distY <= (rectH/2)) {
      //println("distY value= "+ distY);
      //noLoop();
      return true;
    }
    return false;
  }

  float getBallOnBatPos() {
    float batX = bat.getX();
    float batY = bat.getY();
    float distX = dist(x, y, batX, batY);
    return distX;
  }
  boolean checkDead() {
    if (y>height) { 
      return true;
    }
    return false;
  }
}