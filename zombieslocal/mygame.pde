//TODO: Implement networking.
//TODO: Add guns, powerups, health drops.
//TODO: Gameover feels really messy...
//TODO: Make player zombie when killed (for effect).
//TODO: Gun firing is odd for semi-auto. Temp fix in place.
//TODO: Add movement acceleration to enemy and player.

/**** Global Variables ****/
Player myPlayer;
ArrayList<Player> thePlayers;
ArrayList<Bullet> theBullets;
ArrayList<Enemy> theEnemies;
ArrayList<Drop> theDrops;
PVector mouseLoc;
final static int NORTH = 1;
final static int EAST = 2;
final static int SOUTH = 4;
final static int WEST = 8;
// Not sure if these should be globals, but...
float enemyInterval;
float spawnSpeed;
float spawnModifier;
float screenFade;
boolean gameover;



void draw() {
  /**** Miscellaneous ****/
  background(50);
  if (!gameover) {
   // spawn();
  }
  
   if (gamestate == 1) {
    gameUpdate();
    gameDraw();
  } else if (gamestate == 2) {
    gameUpdate();
    gameDraw();
    gameoverDraw();
  }
  
  /**** Updates ****/
  // Player
  for (int i = 0; i < thePlayers.size(); i++) {
    thePlayers.get(i).update();
  }
  
  // Bullets
  for (int i = 0; i < theBullets.size(); i++) {
    theBullets.get(i).update();
  }
  
  // Enemies
  for (int i = 0; i < theEnemies.size(); i++) {
    theEnemies.get(i).update();
  }
  
  // Drops
  for (int i = 0; i < theDrops.size(); i++) {
    theDrops.get(i).update();
  }
  
  
  
  /**** Displays ****/
  // Player
  for (int i = 0; i < thePlayers.size(); i++) {
    thePlayers.get(i).display();
  }
  
  // Bullets
  for (int i = 0; i < theBullets.size(); i++) {
    theBullets.get(i).display();
  }
  
  // Enemies
  for (int i = 0; i < theEnemies.size(); i++) {
    theEnemies.get(i).display();
  }
  
  // Drops
  for (int i = 0; i < theDrops.size(); i++) {
    theDrops.get(i).display();
  }
  
  if (gameover) {
    gameoverDraw();
  }
  
  if (myPlayer.alive) {
  //  debug();
  }
}


 

