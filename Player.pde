class Player {
  
  int score;
  int gold;
  
  public Player() {
    gold = GOLD_STARTING;
  }
  
  boolean chargeGold(int gold) {
    if (this.gold >= gold) {
      this.gold -= gold;
      return true;
    } else {
      return false;
    }  
  }
}
