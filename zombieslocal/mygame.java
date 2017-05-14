import processing.core.*; 
import processing.xml.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class mygame extends PApplet {

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

public void setup() {
  size(600, 480);
  frameRate(60);
  cursor(CROSS);
  initialize();
}

public void draw() {
  /**** Miscellaneous ****/
  background(50);
  if (!gameover) {
    spawn();
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
    debug();
  }
}

public void keyPressed() {
  switch(key) {
    // For player direction.
    case('w'):case('W'):myPlayer.direction |=NORTH;break;
    case('d'):case('D'):myPlayer.direction |=EAST;break;
    case('s'):case('S'):myPlayer.direction |=SOUTH;break;
    case('a'):case('A'):myPlayer.direction |=WEST;break;
    // Enemy Spawning (For Debugging!)
    //case('z'): theEnemies.add(new Enemy());break;
    case('z'): enemyInterval = 100;break;
    // Restart game if it's over
    case('r'):case('R'): if (gameover) { initialize(); }break;
  }
}
 
public void keyReleased() {
  // For player direction.
  switch(key) {
    case('w'):case('W'):myPlayer.direction ^=NORTH;break;
    case('d'):case('D'):myPlayer.direction ^=EAST;break;
    case('s'):case('S'):myPlayer.direction ^=SOUTH;break;
    case('a'):case('A'):myPlayer.direction ^=WEST;break;
  }
}

public void mouseMoved() {
  mouseLoc.x = mouseX;
  mouseLoc.y = mouseY;
}

public void mouseDragged() {
  mouseLoc.x = mouseX;
  mouseLoc.y = mouseY;
}

public void mousePressed() {
  myPlayer.weapon.firing = true;
}

public void mouseReleased() {
  // If the gun is an automatic, enable this.
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
  int colNorm;
  int colCur;
  
  /**** Constructors ****/
  Bullet(Player tempOwner) {
    owner = tempOwner;
    location = owner.location.get();
    breadth = 10;
    speed = 15.0f;
    damage = 1;
    trajectory = PVector.sub(mouseLoc, location);
    trajectory.normalize();
    trajectory.mult(speed);
    colNorm = color(25, 75, 200);
    colCur = colNorm;
  }
  
  Bullet(PVector tempTrajectory) {
    location = owner.location.get();
    breadth = 10;
    speed = 15.0f;
    damage = 1;
    trajectory = PVector.sub(mouseLoc, location);
    trajectory.normalize();
    trajectory.mult(speed);
    colNorm = color(25, 75, 200);
    colCur = colNorm;
  }
  
  /**** Methods ****/
  public void travel() {
    // Bullet is moved along the trajectory
    location.add(trajectory);
  }
  
  public void stillAlive() {
    // Delete bullet if it goes off screen.
    // Also, a cheesy Portal reference.
    // http://www.youtube.com/watch?v=8IGS9qY7xko
    // Also, thanks amnon.owned from the Processing forums
    // for the refactored code tip!
    if (location.y > height || location.y < 0 || location.x > width || location.x < 0) {
      destroy();
    }
  }
  
  public void hasHit() {
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
  
  public void destroy() {
    theBullets.remove(this);
  }
  
  
  /**** Update and Display ****/
  public void update() {
    travel();
    stillAlive();
    hasHit();
  }
  
  public void display() {
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
  int colCur;
  int type;
  
  Drop(int i) {
    location = new PVector(PApplet.parseInt(random(width)), PApplet.parseInt(random(height)));
    breadth = 10;
    type = i;
    
    switch(i) {
      // Health pack.
      case(0):
        colCur = color(255, 118, 246); break;
    }
  }
  
  public void update() {
    
  }
  
  public void display() {
    fill(colCur);
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
  int damage;
  int breadth;
  Timer hitTimer;
  int colNorm;
  int colHit;
  int colCur;
  
  /**** Constructors ****/
  Enemy() {
    location = generateSpawn();
    target = getTarget();
    speed = 0.7f;
    breadth = 18;
    healthMax = 2;
    healthCur = healthMax;
    damage = 1;
    hitTimer = new Timer(25);
    colNorm = color(125, 75, 100);
    colHit = color(255, 0, 0);
    colCur = colNorm;
  }
  
  /**** Methods ****/
  public void walk() {
    if (gameover == false) {
      // Enemy walks towards player.
      trajectory = PVector.sub(target.location, location);
      trajectory.normalize();
      trajectory.mult(speed);
    }
    location.add(trajectory);
  }
  
  public void hasHit() {
    for (int i = 0; i < thePlayers.size(); i++) {
      Player p = thePlayers.get(i);
      
      if (p.alive == true) {
        float distance = dist(location.x, location.y, p.location.x, p.location.y);
       
        if (distance < breadth/2 + p.breadth/2) {
          p.takeDamage(this);
          destroy();
          break;
        }
      }
    }
  }
  
  public void takeDamage(Bullet b) {
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
  
  public void colChange() {
    if (colCur == colHit && hitTimer.isFinished()) {
      colCur = colNorm;
    }
  }
  
  public void destroy() {
    theEnemies.remove(this);
  }
  
  public void shamble() {
    this.speed = random(0.4f, 1);
    trajectory.set(random(-50, 50), random(-50, 50), 0);
    trajectory.normalize();
    trajectory.mult(speed);
  }
  
  public PVector generateSpawn() {
    int side;
    int spawnX = 0;
    int spawnY = 0;
    PVector spawnCoords;
    
    side = PApplet.parseInt(random(4));
    switch (side) {
      case(0): 
        spawnX = PApplet.parseInt(random(width));
        spawnY = 0;
        break;
      case(1): 
        spawnX = width;
        spawnY = PApplet.parseInt(random(height));
        break;
      case(2): 
        spawnX = PApplet.parseInt(random(width));
        spawnY = height;
        break;
      case(3): 
        spawnX = 0;
        spawnY = PApplet.parseInt(random(height));
        break;
    }
    
    return new PVector(spawnX, spawnY);
  }
  
  public Player getTarget() {
    int targetId;
    
    targetId = PApplet.parseInt(random(thePlayers.size()));
    
    return thePlayers.get(targetId);
  }
  
  /**** Update and Display ****/
  public void update() {
    walk();
    hasHit();
    colChange();
  }
  
  public void display() {
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
    speed = 0.9f;
    breadth = 18;
    healthMax = 1;
    healthCur = healthMax;
    damage = 1;
    colNorm = color(25, 255, 25);
    colHit = color(255, 0, 0);
    colCur = colNorm;
    trajectory = PVector.sub(myPlayer.location, location);
    trajectory.normalize();
    trajectory.mult(speed);
  }
}


class BossEnemy extends Enemy {
  /**** Constructors ****/
  BossEnemy() {
    location = generateSpawn();
    speed = 0.2f;
    breadth = 125;
    healthMax = 200;
    healthCur = healthMax;
    damage = 100;
    colNorm = color(255, 0, 0);
    colHit = color(255, 0, 0);
    colCur = colNorm;
    trajectory = PVector.sub(myPlayer.location, location);
    trajectory.normalize();
    trajectory.mult(speed);
  }
}
// Sets all globals to their defaults; handy for restarting.
public void initialize() {
  background(50);
  gameover = false;
  enemyInterval = 0.0f;
  spawnSpeed = 50.0f;
  spawnModifier = 0.35f;
  screenFade = 0.0f;
  mouseLoc = new PVector(0,0);
  myPlayer = new Player();
  thePlayers = new ArrayList<Player>();
  thePlayers.add(myPlayer);
  theBullets = new ArrayList<Bullet>();
  theEnemies = new ArrayList<Enemy>();
  theDrops = new ArrayList<Drop>();
}

// Creates new enemies based on the spawnSpeed which gradually
// decreases (making spawning faster.)
// Should be a static method of enemy but Processing doesn't
// like static methods :(
public void spawn() {
  if (enemyInterval < spawnSpeed) {
    enemyInterval++;
  } else {
    enemyInterval = 0;
    if (spawnSpeed > 40) {
      spawnSpeed -= spawnModifier;
    } else {
      spawnSpeed = 40;
    }
    
    int enemyType;
    enemyType = PApplet.parseInt(random(4));
    
    switch (enemyType) {
      case(0): theEnemies.add(new Enemy()); break;
      case(1): theEnemies.add(new BossEnemy()); break;
      default: theEnemies.add(new FastEnemy()); break;
    }
  }
}

// Logic that runs when game's over. (Zombie shamble, etc.)
public void gameover() {
  for (int i = 0; i < theEnemies.size(); i++) {
    theEnemies.get(i).shamble();
  }
}

public void gameoverDraw() {
  // Draw a big transparent square over the window and
  // slowly make the square become less transparent.
  fill(0, 0, 0, screenFade);
  screenFade = constrain(screenFade + .8f, 0, 255);
  rect(0, 0, width, height);
  noFill();
  // Write the gameover text.
  textAlign(CENTER);
  textSize(24);
  fill(255, 0, 0);
  text("BRAAAAAAINS!", width / 2, 50);
  noFill();
  textSize(16);
  text("Score: " + myPlayer.score, width / 2, 75);
  textSize(14);
  text("Tap to restart.", width / 2, 100);
  textSize(12);
}

// Adds a circle on the cursor, a line from the player to mouse,
// and some debug information at the top-left.
public void debug() {
  fill(255);
  textAlign(LEFT);
  text("FPS: " + PApplet.parseInt(frameRate), 5, 40);
  noFill();
}
class Gun {
  /**** Fields ****/
  Player owner;
  boolean firing;
  byte type;
  
  
  /**** Constructors ****/
  Gun(Player tempOwner) {
    owner = tempOwner;
    firing = false;
    type = 0;
  }
  
  /**** Methods *****/
  public void fire() {
    if (owner.alive) {
      if (firing) {
        theBullets.add(new Bullet(owner));
        firing = false;
      }
    }
  }
  
  public void update() {
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
    ammoMax = 25;
    ammoCur = ammoMax;
  }
  
  
  /**** Methods *****/
  // This fires the gun like an automatic weapon.
  public void fire() {
    if (owner.alive) {
      if (firing && fireRate.isFinished()) {
        theBullets.add(new Bullet(owner));
        fireRate.start();
      }
    }
  }
}
class Timer {
  int timeStarted;
  int timeLength;
  
  Timer(int tempTimeLength) {
    timeLength = tempTimeLength;
  }
  
  public void start() {
    timeStarted = millis();
  }
  
  public boolean isFinished() {
    int timePassed = millis() - timeStarted;
    
    if (timePassed >= timeLength) {
      return true;
    } else {
      return false;
    }
    
  }
}
class Player {
  /**** Fields ****/
  PVector location;
  int direction;
  float speed;
  int breadth;
  boolean alive;
  int healthMax;
  int healthCur;
  int score;
  Gun weapon;
  Timer hitTimer;
  int colNorm;
  int colHit;
  int colCur;
  
  
  /**** Constructors ****/
  Player() {
    location = new PVector(width/2, height/2);
    direction = 0;
    speed = 2;
    breadth = 20;
    alive = true;
    healthMax = 10;
    healthCur = healthMax;
    score = 0;
    weapon = new SMG(this);
    hitTimer = new Timer(25);
    colNorm = color(200, 100, 0);
    colHit = color(255, 0, 0);
    colCur = colNorm;
  }
  
  /**** Methods ****/
  public void walk() {
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
  
  public void takeDamage(Enemy e) {
    healthCur = constrain(healthCur - e.damage, 0, healthMax);
    if (healthCur <= 0) {
      destroy();
    } else {
      // Flash colors
      colCur = colHit;
      hitTimer.start();
    }
  }
  
  public void colChange() {
    if (colCur == colHit && hitTimer.isFinished()) {
      colCur = colNorm;
    }
  }
  
  public void destroy() {
    thePlayers.remove(this);
    alive = false;
    gameover = true;
    
    for (int i = 0; i < thePlayers.size(); i++) {
      Player p = thePlayers.get(i);
      
      if (p.alive == true) {
        gameover = false;
      }
    }
    
    if (gameover) {
      gameover();
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
  public void update() {
    walk();
    colChange();
    weapon.update();
  }
  
  public void display() {
    // Draw the player.
    pushMatrix();
    translate(location.x, location.y);
    rotate(atan2(mouseY-location.y, mouseX-location.x));
    fill(colCur);
    ellipse(0, 0, breadth, breadth);
    popMatrix();
    
    
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
  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#DFDFDF", "mygame" });
  }
}
