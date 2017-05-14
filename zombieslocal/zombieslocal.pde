/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/41478*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
//TODO: Implement states (Gameover, menus, etc.)
//TODO: Implement networking.
//TODO: HasHit should be a boolean (methinks).
//TODO: Use a timer for drops and enemies.
//TODO: Make player zombie when killed (for effect).
//TODO: Add movement acceleration to enemy and player.

/**** Global Variables ****/
//Player myPlayer;
//ArrayList<Player> thePlayers;
//ArrayList<Bullet> theBullets;
//ArrayList<Enemy> theEnemies;
//ArrayList<Drop> theDrops;
//final static int NORTH = 1;
//final static int EAST = 2;
//final static int SOUTH = 4;
//final static int WEST = 8;
// Not sure if these should be globals, but...
float spawnInterval;
//float spawnSpeed;
//float spawnModifier;
float dropInterval;
float dropSpeed;
float dropModifier;
//float screenFade;
boolean debug;
int gamestate; // 0 = Main menu, 1 = Game, 2 = Gameover

void setup() {
  size(1024, 640);
  frameRate(60);
  cursor(CROSS);
  
  initialize();
}


void keyPressed() {
  switch(key) {
    // For player direction.
    case('w'):case('W'):myPlayer.direction |=NORTH;break;
    case('d'):case('D'):myPlayer.direction |=EAST;break;
    case('s'):case('S'):myPlayer.direction |=SOUTH;break;
    case('a'):case('A'):myPlayer.direction |=WEST;break;
    // Restart game if it's over
    case('r'):case('R'): if (gamestate == 2) { initialize(); }break;
    // Enable debug mode.
      case('t'):case('T'): if (debug) { debug = false;} else { debug = true; }break;
    // Enemy Spawning (For Debugging!)
    //case('z'): theEnemies.add(new Enemy());break;
    //case('z'): spawnInterval = 100;break;
  }
}
 
void keyReleased() {
  // For player direction.
  switch(key) {
    case('w'):case('W'):myPlayer.direction ^=NORTH;break;
    case('d'):case('D'):myPlayer.direction ^=EAST;break;
    case('s'):case('S'):myPlayer.direction ^=SOUTH;break;
    case('a'):case('A'):myPlayer.direction ^=WEST;break;
  }
}

void mouseMoved() {
  myPlayer.mouseLoc.x = mouseX;
  myPlayer.mouseLoc.y = mouseY;
}

void mouseDragged() {
  myPlayer.mouseLoc.x = mouseX;
  myPlayer.mouseLoc.y = mouseY;
}

void mousePressed() {
  myPlayer.weapon.firing = true;
}

void mouseReleased() {
  // If the gun is an automatic, enable this.
  // Fixes an issue with fully/semi auto guns.
  if (myPlayer.weapon.type == 1) {
    myPlayer.weapon.firing = false;
  }
}
