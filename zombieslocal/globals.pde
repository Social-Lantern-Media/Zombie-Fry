// Sets all globals to their defaults; handy for restarting.
void initialize() {
  background(50);
  debug = false;
  gamestate = 1;
  spawnInterval = 0.0;
  spawnSpeed = 30.0;
  spawnModifier = 0.05;
  dropInterval = 0.0;
  dropSpeed = 800.0;
  dropModifier = 30;
  screenFade = 0.0;
  myPlayer = new Player();
  thePlayers = new ArrayList<Player>();
  thePlayers.add(myPlayer);
  theBullets = new ArrayList<Bullet>();
  theEnemies = new ArrayList<Enemy>();
  theDrops = new ArrayList<Drop>();
}

// Creates enemies on an interval which decreases slowly.
// Should be a static method of "enemy" but Processing
// doesn't like static methods :(
void enemySpawn() {
  if (spawnInterval < spawnSpeed) {
    spawnInterval++;
  } else {
    spawnInterval = 0;
    if (spawnSpeed > 50) {
      spawnSpeed -= spawnModifier;
    } else {
      spawnSpeed = 40;
    }
    
    int enemyType;
    enemyType = int(random(4));
    
    switch (enemyType) {
      case(0): theEnemies.add(new Enemy()); break;
      case(1): theEnemies.add(new BossEnemy()); break;
       default: theEnemies.add(new FastEnemy()); break;
    }
  }
}

// Creates drops on an interval which decreases slowly.
// Should be a static method of "drop" but Processing
// doesn't like static methods :(
void dropSpawn() {
  if (dropInterval < dropSpeed) {
    dropInterval++;
  } else {
    dropInterval = 0;
    if (dropSpeed > 250) {
      dropSpeed -= dropModifier;
    } else {
      dropSpeed = 250;
    }
    
    int dropType;
    dropType = int(random(3));
    
    switch (dropType) {
      case(0): theDrops.add(new Drop(1)); break;
      default: theDrops.add(new Drop(0)); break;
    }
  }
}

void shambleTheZombies() {
  for (int i = 0; i < theEnemies.size(); i++) {
    theEnemies.get(i).shamble();
  }
}

// Adds a circle on the cursor, a line from the player to mouse,
// and some debug information at the top-left.
//void debug() {
 // fill(255);
 // textAlign(LEFT);
 // text("FPS: " + int(frameRate), 5, 40);
 // text("Drop Interval: " + dropInterval, 5, 55);
 // text("Drop Speed: " + dropSpeed, 5, 70);
 // text("Spawn Interval: " + spawnInterval, 5, 85);
 // text("Spawn Speed: " + spawnSpeed, 5, 100);
 // noFill();
 // fill(0);
  /*
  // Draws a line from each enemy to it's target.
  for (int i = 0; i < theEnemies.size(); i++) {
    Enemy e = theEnemies.get(i);
    line(e.location.x, e.location.y, e.target.location.x, e.target.location.y);
  }
  */
 // noFill();
//}
