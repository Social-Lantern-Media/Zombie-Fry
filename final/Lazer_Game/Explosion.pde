class Puff
{
  PVector loc;
  PVector vel;
  int life;
  boolean dead;
  
  Puff(float x, float y, float xVel, float yVel)
  {
    loc = new PVector(x, y);
    vel = new PVector(xVel, yVel);
    life = 255;
    dead = false;
  }
  
  void Run()
  {
    loc.add(vel);
    Render();
    life = life - 30;
  }
  

  
  void Render()
  {
    pushMatrix();
      translate(loc.x, loc.y);
      ellipseMode(CENTER);
     // fill(255, 0, 0, life);
     fill(random(40,140), random(40,170), random(2,10));
      noStroke();
      ellipse(0, 0, random(0,4), random(0,4));
    popMatrix();
  }
  
  
  
  boolean Dead()
  {
    if (life <= 0)
      return true;
    else
      return false;
  }
}

class Explosion
{
  ArrayList puffs;
  PVector loc;
  
  Explosion(float x, float y)
  {
    loc = new PVector(x, y);
    puffs = new ArrayList();
    
    for (int i = 0; i <= 10; i++)
      puffs.add(new Puff(loc.x, loc.y, random(-1, 1), random(-1, 1)));
  }
  
  void Run()
  {
    for (int i = puffs.size() - 1; i >= 0; i--)
    {
      Puff puff = (Puff) puffs.get(i);
      puff.Run();
      if (puff.Dead())
      {
        puffs.remove(i);
      }
    }
  }
}

class ExplosionEngine
{
  ArrayList explosions;
  
  ExplosionEngine()
  {
    explosions = new ArrayList();
  }
  
  void Run()
  {
    for (int i = explosions.size() - 1; i >= 0; i--)
    {
      Explosion explosion = (Explosion) explosions.get(i);
      explosion.Run();
      if (explosion.puffs.size() <= 0)
      {
        explosions.remove(i);
      }
    }
  }
  
  void AddExplosion(float x, float y)
  {
    explosions.add(new Explosion(x, y));
  }
}
