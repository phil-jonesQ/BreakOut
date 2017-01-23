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
    speed=10;
  }

  void show() {
    noStroke();
    fill(255);
    rect(x, y, w, h);
  }

  void move(float direction) {
    if (direction==1) {
      x=x+speed;
    }
    if (direction==-1) {
      x=x-speed;
    }
    if (x>width-scl*2) {
      x = width-scl*2;
    }
    if (x<0-scl*2) {
      x = -scl*2;
    }
  }

  float getX() {
    return x;
  }

  float getY() {
    return y;
  }
}