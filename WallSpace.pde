class WallSpace extends RoadSpace {
  
  boolean wallUp = true;
  BaseWall wall;
  
  public WallSpace() {
    this(0, 0);  
  }
  
  public WallSpace(int x, int y) {
    super(x, y);
    createWall();
  }
  
  void createWall() {
    wall = new BaseWall(pos.x + SPACE_WIDTH/2, pos.y + SPACE_HEIGHT/2);
  }
  
  @Override
  void draw() {
    super.draw();
    wall.draw(); 
  }
}
