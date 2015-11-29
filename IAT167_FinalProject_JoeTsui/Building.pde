float projectileYPercent = .65;

class Building {
  PVector pos;
  PVector projectileStartPos;
  int timer = 0;
  int PROJECTILE_DAMAGE = 25;
  int SHOT_TIMER = 60;
  float attackRadius = TOWER_ATTACK_RANGE_BASE;
  ArrayList<BuildingProjectile> projectiles = new ArrayList<BuildingProjectile>();
  ArrayList<Integer> upgradePaths = new ArrayList<Integer>();

  public Building() {
    this(width/2, height/2);
  }

  public Building(Building building) {
    this(building.pos.x, building.pos.y);
  }

  public Building(float x, float y) {
    this.pos = new PVector(x, y);
    this.projectileStartPos = new PVector(pos.x, pos.y - (Space.SPACE_WIDTH * projectileYPercent));
    setUpgradePaths();
  }

  void updatePos(float x, float y) {
    this.pos.x = x;
    this.pos.y = y;
    this.projectileStartPos.x = x; 
    this.projectileStartPos.y = y - (Space.SPACE_WIDTH * projectileYPercent);
  }

  void setUpgradePaths() {
    upgradePaths.add(TOWER_ID_SNIPER);
    upgradePaths.add(TOWER_ID_RAPID);
    upgradePaths.add(TOWER_ID_AOE);
  }

  Building upgrade(int TOWER_ID) {
    Building tempBuilding;
    switch (TOWER_ID) {
    case TOWER_ID_BASE:
      tempBuilding = new Building(this);
      break;
    case TOWER_ID_SNIPER:
      tempBuilding = new SniperBuilding(this);
      break;
    case TOWER_ID_RAPID:
      tempBuilding = new RapidBuilding(this);
      break;
    case TOWER_ID_AOE:
      tempBuilding = new AOEBuilding(this);
      break;
    case TOWER_ID_LASER:
      tempBuilding = new LaserBuilding(this);
      break;
    default:
      return null;
    }
    return tempBuilding;
  }

  void shootAt(Enemy enemy, boolean targeted) {
    if (targeted) {
      projectiles.add(new BuildingProjectile(pos, enemy, (int)(PROJECTILE_DAMAGE * TARGETED_DAMAGE_AMP)));
    } else {
      projectiles.add(new BuildingProjectile(projectileStartPos, enemy, PROJECTILE_DAMAGE));
    }
  }

  void update() {
    checkForTargets();
    updateProjectiles();
  }

  void checkForTargets() {
    if (timer == 0) {
      if (selectedEnemy != null) {
        if (checkEnemy(selectedEnemy)) {
          shootAt(selectedEnemy, true);
          timer = SHOT_TIMER;
          return;
        }
      }
      for (Enemy enemy : enemyList) {
        if (checkEnemy(enemy)) {
          shootAt(enemy, false);
          timer = SHOT_TIMER;
          return;
        }
      }
    } else {
      timer--;
    }
  }

  boolean checkEnemy(Enemy enemy) {
    return (enemy.state == STATE_READY) && (PVector.dist(pos, enemy.pos) < attackRadius);
  }

  void updateProjectiles() {
    for (int i = projectiles.size () - 1; i >= 0; i--) {
      BuildingProjectile projectile = projectiles.get(i);
      projectile.update();
      if (projectile.removeMe) {
        projectiles.remove(i);
      }
    }
  }

  void draw() {
    drawBuilding();
    for (BuildingProjectile projectile : projectiles) {
      projectile.draw();
    }
  }

  void UIDraw(int upgradeIndex) {
    draw();  
    pushMatrix();
    translate(pos.x, pos.y);
    if (upgradeIndex == -1) {
      fill(255, 200, 200, 126);
      ellipse(0, 0, attackRadius * 2, attackRadius * 2);
    } else if (upgradeIndex == 1) {
      fill(255, 200, 200, 126);
      ellipse(0, 0, TOWER_ATTACK_RANGE_RANGE * 2, TOWER_ATTACK_RANGE_RANGE * 2);
    } else if (upgradeIndex == 2) {
      fill(255, 200, 200, 126);
      ellipse(0, 0, TOWER_ATTACK_RANGE_SPEED * 2, TOWER_ATTACK_RANGE_SPEED* 2);
    } else if (upgradeIndex == 3) {
      fill(255, 200, 200, 126);
      ellipse(0, 0, TOWER_ATTACK_RANGE_AOE * 2, TOWER_ATTACK_RANGE_AOE * 2);
    }
    popMatrix();
  }

  void drawBuilding() {
    pushMatrix();
    translate(pos.x, pos.y);
    drawStructure();
    popMatrix();
  }

  void drawStructure() {
    fill(160, 160, 160);
    stroke(0);
    strokeWeight(1);
    int spaceWidth = Space.SPACE_WIDTH;
    beginShape();
    vertex(-spaceWidth * .35, spaceWidth * .4);
    vertex(-spaceWidth * .35, spaceWidth * .35);
    vertex(-spaceWidth * .25, spaceWidth * .25);
    vertex(-spaceWidth * .25, spaceWidth * .1);
    vertex(-spaceWidth * .25, -spaceWidth * .3);
    vertex(-spaceWidth * .2, -spaceWidth * .5);
    vertex(-spaceWidth * .3, -spaceWidth * .8);
    vertex(spaceWidth * .3, -spaceWidth * .8);
    vertex(spaceWidth * .2, -spaceWidth * .5);
    vertex(spaceWidth * .25, -spaceWidth * .3);
    vertex(spaceWidth * .25, spaceWidth * .1);
    vertex(spaceWidth * .25, spaceWidth * .25);
    vertex(spaceWidth * .35, spaceWidth * .35);
    vertex(spaceWidth * .35, spaceWidth * .4);
    endShape(CLOSE);
    translate(0, -spaceWidth * projectileYPercent);
    float gemAlpha = 125 + (120 * (1 - (timer / (float)SHOT_TIMER)));
    drawGem(gemAlpha);
    noStroke();
  }

  void drawGem(float gemAlpha) {
    stroke(0);
    strokeWeight(1);
    fill(0);
    ellipse(0, 0, Space.SPACE_WIDTH * .4, Space.SPACE_WIDTH * .4);
    fill(255, 70, 255, gemAlpha);
    ellipse(0, 0, Space.SPACE_WIDTH * .4, Space.SPACE_WIDTH * .4);
  }
}

