class RoadSpace extends Space {

  public RoadSpace() {
    this(0, 0);
  }  

  public RoadSpace(int x, int y) {
    super(x, y);
  }

  @Override
    void draw() {
    pushMatrix();
    translate(pos.x, pos.y);
    noStroke();
    fill(120, 60, 60);
    rect(0, 0, SPACE_WIDTH, SPACE_HEIGHT);
    popMatrix();
  }
}

