class LaserBuilding extends Building {

  public LaserBuilding(Building building) {
    this(building.pos.x, building.pos.y);
  }

  public LaserBuilding(float x, float y) {
    super(x, y);
    attackRadius = 4.5 * Space.SPACE_WIDTH;
    PROJECTILE_DAMAGE = 1;
    SHOT_TIMER = 5;
  }

  @Override
    void setUpgradePaths() {
  }

  @Override
    void shootAt(Enemy enemy, boolean targeted) {
    if (targeted) {
      projectiles.add(new LaserProjectile(enemy, pos, attackRadius, (int)(PROJECTILE_DAMAGE * TARGETED_DAMAGE_AMP)));
    } else {
      projectiles.add(new LaserProjectile(enemy, pos, attackRadius, PROJECTILE_DAMAGE));
    }
  }


  void drawBuilding() {
    pushMatrix();
    translate(pos.x, pos.y);
    fill(255, 0, 0);
    ellipse(0, 0, 20, 20);  
    strokeWeight(5);
    popMatrix();
  }
}

