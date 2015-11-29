
class Space {

  static final int SPACE_WIDTH = 30;
  static final int SPACE_HEIGHT = 30;

  PVector pos;

  public Space() {
    this(0, 0);
  }

  public Space(int x, int y) {
    pos = new PVector(x, y);
  }

  void draw() {
    pushMatrix();
    translate(pos.x, pos.y);
    noStroke();
    if ((int)((pos.x + pos.y) / Space.SPACE_WIDTH) % 2 != 0) {
      image(TILE_EMPTY[(int)(((pos.x * 2) + (pos.y * 3)) / Space.SPACE_WIDTH) % TILE_EMPTY.length], 0, 0);
    } else {
      image(TILE_EMPTY[0], 0, 0);  
    }
    popMatrix();
  }
}

