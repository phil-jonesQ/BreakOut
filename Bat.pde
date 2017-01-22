class Bat {

  float x;
  float y;
  float w;
  float h;
  float speed;

  Bat() {

    w=scl*4;
    h=scl/2;
    x=width/2-scl*2;
    y=height-h;
    speed=5;
  }


  void show() {

    noStroke();
    fill(255);
    rect(x, y, w, h);
  }


  void move(boolean direction) {

    if (direction) {

      x=x+speed;
    } else {
      x=x-speed;
    }

    if (x>width-w) {

      x = width-w;
    }
    if (x<0) {

      x = 0;
    }
  }

  float getX() {

    return x;
  }

  float getY() {

    return y;
  }
}