class BuildingSpace extends Space {

  Building building;

  public BuildingSpace() {
    this(0, 0);
  }  

  public BuildingSpace(int x, int y) {
    super(x, y);
    this.building = null;
  }  

  void upgradeBuilding(int TOWER_ID) {
    buildingList.remove(building);
    building = building.upgrade(TOWER_ID);
    buildingList.add(building);
  }

  boolean addBuilding(Building building) {
    if (this.building == null) {
      this.building = building;
      this.building.updatePos(this.pos.x + SPACE_WIDTH / 2, this.pos.y + SPACE_HEIGHT / 2);  
      return true;
    }
    return false;
  }

  @Override
    void draw() {
    drawSpace();
  }

  void drawSpace() {
    pushMatrix();
    translate(pos.x, pos.y);
    noStroke();
    fill(190, 190, 190);
    rect(0, 0, SPACE_WIDTH, SPACE_HEIGHT);  
    popMatrix();
  }
}

