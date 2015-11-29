class Enemy extends Actor {

  int BASE_MAX_HEALTH = 100;
  int GOLD_DROP;
  float healthPercent = 1.0;
  Node currNode;
  Node nextNode;
  PVector moveVector;
  float speed;
  boolean end;
  int radius = 7;
  color bodyColor = color(255, 200, 200);

  public Enemy(Node node) {
    this(node, 1);
  }

  public Enemy(Node node, int buffFactor) {
    super(node.pos.x, node.pos.y);
    this.speed = 1;
    this.currNode = node;
    this.nextNode = node.next.get(0);
    this.moveVector = node.unitVectors.get(0);
    this.GOLD_DROP = 0;
    setMaxAndCurrHealth(BASE_MAX_HEALTH * buffFactor);
  }

  void update() {
    if (state == STATE_READY) {
      move();
    } else if (state == STATE_DEAD) {
      if (timer == TIME_IN_STATE_DEAD) {
        state = STATE_REMOVE;
      }
    }
    timer++;
  }

  boolean isTargetClicked() {
    return (abs(pos.x - mouseX) < radius + 5) && (abs(pos.y - mouseY) < radius + 5);
  }

  void move() {
    pos.add(PVector.mult(moveVector, speed));
    if ((abs(nextNode.pos.x - currNode.pos.x) < abs(pos.x - currNode.pos.x))
      || (abs(nextNode.pos.y - currNode.pos.y) < abs(pos.y - currNode.pos.y))) {
      setToNextNode();
    }
  }

  void setToNextNode() {
    currNode = nextNode;
    if (nextNode.next.size() > 0) {
      int index = int(random(nextNode.next.size()));
      this.pos.set(nextNode.pos);
      nextNode = nextNode.next.get(index);
      moveVector = currNode.unitVectors.get(index);
    } else {
      end = true;
    }
  }

  @Override
    void takeDamage(int damage) {
    if (state == STATE_READY) {
      super.takeDamage(damage);
      addTextEffect(damage + "", color(220, 220, 220), pos.x, pos.y + 5, 60, LEFT, 10 + (damage / 50));
      healthPercent = currentHealth / (float)maxHealth;
      if (state == STATE_DEAD) {
        player.score += this.GOLD_DROP;
        player.gold += this.GOLD_DROP;
        timer = 0;
      }
    }
  }

  @Override
    void draw() {
    pushMatrix();
    translate(pos.x, pos.y);
    drawEnemy();
    if (state == STATE_READY) {
      drawHealthBar();
    }
    popMatrix();
  }

  void drawEnemy() {
    pushMatrix();
    if (state == STATE_READY) {
      float translationY = abs(sin(timer / (5 - (speed/1.5))) * radius * .25);
      translate(0, translationY);
    }
    drawBase();
    drawHat();
    noTint();
    popMatrix();
  }

  void drawBase() {

    float alphaFactor = 255;
    if (state == STATE_DEAD) {
      alphaFactor = 255 * (1 - (timer / (float) TIME_IN_STATE_DEAD));
    }

    pushMatrix();
    translate(0, radius * .2);
    noStroke();
    strokeWeight(1);
    fill(bodyColor, alphaFactor);
    // Body
    ellipse(0, 0, radius * 2, radius * 1.8);
    beginShape();
    vertex(0, -radius * .9);
    vertex(radius * .9, -radius * 1.1);
    vertex(radius, 0);
    endShape();

    // Eyes
    fill(0, alphaFactor);
    ellipse(radius / 3, -radius / 10, radius / 2, radius / 2);
    ellipse(-radius * 2 / 3, -radius / 10, radius / 2, radius / 2);
    fill(255, alphaFactor);
    ellipse(radius / 3, -radius / 10, radius / 3, radius / 3);
    ellipse(-radius * 2 / 3, -radius / 10, radius / 3, radius / 3);
    popMatrix();

    // Mouth
    noFill();
    stroke(0, alphaFactor);
    curve(-radius, -radius/2, -radius * 2 / 3, radius * 2 / 3, -radius / 6, radius * 2 / 3, radius, -radius/2);
    curve(-radius, -radius/2, -radius / 6, radius * 2 / 3, radius / 3, radius * 2 / 3, radius, -radius/2);
  }

  void drawHat() {
    // LEAVE EMPTY
  }

  void drawHealthBar() {
    noFill();
    stroke(0);
    strokeWeight(2);
    float healthBarWidth = Space.SPACE_WIDTH * .8;    
    rect(-healthBarWidth/2.0, -healthBarWidth/1.7, healthBarWidth, healthBarWidth/6.0);
    noStroke();
    fill(255, 0, 0);
    rect(-healthBarWidth/2.0, -healthBarWidth/1.7, healthBarWidth * healthPercent, healthBarWidth/6.0);
  }
}

class Grunt extends Enemy {

  public Grunt(Node node) {
    super(node, 1);
  }

  public Grunt(Node node, int buffFactor) {
    super(node, buffFactor);
    this.BASE_MAX_HEALTH = 100;
    this.GOLD_DROP = GOLD_GRUNT_DROP;
    this.speed = .8;
    this.radius = 12;
    setMaxAndCurrHealth(BASE_MAX_HEALTH * buffFactor);
  }

  @Override
    void drawHat() {
    float alphaFactor = 255;
    if (state == STATE_DEAD) {
      alphaFactor = 255 * (1 - (timer / (float) TIME_IN_STATE_DEAD));
    }

    pushMatrix();
    translate(0, -radius * .3);
    stroke(0, alphaFactor);
    fill(0, 50, 20, alphaFactor);
    arc(0, 0, radius * 2.2, radius * 1.6, PI, PI * 2);
    rect(radius * .7, 0, radius * .175, radius * .8);
    line(-radius * 1.1, 0, radius * 1.1, 0);
    noStroke();
    popMatrix();
  }
}

class Zerg extends Enemy {

  public Zerg(Node node) {
    super(node, 1);
  }

  public Zerg(Node node, int buffFactor) {
    super(node, buffFactor);
    this.BASE_MAX_HEALTH = 65;
    this.GOLD_DROP = GOLD_ZERG_DROP;
    this.speed = 1.5;
    this.radius = 10;
    this.bodyColor = color(255, 50, 50);
    setMaxAndCurrHealth(BASE_MAX_HEALTH * buffFactor);
  }

  @Override
    void drawHat() {
    float alphaFactor = 255;
    if (state == STATE_DEAD) {
      alphaFactor = 255 * (1 - (timer / (float) TIME_IN_STATE_DEAD));
    }

    pushMatrix();
    translate(0, -radius * .1);
    stroke(0, alphaFactor);
    fill(210, 160, 10, alphaFactor);
    arc(0, 0, radius * 1.9, radius * 1.8, PI, PI * 2);
    // HORNS
    fill(100, 80, 0, alphaFactor);
    beginShape();
    curveVertex(-radius * 2, -radius * 1.5);
    curveVertex(radius / 2, -radius * 3 / 4);
    curveVertex(radius, -radius);
    curveVertex(radius * 7 / 8, -radius / 4);
    curveVertex(-radius, radius * 2);
    endShape();

    beginShape();
    curveVertex(radius * 2, -radius * 1.5);
    curveVertex(-radius / 2, -radius * 3 / 4);
    curveVertex(-radius, -radius);
    curveVertex(-radius * 7 / 8, -radius / 4);
    curveVertex(radius, radius * 2);
    endShape();
    line(-radius * .9, 0, radius * .9, 0);
    noStroke();
    popMatrix();
  }
}

class Tank extends Enemy {

  public Tank(Node node) {
    super(node, 1);
  }

  public Tank(Node node, int buffFactor) {
    super(node, buffFactor);
    this.BASE_MAX_HEALTH = 225;
    this.GOLD_DROP = GOLD_TANK_DROP;
    this.speed = .7;
    this.radius = 12;
    this.bodyColor = color(50, 200, 120);
    setMaxAndCurrHealth(BASE_MAX_HEALTH * buffFactor);
  }

  @Override
    void drawHat() {
    float alphaFactor = 255;
    if (state == STATE_DEAD) {
      alphaFactor = 255 * (1 - (timer / (float) TIME_IN_STATE_DEAD));
    }
    pushMatrix();
    translate(0, -radius * .1);
    stroke(0, alphaFactor);
    fill(175, 175, 175, alphaFactor);
    arc(0, 0, radius * 2, radius * 1.8, PI, PI * 2);
    fill(255, alphaFactor);
    quad(-radius, -radius * .35, -radius, -radius * .1, -radius * .4, -radius * .3, -radius * .4, -radius * .9);
    quad(radius * .75, -radius * .35, radius * .75, -radius * .1, -radius * .5, -radius * .3, -radius * .5, -radius * .9);
    fill(175, 175, 175, alphaFactor);
    ellipse(radius * .85, -radius * .2, radius * .45, radius * .5);
    line(-radius * 1.1, 0, radius * 1.1, 0);
    noStroke();
    popMatrix();
  }
}

class Shieldbro extends Enemy {

  int MAX_SHIELD = 10;
  int currentShield = 0;
  float shieldPercent = 1;

  public Shieldbro(Node node) {
    super(node, 1);
  }

  public Shieldbro(Node node, int buffFactor) {
    super(node, buffFactor);
    this.BASE_MAX_HEALTH = 275;
    this.GOLD_DROP = GOLD_SHIELDBRO_DROP;
    this.speed = .4;
    this.radius = 13;
    setMaxAndCurrHealth(BASE_MAX_HEALTH * buffFactor);
    this.MAX_SHIELD = (int)(BASE_MAX_HEALTH * .6);
    this.currentShield = MAX_SHIELD;
    this.bodyColor = color(60, 140, 150);
  }

  @Override
    void update() {
    if (state == STATE_READY) {
      if (frameCount % 4 == 0) {
        if (currentShield < MAX_SHIELD) {
          currentShield += 1;
          shieldPercent = currentShield / (float) MAX_SHIELD;
        }
      }
    }
    super.update();
  }

  @Override
    void takeDamage(int damage) {
    if (state == STATE_READY) {
      addTextEffect(damage + "", color(255, 250, 250), pos.x, pos.y + 5, 60, LEFT, 10 + (damage / 50));
      if (currentShield > 0) {
        currentShield -= damage * .6;
        damage = (int)(damage * .4);
        if (currentShield < 0) {
          damage += -currentShield;
          currentShield = 0;
        }
        shieldPercent = currentShield / (float) MAX_SHIELD;
      }
      super.takeDamage(damage);
      healthPercent = currentHealth / (float)maxHealth;
      if (state == STATE_DEAD) {
        player.gold += this.GOLD_DROP;
      }
    }
  }

  @Override
    void drawHealthBar() {
    noFill();
    stroke(0);
    strokeWeight(2);
    float healthBarWidth = Space.SPACE_WIDTH * .8;    
    rect(-healthBarWidth/2.0, -healthBarWidth/1.7, healthBarWidth, healthBarWidth/6.0);
    noStroke();
    fill(255, 0, 0);
    int HEALTH_SHIELD_AMOUNT = MAX_SHIELD + BASE_MAX_HEALTH;
    float healthAmount = healthBarWidth * healthPercent * BASE_MAX_HEALTH / HEALTH_SHIELD_AMOUNT;
    float shieldAmount = healthBarWidth * shieldPercent * MAX_SHIELD / HEALTH_SHIELD_AMOUNT;
    rect(-healthBarWidth/2.0, -healthBarWidth/1.7, healthAmount, healthBarWidth/6.0);
    fill(220, 220, 255);
    rect(-healthBarWidth/2.0 + healthAmount, -healthBarWidth/1.7, shieldAmount, healthBarWidth/6.0);
  }

  @Override
    void drawHat() {
    float alphaFactor = 255;
    if (state == STATE_DEAD) {
      alphaFactor = 255 * (1 - (timer / (float) TIME_IN_STATE_DEAD));
    }

    pushMatrix();
    translate(0, -radius * .3);
    stroke(0, alphaFactor);
    fill(10, 10, 10, alphaFactor);
    beginShape();
    vertex(-radius * .75, -radius * 1.25);
    vertex(-radius * .75, 0);
    curveVertex(-radius, radius * 1.5);
    curveVertex(-radius * .75, 0);
    curveVertex(radius * .75, 0);
    curveVertex(-radius, radius * 1.5);
    vertex(radius * .75, 0);
    vertex(radius * .75, -radius * 1.25);
    curveVertex(radius, radius);
    curveVertex(radius * .75, -radius * 1.25);
    curveVertex(-radius * .75, -radius * 1.25);
    curveVertex(-radius, radius);

    endShape();
    noStroke();
    popMatrix();
  }
}

public class Boss extends Enemy {

  int actionRadius = 125;
  float healAmount = .02;
  int actionTimer = 0;
  int ACTION_WAIT_TIME = 120;
  int recoveryTimer = 0;
  int RECOVERY_TIME = 60;

  public Boss(Node node) {
    super(node, 1);
  }

  public Boss(Node node, int buffFactor) {
    super(node, buffFactor);
    this.BASE_MAX_HEALTH = 2500;
    this.GOLD_DROP = 0;
    this.speed = .4;
    this.radius = 16;
    setMaxAndCurrHealth(BASE_MAX_HEALTH * buffFactor);
    this.actionTimer = ACTION_WAIT_TIME;
    this.bodyColor = color(240, 240, 120);
    recoveryTimer = -1;
  }

  @Override
    void update() {
    if (state == STATE_READY) {
      move();
      if (actionTimer <= 0) {
        if (actionTimer == 0) {
          recoveryTimer = RECOVERY_TIME;
          actionTimer--;
        }
        if (recoveryTimer == 0) {
          actionTimer = ACTION_WAIT_TIME;
        }
        healNearbyEnemies();
        recoveryTimer--;
      } else {
        actionTimer--;
      }
    } else if (state == STATE_DEAD) {
      if (timer == TIME_IN_STATE_DEAD) {
        state = STATE_REMOVE;
      }
      actionTimer = ACTION_WAIT_TIME;
    }
    timer++;
  }

  @Override
    void draw() {
    pushMatrix();
    translate(pos.x, pos.y);
    drawEnemy();
    popMatrix();
    drawHealthBar();
  }

  void healNearbyEnemies() {
    if (recoveryTimer % 15 == 0) {
      for (Enemy enemy : enemyList) {
        if (PVector.dist(enemy.pos, pos) < actionRadius) {
          if (enemy != this) {
            healEnemy(enemy);
          }
        }
      }
    }
  }

  void healEnemy(Enemy enemy) {
    int healedAmount = (int)(enemy.maxHealth * healAmount);
    addTextEffect("+" + healedAmount, color(0, 255, 0), enemy.pos.x, enemy.pos.y, 30, LEFT);
    enemy.currentHealth += healedAmount;
    if (enemy.currentHealth > enemy.maxHealth) {
      enemy.currentHealth = enemy.maxHealth;
    }
  }

  @Override
    void drawHealthBar() {
    pushMatrix();
    translate(width/2, height/16);
    fill(0);
    textSize(20);
    textAlign(CENTER, CENTER);
    text("Boss", 0, -15);
    noFill();
    stroke(0);
    strokeWeight(2);
    float healthBarWidth = Space.SPACE_WIDTH * 8;    
    rect(-healthBarWidth/2.0, 0, healthBarWidth, healthBarWidth/12.0);
    noStroke();
    fill(255, 0, 0);
    rect(-healthBarWidth/2.0, 0, healthBarWidth * healthPercent, healthBarWidth/12.0);
    textSize(12);
    textAlign(CENTER, CENTER);
    fill(0, 200);
    text(this.currentHealth + "/" + this.maxHealth, healthBarWidth / 3, healthBarWidth / 8);
    popMatrix();
  }

  @Override
    void drawEnemy() {
    if (actionTimer < 0) {
      float effectPercent = 1 - (recoveryTimer / (float)RECOVERY_TIME);
      fill(0, 255, 0, 25 + (50 * effectPercent));
      float effectWidth = actionRadius * 2 * ((effectPercent * .25) + .95);
      ellipse(0, 0, effectWidth, effectWidth);
    }
    pushMatrix();
    if (state == STATE_READY) {
      float translationY = abs(sin(timer / (5 - (speed/1.5))) * radius * .25);
      translate(0, translationY);
    }
    drawBase();
    drawHat();
    popMatrix();
  }

  @Override
    void drawHat() {
    float alphaFactor = 255;
    if (state == STATE_DEAD) {
      alphaFactor = 255 * (1 - (timer / (float) TIME_IN_STATE_DEAD));
    }

    pushMatrix();
    translate(0, -radius * .3);
    stroke(0, alphaFactor);
    fill(255, 255, 50, alphaFactor);
    beginShape();
    vertex(-radius, 0);
    vertex(-radius * 1.25, -radius);
    vertex(-radius * .65, -radius * .65);
    vertex(0, -radius * 1.25);
    vertex(radius * .65, -radius * .65);
    vertex(radius * 1.25, -radius);
    vertex(radius, 0);
    curveVertex(radius * 1.25, -radius);
    curveVertex(radius, 0);
    curveVertex(-radius, 0);
    curveVertex(-radius * 1.25, -radius);
    endShape();
    fill(255, 0, 0, alphaFactor);
    ellipse(-radius * 1.25, -radius, radius * .25, radius * .25);
    ellipse(0, -radius * 1.25, radius * .25, radius * .25);
    ellipse(radius * 1.25, -radius, radius * .25, radius * .25);
    fill(220, 50, 50, alphaFactor);
    ellipse(0, -radius * .5, radius * .5, radius * .5);
    noStroke();
    popMatrix();
  }
}

class Wave {

  ArrayList<Enemy> enemies = new ArrayList<Enemy>();
  int numMaxEnemies;
  final int SPAWN_DELAY = 45;
  boolean waveOver = false;
  int timer = SPAWN_DELAY;

  public Wave() {
  }

  public Wave(int[] numEnemies) {
    for (int i = numEnemies.length - 1; i >= 0; i--) {
      for (int j = 0; j < numEnemies[i]; j++) {
        switch (i) {
        case ENEMY_INDEX_GRUNT:
          enemies.add(new Grunt(AIPath, level));
          break;
        case ENEMY_INDEX_ZERG:
          enemies.add(new Zerg(AIPath, level));
          break;
        case ENEMY_INDEX_TANK:
          enemies.add(new Tank(AIPath, level));
          break;
        case ENEMY_INDEX_SHIELDBRO:
          enemies.add(new Shieldbro(AIPath, level));
          break;
        case ENEMY_INDEX_BOSS:
          enemies.add(new Boss(AIPath, level));
          break;
        }
      }
    }
    numMaxEnemies = enemies.size();
  }

  int size() {
    return enemies.size();
  }

  void spawnEnemy() {
    if (enemies.size() > 0) {
      if (timer == 0) {
        Enemy enemy = enemies.get(0);
        enemyList.add(enemy);
        enemies.remove(enemy);
        timer = SPAWN_DELAY;
      } else {
        timer--;
      }
    } else {
      waveOver = true;
    }
  }
}

