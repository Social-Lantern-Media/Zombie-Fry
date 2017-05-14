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
