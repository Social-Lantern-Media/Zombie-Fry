class Enemy
{
  PVector loc;
  PVector vel;
  PVector acc;
  boolean dead;
  float d;
  int points;
  int hitpoints;


  Animation animation;

  Enemy(float x, float y, float velx, float vely, float _d, int _points, int _hitpoints, Animation _animation)
  {
    dead = false;
    loc = new PVector(x, y);
    vel = new PVector(velx, vely);
    acc = new PVector(2, 2);
    d = _d;
    points = _points;
    hitpoints = _hitpoints;



    // points = 100;




    //set up sprite

    animation = _animation;
  }

  //////////////add life counter for enemies
  //calls 

  boolean Dead()
  {

    if (dead && shooter == true ) {
      hitpoints = hitpoints - 1;
      return true;
    } else if (dead && shooter == false ) {

      if (buildinghit == true && dead && shooter == false) {
        hitpoints = 0;
        return true;
      } else {
        hitpoints = hitpoints;
        return false;
      }
    } else {
      //hitpoints = hitpoints - 1;
      return false;
    }
  }

  //check if over enemy and dead 
  public void CheckShot(boolean isShooting, float mX, float mY)
  {
    if (isShooting && mX > loc.x - 16 && mX < loc.x + 16 && mY > loc.y - 16 && mY < loc.y + 16)
    {
      dead = true;
      shooter = true;
      //buildinghit = true;
    } else {
      shooter = false;
      // dead = false;
      //buildinghit = true;
    }
  }



  public void Run()
  {
    vel.mult(acc, 0);
    loc.add(vel);
    CheckOnScreen();
    CheckHit();
    Render();
  }

  public void RandomVelocity()
  {
    vel.x = random(-2, 2);
    vel.y = random(-2, 2);
  }

  int CheckOnScreen()
  {
    if (loc.x > width + d + 1)
    {
      RandomVelocity();
      loc.x = -d;
      return 0;
    }
    if (loc.x < -d - 1)
    {
      RandomVelocity();
      loc.x = width + d;
      return 0;
    }
    if (loc.y > height + d + 1)
    {
      RandomVelocity();
      loc.y = -d;
      return 0;
    }
    if (loc.y < -d - 1)
    {
      RandomVelocity();
      loc.y = height + d;
      return 0;
    }
    return 0;
  }

  public void CheckHit()
  {

    if (buildinghit == true) {
      //dead = true;
      // shooter = true; 
      //hitpoints = 0;
    }

    //Checks if the enemy has hit the lazer
    if (loc.x > lazer.loc.x - 40 && loc.x < lazer.loc.x + 40 && loc.y > lazer.loc.y - 40 && loc.y < lazer.loc.y + 40)
    {
      //determines health of buildings
      shooter = true;
      dead = true;
      buildinghit = true;

      lazer.health -= 5;


      lazer.score = lazer.score-100;
      lazer.score = lazer.score+100;
    }

    //upgrades == health defines loc.x and loc.y - spacing  by 10px 
    if (lazer.health == 110) {
      // Checks if the enemy has hit the lazers upgrades

      if (loc.x > lazer.loc.x - 80 && loc.x < lazer.loc.x + 80 && loc.y > lazer.loc.y - 80 && loc.y < lazer.loc.y + 80)
      {
        //determines health of buildings
        shooter = true;
        dead = true;
        buildinghit = true;
        //hitpoints = hitpoints - 2;
        lazer.health -= 5;

        lazer.score = lazer.score-100;
        lazer.score = lazer.score+100;
      }
    }

    if (lazer.health == 120) {
      // Checks if the enemy has hit the lazers upgrades

      if (loc.x > lazer.loc.x - 80 && loc.x < lazer.loc.x + 80 && loc.y > lazer.loc.y - 80 && loc.y < lazer.loc.y + 80)
      {
        //determines health of buildings
        shooter = true;
        dead = true;
        buildinghit = true;
        //hitpoints = hitpoints - 2;
        lazer.health -= 5;

        lazer.score = lazer.score-100;
        lazer.score = lazer.score+100;
      }
    }

    if (lazer.health == 130) {
      // Checks if the enemy has hit the lazers upgrades

      if (loc.x > lazer.loc.x - 80 && loc.x < lazer.loc.x + 80 && loc.y > lazer.loc.y - 80 && loc.y < lazer.loc.y + 80)
      {
        //determines health of buildings
        shooter = true;
        dead = true;
        buildinghit = true;
        //hitpoints = hitpoints - 2;
        lazer.health -= 5;

        lazer.score = lazer.score-100;
        lazer.score = lazer.score+100;
      }
    }
    if (lazer.health == 140) {
      // Checks if the enemy has hit the lazers upgrades

      if (loc.x > lazer.loc.x - 80 && loc.x < lazer.loc.x + 80 && loc.y > lazer.loc.y - 80 && loc.y < lazer.loc.y + 80)
      {
        //determines health of buildings
        shooter = true;
        dead = true;
        buildinghit = true;
        //hitpoints = hitpoints - 2;
        lazer.health -= 5;

        lazer.score = lazer.score-100;
        lazer.score = lazer.score+100;
      }
    }
    if (lazer.health == 150) {
      // Checks if the enemy has hit the lazers upgrades

      if (loc.x > lazer.loc.x - 80 && loc.x < lazer.loc.x + 80 && loc.y > lazer.loc.y - 80 && loc.y < lazer.loc.y + 80)
      {
        //determines health of buildings
        shooter = true;
        dead = true;
        buildinghit = true;
        //hitpoints = hitpoints - 2;
        lazer.health -= 5;

        lazer.score = lazer.score-100;
        lazer.score = lazer.score+100;
      }
    }
    if (lazer.health == 160) {
      // Checks if the enemy has hit the lazers upgrades

      if (loc.x > lazer.loc.x - 80 && loc.x < lazer.loc.x + 80 && loc.y > lazer.loc.y - 80 && loc.y < lazer.loc.y + 80)
      {
        //determines health of buildings
        shooter = true;
        dead = true;
        buildinghit = true;
        //hitpoints = hitpoints - 2;
        lazer.health -= 5;

        lazer.score = lazer.score-100;
        lazer.score = lazer.score+100;
      }
    }
    if (lazer.health == 170) {
      // Checks if the enemy has hit the lazers upgrades

      if (loc.x > lazer.loc.x - 80 && loc.x < lazer.loc.x + 80 && loc.y > lazer.loc.y - 80 && loc.y < lazer.loc.y + 80)
      {
        //determines health of buildings
        shooter = true;
        dead = true;
        buildinghit = true;
        //hitpoints = hitpoints - 2;
        lazer.health -= 5;

        lazer.score = lazer.score-100;
        lazer.score = lazer.score+100;
      }
    }
    if (lazer.health == 180) {
      // Checks if the enemy has hit the lazers upgrades

      if (loc.x > lazer.loc.x - 80 && loc.x < lazer.loc.x + 80 && loc.y > lazer.loc.y - 80 && loc.y < lazer.loc.y + 80)
      {
        //determines health of buildings
        shooter = true;
        dead = true;
        buildinghit = true;
        //hitpoints = hitpoints - 2;
        lazer.health -= 5;

        lazer.score = lazer.score-100;
        lazer.score = lazer.score+100;
      }
    }
    if (lazer.health == 190) {
      // Checks if the enemy has hit the lazers upgrades

      if (loc.x > lazer.loc.x - 80 && loc.x < lazer.loc.x + 80 && loc.y > lazer.loc.y - 80 && loc.y < lazer.loc.y + 80)
      {
        //determines health of buildings
        shooter = true;
        dead = true;
        buildinghit = true;
        //hitpoints = hitpoints - 2;
        lazer.health -= 5;

        lazer.score = lazer.score-100;
        lazer.score = lazer.score+100;
      }
    }
    if (lazer.health == 200) {
      // Checks if the enemy has hit the lazers upgrades

      if (loc.x > lazer.loc.x - 80 && loc.x < lazer.loc.x + 80 && loc.y > lazer.loc.y - 80 && loc.y < lazer.loc.y + 80)
      {
        //determines health of buildings
        shooter = true;
        dead = true;
        buildinghit = true;
        //hitpoints = hitpoints - 2;
        lazer.health -= 5;

        lazer.score = lazer.score-100;
        lazer.score = lazer.score+100;
      }
    }
  }

  public void Render()
  {
    float theta = vel.heading2D() + PI/2;
    fill(200, 100);
    stroke(255);
    pushMatrix();
    translate(loc.x, loc.y);

    rotate(theta);
    imageMode(CENTER);
    animation.display(0, 0);
    popMatrix();
  }
}

class EnemyEngine
{
  ArrayList enemies;
  int v;

  int character; 

  EnemyEngine(int _v)
  {
    enemies = new ArrayList();
    v = _v;
  }

  void AddEnemy(float x, float y, float xvel, float yvel, float d)
  {

    //generations enemy 
    int gang = (int)random(1, 11);

    /////////// add sheep and more collectables 

    switch(gang)
    {
    case 1:
      Animation a = new Animation("enemy/enemy5_", 4);

      enemies.add(new Enemy(x, y, xvel, yvel, d, 100, 7, a));
      character = 1; 
      break;
    case 2:
      Animation b = new Animation("enemy/enemy2_", 4);

      enemies.add(new Enemy(x, y, xvel, yvel, d, 110, 1, b));
      character = 2; 
      break;
    case 3:
      Animation c1 = new Animation("enemy/enemy5_", 4);

      enemies.add(new Enemy(x, y, xvel, yvel, d, 110, 2, c1));
      character = 3; 
      break;
    case 4:
      Animation d1 = new Animation("enemy/enemy4_", 4);
      character = 4;
      enemies.add(new Enemy(x, y, xvel, yvel, d, 100, 1, d1));
      break;
    case 5:
      Animation d11 = new Animation("enemy/enemy3_", 4);
      character = 5; 
      enemies.add(new Enemy(x, y, xvel, yvel, d, 100, 1, d11));
      break;  

    case 6:
      Animation c11 = new Animation("enemy/enemy2_", 4);
      character = 6; 
      enemies.add(new Enemy(x, y, xvel, yvel, d, 150, 3, c11));
      break;

    case 7:
      Animation b1 = new Animation("enemy/enemy1_", 3);
      character = 7; 
      enemies.add(new Enemy(x, y, xvel, yvel, d, 110, 2, b1));
      break;

    case 8:
      Animation a1 = new Animation("enemy/enemy_", 3);
      character = 8; 
      enemies.add(new Enemy(x, y, xvel, yvel, d, 150, 3, a1));
      break;
      
      //oil canister
    case 9:
      character = 9; 
      Animation f1 = new Animation("enemy/dead_", 3);
      enemies.add(new Enemy(random(0, width), random(0, height), 0, 0, d, 70, 15, f1));

      break;
      //med pack     
    case 10:
      character = 10; 
      Animation g1 = new Animation("enemy/dog_", 3);
      enemies.add(new Enemy(random(0, width), random(0, height), 0, 0, d, 20, 10, g1));
      break;
    }
  }

  //generates random location
  void RandomEnemy()
  {
    int i = (int)random(0, 5);
    if (i == 1 )
      AddEnemy(-5, random(0, height), random(0.5, v), random(-v, v), 16);

    if (i == 2)
      AddEnemy(random(0, width), -5, random(-2, 2), random(0.5, v), 16);
    if (i == 3)
      AddEnemy(width + 5, random(0, height), random(-0.5, -v), random(-v, v), 16);
    if (i == 4)
      AddEnemy(random(0, width), height + 5, random(-v, v), random(-0.5, -v), 16);
    //  if ( i == 5) 
    //  AddEnemy(random(0, width), random(0, height), 0, 0, 16);
  }



  void Run(Lazer laser)
  {

    for (int i = enemies.size () - 1; i >= 0; i--)
    {

      Enemy enemy = (Enemy) enemies.get(i);

      enemy.Run();

      enemy.CheckShot(laser.shooting, mouseX, mouseY);

      if (enemy.Dead())
      {
        //buildinghit = true;
        explosionEngine.AddExplosion(enemy.loc.x, enemy.loc.y);
        decalEngine.AddBloodSplot(enemy.loc.x, enemy.loc.y);
        laser.score += enemy.points;
        buildinghit = false;
        fill(0, 247, 39); 
        textSize(36);

        //points value set to value of enemy creation

        if (enemy.points == 200) {
          text("oil", enemy.loc.x-25, enemy.loc.y-25);
           // pause = false;
  //pause(); 
          oilcounter = oilcounter + 1;
          oilcounterr = oilcounterr + 1; 

          if ( oilcounter == 15) {
            text("POWER UPGRADE", enemy.loc.x-25, enemy.loc.y+25);
            // pause = false;
  //pause(); 
            lazer.power = lazer.power + 250;
            oilcounter = 0;
          }
          if ( oilcounterr == 50) {
            text("oil x50", enemy.loc.x-25, enemy.loc.y+25);
             // pause = false;
  //pause(); 
            lazer.power = lazer.power + 500;
          }
          if ( oilcounterr == 150) {
            text("oil x150", enemy.loc.x-25, enemy.loc.y+25);
             // pause = false;
  //pause(); 
            lazer.power = lazer.power + 1000;
          }
          if ( oilcounterr == 300) {
            text("oil x300", enemy.loc.x-25, enemy.loc.y+25);
             // pause = false;
  //pause(); 
            lazer.power = lazer.power + 3000;
          }
          //add score marker for extra x5/x25/x150 badge
        }



        if (enemy.points == 300) {
          text("supplies", enemy.loc.x-25, enemy.loc.y-25);
           // pause = false;
  //pause(); 
          hlcounter =hlcounter + 1;
          hlcounterr =hlcounterr + 1;

          if ( hlcounter == 15) {
            text("BUILDING UPGRADED", enemy.loc.x-25, enemy.loc.y+25);
             // pause = false;
  //pause(); 
            //lazer.health = 150;
            lazer.health = lazer.health +10; 
            hlcounter = 0;
          }
          if ( hlcounterr == 50) {
            text("supplies x50", enemy.loc.x-25, enemy.loc.y+25);
             // pause = false;
  //pause(); 
            lazer.health = 150;
          }
          if ( hlcounterr == 150) {
            text("supplies x150", enemy.loc.x-25, enemy.loc.y+25);
             // pause = false;
  //pause(); 
            lazer.health = 150;
          }
          if ( hlcounterr == 300) {
            text("supplies x300", enemy.loc.x-25, enemy.loc.y-25);
             // pause = false;
  //pause(); 
            lazer.health = 150;
          }
          //add score marker for extra x5/x25/x150 badge
        }
        fill(0, 247, 39); 
        textSize(36);
        text("+"+enemy.points, enemy.loc.x+25, enemy.loc.y);


        rechargecounter +=1; 
        supplycounter +=1; 

        //setup point system 


        // recharge upgrades 
        if (  rechargecounter == 15 ) {

          recharge = recharge + win;
          rechargecounter = 0;
        }


        //building upgrades 
        if ( supplycounter == 30) {
          lazer.health = lazer.health + 10;
          //life = life + gain; 
          println(life);
          supplycounter = 0;
        }




        RandomEnemy();
        // enemy.hitpoints = enemy.hitpoints -1;
        if (enemy.hitpoints == 0  ) {

          //if (enemy.hitpoints >0){
          //  enemy.hitpoints = 0;
          //  }
          enemies.remove(i);
        }
        if (buildinghit == true) {
          enemies.remove(i);
        }
      }
    }
  }
  void Stop()
  {
    for (int i = enemies.size () - 1; i >= 0; i--)
    {
      Enemy enemy = (Enemy) enemies.get(i);
      enemy.Run();
      // enemy.hitpoints = enemy.hitpoints -1;
      if (enemy.hitpoints == 0 ) {
        //if (enemy.hitpoints >0){
        // enemy.hitpoints = 0;
        //}
        enemies.remove(i);
      }
      if (buildinghit == true) {
        enemies.remove(i);
      }
    }
  }
}
