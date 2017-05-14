public class Lazer
{
  PVector loc;
  boolean shooting;

  int power;
  int shootCost;
  int shootRecharge;
  int health;

  int score;

  //timer
  int prevMillis;

  //images
  PImage castle;
  PImage castleMask;
  PImage turret; 
  
  PImage smoke10;
  PImage smoke20;
  PImage smoke30; 

  Lazer(int x, int y)
  {
    loc = new PVector(x, y);
    prevMillis = 0;

    power = 1000;
    shootCost = 10;
    shootRecharge = 0;
    health = 100 + life;
    life = health; 

    //images
   // castleMask = loadImage("castle mask.png");
    turret = loadImage("turret.png");
    smoke30 = loadImage("smoke30.png");
    smoke20 = loadImage("smoke20.png");
     smoke10 = loadImage("smoke10.png");
  }

  void Run()
  {
    //draw wall
    imageMode(CENTER);

    switch(health)
    {

      case 200:
      castle = loadImage("castle 200.png");
      
     //rect(loc.x, loc.y, 80, 80);
     // castle.mask(castleMask);  
      break;  
      
      case 190:
      castle = loadImage("castle 190.png");
      noFill();
     // rect(loc.x, loc.y, 80, 80);
     // castle.mask(castleMask);  
      break;  
    
      case 180:
      castle = loadImage("castle 180.png");
     noFill();
     //rect(loc.x, loc.y, 80, 80);
     // castle.mask(castleMask);  
      break;  
      
      case 170:
      castle = loadImage("castle 170.png");
     noFill();
     // rect(loc.x, loc.y, 80, 80);
      //castle.mask(castleMask);  
      break;  
      
      case 160:
      castle = loadImage("castle 160.png");
     noFill();
     //rect(loc.x, loc.y, 80, 80);
     // castle.mask(castleMask);  
      break;  
      
      case 150:
      castle = loadImage("castle 150.png");
      noFill();
     // rect(loc.x, loc.y, 80, 80);
     // castle.mask(castleMask);  
      break;  

    case 140:
      castle = loadImage("castle 140.png");
      noFill();
    // rect(loc.x, loc.y, 80, 80);
      //castle.mask(castleMask);  
      break;  

    case 130:
      castle = loadImage("castle 130.png");
      noFill();
     //rect(loc.x, loc.y, 80, 80);
      //castle.mask(castleMask);  
      break;  

    case 120:
      castle = loadImage("castle 120.png");
      noFill();
     //rect(loc.x, loc.y, 80, 80);
     // castle.mask(castleMask);  
      break;  

    case 110:
      castle = loadImage("castle 110.png");
      
      //rect(loc.x, loc.y, 80, 80);
      //castle.mask(castleMask);  
      break;   

    case 100:
      castle = loadImage("castle 100.png");
     // castle.mask(castleMask);
      break;
    case 90:
      castle = loadImage("castle 90.png");
     // castle.mask(castleMask);
      break;
    case 80:
      castle = loadImage("castle 80.png");
     // castle.mask(castleMask);
      break;
    case 70:
      castle = loadImage("castle 70.png");
     // castle.mask(castleMask);
      break;
    case 60:
      castle = loadImage("castle 60.png");
     // castle.mask(castleMask);
      break;
    case 50:
      castle = loadImage("castle 50.png");
     // castle.mask(castleMask);
      break;
    case 40:
      castle = loadImage("castle 40.png");
     // castle.mask(castleMask);
      break;
    case 30:
      castle = loadImage("castle 30.png");
      image(smoke30,  loc.x, loc.y);
      
    //  castle.mask(castleMask);
      break;
    case 20:
      castle = loadImage("castle 20.png");
      image(smoke20,  loc.x, loc.y);
      
     // castle.mask(castleMask);
      break;
    case 10:
      castle = loadImage("castle 10.png");
      image(smoke10, loc.x, loc.y);
      
    //  castle.mask(castleMask);
      break;
    case 0:
      castle = loadImage("castle dead.png");
     // castle.mask(castleMask);
      break;
    }

    image(castle, loc.x, loc.y);
    
    
   

    if ( power < 200) {
      fill(247, 0, 0);
      textSize(24); 
      text("POWER:  " + lazer.power, width / 2, 52);
    }
    if ( power < 500 && power > 200) {
      fill(214, 247, 0); 
      textSize(24);
      text("POWER:  " + lazer.power, width / 2, 52);
    }
    if ( power > 500) {
      fill(0, 247, 39); 
      textSize(24);
      text("POWER:  " + lazer.power, width / 2, 52);
    } 







    //draw lazer beam
    if (shooting)
    {
      power -= shootCost;
      explosionEngine.AddExplosion(mouseX, mouseY);

      strokeWeight(7); 
      stroke(255, 0, 0, 100);
      line(loc.x, loc.y, mouseX, mouseY);
      strokeWeight(1); 
      stroke(255);

      line(loc.x, loc.y, mouseX, mouseY);
      //draw turret
      noStroke();
      pushMatrix();

      translate(loc.x, loc.y);
      rotate(atan2(mouseY - loc.x, mouseX - loc.y));
      //imageMode(CENTER);
       image(turret, CENTER,CENTER); 
      //fill(0);
      //rect(3, 0, 15, 5);
      //fill(0, 0, 255);
     // ellipseMode(CENTER);
      //ellipse(0, 0, 15, 15);

      //fill(100);
      //ellipse(0, 0, 8, 8);

      popMatrix();
    } else {
      power +=20;

      if (power >=1000) {
        lazer.power = recharge;
      }



      //draw turret
      noStroke();
      pushMatrix();
      translate(loc.x, loc.y);
      rotate(atan2(mouseY - loc.x, mouseX - loc.y));
      //rectMode(CENTER);
      //imageMode(CENTER); 
       image(turret, CENTER,CENTER); 
      //set color for muzzle

      //fill(0);
      //rect(6, 0, 15, 5);
      //fill(0, 0, 255);
      //ellipseMode(CENTER);
      //ellipse(0, 0, 15, 15);
      //fill(100);
      //ellipse(0, 0, 9, 9);
      popMatrix();

      //draw cursor
      noStroke();
      ellipseMode(CENTER);
      fill(255, 0, 0);
      ellipse(mouseX, mouseY, 6, 6);
      fill(255);
      ellipse(mouseX, mouseY, 3, 3);

      //update timer
      if (millis() >= prevMillis + 500)
      {
        prevMillis = millis();
        if (shooting)
        {
          power -= shootCost;
        } else if (power < 100)
        {
          power += shootRecharge;
        }
      }
    }

    if (power <= shootCost && shooting)
      shooting = false;
      //shooter = false;
  }

  void StartShooting()
  {
    if (power >= shootCost)
    {
      shooting = true;
     // shooter = true;
      power -= shootCost; //this makes sure power is reduced if mouse is only tapped instead of held down
    }
  }

  void StopShooting()
  {
    shooting = false;
  }
}
