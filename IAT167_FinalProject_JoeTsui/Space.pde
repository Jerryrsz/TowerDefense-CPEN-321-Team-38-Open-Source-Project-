
class Space {

  static final int SPACE_WIDTH = 30;
  static final int SPACE_HEIGHT = 30;

  PVector pos;
  char texture;

  public Space() {
    this(0, 0);
  }

  public Space(int x, int y) {
    pos = new PVector(x, y);
  }
  
    public Space(int x, int y, char texture) {
    pos = new PVector(x, y);
    this.texture = texture;
  }

  void draw() {
    pushMatrix();
    translate(pos.x, pos.y);
    noStroke();
    if ((int)((pos.x + pos.y) / Space.SPACE_WIDTH) % 2 != 0) {
      //image(TILE_EMPTY[(int)(((pos.x * 2) + (pos.y * 3)) / Space.SPACE_WIDTH) % TILE_EMPTY.length], 0, 0);
      if( texture == '8')
        image(grassu, 0, 0);
      else if ( texture == '2' )
        image(grassd, 0, 0);
      else if ( texture == '4' )
        image(grassl, 0, 0);
      else if ( texture == '6' )
        image(grassr, 0, 0);
      else if ( texture == '7' )
        image(grassul, 0, 0);
      else if ( texture == '9' )
        image(grassur, 0, 0);
      else if ( texture == '1' )
        image(grassbl, 0, 0);
      else if ( texture == '3' )
        image(grassbr, 0, 0);
      else
        image(grass, 0, 0);
    } else {
      //image(TILE_EMPTY[0], 0, 0);  
      if( texture == '8')
        image(grassu, 0, 0);
      else if ( texture == '2' )
        image(grassd, 0, 0);
      else if ( texture == '4' )
        image(grassl, 0, 0);
      else if ( texture == '6' )
        image(grassr, 0, 0);
      else if ( texture == '7' )
        image(grassul, 0, 0);
      else if ( texture == '9' )
        image(grassur, 0, 0);
      else if ( texture == '1' )
        image(grassbl, 0, 0);
      else if ( texture == '3' )
        image(grassbr, 0, 0);
      else
        image(grass, 0, 0);
    }
    popMatrix();
  }
}

class u extends Space{
  
  public u() {
    this(0, 0);
  }

  public u(int x, int y) {
    pos = new PVector(x, y);
  }

  @Override
  void draw() {
    pushMatrix();
    translate(pos.x, pos.y);
    noStroke();
    if ((int)((pos.x + pos.y) / Space.SPACE_WIDTH) % 2 != 0) {
      //image(TILE_EMPTY[(int)(((pos.x * 2) + (pos.y * 3)) / Space.SPACE_WIDTH) % TILE_EMPTY.length], 0, 0);
      image(grassu, 0, 0);
    } else {
      //image(TILE_EMPTY[0], 0, 0);  
      image(grassu, 0, 0);
    }
    popMatrix();
  }
}



