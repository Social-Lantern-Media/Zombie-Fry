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
class Bullet {
  /**** Fields ****/
  Player owner;
  PVector location;
  PVector trajectory;
  float speed;
  int damage;
  int breadth;
  color colNorm;
  color colCur;
  
  /**** Constructors ****/
  Bullet(Player tempOwner) {
    owner = tempOwner;
    location = owner.location.get();
    breadth = 10;
    speed = 15.0;
    damage = 1;
    trajectory = PVector.sub(owner.mouseLoc, location);
    trajectory.normalize();
    trajectory.mult(speed);
    colNorm = color(25, 75, 200);
    colCur = colNorm;
  }
  
  /**** Methods ****/
  void travel() {
    // Bullet is moved along the trajectory
    location.add(trajectory);
  }
  
  void stillAlive() {
    // Delete bullet if it goes off screen.
    // Also, a cheesy Portal reference.
    // http://www.youtube.com/watch?v=8IGS9qY7xko
    // Also, thanks amnon.owned from the Processing forums
    // for the refactored code tip!
    if (location.y > height || location.y < 0 || location.x > width || location.x < 0) {
      destroy();
    }
  }
  
  void hasHit() {
    for (int i = 0; i < theEnemies.size(); i++) {
      Enemy e = theEnemies.get(i);
      float distance = dist(location.x, location.y, e.location.x, e.location.y);
     
      if (distance < breadth/2 + e.breadth/2) {
        e.takeDamage(this);
        destroy();
        break;
      }
    }
  }
  
  void destroy() {
    theBullets.remove(this);
  }
  
  
  /**** Update and Display ****/
  void update() {
    travel();
    stillAlive();
    hasHit();
  }
  
  void display() {
    pushMatrix();
    ellipseMode(CENTER);
    fill(colCur);
    ellipse(location.x, location.y, breadth, breadth);
    noFill();
    popMatrix();
  }
  
}
class Drop {
  PVector location;
  int breadth;
  color colNorm;
  int type;
  
  Drop(int i) {
    location = new PVector(int(random(width)), int(random(height)));
    breadth = 10;
    type = i;
    
    switch(i) {
      // Health pack.
      case(0):
        colNorm = color(255, 118, 246); break;
      // SMG
      case(1):
        colNorm = color(255, 255, 0); break;
    }
  }
  
  void hasHit() {
    for (int i = 0; i < thePlayers.size(); i++) {
      Player p = thePlayers.get(i);
      float distance = dist(location.x, location.y, p.location.x, p.location.y);
      
      if (distance < breadth/2 + p.breadth/2) {
        giveEffect(p);
        destroy();
        break;
      }
    }
  }
  
  void giveEffect(Player p) {
    switch(type) {
      case(0): p.heal(3); break;
      case(1): p.weapon = new SMG(p); break;
    }
  }
  
  void destroy() {
    theDrops.remove(this);
  }
  
  void update() {
    hasHit();
  }
  
  void display() {
    fill(colNorm);
    ellipse(location.x, location.y, breadth, breadth);
    noFill();
  }
  
}
class Enemy {
  /**** Fields ****/
  PVector location;
  PVector trajectory;
  Player target;
  float speed;
  float speedAcc;
  int healthMax;
  int healthCur;
  float damage;
  int breadth;
  Timer hitTimer;
  color colNorm;
  color colHit;
  color colCur;
  
  /**** Constructors ****/
  Enemy() {
    location = generateSpawn();
    target = getTarget();
    speed = 0.7;
    breadth = 18;
    healthMax = 2;
    healthCur = healthMax;
    damage = 0.2f;
    hitTimer = new Timer(25);
    colNorm = color(125, 75, 100);
    colHit = color(255);
    colCur = colNorm;
  }
  
  /**** Methods ****/
  void walk() {
    if (gamestate == 1) {
      // Enemy walks towards player.
      trajectory = PVector.sub(target.location, location);
      trajectory.normalize();
      trajectory.mult(speed);
    }
    location.add(trajectory);
  }
  
  void hasHit() {
    for (int i = 0; i < thePlayers.size(); i++) {
      Player p = thePlayers.get(i);
      
      if (p.alive == true) {
        float distance = dist(location.x, location.y, p.location.x, p.location.y);
        
        // If there is a collision...
        if (distance < breadth/2 + p.breadth/2) {
          p.takeDamage(this);
          //destroy();
          break;
        }
      }
    }
  }
  
  void takeDamage(Bullet b) {
    healthCur -= b.damage;
    if (healthCur <= 0) {
      destroy();
      b.owner.score++;
    } else {
      // Flash colors
      colCur = colHit;
      hitTimer.start();
    }
  }
  
  void colChange() {
    if (colCur == colHit && hitTimer.isFinished()) {
      colCur = colNorm;
    }
  }
  
  void destroy() {
    theEnemies.remove(this);
  }
  
  void shamble() {
    this.speed = random(0.2, 0.7);
    trajectory.set(random(-50, 50), random(-50, 50), 0);
    trajectory.normalize();
    trajectory.mult(speed);
  }
  
  PVector generateSpawn() {
    int side;
    int spawnX = 0;
    int spawnY = 0;
    PVector spawnCoords;
    
    side = int(random(4));
    switch (side) {
      case(0): 
        spawnX = int(random(width));
        spawnY = 0;
        break;
      case(1): 
        spawnX = width;
        spawnY = int(random(height));
        break;
      case(2): 
        spawnX = int(random(width));
        spawnY = height;
        break;
      case(3): 
        spawnX = 0;
        spawnY = int(random(height));
        break;
    }
    
    return new PVector(spawnX, spawnY);
  }
  
  Player getTarget() {
    int targetId;
    
    targetId = int(random(thePlayers.size()));
    
    return thePlayers.get(targetId);
  }
  
  /**** Update and Display ****/
  void update() {
    walk();
    hasHit();
    colChange();
  }
  
  void display() {
    // Draw the enemy.
    pushMatrix();
    ellipseMode(CENTER);
    fill(colCur);
    ellipse(location.x, location.y, breadth, breadth);
    popMatrix();
    
    // Show health as number
    fill(colNorm);
    textAlign(CENTER);
    text(healthCur, location.x, location.y - 25);
    
    // Health Bar!
    pushMatrix();
    stroke(0);
    strokeWeight(1);
    fill(255, 0, 0);
    rect(location.x - 25, location.y - 20, 50, 5);
    stroke(0, 255);
    fill(0, 255, 0);
    rect(location.x - 25, location.y - 20, map(healthCur, 0, healthMax, 0, 50), 5);
    noFill();
    popMatrix();
  }  
}




/**** Alternate Enemies ****/

class FastEnemy extends Enemy {
  /**** Constructors ****/
  FastEnemy() {
    location = generateSpawn();
    speed = 0.9;
    breadth = 18;
    healthMax = 1;
    healthCur = healthMax;
    damage = 0.1;
    colNorm = color(25, 255, 25);
    colHit = color(255);
    colCur = colNorm;
  }
}


class BossEnemy extends Enemy {
  /**** Constructors ****/
  BossEnemy() {
    location = generateSpawn();
    speed = 0.2;
    breadth = 75;
    healthMax = 7;
    healthCur = healthMax;
    damage = 0.4;
    colNorm = color(255, 0, 0);
    colHit = color(255);
    colCur = colNorm;
  }
}
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
class Gun {
  /**** Fields ****/
  Player owner;
  boolean firing;
  // Type: 0 = SemiAuto, 1 = FullyAuto
  byte type;
  
  
  /**** Constructors ****/
  Gun(Player tempOwner) {
    owner = tempOwner;
    firing = false;
    type = 0;
  }
  
  /**** Methods *****/
  void fire() {
    if (owner.alive) {
      if (firing) {
        theBullets.add(new Bullet(owner));
        firing = false;
      }
    }
  }
  
  void update() {
    fire();
  }
  
}


class Pistol extends Gun {
  /**** Constructors ****/
  Pistol(Player tempOwner) {
    super(tempOwner);
  }
}


class SMG extends Gun {
  /**** Fields ****/
  Timer fireRate;
  int ammoMax;
  int ammoCur;
  
  /**** Constructors ****/
  SMG(Player tempOwner) {
    super(tempOwner);
    type = 1;
    fireRate = new Timer(115);
    ammoMax = 100;
    ammoCur = ammoMax;
  }
  
  
  /**** Methods *****/
  // This fires the gun like an automatic weapon.
  void fire() {
    if (owner.alive) {
      if (firing && fireRate.isFinished() && ammoCur > 0) {
        // Fire off a bullet and reduce ammo count.
        theBullets.add(new Bullet(owner));
        ammoCur--;
        
        // If we have more ammo, restart the firing cooldown.
        // Otherwise, give the player back the pistol.
        if (ammoCur > 0) {
          fireRate.start();
        } else {
          owner.weapon = new Pistol(owner);
        }
      }
    }
  }
}
// Timer class; currently used for hit flashing.
class Timer {
  int timeStarted;
  int timeLength;
  
  Timer(int tempTimeLength) {
    timeLength = tempTimeLength;
  }
  
  void start() {
    timeStarted = millis();
  }
  
  boolean isFinished() {
    int timePassed = millis() - timeStarted;
    
    if (timePassed >= timeLength) {
      return true;
    } else {
      return false;
    }
    
  }
}
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


 

class Player {
  /**** Fields ****/
  PVector location;
  PVector mouseLoc;
  int direction;
  float speed;
  int breadth;
  boolean alive;
  float healthMax;
  float healthCur;
  int score=0 ;
  int highscore=0;
  Gun weapon;
  Timer hitTimer;
  color colNorm;
  color colHit;
  color colCur;
  
  
  
  /**** Constructors ****/
  Player() {
    location = new PVector(width/2, height/2);
    mouseLoc = new PVector(0,0);
    direction = 0;
    speed = 2;
    breadth = 20;
    alive = true;
    healthMax = 20;
    healthCur = healthMax;
    score = 0;
    weapon = new Pistol(this);
    hitTimer = new Timer(25);
    
    colNorm = color(200, 100, 0);
    
    colHit = color(255, 0, 0);
    
    colCur = colNorm;
  }
  
  /**** Methods ****/
  void walk() {
    switch (direction) {
      case NORTH: location.y -= speed; break;
      case WEST: location.x -= speed; break;
      case SOUTH: location.y += speed; break;
      case EAST: location.x += speed; break;
      /*
      // Normalized?
      case NORTH|WEST: location.y -= speed / 2; location.x -= speed / 2; break;
      case NORTH|EAST: location.y -= speed / 2; location.x += speed / 2; break;
      case SOUTH|WEST: location.y += speed / 2; location.x -= speed / 2; break;
      case SOUTH|EAST: location.y += speed / 2; location.x += speed / 2; break;
      */
      case NORTH|WEST: location.y -= speed; location.x -= speed; break;
      case NORTH|EAST: location.y -= speed; location.x += speed; break;
      case SOUTH|WEST: location.y += speed; location.x -= speed; break;
      case SOUTH|EAST: location.y += speed; location.x += speed; break;
      case NORTH|WEST|EAST: location.y -= speed; break;
      case SOUTH|WEST|EAST: location.y += speed; break;
      case NORTH|WEST|SOUTH: location.x -= speed; break;
      case NORTH|SOUTH|EAST: location.x += speed; break;
    }
    location.x = constrain(location.x, 0 + (breadth / 2), width - (breadth / 2));
    location.y = constrain(location.y, 0 + (breadth / 2), height - (breadth / 2));
  }
  
  void takeDamage(Enemy e) {
    healthCur = constrain(healthCur - e.damage, 0, healthMax);
    if (healthCur <= 0) {
      destroy();
    } else {
      // Flash colors
      colCur = colHit;
      hitTimer.start();
    }
  }
  
  void heal(int healAmt) {
    healthCur = constrain(healthCur + healAmt, 0, healthMax);
  }
  
  void colChange() {
    if (colCur == colHit && hitTimer.isFinished()) {
      colCur = colNorm;
    }
  }
  
  void destroy() {
    thePlayers.remove(this);
    alive = false;
    gamestate = 2;
    
    for (int i = 0; i < thePlayers.size(); i++) {
      Player p = thePlayers.get(i);
      
      if (p.alive == true) {
        gamestate = 1;
      }
    }
    
    if (gamestate == 2) {
      shambleTheZombies();
    } else {
      // If the game is still going, zombies choose a new target.
      for (int i = 0; i < theEnemies.size(); i++) {
        Enemy e = theEnemies.get(i);
        
        if (e.target == this) {
          e.target = e.getTarget();
        }
      } 
    }
      
  }
  
  
  /**** Update and Display ****/
  void update() {
    walk();
    colChange();
    weapon.update();
  }
  
  void display() {
    // Draw the player.
    fill(colCur);
    ellipse(location.x, location.y, breadth, breadth);
    
    // This code draws a rotating player - good for the future.
    /*
    pushMatrix();
    translate(location.x, location.y);
    rotate(atan2(mouseY-location.y, mouseX-location.x));
    fill(colCur);
    ellipse(0, 0, breadth, breadth);
    popMatrix();
    */
    
    
    // Show health as number.
    fill(colNorm);
    textAlign(CENTER);
    text(healthCur, location.x, location.y - 25);
    
    // Health Bar!
    pushMatrix();
    stroke(0);
    strokeWeight(1);
    fill(255, 0, 0);
    rect(location.x - 25, location.y - 20, 50, 5);
    stroke(0, 255);
    fill(0, 255, 0);
    rect(location.x - 25, location.y - 20, map(healthCur, 0, healthMax, 0, 50), 5);
    noFill();
    popMatrix();
    
    // Only show the score for our player at the top.
    if (this == myPlayer) {
      fill(255);
      textAlign(LEFT);
      text("Score: " + score, 5, 20);
      noFill();
    }
  }
  
}
int score = 0;
int highscore = 0;

void gameUpdate() {
  /**** Miscellaneous ****/
  background(50);
  if (gamestate == 1) {
    enemySpawn();
    dropSpawn();
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
}

void gameDraw() {
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
}

void gameoverDraw() {
  // Draw a big transparent square over the window and
  // slowly make the square become less transparent.
  fill(0, 0, 0, screenFade);
  screenFade = constrain(screenFade + .8, 0, 255);
  rect(0, 0, width, height);
  noFill();
  // Write the gameover text.
  textAlign(CENTER);
  textSize(24);
  fill(255, 0, 0);
  text("You were Consumed by the Horde!", width / 2, 50);
  noFill();
  textSize(16);
  text("Score: " +myPlayer.score, width / 2, 75);
  
  if (myPlayer.score > highscore){
    highscore= myPlayer.score ; 
  }
  
 text("Highscore: " + highscore, width / 2, 95);
  textSize(14);
  text("Tap to restart", width / 2, 110);
  textSize(12);
}

