import java.util.LinkedList;

class LevelPlan {

  int numLevels = 4;
  char BUILDING = 'B';
  char ROAD = 'R';
  char EMPTY = ' ';
  

  
   


  ArrayList<String> getLevel(int num) {
    switch (num) {
    case 1:
      return getLevel1();
    case 2:
      return getLevel2();
    case 3:
      return getLevel3();
    case 4:
      return getLevel4();
    default:
      return null;
    }
  }

  ArrayList<String> getLevel1() {
    ArrayList<String> levelPlan = new ArrayList<String>();
    /*
<<<<<<< HEAD
=======
    levelPlan.add("                         ");
    levelPlan.add("                         ");
    levelPlan.add("       RRRRR             ");
    levelPlan.add("       R789R             ");
    levelPlan.add("       R456R             ");
    levelPlan.add("       R123R             ");
    levelPlan.add("       RRRRR             ");
    levelPlan.add("                         ");
    levelPlan.add("              RRRRR      ");
    levelPlan.add("    RRRRR     R   R B    ");
    levelPlan.add("WRRRR B RRRRRRRB  RRRRR  ");
    levelPlan.add("          88  RRRRR B RR ");
    levelPlan.add("                       RS");
    levelPlan.add("                         ");
    levelPlan.add("                         ");
    levelPlan.add("                         ");
    */
    
    levelPlan.add("                         ");
    levelPlan.add("                         ");
    levelPlan.add("                         ");
    levelPlan.add("                         ");
    levelPlan.add("                         ");
    levelPlan.add("                         ");
    levelPlan.add("                         ");
    levelPlan.add("              22222      ");
    levelPlan.add("    22222    6RRRRR42    ");
    levelPlan.add("2223RRRRR12223Rj89RiB12  ");
    levelPlan.add("WRRRRuBuRRRRRRRB13RRRRR1 ");
    levelPlan.add("88888 8 888889RRRRRuBuRR1");
    levelPlan.add("              88888 8 9RS");
    levelPlan.add("                       88");
    levelPlan.add("                         ");
    levelPlan.add("                         ");

  
    return levelPlan;
  }
  
  

  ArrayList<String> getLevel2() {
    ArrayList<String> levelPlan = new ArrayList<String>();
    levelPlan.add("                         ");
    levelPlan.add("                         ");
    levelPlan.add("                         ");
    levelPlan.add("                         ");
    levelPlan.add("                         ");
    levelPlan.add("                         ");
    levelPlan.add("                  22222  ");
    levelPlan.add("         222    23RRRRR4 ");
    levelPlan.add("        3RRR4 23RRR7p9R4 ");
    levelPlan.add("22222226RRBR13RRR786BlR4 ");
    levelPlan.add("WRRRRRBiR79RRRRBj   26R4 ");
    levelPlan.add("88889RRRR4 9BuRRR123BiR12");
    levelPlan.add("     8888   8 89RRRRRRRRS");
    levelPlan.add("                888888888");
    levelPlan.add("                         ");
    levelPlan.add("                         ");
    return levelPlan;
  }

  ArrayList<String> getLevel3() {
    ArrayList<String> levelPlan = new ArrayList<String>();
    levelPlan.add("                         ");
    levelPlan.add("                         ");
    levelPlan.add("                         ");
    levelPlan.add("                         ");
    levelPlan.add("                         ");
    levelPlan.add("       22222 2   222222  ");
    levelPlan.add("      6RRRRRiB4 6BRRRRR4 ");
    levelPlan.add("    223Rj9BRRj  3RR789R4 ");
    levelPlan.add("   6RRRRR4p9RR13RR7 26R4 ");
    levelPlan.add("2226R7p9RlB49RRRRB46BlR4 ");
    levelPlan.add("WRRiRlBlR48 29RB78  p6R4 ");
    levelPlan.add("89RRR486R1 3BiRj 2 6BlR12");
    levelPlan.add("  888  6RRiRRRRRiB12p3RRS");
    levelPlan.add("        9RRR789RRRRRRRR79");
    levelPlan.add("         888   88888888  ");
    levelPlan.add("                         ");
    return levelPlan;
  }

  ArrayList<String> getLevel4() {
    ArrayList<String> levelPlan = new ArrayList<String>();
    levelPlan.add("                         ");
    levelPlan.add("                         ");
    levelPlan.add("                         ");
    levelPlan.add("      2  2   2 22222     ");
    levelPlan.add("     3B13B126BiRRRRR1    ");
    levelPlan.add("    6RRRRRRR4kRR7kBRR12  ");
    levelPlan.add("    6Rj9R7kRlBR76B79RRR4 ");
    levelPlan.add("    6RBiRlBR1kR1222289R4 ");
    levelPlan.add("   26RRRR4kRRRRRRRRR16R4 ");
    levelPlan.add("223B18kR16B789Rj9BuRBiR4 ");
    levelPlan.add("WRRRRlBRR48 26RB4 6RRRR4 ");
    levelPlan.add("8889R1pkR4 6BlR7 2 9BuR12");
    levelPlan.add("   6RRRRR4  83R16B4 p6RRS");
    levelPlan.add("    89B78   6BRR1p23BiR78");
    levelPlan.add("      8      89RRRRRRRR4 ");
    levelPlan.add("               88888888  ");
    return levelPlan;
  }

  ArrayList<Wave> getEnemyWaves(int num) {
    ArrayList<Wave> enemyWaves = new ArrayList<Wave>();
    switch (num) {
    case 1:
      getEnemyWavesLevel1(enemyWaves);
      break;
    case 2:
      getEnemyWavesLevel2(enemyWaves);
      break;
    case 3:
      getEnemyWavesLevel3(enemyWaves);
      break;
    case 4:
      getEnemyWavesLevel4(enemyWaves);
      break;
    }
    return enemyWaves;
  }

  void getEnemyWavesLevel1(ArrayList<Wave> enemyWaves) {
    int[][] waveNumbers = new int[][] 
    {
      {
        3, 0, 0, 0, 0, 1, 0, 0, 1
      }
      , {
        3, 2, 0, 0, 0, 0, 0, 0
      }
    };
    for (int i = 0; i < waveNumbers.length; i++) {
      enemyWaves.add(new Wave(waveNumbers[i]));
    }
  }

  void getEnemyWavesLevel2(ArrayList<Wave> enemyWaves) {
    int[][] waveNumbers = new int[][] 
    {
      {
        4, 2, 0, 0, 0, 1, 1, 1
      }
      , {
        3, 1, 0, 1, 0, 1, 1, 1
      }
      , {
        2, 2, 1, 1, 0, 3 ,2, 1
      }
    };
    for (int i = 0; i < waveNumbers.length; i++) {
      enemyWaves.add(new Wave(waveNumbers[i]));
    }
  }

  void getEnemyWavesLevel3(ArrayList<Wave> enemyWaves) {
    int[][] waveNumbers = new int[][] 
    {
      {
        5, 3, 0, 1, 0, 1, 1, 1
      }
      , {
        6, 2, 1, 0, 0, 0, 2, 1
      }
      , {
        2, 9, 1, 1, 0, 0, 1, 4
      }
      , {
        5, 4, 2, 3, 0, 1, 1, 1
      }
    };
    for (int i = 0; i < waveNumbers.length; i++) {
      enemyWaves.add(new Wave(waveNumbers[i]));
    }
  }

  void getEnemyWavesLevel4(ArrayList<Wave> enemyWaves) {
    int[][] waveNumbers = new int[][] 
    {
      {
        6, 6, 0, 2, 0, 1, 1, 1, 1
      }
      , {
        12, 7, 4, 3, 0, 1, 1, 2, 3
      }
      , {
        12, 6, 5, 5, 1, 10, 13, 13, 13
      }
    };
    for (int i = 0; i < waveNumbers.length; i++) {
      enemyWaves.add(new Wave(waveNumbers[i]));
    }
  }

  Node getLevelPath(int num) {
    switch (num) {
    case 1:
      return calcPath(getLevel1());
    case 2:
      return calcPath(getLevel2());
    case 3:
      return calcPath(getLevel3());
    case 4:
      return calcPath(getLevel4());
    default:
      return null;
    }
  }

  Node calcPath(ArrayList<String> levelPlan) {
    PathfindNode start = new PathfindNode(0, 0);
    PathfindNode end = new PathfindNode(0, 0);
    boolean[][] nodeGrid = convertPlanToGrid(levelPlan, start, end);
    // Find all intersections
    ArrayList<PathfindNode> intersections = findIntersections(nodeGrid);
    debugGrid(nodeGrid, intersections);
    // Find edges
    ArrayList<PathfindEdge> edges = findEdges(nodeGrid, start, end);
    for (int i = 0; i < edges.size (); i++) {
      PathfindEdge edge = edges.get(i);
    }
    // Start at start node
    PathfindEdge edge = getEdge(edges, start.x, start.y);
    Node rootNode = new Node(start.x, start.y);
    Node currNode = null;
    ArrayList<Node> nodeIntersections = new ArrayList<Node>();
    for (PathfindNode node : intersections) {
      nodeIntersections.add(new Node(node.x, node.y));
    }
    Node first = new Node(0, 0);
    Node last = edge.createNodes(first);
    rootNode.next.add(first);
    Node intersection = getIntersection(nodeIntersections, edge.vertex2.x, edge.vertex2.y);
    last.next.add(intersection);
    edges.remove(edge);
    // Move out along paths

    while (edges.size () > 0) {
      edge = edges.get(0);
      PathfindNode pfNode = edge.vertex1;
      while (edge != null) {
        first = new Node(0, 0);
        last = edge.createNodes(first);
        currNode = getIntersection(nodeIntersections, edge.vertex1.x, edge.vertex1.y);
        currNode.next.add(first);
        intersection = getIntersection(nodeIntersections, edge.vertex2.x, edge.vertex2.y);
        if (intersection != null) last.next.add(intersection);

        edges.remove(edge);
        edge = getEdge(edges, pfNode.x, pfNode.y);
      }
    }
    Node endNode = new Node(end.x, end.y);
    last.next.add(endNode);

    // End node
    Node offScreenNode = new Node(end.x - 1, end.y);
    endNode.next.add(offScreenNode);

    // Start node
    Node offScreenStartNode = new Node(start.x + 1, start.y);
    offScreenStartNode.next.add(rootNode);
    rootNode = offScreenStartNode;
    // When hits intersection remove edge
    return rootNode;
  }

  boolean[][] convertPlanToGrid(ArrayList<String> levelPlan, PathfindNode start, PathfindNode end) {
    boolean[][] nodeGrid = new boolean[levelPlan.size()][levelPlan.get(0).length()];
    for (int i = 0; i < levelPlan.size (); i++) {
      String row = levelPlan.get(i);
      for (int j = 0; j < row.length (); j++) {
        char square = row.charAt(j);
        switch (square) {
        case GRID_WALLSPACE:
          end.x = j;
          end.y = i;
          nodeGrid[i][j] = true;
          break;
        case GRID_STARTSPACE:
          start.x = j;
          start.y = i;
          nodeGrid[i][j] = true;
          break;
        case GRID_ROADSPACE:
          nodeGrid[i][j] = true;
          break;
        }
      }
    }
    return nodeGrid;
  }

  ArrayList<PathfindNode> findIntersections(boolean[][] grid) {
    ArrayList<PathfindNode> intersections = new ArrayList<PathfindNode>();
    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid[i].length; j++) {
        if (grid[i][j]) {
          int neighbours = 0;
          if (i > 0) {
            if (grid[i - 1][j]) neighbours++;
          }
          if (i < grid.length - 1) {
            if (grid[i + 1][j]) neighbours++;
          }
          if (j > 0) {
            if (grid[i][j - 1]) neighbours++;
          }
          if (j < grid[i].length - 1) {
            if (grid[i][j + 1]) neighbours++;
          }
          if (neighbours > 2) {
            intersections.add(new PathfindNode(j, i));
          }
        }
      }
    }
    return intersections;
  }

  ArrayList<PathfindEdge> findEdges(boolean[][] nodeGrid, PathfindNode start, PathfindNode end) {
    ArrayList<PathfindEdge> edges = new ArrayList<PathfindEdge>();
    ArrayList<Integer> neighbours = new ArrayList<Integer>();
    findNeighbours(nodeGrid, start.x, start.y, neighbours);
    int[] gridPos = getGridPos(neighbours.get(0), start.x, start.y);
    //recurseFindEdges(nodeGrid, edges, start, new PathfindNode(gridPos[0], gridPos[1]));
    //return edges;
    bfsFindEdges(nodeGrid, edges, start, new PathfindNode(gridPos[0], gridPos[1]));
    return edges;
  }

  void bfsFindEdges(boolean[][] nodeGrid, ArrayList<PathfindEdge> edges, PathfindNode start, PathfindNode firstNode) {

    ArrayList<Integer> neighbours = new ArrayList<Integer>();
    LinkedList<BFSNode> bfsQueue = new LinkedList<BFSNode>();
    bfsQueue.add(new BFSNode(start, firstNode));

    do {
      boolean nextNode = false;
      BFSNode bfsNode = bfsQueue.removeFirst();
      int x = bfsNode.curr.x;
      int y = bfsNode.curr.y;
      int prevX = bfsNode.prev.x;
      int prevY = bfsNode.prev.y;
      PathfindEdge edge = new PathfindEdge(bfsNode.prev);
      while (!nextNode) {
        findNeighbours(nodeGrid, x, y, neighbours);
        if (neighbours.size() == 1) {
          edge.vertex2 = new PathfindNode(x, y);
          if (!edges.contains(edge)) {
            edges.add(edge);
          }
          nextNode = true;
        } else if (neighbours.size() == 2) {
          edge.add(new PathfindNode(x, y));
          int[] gridPos = getGridPos(neighbours.get(0), x, y);
          if (prevX == gridPos[0] && prevY == gridPos[1]) {
            gridPos = getGridPos(neighbours.get(1), x, y);
          }
          prevX = x;
          prevY = y;
          x = gridPos[0];
          y = gridPos[1];
        } else {
          edge.vertex2 = new PathfindNode(x, y);
          if (!edges.contains(edge) && (edge.vertex1.x >= edge.vertex2.x)) {
            edges.add(edge);
            for (int i = 0; i < neighbours.size (); i++) {
              int[] gridPos = getGridPos(neighbours.get(i), x, y);
              if (!(prevX == gridPos[0] && prevY == gridPos[1])) {
                bfsQueue.add(new BFSNode(new PathfindNode(x, y), new PathfindNode(gridPos[0], gridPos[1])));
              }
            }
          }
          nextNode = true;
        }
      }
    } 
    while (bfsQueue.size () > 0);
  }

  void recurseFindEdges(boolean[][] nodeGrid, ArrayList<PathfindEdge> edges, PathfindNode start, PathfindNode current) {
    int x = current.x;
    int y = current.y;
    int prevX = start.x;
    int prevY = start.y;
    ArrayList<Integer> neighbours = new ArrayList<Integer>();
    PathfindEdge edge = new PathfindEdge(start);
    do {
      findNeighbours(nodeGrid, x, y, neighbours);
      if (neighbours.size() == 1) {
        edge.vertex2 = new PathfindNode(x, y);
        edges.add(edge);
        return;
      } else if (neighbours.size() == 2) {
        edge.add(new PathfindNode(x, y));
        int[] gridPos = getGridPos(neighbours.get(0), x, y);
        if (prevX == gridPos[0] && prevY == gridPos[1]) {
          gridPos = getGridPos(neighbours.get(1), x, y);
        }
        prevX = x;
        prevY = y;
        x = gridPos[0];
        y = gridPos[1];
      } else {
        edge.vertex2 = new PathfindNode(x, y);
        if (edge.vertex1.x < edge.vertex2.x) {
          println("boop");
        }
        if (edges.contains(edge)) {
          return;
        }
        edges.add(edge);
        for (int i = 0; i < neighbours.size (); i++) {
          int[] gridPos = getGridPos(neighbours.get(i), x, y);
          if (!(prevX == gridPos[0] && prevY == gridPos[1])) {
            recurseFindEdges(nodeGrid, edges, new PathfindNode(x, y), new PathfindNode(gridPos[0], gridPos[1]));
          }
        }
      }
    } 
    while (neighbours.size () < 3);
  }

  Node getIntersection(ArrayList<Node> nodes, int x, int y) {
    for (Node node : nodes) {
      if (node.pos.x == x && node.pos.y == y) {
        return node;
      }
    }
    return null;
  }

  PathfindEdge getEdge(ArrayList<PathfindEdge> edges, int x, int y) {
    for (PathfindEdge edge : edges) {
      if (edge.vertex1.x == x && edge.vertex1.y == y) {
        return edge;
      }
    }
    return null;
  }

  // [X, Y]
  int[] getGridPos(int direction, int x, int y) {
    switch (direction) {
    case 1:
      return new int[] {
        x, y - 1
      };
    case 2:
      return new int[] {
        x + 1, y
      };
    case 3:
      return new int[] {
        x, y + 1
      };
    case 4:
      return new int[] {
        x - 1, y
      };
    }
    return null;
  }

  void findNeighbours(boolean[][] nodeGrid, int x, int y, ArrayList<Integer> neighbours) {
    neighbours.clear();
    if (y > 0) {
      if (nodeGrid[y - 1][x]) neighbours.add(1);
    }
    if (y < nodeGrid.length - 1) {
      if (nodeGrid[y + 1][x]) neighbours.add(3);
    }
    if (x > 0) {
      if (nodeGrid[y][x - 1]) neighbours.add(4);
    }
    if (x < nodeGrid[y].length - 1) {
      if (nodeGrid[y][x + 1]) neighbours.add(2);
    }
  }

  boolean isIntersection(int x, int y, ArrayList<PathfindNode> intersections) {
    for (PathfindNode node : intersections) {
      if (node.x == x && node.y == y) {
        return true;
      }
    }
    return false;
  }

  void debugGrid(boolean[][] grid, ArrayList<PathfindNode> intersections) {
    println("0123456789|    |    |");
    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid[i].length; j++) {
        if (isIntersection(j, i, intersections)) {
          print('O');
        } else {
          print((grid[i][j])? 'X' : ' ');
        }
      }  
      println();
    }
  }
}

