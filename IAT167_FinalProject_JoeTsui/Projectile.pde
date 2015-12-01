abstract class Projectile {

  PVector pos;
  PVector vel;
  boolean removeMe;
  int radius = 3;
  int damage;

  public Projectile() {
    this(new PVector(width/2, height/2), new PVector(0, 0), 25);
  }

  public Projectile(PVector pos, PVector vel, int damage) {
    this.pos = pos.get();
    this.vel = vel;
    this.damage = damage;
  }

  void move() {
    pos.add(vel);
  }

  void update() {
    move();
    if (checkForCollision()) {
      removeMe = true;
    }
  }

  void draw() {
  }

  abstract boolean checkForCollision();
}

class BuildingProjectile extends Projectile {

  Enemy target;
  float speed = 4;
  int effectRadius = 16;
  int effectTime = 20;  
  color effectColor = color(255, 70, 255);

  public BuildingProjectile(PVector pos, Enemy enemy, int damage) {
    super(pos, (PVector.sub(enemy.pos, pos)).normalize(null), damage);
    vel.mult(speed);
    this.target = enemy;
  }

  @Override
    boolean checkForCollision() {
    if (PVector.dist(pos, target.pos) < radius + target.radius) {
      effects.add(getProjectileEffect());
      dealDamage();
      return true;
    }
    return false;
  }

  void dealDamage() {
    target.takeDamage(damage);
  }

  @Override
    void update() {
    recalculateVelocity();
    super.update();
  }

  void recalculateVelocity() {
    vel = (PVector.sub(target.pos, pos)).normalize(null);
    vel.mult(speed);
  }

  @Override
    void draw() {
    pushMatrix();
    translate(pos.x, pos.y);
    fill(effectColor);
    ellipse(0, 0, radius * 2, radius * 2);
    popMatrix();
  }

  Effect getProjectileEffect() {
    return new Effect(pos.x, pos.y, effectTime) {
      @Override
        public void drawEffect() {
        float timerPercent = (float)this.timer / MAX_TIME;
        fill(effectColor, 255 * timerPercent);
        ellipse(0, 0, effectRadius * timerPercent, effectRadius * timerPercent);
      }
    };
  }
}

class SniperProjectile extends BuildingProjectile {

  public SniperProjectile(PVector pos, Enemy enemy, int damage) {
    super(pos, enemy, damage);
    this.radius = 3;
    this.effectRadius = 15;
    this.effectTime = 30;
    this.speed = 12;
    this.effectColor = color(145, 160, 255);
  }

  @Override
    void draw() {
    pushMatrix();
    translate(pos.x, pos.y);
    fill(effectColor);
    rotate(vel.heading() - PI/2);
    ellipse(0, 0, radius * 2, radius * 2);
    fill(effectColor, 150);
    triangle(-radius, 0, radius, 0, 0, -15);
    popMatrix();
  }
}

class RapidProjectile extends BuildingProjectile {
    
  public RapidProjectile(PVector pos, Enemy enemy, int damage) {
    super(pos, enemy, damage);
    this.radius = 3;
    this.effectRadius = 12;
    this.effectTime = 15;
    this.speed = 5;
    this.effectColor = color(255);
  }
  
}

class AOEProjectile extends BuildingProjectile {

  int explosionRadius = 70;
  float dmgDampFactor = .5;

  public AOEProjectile(PVector pos, Enemy enemy, int damage) {
    super(pos, enemy, damage);
    this.effectRadius = explosionRadius;
    this.effectTime = 25;
    this.speed = 5;
    this.effectColor = color(255, 0, 0);
  }

  @Override
    void dealDamage() {
    for (Enemy enemy : enemyList) {
      if (PVector.dist(this.pos, enemy.pos) < this.explosionRadius + enemy.radius) {
        enemy.takeDamage((enemy != target)? (int)(damage * dmgDampFactor) : damage);
      }
    }
  }

  @Override
    Effect getProjectileEffect() {
    return new Effect(pos.x, pos.y, effectTime) {
      @Override
        public void drawEffect() {
        float timerPercent = (float)this.timer / MAX_TIME;
        float projectileLength = (effectRadius / 2) * (2 - timerPercent);
        fill(effectColor, 255 * timerPercent);
        ellipse(0, 0, projectileLength * 2, projectileLength * 2);
      }
    };
  }
}

class LaserProjectile extends BuildingProjectile {

  float range;

  public LaserProjectile(Enemy target, PVector startPos, float range, int damage) {
    super(startPos, target, damage);
    this.range = range;
    
  }

  @Override
    void update() {
    if (frameCount % 6 == 0) {
      if (PVector.dist(target.pos, pos) <= range && target.state == STATE_READY) {
        dealDamage();
      } else {
        this.removeMe = true;
      }
    }
  }

  @Override 
    void draw() {
      pushMatrix();
      strokeWeight(3);
      stroke(229,41,41);
      line(pos.x, pos.y, target.pos.x, target.pos.y);
      stroke(0,0,0);
      noStroke();
   
       laserEffects();
      
      noStroke();
      popMatrix();
  }
  
  @Override
    Effect getProjectileEffect() {
    return new Effect(pos.x, pos.y, effectTime) {
      @Override
        public void drawEffect() {
        stroke(255, 201, 201, 5);
        strokeWeight(1);
        line(pos.x, pos.y, target.pos.x, target.pos.y);
        noStroke();
      }
    };
  }
  
  void laserEffects () {
      float newx, newy, newy2, amp;
      float theta = 0;
      amp = 5;
      int edge = (int) sqrt((abs(target.pos.x - pos.x))*(abs(target.pos.x - pos.x)) + (abs(target.pos.y - pos.y))*(abs(target.pos.y - pos.y)));
      float dx = (TWO_PI / edge);
      float x = 0;
      float rotangle;
      float o = abs(target.pos.y - pos.y);
      float a = abs(target.pos.x - pos.x);
      float oa = o/a;
      
      rotangle = atan(o/a);
      for (int i = 0; i < edge; i++) {
      
        newy = sin(x+theta)*amp;
        newy2 = -sin(x+theta)*amp;
        x += dx;
        
        float xinc;
        if ( (target.pos.x - pos.x) < 0 )
          xinc = -i;
        else
          xinc = i;
        
        float xdif = (target.pos.x - pos.x);
        float ydif = (target.pos.y - pos.y);
        
        if ( (xdif > 0 && ydif < 0) || (xdif < 0 && ydif > 0) ) {
          stroke(0,137,255);
          point(pos.x + (xinc*cos(rotangle) + newy*sin(rotangle)),pos.y + (-xinc*sin(rotangle) + newy*cos(rotangle)));
          //point(pos.x + xinc,pos.y + newy);
          stroke(0,137,255);
          point(pos.x + (xinc*cos(rotangle) + newy2*sin(rotangle)),pos.y + (-xinc*sin(rotangle) + newy2*cos(rotangle)));
        }
        else {
          stroke(0,137,255);
          point(pos.x + (xinc*cos(rotangle) - newy*sin(rotangle)),pos.y + (xinc*sin(rotangle) + newy*cos(rotangle)));
          //point(pos.x + xinc,pos.y + newy);
          stroke(0,137,255);
          point(pos.x + (xinc*cos(rotangle) - newy2*sin(rotangle)),pos.y + (xinc*sin(rotangle) + newy2*cos(rotangle)));
        }
        
      }
      
    
    
      /*
      fill(255,149,149,15);
      int newx = (int)(pos.x + (target.pos.x - pos.x)*.25);
      int newy = (int)(pos.y + (target.pos.y - pos.y)*.25);
      ellipse(newx,newy, 7, 7);
      fill(255,149,149,25);
      newx = (int)(pos.x + (target.pos.x - pos.x)*.45);
      newy = (int)(pos.y + (target.pos.y - pos.y)*.45);
      ellipse(newx,newy, 7, 7);
      fill(255,149,149,35);
      newx = (int)(pos.x + (target.pos.x - pos.x)*.65);
      newy = (int)(pos.y + (target.pos.y - pos.y)*.65);
      ellipse(newx,newy, 7, 7);
      fill(255,149,149,45);
      newx = (int)(pos.x + (target.pos.x - pos.x)*.85);
      newy = (int)(pos.y + (target.pos.y - pos.y)*.85);
      ellipse(newx,newy, 7, 7);
      
      fill(149,206,255,15);
      newx = (int)(pos.x + (target.pos.x - pos.x)*.15);
      newy = (int)(pos.y + (target.pos.y - pos.y)*.15);
      ellipse(newx,newy, 7, 7);
      fill(149,206,255,25);
      newx = (int)(pos.x + (target.pos.x - pos.x)*.35);
      newy = (int)(pos.y + (target.pos.y - pos.y)*.35);
      ellipse(newx,newy, 7, 7);
      fill(149,206,255,35);
      newx = (int)(pos.x + (target.pos.x - pos.x)*.55);
      newy = (int)(pos.y + (target.pos.y - pos.y)*.55);
      ellipse(newx,newy, 7, 7);
      fill(149,206,255,45);
      newx = (int)(pos.x + (target.pos.x - pos.x)*.75);
      newy = (int)(pos.y + (target.pos.y - pos.y)*.75);
      ellipse(newx,newy, 7, 7);
      */
      


      
  }
}


class CrippleProjectile extends BuildingProjectile {

  public CrippleProjectile(PVector pos, Enemy enemy, int damage) {
    super(pos, enemy, damage);
    this.radius = 3;
    this.effectRadius = 15;
    this.effectTime = 30;
    this.speed = 12;
    this.effectColor = color(145, 160, 255);
  }

  @Override
    void draw() {
    pushMatrix();
    translate(pos.x, pos.y);
    fill(effectColor);
    rotate(vel.heading() - PI/2);
    ellipse(0, 0, radius * 2, radius * 2);
    fill(effectColor, 150);
    triangle(-radius, 0, radius, 0, 0, -15);
    popMatrix();
  }
  
  void dealDamage() {
    target.takeDamage(damage);
    target.speed = target.speed * .80;
  }
  
}

class ArnoldProjectile extends BuildingProjectile {

  public ArnoldProjectile(PVector pos, Enemy enemy, int damage) {
    super(pos, enemy, damage);
    this.radius = 3;
    this.effectRadius = 15;
    this.effectTime = 30;
    this.speed = 12;
    this.effectColor = color(145, 160, 255);
  }

  @Override
    void draw() {
    pushMatrix();
    translate(pos.x, pos.y);
    fill(effectColor);
    rotate(vel.heading() - PI/2);
    ellipse(0, 0, radius * 2, radius * 2);
    fill(effectColor, 150);
    triangle(-radius, 0, radius, 0, 0, -15);
    popMatrix();
  }
  
  void dealDamage() {
    target.takeDamage(damage);
  }
  
}




