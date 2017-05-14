class Smudge
{
  int life;
  float x1;
  float y1;
  float x2;
  float y2;
  
  Smudge(float _x1, float _y1 , float _x2, float _y2)
  {
    x1 = _x1;
    y1 = _y1;
    x2 = _x2;
    y2 = _y2;
    life = 50;
  }
  
  void Run()
  {
    life--;
    float a, r;
    a = map(life, 0, 50, 0, 255);
    r = map(life, 0, 75, 0, 255);
    stroke(r, 0, 0, a);
    strokeWeight(1);
    line(x1, y1, x2, y2);
  }
  
  boolean Dead()
  {
    if (life <= 0)
      return true;
    else
      return false;
  }
}

class SmudgeEngine
{
  ArrayList smudges;
  
  SmudgeEngine()
  {
    smudges = new ArrayList();
  }
  
  void Run()
  {
    for (int i = smudges.size() - 1; i >= 0; i--)
    {
      Smudge smudge = (Smudge) smudges.get(i);
      smudge.Run();
      if (smudge.Dead())
        smudges.remove(i);
    }
  }
  
  void Add(float x, float y, float pX, float pY)
  {
    smudges.add(new Smudge(x, y, pX, pY));
  }
}
