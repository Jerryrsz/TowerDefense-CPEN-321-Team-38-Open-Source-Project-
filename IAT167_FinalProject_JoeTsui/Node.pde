class Node {
  PVector pos;
  ArrayList<Node> next;  
  ArrayList<PVector> unitVectors = new ArrayList<PVector>();
  public Node(int x, int y) {
    this.pos = new PVector(x, y);
    this.next = new ArrayList<Node>();
  }

  Node addNode(PathfindNode node) {
    Node newNode = new Node(node.x, node.y);
    this.next.add(newNode);
    return newNode;
  }

  void addNode(Node node) {
    next.add(node);
  }

  void setPositionsToScreenSize() {
    if (!(((pos.x - Space.SPACE_WIDTH/2) % Space.SPACE_WIDTH == 0) && ((pos.y - Space.SPACE_HEIGHT/2) % Space.SPACE_HEIGHT == 0))) {
      pos.x = (pos.x + .5) * Space.SPACE_WIDTH;
      pos.y = (pos.y + .5) * Space.SPACE_HEIGHT;
      for (Node node : next) {  
        node.setPositionsToScreenSize();
      }
    }
  }

  void createUnitVector() {
    for (int i = 0; i < next.size (); i++) {
      Node nextNode = next.get(i);
      PVector unitVector = PVector.sub(nextNode.pos, pos);
      unitVector.normalize();
      unitVectors.add(unitVector);
      nextNode.createUnitVector();
    }
  }
}

class PathfindEdge {
  PathfindNode vertex1;
  PathfindNode vertex2;
  ArrayList<PathfindNode> nodes = new ArrayList<PathfindNode>();

  public PathfindEdge(PathfindNode start) {
    this.vertex1 = start;
  }  

  void add(PathfindNode node) {
    nodes.add(node);
  }

  Node createNodes(Node first) {
    Node prev = null;
    Node node = null;
    for (int i = 0; i < nodes.size (); i++) {
      if (i == 0) {
        first.pos.x = nodes.get(i).x;
        first.pos.y = nodes.get(i).y; 
        node = first;
      } else {
        node = new Node(nodes.get(i).x, nodes.get(i).y);
      }
      if (prev != null) {
        prev.next.add(node);
      }
      prev = node;
    }  
    return node;
  }

  boolean equals(Object o) {
    if (o == null) return false;
    PathfindEdge edge = (PathfindEdge)o;
    boolean endsMatch = (this.vertex1.equals(edge.vertex1) && this.vertex2.equals(edge.vertex2)) 
      || (this.vertex1.equals(edge.vertex2) && this.vertex2.equals(edge.vertex1));
    boolean verticesMatch = this.nodes.size() == edge.nodes.size();
    return endsMatch && verticesMatch;
  }

  int hashCode() {
    return (vertex1.hashCode() * 13) + (vertex2.hashCode() * 17) + (nodes.hashCode() * 19);
  }

  PathfindNode getLast() {
    return (nodes.size() > 0)? nodes.get(nodes.size() - 1) : null;
  }
}

class PathfindNode {
  int x, y;
  public PathfindNode(int x, int y) {
    this.x = x;
    this.y = y;
  }  

  boolean equals(PathfindNode node) {
    return this.x == node.x && this.y == node.y;
  }

  int hashCode() {
    return (x * 7) + (y * 11);
  }
}

class BFSNode {
  PathfindNode prev;
  PathfindNode curr;

  public BFSNode(PathfindNode prev, PathfindNode curr) {
    this.prev = prev;
    this.curr = curr;
  }
}

