class Grid {
  int GRID_WIDTH;
  int GRID_HEIGHT;

  Space[][] gridSpace;

  public Grid(int w, int h) {
    GRID_WIDTH = w;
    GRID_HEIGHT = h;
    gridSpace = new Space[h][w];
  }

  Space get(int x, int y) {
    return gridSpace[y][x];
  }

  void loadLevel(ArrayList<String> levelPlan) {
    for (int i = 0; i < levelPlan.size (); i++) {
      String row = levelPlan.get(i);
      for (int j = 0; j < row.length (); j++) {
        char square = row.charAt(j);
        switch (square) {
        case GRID_BUILDINGSPACE:
          gridSpace[i][j] = new BuildingSpace(j * Space.SPACE_WIDTH, i * Space.SPACE_HEIGHT);
          break;
        case GRID_WALLSPACE:
          gridSpace[i][j] = new WallSpace(j * Space.SPACE_WIDTH, i * Space.SPACE_HEIGHT);
          break;
        case GRID_STARTSPACE:
        case GRID_ROADSPACE:
          gridSpace[i][j] = new RoadSpace(j * Space.SPACE_WIDTH, i * Space.SPACE_HEIGHT);
          break;
        case GRID_SPACE:
        default:
          gridSpace[i][j] = new Space(j * Space.SPACE_WIDTH, i * Space.SPACE_HEIGHT);
          break;
        }
      }
    }
  }

  void draw() {
    for (int y = 0; y < GRID_HEIGHT; y++) {
      for (int x = 0; x < GRID_WIDTH; x++) {
        gridSpace[y][x].draw();
      }
    }
  }
}

