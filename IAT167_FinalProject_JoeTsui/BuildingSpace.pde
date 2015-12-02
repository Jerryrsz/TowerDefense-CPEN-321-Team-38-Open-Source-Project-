class BuildingSpace extends Space {

  Building building;
  char texture;

  public BuildingSpace() {
    this(0, 0);
  }  

  public BuildingSpace(int x, int y) {
    super(x, y);
    this.building = null;
  }

  public BuildingSpace(int x, int y, char texture) {
    super(x, y);
    this.building = null;
    this.texture = texture;
  }  

  void upgradeBuilding(int TOWER_ID) {
    
    if ( TOWER_ID == 8 ){
      buildingList.remove(building);
      this.building = null;
    }
    else {
      buildingList.remove(building);
      building = building.upgrade(TOWER_ID);
      buildingList.add(building);
    }
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
    /*
    noStroke();
    fill(190, 190, 190);
    rect(0, 0, SPACE_WIDTH, SPACE_HEIGHT); 
   */
    image(stoneb, 0, 0); 
    popMatrix();
  }
}

