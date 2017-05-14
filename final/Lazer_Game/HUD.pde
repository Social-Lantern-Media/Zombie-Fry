class HUD
{
  PVector loc;
  PVector size;
  PFont txtFont;
  int r, g, b;
  
  HUD(float x, float y, int w, int h, int _r, int _g, int _b)
  {
    loc = new PVector(x, y);
    size = new PVector(w, h);
    r = _r;
    g = _g;
    b= _b;
  }
  
  void Render()
  {
    pushMatrix();
      translate(loc.x, loc.y);
      rectMode(CORNER);
      fill(r, g, b);
      rect(0, 0, size.x, size.y);
    popMatrix();
  }
}
