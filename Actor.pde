abstract class Actor {

  int radius = 10;

  PVector pos, vel;
  int maxHealth;
  int currentHealth = maxHealth;
  int state = STATE_READY;
  int timer = 0;

  public Actor() {
    this(width/2, height/2);
  }

  public Actor(float x, float y) {
    this.pos = new PVector(x, y);
    this.vel = new PVector(0, 0);
  }

  void setMaxAndCurrHealth(int max) {
    maxHealth = max;
    currentHealth = max;
  }

  void takeDamage(int damage) {
    currentHealth -= damage;
    if (currentHealth <= 0) {
      currentHealth = 0;
      state = STATE_DEAD;
    }
  }

  boolean isClicked() {
    return (PVector.dist(new PVector(mouseX, mouseY), pos) < radius);
}

  abstract void draw();
}

