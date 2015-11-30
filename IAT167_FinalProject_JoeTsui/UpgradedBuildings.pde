class SniperBuilding extends Building {

  public SniperBuilding(Building building) {
    this(building.pos.x, building.pos.y);
  }

  public SniperBuilding(float x, float y) {
    super(x, y);
    attackRadius = TOWER_ATTACK_RANGE_RANGE;
    PROJECTILE_DAMAGE = 75;
    SHOT_TIMER = 90;
  }

  @Override
    void setUpgradePaths() {
    upgradePaths.add(TOWER_ID_RAPID);
    upgradePaths.add(TOWER_ID_AOE);
    upgradePaths.add(TOWER_ID_ARROW);
  }

  @Override
    void shootAt(Enemy enemy, boolean targeted) {
    if (targeted) {
      projectiles.add(new SniperProjectile(projectileStartPos, enemy, (int)(PROJECTILE_DAMAGE * TARGETED_DAMAGE_AMP)));
    } else {
      projectiles.add(new SniperProjectile(projectileStartPos, enemy, PROJECTILE_DAMAGE));
    }
  }
  
  @Override
  void drawGem(float gemAlpha) {

    stroke(0);
    strokeWeight(1);
    fill(0);
    triangle(-Space.SPACE_WIDTH * .25, Space.SPACE_WIDTH * .125, Space.SPACE_WIDTH * .25, Space.SPACE_WIDTH * .125, 0, -Space.SPACE_WIDTH * .25);
    fill(145, 160, 255, gemAlpha);
    triangle(-Space.SPACE_WIDTH * .25, Space.SPACE_WIDTH * .125, Space.SPACE_WIDTH * .25, Space.SPACE_WIDTH * .125, 0, -Space.SPACE_WIDTH * .25);
  }
}

class RapidBuilding extends Building {

  public RapidBuilding(Building building) {
    this(building.pos.x, building.pos.y);
  }

  public RapidBuilding(float x, float y) {
    super(x, y);
    attackRadius = TOWER_ATTACK_RANGE_SPEED;
    PROJECTILE_DAMAGE = 10;
    SHOT_TIMER = 10;
  }

  @Override
    void shootAt(Enemy enemy, boolean targeted) {
    if (targeted) {
      projectiles.add(new RapidProjectile(projectileStartPos, enemy, (int)(PROJECTILE_DAMAGE * TARGETED_DAMAGE_AMP)));
    } else {
      projectiles.add(new RapidProjectile(projectileStartPos, enemy, PROJECTILE_DAMAGE));
    }
  }

  @Override
    void setUpgradePaths() {
    upgradePaths.add(TOWER_ID_SNIPER);
    upgradePaths.add(TOWER_ID_AOE);
    upgradePaths.add(TOWER_ID_ARROW);
  }

  @Override
  void drawGem(float gemAlpha) {

    stroke(0);
    strokeWeight(1);
    fill(0);
    quad(-Space.SPACE_WIDTH * .24, 0, 0, Space.SPACE_WIDTH * .24, Space.SPACE_WIDTH * .24, 0, 0, -Space.SPACE_WIDTH * .24);
    fill(255, gemAlpha);
    quad(-Space.SPACE_WIDTH * .24, 0, 0, Space.SPACE_WIDTH * .24, Space.SPACE_WIDTH * .24, 0, 0, -Space.SPACE_WIDTH * .24);
  }
  
}

class AOEBuilding extends Building {

  public AOEBuilding(Building building) {
    this(building.pos.x, building.pos.y);
  }

  public AOEBuilding(float x, float y) {
    super(x, y);
    attackRadius = TOWER_ATTACK_RANGE_AOE;
    PROJECTILE_DAMAGE = 35;
    SHOT_TIMER = 75;
  }

  @Override
    void setUpgradePaths() {
    upgradePaths.add(TOWER_ID_SNIPER);
    upgradePaths.add(TOWER_ID_RAPID);
    upgradePaths.add(TOWER_ID_ARROW);
  }

  @Override
  void drawGem(float gemAlpha) {
    
    stroke(0);
    strokeWeight(1);
    float baseLength = -Space.SPACE_WIDTH * .28;
    float c1 = 0.309 * baseLength;
    float c2 = 0.809 * baseLength;
    float s1 = 0.951 * baseLength;
    float s2 = 0.588 * baseLength;
    fill(0);
    beginShape();
    vertex(0, baseLength);
    vertex(s1, c1);
    vertex(s2, -c2);
    vertex(-s2, -c2);
    vertex(-s1, c1);
    endShape(CLOSE);
    fill(255, 120, 120, gemAlpha);
    beginShape();
    vertex(0, baseLength);
    vertex(s1, c1);
    vertex(s2, -c2);
    vertex(-s2, -c2);
    vertex(-s1, c1);
    endShape(CLOSE);
  }

  @Override
    void checkForTargets() {
    if (projectiles.size() == 0) {
      super.checkForTargets();
    }
  }

  @Override
    void shootAt(Enemy enemy, boolean targeted) {
    if (targeted) {
      projectiles.add(new AOEProjectile(projectileStartPos, enemy, (int)(PROJECTILE_DAMAGE * TARGETED_DAMAGE_AMP)));
    } else {
      projectiles.add(new AOEProjectile(projectileStartPos, enemy, PROJECTILE_DAMAGE));
    }
  }
}

class TeslaBuilding extends Building {

  public TeslaBuilding(Building building) {
    this(building.pos.x, building.pos.y);
  }

  public TeslaBuilding(float x, float y) {
    super(x, y);
    attackRadius = TOWER_ATTACK_RANGE_AOE;
    PROJECTILE_DAMAGE = 35;
    SHOT_TIMER = 75;
  }

  @Override
    void setUpgradePaths() {
    upgradePaths.add(TOWER_ID_SNIPER);
    upgradePaths.add(TOWER_ID_RAPID);
    upgradePaths.add(TOWER_ID_AOE);
    upgradePaths.add(TOWER_ID_ARNOLD);
  }

  @Override
  void drawGem(float gemAlpha) {
    
    stroke(0);
    strokeWeight(1);
    float baseLength = -Space.SPACE_WIDTH * .28;
    float c1 = 0.309 * baseLength;
    float c2 = 0.809 * baseLength;
    float s1 = 0.951 * baseLength;
    float s2 = 0.588 * baseLength;
    fill(0);
    beginShape();
    vertex(0, baseLength);
    vertex(s1, c1);
    vertex(s2, -c2);
    vertex(-s2, -c2);
    vertex(-s1, c1);
    endShape(CLOSE);
    fill(255, 120, 120, gemAlpha);
    beginShape();
    vertex(0, baseLength);
    vertex(s1, c1);
    vertex(s2, -c2);
    vertex(-s2, -c2);
    vertex(-s1, c1);
    endShape(CLOSE);
  }

  
  @Override
  void checkForTargets() {
    if (timer == 0) {
      for (Enemy enemy : enemyList) {
        if (checkEnemy(enemy)) {
          shootAt(enemy, false);
          timer = SHOT_TIMER;
          //return;
        }
      }
    } else {
      timer--;
    }
  }
  
    @Override
    void shootAt(Enemy enemy, boolean targeted) {
      projectiles.add(new BuildingProjectile(projectileStartPos, enemy, PROJECTILE_DAMAGE));
    }
  
  
}

class CrippleBuilding extends Building {

  public CrippleBuilding(Building building) {
    this(building.pos.x, building.pos.y);
  }

  public CrippleBuilding(float x, float y) {
    super(x, y);
    attackRadius = TOWER_ATTACK_RANGE_BASE;
    PROJECTILE_DAMAGE = 15;
    SHOT_TIMER = 125;
  }

  @Override
    void setUpgradePaths() {
    upgradePaths.add(TOWER_ID_SNIPER);
    upgradePaths.add(TOWER_ID_RAPID);
    upgradePaths.add(TOWER_ID_AOE);
    upgradePaths.add(TOWER_ID_ARNOLD);
  }

  @Override
  void drawGem(float gemAlpha) {
    
    stroke(0);
    strokeWeight(1);
    float baseLength = -Space.SPACE_WIDTH * .28;
    float c1 = 0.309 * baseLength;
    float c2 = 0.809 * baseLength;
    float s1 = 0.951 * baseLength;
    float s2 = 0.588 * baseLength;
    fill(0);
    beginShape();
    vertex(0, baseLength);
    vertex(s1, c1);
    vertex(s2, -c2);
    vertex(-s2, -c2);
    vertex(-s1, c1);
    endShape(CLOSE);
    fill(255, 120, 120, gemAlpha);
    beginShape();
    vertex(0, baseLength);
    vertex(s1, c1);
    vertex(s2, -c2);
    vertex(-s2, -c2);
    vertex(-s1, c1);
    endShape(CLOSE);
  }


  
    @Override
    void shootAt(Enemy enemy, boolean targeted) {
      projectiles.add(new CrippleProjectile(projectileStartPos, enemy, PROJECTILE_DAMAGE));
    }
  
  
}

class ArnoldBuilding extends Building {

  public ArnoldBuilding(Building building) {
    this(building.pos.x, building.pos.y);
  }

  public ArnoldBuilding(float x, float y) {
    super(x, y);
    attackRadius = TOWER_ATTACK_RANGE_BASE * 4;
    PROJECTILE_DAMAGE = 5;
    SHOT_TIMER = 5;
  }

  @Override
    void setUpgradePaths() {
   
  }
  
    @Override
  void checkForTargets() {
    if (timer == 0) {
      for (Enemy enemy : enemyList) {
        if (checkEnemy(enemy)) {
          shootAt(enemy, false);
          timer = SHOT_TIMER;
          //return;
        }
      }
    } else {
      timer--;
    }
  }
  
  @Override
  boolean checkEnemy(Enemy enemy) {
    int radius = 7;
    return (enemy.state == STATE_READY) && (PVector.dist(pos, enemy.pos) < attackRadius) && (abs(enemy.pos.x - mouseX) < radius + 5) && (abs(enemy.pos.y - mouseY) < radius + 5) ;
  }
  
    @Override
    void shootAt(Enemy enemy, boolean targeted) {
      projectiles.add(new ArnoldProjectile(projectileStartPos, enemy, PROJECTILE_DAMAGE));
    }
  
  
}

