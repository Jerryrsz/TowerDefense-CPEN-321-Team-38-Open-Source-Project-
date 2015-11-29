boolean placeTower = false;
Enemy selectedEnemy = null;
Building tempBuilding = null;
Building selectedBuilding = null;
int hoverUpgradeIndex = -1;

class UI {

  ArrayList<Button> buttons = new ArrayList<Button>();
  ArrayList<UIPanel> panels = new ArrayList<UIPanel>();

  Button nextWaveBtn;
  Button buildingBtn;
  UIPanel buildingPnl;

  final int x = 0;
  final int y = gameHeight * Space.SPACE_HEIGHT;
  final int barWidth = gameWidth * Space.SPACE_WIDTH;
  final int barHeight = 110;

  // Left bar for stats
  final int statBarX = 5;
  final int statBarY = 50;
  final int statBarWidth = 125;
  final int statBarHeight = barHeight - (statBarY * 2);

  public UI() {
  }

  void draw() {
    // Other stuff
    drawShields();
    drawStatBar();
    // Background

    pushMatrix();
    translate(x, y);
    fill(210, 210, 210);
    rect(0, 0, barWidth, barHeight);
    for (UIPanel panel : panels) {
      if (panel.enabled) panel.draw();
    }
    for (Button button : buttons) {
      button.draw();
    }
    if (enemyList.size() == 0) {
      fill(0);
      text("Next wave in " + ((int)((waveTimer / 60.0) * 10) / 10.0) + " seconds.", 635, 100);
    }
    popMatrix();
    if (selectedEnemy != null) {
      drawEnemyTarget(selectedEnemy.pos.x, selectedEnemy.pos.y);
    }
    if (tempBuilding != null) {
      tempBuilding.pos.x = mouseX;
      tempBuilding.pos.y = mouseY;
      tempBuilding.UIDraw(-1);
    }
    displayScore();
    mouseOver();
  }

  void addButton(Button button) {
    buttons.add(button);
  }

  void addPanel(UIPanel panel) {
    panels.add(panel);
  }

  void unpressSelectionButtons() {
    for (Button button : buttons) {
      button.unpress();
    }
  }

  void drawStatBar() {
    pushMatrix();
    translate(statBarX, statBarY);
    fill(255, 220, 100);
    fill(0);
    textAlign(LEFT, BOTTOM);
    textSize(14);
    text("Gold: " + player.gold, 10, 25);
    text("Level: " + level, 10, 40);
    if (enemyWaves.size() > 0) {
      text("Wave: " + (numMaxWaves - enemyWaves.size() + 1) + "/" + numMaxWaves, 10, 55);
    } else {
      text("No waves left!", 10, 55);
    }
    if (enemyWaves.size() > 0) {
      text("Enemies: " + enemyWaves.get(0).size() + "/" + enemyWaves.get(0).numMaxEnemies, 10, 70);
    }
    popMatrix();
  }

  void drawShields() {
    pushMatrix();
    translate(10, 10);
    fill(85, 85, 200, 200);
    rect(0, 0, 150, 30);
    int shieldSpace = 30;
    translate(shieldSpace / 2, 15);
    stroke(0);
    strokeWeight(1);
    for (int i = 0; i < playerShields; i++) {
      pushMatrix();
      fill(255, 225, 50);
      beginShape();
      curveVertex(-50, -40);
      curveVertex(0, -12);
      curveVertex(9, -8);
      curveVertex(0, 10);
      curveVertex(-9, -8);
      curveVertex(0, -12);
      curveVertex(50, -40);
      endShape(CLOSE);
      popMatrix();
      translate(shieldSpace, 0);
    }
    noStroke();
    popMatrix();
  }

  void displayScore() {
    fill(0);
    textSize(20);
    textAlign(LEFT, CENTER);
    text("Score: " + player.score, width - 150, height / 24);
  }

  void drawEnemyTarget(float x, float y) {
    pushMatrix();
    translate(x, y);
    int cornerNum = 20;
    int lengthNum = 4;
    int middleTargetNum = 7;
    stroke(255, 0, 0);
    strokeWeight(2);
    line(-cornerNum, -lengthNum, -cornerNum, -cornerNum);
    line(-lengthNum, -cornerNum, -cornerNum, -cornerNum);
    line(cornerNum, -lengthNum, cornerNum, -cornerNum);
    line(lengthNum, -cornerNum, cornerNum, -cornerNum);
    line(-cornerNum, lengthNum, -cornerNum, cornerNum);
    line(-lengthNum, cornerNum, -cornerNum, cornerNum);
    line(cornerNum, lengthNum, cornerNum, cornerNum);
    line(lengthNum, cornerNum, cornerNum, cornerNum);

    strokeWeight(1);
    line(-middleTargetNum, 0, middleTargetNum, 0);
    line(0, -middleTargetNum, 0, middleTargetNum);
    noStroke();
    popMatrix();
  }

  boolean isClicked() {
    return (x < mouseX && mouseX < x + barWidth) 
      && (y < mouseY && mouseY < y + barHeight);
  }
}

UI setupUI() {
  placeTower = false;
  UI ui = new UI();
  Button nextWaveButton = getButton(600, 25, TEXT_BUTTON_WAVE, color(240, 225, 60), getNextWaveListener());
  ui.nextWaveBtn = nextWaveButton;
  Button towerButton = getButton(50, 25, TEXT_BUTTON_TOWER, color(60, 160, 240), getTowerListener());
  ui.buildingBtn = towerButton;
  UIPanel buildingInfoPanel = getBuildingInfoPanel(175, 5);
  ui.buildingPnl = buildingInfoPanel;

  ui.addButton(nextWaveButton);
  ui.addButton(towerButton);
  ui.addPanel(buildingInfoPanel);
  return ui;
}

abstract class UIPanel {
  PVector pos;
  ArrayList<Button> buttons = new ArrayList<Button>();
  boolean enabled = false;

  public UIPanel(int x, int y) {
    pos = new PVector(x, y);
  }

  void draw() {
    pushMatrix();
    translate(pos.x, pos.y);
    drawPanel();
    popMatrix();
    for (Button button : buttons) {
      button.draw();
    }
  }

  abstract void drawPanel();
}

Listener getNextWaveListener() {
  return new Listener() {
    @Override
      public void trigger() {
      spawnWave = true;
    }
  };
}

Listener getTowerListener() {
  return new Listener() {
    @Override
      public void trigger() {
      placeTower = true;
      makeTempBuilding();
    }
  };
}

Listener getUpgradeListener(int TOWER_ID) {
  final int tempInt = TOWER_ID;
  return new Listener() {
    @Override
      public void trigger() {
      if (selectedBuilding != null && !placeTower) {
        if (!upgradeSelectedBuilding(tempInt)) {
          for (Button button : botUI.buildingPnl.buttons) {
            button.unpress();
          }
        }
      }
    }
  };
}

UIPanel getBuildingInfoPanel(int x, int y) {
  return new UIPanel(x, y) {
    @Override
      public void drawPanel() {
      final int bPanelX = 20;
      final int bPanelY = 5;
      final int bPanelWidth = 185;
      final int bPanelExtWidth = 150;
      final int bPanelHeight = botUI.barHeight - (bPanelY * 2);

      fill(120, 120, 180);
      textSize(13);
      if (selectedBuilding.upgradePaths.size () == 3) {
        rect(0, 0, bPanelWidth + bPanelExtWidth, bPanelHeight);
        fill(0);
        text("Upgrade Tower - " + GOLD_BASEUPGRADE_COST + "G: ", 170, 35);
      } else {
        rect(0, 0, bPanelWidth + bPanelExtWidth, bPanelHeight);
        fill(0);
        text("Switch Upgrades - " + GOLD_SWITCHUPGRADE_COST + "G: ", 170, 35);
      }
      fill(0);
      textAlign(LEFT, BOTTOM);
      text("Building", 10, 30);
      text("Damage: " + selectedBuilding.PROJECTILE_DAMAGE, 10, 50);
      text("Shots per second: " + int((60.0 / selectedBuilding.SHOT_TIMER) * 100) / 100.0, 10, 70);
      text("DPS: " + selectedBuilding.PROJECTILE_DAMAGE * 60.0 / selectedBuilding.SHOT_TIMER, 10, 90);
    }
  };
}

Button getButton(int x, int y, String text, color c, Listener listener) {
  Button button = new Button(x, y, text, c);
  button.addListener(listener);
  return button;
}

Button getButton(int x, int y, String text, int btnWidth, int btnHeight, color c) {
  Button button = new Button(x, y, text, btnWidth, btnHeight, c);
  return button;
}

Button getButton(int x, int y, String text, int btnWidth, int btnHeight, color c, Listener listener) {
  Button button = new Button(x, y, text, btnWidth, btnHeight, c);
  button.addListener(listener);
  return button;
}

void mouseOver() {
  hoverUpgradeIndex = -1;
  if (botUI.isClicked()) {
    if (placeTower == false) {
      for (Button button : botUI.buttons) {
        if (button.isClicked()) {
          if (button.text == TEXT_BUTTON_WAVE) {
            drawPopup(DESCRIPTION_WAVE);
            return;
          } else if (button.text == TEXT_BUTTON_TOWER) {
            drawPopup(DESCRIPTION_TOWER);
            return;
          }
        }
      }
      for (Button button : botUI.buildingPnl.buttons) {
        if (button.isClicked()) {
          if (button.text == TOWER_ID_NAMES[1]) {
            drawPopup(DESCRIPTION_RANGE);
            hoverUpgradeIndex = 1;
          } else if (button.text == TOWER_ID_NAMES[2]) {
            drawPopup(DESCRIPTION_SPEED);
            hoverUpgradeIndex = 2;
          } else if (button.text == TOWER_ID_NAMES[3]) {
            drawPopup(DESCRIPTION_AOE);
            hoverUpgradeIndex = 3;
          }
        }
      }
    }
  } else {
    int x = (mouseX / Space.SPACE_WIDTH);
    int y = (mouseY / Space.SPACE_HEIGHT);
    try {
      Space space = grid.get(x, y);
      if (space.getClass() == RoadSpace.class) {
        for (Enemy enemy : enemyList) {
          if (enemy.isTargetClicked()) {
            String title;
            String description1;
            String description2;
            if (enemy.getClass() == Grunt.class) {
              title = "Grunt";
              description1 = DESCRIPTION_GRUNT1;
              description2 = DESCRIPTION_GRUNT2;
            } else if (enemy.getClass() == Zerg.class) {
              title = "Zerg";
              description1 = DESCRIPTION_ZERG1;
              description2 = DESCRIPTION_ZERG2;
            } else if (enemy.getClass() == Tank.class) {
              title = "Tank";
              description1 = DESCRIPTION_TANK1;
              description2 = DESCRIPTION_TANK2;
            } else if (enemy.getClass() == Shieldbro.class) {
              title = "Shieldbro";
              description1 = DESCRIPTION_SHIELDBRO1;
              description2 = DESCRIPTION_SHIELDBRO2;
            } else if (enemy.getClass() == Boss.class) {
              title = "Boss";
              description1 = DESCRIPTION_BOSS1;
              description2 = DESCRIPTION_BOSS2;
            } else {
              title = "";
              description1 = "";
              description2 = "";
            }
            String enemyHealth = enemy.currentHealth + "/" + enemy.maxHealth;
            String[] EnemyStats = {
              title, "", enemyHealth, description1, description2
            };
            drawPopup(EnemyStats);
            break;
          }
        }
      }
    } 
    catch (Exception e) {
    }
  }
}

void keyPressed() {
  if (gameState == GAMESTATE_GAMEPLAY) {
    switch (key) {
    case 't':
      botUI.buildingBtn.onClick();
      break;
    }
  }
}

void mousePressed() {

  if (gameState == GAMESTATE_GAMEPLAY) {
    mousePressedGameplay();
  } else {
    resetGame();
    gameState = GAMESTATE_GAMEPLAY;
  }
}

void mousePressedGameplay() {
  if (mouseButton == LEFT) {
    if (botUI.isClicked()) {
      for (UIPanel panel : botUI.panels) {
        for (Button button : panel.buttons) {
          if (button.isClicked()) {
            button.onClick();
            break;
          }
        }
      }
      for (Button button : botUI.buttons) {
        if (button.isClicked()) {
          button.onClick();
          break;
        }
      }
    } else {
      try {
        int x = (mouseX / Space.SPACE_WIDTH);
        int y = (mouseY / Space.SPACE_HEIGHT);
        Space space = grid.get(x, y);
        if (space.getClass() == BuildingSpace.class) {
          if (placeTower) {
            addBuilding(space);
          }
        } else if (space.getClass() == RoadSpace.class) {
          for (Enemy enemy : enemyList) {
            if (enemy.isTargetClicked()) {
              selectedEnemy = enemy;
              break;
            }
          }
        }
        tryGetSelectedBuilding(space);
      }
      catch (Exception e) {
      }
    }
  } else if (mouseButton == RIGHT) {
    selectedBuilding = null;
    resetTowerPlacer();
  }
}

void makeTempBuilding() {
  tempBuilding = new Building(mouseX, mouseY);
  selectedBuilding = tempBuilding;
  selectedBuildingChanged();
}

void addBuilding(Space space) {
  if (space.getClass() == BuildingSpace.class) {
    if (player.gold >= GOLD_BASEBUILDING_COST) {
      if (((BuildingSpace)space).addBuilding(tempBuilding)) {
        buildingList.add(tempBuilding);
        selectedBuilding = tempBuilding;
        resetTowerPlacer();
        player.chargeGold(GOLD_BASEBUILDING_COST);
      } else {
        addTextEffect("A tower already \nexists here!", color(0), mouseX + 10, mouseY, 60, LEFT, 12);
      }
    } else {
      addTextEffect("Not enough Gold!", color(0), mouseX, mouseY, 60, LEFT, 12);
    }
  }
}

void resetTowerPlacer() {
  botUI.buildingBtn.unpress();
  placeTower = false;
  selectedBuildingChanged();
  tempBuilding = null;
}

void tryGetSelectedBuilding(Space space) {
  if (space.getClass() == BuildingSpace.class) {
    selectedBuilding = ((BuildingSpace)space).building;
  } else {
    selectedBuilding = null;
  }
  selectedBuildingChanged();
}

boolean upgradeSelectedBuilding(int TOWER_ID) {
  BuildingSpace space = (BuildingSpace)grid.get((int)selectedBuilding.pos.x/Space.SPACE_WIDTH, (int)selectedBuilding.pos.y/Space.SPACE_HEIGHT);
  if (player.chargeGold(GOLD_BASEUPGRADE_COST)) {
    space.upgradeBuilding(TOWER_ID);
    selectedBuilding = space.building;
    selectedBuildingChanged();
    return true;
  } else {
    addTextEffect("Not enough Gold!", color(0), mouseX, mouseY, 60, LEFT, 12);
  }
  return false;
}

void selectedBuildingChanged() {
  botUI.buildingPnl.enabled = (selectedBuilding != null);
  botUI.buildingPnl.buttons.clear();
  if (selectedBuilding != null) {
    int startingXPos = (selectedBuilding.upgradePaths.size() == 3)? 360 : 385;
    for (int i = 0; i < selectedBuilding.upgradePaths.size (); i++) {
      int towerID = selectedBuilding.upgradePaths.get(i);
      Button upgradeButton = getButton(startingXPos + (i * 50), 65, TOWER_ID_NAMES[towerID], 20, 20, color(200, 200, 100), getUpgradeListener(towerID));
      botUI.buildingPnl.buttons.add(upgradeButton);
    }
  }
}

void addTextEffect(String text, color c, float x, float y, int duration, final int ALIGN_HORI, final int textSize) {
  final color tempC = c;
  final String tempS = text;
  effects.add(new Effect(x, y, duration) {
    @Override
      public void drawEffect() {
      textAlign(ALIGN_HORI, CENTER);
      fill(tempC, 125 + (130 * (float) timer/ MAX_TIME));
      textSize(textSize);
      text(tempS, 5, -5);
    }
  }
  );
}

void addTextEffect(String text, color c, float x, float y, int duration, final int ALIGN_HORI) {
  addTextEffect(text, c, x, y, duration, ALIGN_HORI, 10);
}

void drawTipPopup(String[] text, int xSpace, int ySpace) {
  textSize(13);

  int popupHeight = (text.length + 1) * 13;
  float stringWidth = 0;
  float newStringWidth = 0;
  for (String string : text) {
    newStringWidth = textWidth(string);
    if (newStringWidth > stringWidth) {
      stringWidth = newStringWidth;
    }
  }
  fill(255, 185);
  pushMatrix();
  float popupWidth = stringWidth + 12;
  translate(width - popupWidth - xSpace, ySpace);
  rect(0, 0, popupWidth, (text.length + 1) * 13);
  fill(0);
  textAlign(LEFT, TOP);
  for (int i = 0; i < text.length; i++) {
    text(text[i], 5, 5);
    translate(0, 14);
  }
  popMatrix();
}

void drawPopup(String[] text) {

  textSize(13);

  int popupHeight = (text.length + 1) * 13;
  float stringWidth = 0;
  float newStringWidth = 0;
  for (String string : text) {
    newStringWidth = textWidth(string);
    if (newStringWidth > stringWidth) {
      stringWidth = newStringWidth;
    }
  }

  int xShift = 10;
  int yShift = -int(popupHeight * 2 / 3);

  pushMatrix();
  if (!(mouseX + xShift + stringWidth > width)) {
    translate(mouseX + xShift, 0);
  } else {
    translate(mouseX - xShift - stringWidth, 0);
  }
  if (!(mouseY + yShift + popupHeight > height)) {
    translate(0, mouseY + yShift);
  } else {
    translate(0, height - popupHeight);
  }
  noStroke();
  fill(255, 185);
  rect(0, 0, stringWidth + 12, (text.length + 1) * 13);
  fill(0);
  textAlign(LEFT, TOP);
  for (int i = 0; i < text.length; i++) {
    text(text[i], 5, 5);
    translate(0, 14);
  }
  popMatrix();
}

