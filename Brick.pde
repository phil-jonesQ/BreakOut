class Brick {
  float x;
  float y;
  float w;
  float h;
  float w1;
  float w2;

  Brick(float xIn, float yIn) {

    x = xIn;
    y = yIn;
    w = scl;
    h = scl/3;
  }

  void show() {
    stroke(0);
    rect(x, y, w, h);
    //rect(x,y,w1,h);
  }
  
  float getX() {
   return x; 
  }
  
  float getY() {
   return y; 
  }
}