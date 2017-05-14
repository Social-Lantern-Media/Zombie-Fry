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
