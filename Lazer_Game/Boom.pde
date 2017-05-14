class Boom
{
  PVector loc;
  PImage sprite;
  float rotation;
  
  Boom(float x, float y)
  {
    loc = new PVector(x, y);
    rotation = random(0, 200);
    
    int rand = (int)random(1, 5);
    switch(rand)
    {
      case 1:
        sprite = loadImage("boom.png");
        break;
     case 2:
       sprite = loadImage("boom2.png");
       break;
     case 3:
       sprite = loadImage("boom3.png");
       break;
     case 4:
       sprite = loadImage("boom4.png");
       break;
    }
  }
  
  void Render()
  {
    pushMatrix();
      translate(loc.x, loc.y);
      rotate(rotation);
      image(sprite, 0, 0, 24, 24);
    popMatrix();
  }
}


class DecalEngine2
{
  ArrayList splots;

  DecalEngine2()
  {
    splots = new ArrayList();
  }
  
  void Run()
  {
    for (int i = splots.size() - 1; i >= 0; i--)
    {
      Boom boom = (Boom) splots.get(i);
      boom.Render();
      if (splots.size() > 10)
      {
        splots.remove(0);
      }
    }
  }
  
  void AddBoomSplot(float x, float y)
  {
    splots.add(new Boom(x, y));
  }
}
