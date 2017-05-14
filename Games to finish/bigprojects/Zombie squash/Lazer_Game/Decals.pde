public class Blood
{
  PVector loc;
  PImage sprite;
  float rotation;
  
  Blood(float x, float y)
  {
    loc = new PVector(x, y);
    rotation = random(0, 200);
    
    int rand = (int)random(1, 5);
    switch(rand)
    {
      case 1:
        sprite = loadImage("blood.png");
        break;
     case 2:
       sprite = loadImage("blood2.png");
       break;
     case 3:
       sprite = loadImage("blood3.png");
       break;
     case 4:
       sprite = loadImage("blood4.png");
       break;
    }
  }
  
public void Render()
  {
    pushMatrix();
      translate(loc.x, loc.y);
      rotate(rotation);
      image(sprite, 0, 0, 24, 24);
    popMatrix();
  }
}


class DecalEngine
{
  ArrayList splots;

  DecalEngine()
  {
    splots = new ArrayList();
  }
  
  void Run()
  {
    for (int i = splots.size() - 1; i >= 0; i--)
    {
      Blood blood = (Blood) splots.get(i);
      blood.Render();
      if (splots.size() > 20)
      {
        splots.remove(0);
      }
    }
  }
   void Stop()
  {
    for (int i = splots.size() - 1; i >= 0; i--)
    {
      Blood blood = (Blood) splots.get(i);
      blood.Render();
      splots.remove(0);
      
    }
  }
  
void AddBloodSplot(float x, float y)
  {
    splots.add(new Blood(x, y));
  }
}
