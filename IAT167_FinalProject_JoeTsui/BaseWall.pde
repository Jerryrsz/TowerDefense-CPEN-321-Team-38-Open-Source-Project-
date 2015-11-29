class BaseWall extends Actor {

  int WALL_WIDTH = 15;
  int WALL_HEIGHT = 30;

  public BaseWall() {
    super();
  }

  public BaseWall(float x, float y) {
    super(x, y);
  }

  @Override
    void draw() {
    pushMatrix();
    translate(pos.x - WALL_WIDTH / 2, pos.y - WALL_HEIGHT / 2);
    noStroke();
    for (int i = 0; i < 6; i++) {
      for (int j = 0; j < 3; j++) {
        fill(((i + j) % 2 == 0) ? 0 : 255);
        rect(WALL_WIDTH * j / 3.0, WALL_HEIGHT * i / 6.0, WALL_WIDTH / 3.0, WALL_HEIGHT / 6.0);
      }
    }
    popMatrix();
  }
}

