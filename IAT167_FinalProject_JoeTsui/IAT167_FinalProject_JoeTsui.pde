/*
 Gold needed on purchases
 Laser turret
 */


int gameWidth = 25;
int gameHeight = 16;
LevelPlan levelPlan = new LevelPlan();
Grid grid = new Grid(gameWidth, gameHeight);
Player player = new Player();
UI botUI;
Node AIPath;

int gameState;
int level = 1;
int playerShields = 5;
int waveTimer = 0;

int numMaxWaves = 0;
ArrayList<Wave> enemyWaves = null;
ArrayList<Enemy> enemyList = new ArrayList<Enemy>();
ArrayList<Building> buildingList = new ArrayList<Building>();
ArrayList<Effect> effects = new ArrayList<Effect>();
boolean spawnWave;

void setup() {
  waveTimer = TIME_WAVESPAWN_START;
  gameState = GAMESTATE_GAMEPLAY;
  int spaceSizeX = Space.SPACE_WIDTH;
  int spaceSizeY = Space.SPACE_HEIGHT;
  loadGameLevel(level);
  botUI = setupUI();
  size(spaceSizeX * gameWidth, (spaceSizeY * gameHeight) + botUI.barHeight);
  setupPImages();
}

void resetGame() {

  levelPlan = new LevelPlan();
  grid = new Grid(gameWidth, gameHeight);
  player = new Player();
  AIPath = null;

  level = 1;
  playerShields = 5;
  waveTimer = TIME_WAVESPAWN_START;

  numMaxWaves = 0;
  enemyWaves = null;
  enemyList = new ArrayList<Enemy>();
  buildingList = new ArrayList<Building>();
  effects = new ArrayList<Effect>();
  spawnWave = false;

  loadGameLevel(1);
  botUI = setupUI();
}

void loadGameLevel(int num) {

  if (num <= levelPlan.numLevels) {
    spawnWave = false;
    grid.loadLevel(levelPlan.getLevel(num));
    attachTowersToGrid();
    AIPath = levelPlan.getLevelPath(num);
    AIPath.setPositionsToScreenSize();
    AIPath.createUnitVector();
    enemyWaves = levelPlan.getEnemyWaves(num);
    numMaxWaves = enemyWaves.size();
  } else {
    player.score += playerShields * SCORE_SHIELD;
    gameState = GAMESTATE_GAMEWON;
  }
}

void draw() {
  switch (gameState) {
  case GAMESTATE_GAMEPLAY:
    gameplay();
    break;
  case GAMESTATE_GAMEWON:
    showGameWonScreen();
    break;
  case GAMESTATE_GAMEOVER:
    showGameOverScreen();
    break;
  }
}

void gameplay() {
  background(255);
  grid.draw();
  gameUpdate();
  updateAllActors();
  removeDeadEnemies();
  drawAllActors();
  botUI.draw();
  drawAllEffects();
  drawTips();
}

void removeDeadEnemies() {
  for (int i = enemyList.size () - 1; i >= 0; i--) {
    Enemy enemy = enemyList.get(i);
    if (enemy.state == STATE_REMOVE) {
      if (enemy == selectedEnemy) {
        selectedEnemy = null;
      }
      enemyList.remove(enemy);
      addTextEffect("+" + enemy.GOLD_DROP + " Gold!", color(255, 250, 0), enemy.pos.x, enemy.pos.y - 10, 120, LEFT, 12);
    }
  }
}

void gameUpdate() {
  if (spawnWave) {
    if (!spawnEnemyWave()) {
      if (enemyList.size() == 0) {
        level++;
        loadGameLevel(level);
        botUI.nextWaveBtn.unpress();
      }
    }
  } else {
    if (enemyList.size() == 0) {
      if (waveTimer == 0) {
        spawnWave = true;
      }
      waveTimer--;
    }
  }
}

boolean spawnEnemyWave() {
  if (enemyWaves.size() > 0) {
    Wave currWave = enemyWaves.get(0);
    currWave.spawnEnemy();
    if (currWave.waveOver) {
      enemyWaves.remove(currWave);
      spawnWave = false;
      botUI.nextWaveBtn.unpress();
    }
    waveTimer = TIME_WAVESPAWN_NORMAL;
    return true;
  }
  waveTimer = TIME_WAVESPAWN_LEVEL;
  return false;
}

void updateAllActors() {
  for (int i = enemyList.size () - 1; i >= 0; i--) {
    Enemy enemy = enemyList.get(i);
    if (!enemy.end) {
      enemy.update();
    } else {
      removePlayerShields();
      if (enemy.getClass() == Boss.class) {
        removePlayerShields();
      }
      enemyList.remove(i);
    }
  }
  for (Building building : buildingList) {
    building.update();
  }
}

void drawAllActors() {
  for (Enemy enemy : enemyList) {
    enemy.draw();
  }
  for (Building building : buildingList) {
    if (building != selectedBuilding) {
      building.draw();
    } else {
      building.UIDraw(hoverUpgradeIndex);
    }
  }
}

void drawAllEffects() {
  for (int i = effects.size () - 1; i >= 0; i--) {
    Effect effect = effects.get(i);
    effect.draw();
    if (effect.removeMe) {
      effects.remove(effect);
    }
  }
}

void attachTowersToGrid() {
  for (Building building : buildingList) {
    BuildingSpace space = (BuildingSpace)grid.get((int)building.pos.x / Space.SPACE_WIDTH, (int)building.pos.y / Space.SPACE_WIDTH);
    space.building = building;
  }
}

void removePlayerShields() {
  playerShields--;
  if (playerShields <= 0) {
    gameState = GAMESTATE_GAMEOVER;
  }
}

void showGameOverScreen() {
  background(200, 85, 85);
  textAlign(CENTER, CENTER);
  textSize(50);
  fill(255);
  text("Game Over", width/2, height/2 - 100);
  textSize(35);
  text("Your score is: " + player.score, width/2, height/2);
  text("Click to play again!", width/2, height/2 + 50);
}

void showGameWonScreen() {
  char[] letterGrades = {
    'A', 'B', 'C', 'D', 'E'
  };
  background(85, 85, 200);
  textAlign(CENTER, CENTER);
  textSize(50);
  fill(255);
  text("Game Won!", width/2, height/2 - 100);
  textSize(35);
  text("Your score is: " + player.score, width/2, height/2);
  text("Your rank is: " + letterGrades[5 - playerShields], width/2, height/2 + 50);
  text("Click to play again!", width/2, height/2 + 100);
}

void drawTips() {
  switch (level) {
  case 1:
    drawTipPopup(TIPS_LEVEL1, 5, 50);
    break;
  case 2:
    drawTipPopup(TIPS_LEVEL2, 5, 50);
    break;
  case 3:
    drawTipPopup(TIPS_LEVEL3, 5, 50);
    break;
  case 4:
    drawTipPopup(TIPS_LEVEL4, 5, 50);
    break;
  }
}

