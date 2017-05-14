class Tank
{
  PVector loc;
  PVector acc;
  PVector vel;
  
  int health;
  
  Tank(int x, int y, int _health)
  {
    loc = new PVector(x, y);
    health = _health;
  }
}
