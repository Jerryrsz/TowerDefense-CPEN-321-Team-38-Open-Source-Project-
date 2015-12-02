final int easy = 1;
final int normal = 2;
final int hard = 3;

final char GRID_SPACE = ' ';
final char GRID_ROADSPACE = 'R';
final char GRID_STARTSPACE = 'S';
final char GRID_BUILDINGSPACE = 'B';
final char GRID_WALLSPACE = 'W';
final  char u = '8';
final  char d = '2';
final  char l = '4';
final  char r = '6';
final  char ul = '7';
final  char ur = '9';
final  char bl = '1';
final  char br = '3';

final char hat = 'u';
final char cup = 'i';
final char lear = 'j';
final char rear = 'k';
final char hori = 'p';
final char verti = 'l';

final int STATE_READY = 0;
final int STATE_DEAD = 1;
final int STATE_REMOVE = 2;

final int TIME_IN_STATE_DEAD = 45;

// 500
int GOLD_STARTING;
final int GOLD_BASEBUILDING_COST = 100;
final int GOLD_BASEUPGRADE_COST = 125;
final int GOLD_SWITCHUPGRADE_COST = 50;
final int GOLD_ENEMY_DROP = 10;
final int GOLD_GRUNT_DROP = 25;
final int GOLD_ZERG_DROP = 20;
final int GOLD_TANK_DROP = 35;
final int GOLD_SHIELDBRO_DROP = 40;
final int GOLD_BOSS_DROP = 500;
final int GOLD_DEMACIA_DROP = 1000;
final int GOLD_CORKI_DROP = 100;
final int GOLD_VOODOO_DROP = 75;

final int SCORE_SHIELD = 250;

final int ENEMY_INDEX_GRUNT = 0;
final int ENEMY_INDEX_ZERG = 1;
final int ENEMY_INDEX_TANK = 2;
final int ENEMY_INDEX_SHIELDBRO = 3;
final int ENEMY_INDEX_BOSS = 4;
final int ENEMY_INDEX_DEMACIA = 5;
final int ENEMY_INDEX_CORKI = 6;
final int ENEMY_INDEX_VOODOO = 7;

final int TOWER_ID_BASE = 0;
final int TOWER_ID_SNIPER = 1;
final int TOWER_ID_RAPID = 2;
final int TOWER_ID_AOE = 3;
final int TOWER_ID_LASER = 4;
final int TOWER_ID_ARROW = 5;
final int TOWER_ID_CRIPPLE = 6;
final int TOWER_ID_ARNOLD = 7;
final int TOWER_ID_REMOVE = 8;

final float TOWER_ATTACK_RANGE_BASE = 3.5  * Space.SPACE_WIDTH;
final float TOWER_ATTACK_RANGE_RANGE = 7 * Space.SPACE_WIDTH;
final float TOWER_ATTACK_RANGE_SPEED = 5 * Space.SPACE_WIDTH;
final float TOWER_ATTACK_RANGE_AOE = 4.5 * Space.SPACE_WIDTH;
final float TOWER_ATTACK_RANGE_LASER = 4.5 * Space.SPACE_WIDTH;
final float TOWER_ATTACK_RANGE_ARROW = 3 * Space.SPACE_WIDTH;
final float TOWER_ATTACK_RANGE_CRIPPLE = 3 * Space.SPACE_WIDTH;

final String TEXT_BUTTON_WAVE = "";
final String TEXT_BUTTON_TOWER = "";

final String[] DESCRIPTION_TOWER = {
  "Click to place a tower", "\n", "Right click to cancel"
};
final String[] DESCRIPTION_WAVE = {
  "Click to spawn the next wave", "\n", "Wave will automatically spawn", "when timer reaches zero."
};
final String[] DESCRIPTION_RANGE = {
  "Range tower", "\n", "Long range and high damage", "Good for picking off enemies"
};
final String[] DESCRIPTION_SPEED = {
  "Speed tower", "\n", "High rate of fire", "Good for destroying slow enemies"
};
final String[] DESCRIPTION_AOE = {
  "AOE tower", "\n", "Deals damage to surrounding units", "Good for groups of enemies"
};
final String[] DESCRIPTION_LASER = {
  "DESTRUCTION TOWER", "\n", "DESTRUCTION"
};
final String[] DESCRIPTION_ARROW = {
  "AOE tower", "\n", "Deals reduced damage to ALL surrounding enemies."
};
final String[] DESCRIPTION_CRIPPLE = {
  "CC tower", "\n", "Deals reduced damage to single target, and slows them permanently. Target enemies for full effect."
};
final String[] DESCRIPTION_ARNOLD = {
  "GG tower", "\n", "Get to the chopper. Now."
};
final String[] DESCRIPTION_REMOVE = {
  "Sell tower", "\n", "Goodbye~"
};
final String[] DESCRIPTION_BASE = {
  "Basic Tower", "\n", "Back to the basics..."
};
final String DESCRIPTION_GRUNT1 = "A lowly grunt."; 
final String DESCRIPTION_GRUNT2 = "Paid $10.25/hr";  
final String DESCRIPTION_ZERG1 = "Very fast."; 
final String DESCRIPTION_ZERG2 = "Pick them off!";
final String DESCRIPTION_TANK1 = "Draws aggro";
final String DESCRIPTION_TANK2 = "TAUNT";  
final String DESCRIPTION_SHIELDBRO1 = "Has a shield that"; 
final String DESCRIPTION_SHIELDBRO2 = "regenerates over time";
final String DESCRIPTION_BOSS1 = "Real friendly guy"; 
final String DESCRIPTION_BOSS2 = "that heals enemies";  
final String DESCRIPTION_DEMACIA1 = "A troll with hugh gold drop";
final String DESCRIPTION_DEMACIA2 = "have fun";
final String DESCRIPTION_CORKI1 = "An acrobat performer.";
final String DESCRIPTION_CORKI2 = "it's gigantic";
final String DESCRIPTION_VOODOO1 = "Charlatan that heals nearby minions.";
final String DESCRIPTION_VOODOO2 = "it's maroon";

final String[] TIPS_LEVEL1 = {
  "Place towers on the grid!", "Click on one to select it,", "Upgrade your towers!"
};
final String[] TIPS_LEVEL2 = {
  "You can click on an", "enemy to focus it,", "and deal extra damage!"
};
final String[] TIPS_LEVEL3 = {
  "Mhmmm.", "(Make sure you're", "spending your gold)"
};
final String[] TIPS_LEVEL4 = {
  "Last stretch!", "(Hint: no hints)"
};

final float TARGETED_DAMAGE_AMP = 1.1;

final String[] TOWER_ID_NAMES = {
  "Basic", "Range", "Speed", "AOE", "Laser", "Arrow", "Cripple", "Arnold", "Sell"
};

final int GAMESTATE_GAMEPLAY = 0;
final int GAMESTATE_GAMEOVER = 1;
final int GAMESTATE_GAMEWON = 2;
final int GAMESTATE_MENU = 3;

final int TIME_WAVESPAWN_NORMAL = 10 * 60;
final int TIME_WAVESPAWN_LEVEL = 25 * 60;
final int TIME_WAVESPAWN_START = 60 * 60;

// End constants

PGraphics TILE_EMPTY[] = new PGraphics[6];

void setupPImages() {
  setupTiles();
}

void setupTiles() {
  setupEmptyTile();
}

void setupEmptyTile() {
  color bgColor = color(120, 255, 120);
  color lineColor = color(50, 160, 50);
  for (int i = 0; i < TILE_EMPTY.length; i++) {
    TILE_EMPTY[i] = createGraphics(Space.SPACE_WIDTH, Space.SPACE_HEIGHT);
    TILE_EMPTY[i].beginDraw();
    TILE_EMPTY[i].background(bgColor);
    TILE_EMPTY[i].stroke(lineColor, 140);
    if (i != 0) {
      float lineX = 0 + (Space.SPACE_WIDTH * i / 10);
      float lineY = 5 + (Space.SPACE_HEIGHT * i / 8);
      TILE_EMPTY[i].line(lineX, lineY, lineX + 3, lineY - 3);
      TILE_EMPTY[i].line(lineX + 5, lineY, lineX + 3, lineY - 3);
    }    
    TILE_EMPTY[i].endDraw();
  }
}

