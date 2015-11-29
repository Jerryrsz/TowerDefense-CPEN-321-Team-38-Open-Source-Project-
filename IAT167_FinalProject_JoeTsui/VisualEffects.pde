abstract class Effect {

  float x;
  float y;
  int timer = 0;
  int MAX_TIME;
  boolean removeMe = false;

  public Effect() {
  }

  public Effect(float x, float y, int MAX_TIME) {
    this.x = x;
    this.y = y;
    this.MAX_TIME = MAX_TIME;
    timer = MAX_TIME;
  }

  void draw() {
    if (timer > 0) {
      pushMatrix();
      translate(x, y);
      drawEffect();
      popMatrix();
      timer--;
    } else {
      removeMe = true;
    }
  } 

  abstract void drawEffect();
}

class LaserEffect extends Effect {

  PVector start, end;
  float speed;

  public LaserEffect(float speed, PVector start, PVector end) {
    this.MAX_TIME = (int)(PVector.dist(start, end) / speed);
    timer = MAX_TIME;
    this.speed = speed;
    this.start = start.get();
    this.end = end.get();
  }

  @Override
    void drawEffect() {
    stroke(0, 0, 255, 126 * (float)timer / MAX_TIME);
    line(start.x, start.y, end.x, end.y);
    noStroke();
    start.add(PVector.mult(PVector.sub(end, start).normalize(null), speed / 2.0));
  }
}

