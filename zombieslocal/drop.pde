class Drop {
  PVector location;
  int breadth;
  color colNorm;
  int type;
  
  Drop(int i) {
    location = new PVector(int(random(width)), int(random(height)));
    breadth = 10;
    type = i;
    
    switch(i) {
      // Health pack.
      case(0):
        colNorm = color(255, 118, 246); break;
      // SMG
      case(1):
        colNorm = color(255, 255, 0); break;
    }
  }
  
  void hasHit() {
    for (int i = 0; i < thePlayers.size(); i++) {
      Player p = thePlayers.get(i);
      float distance = dist(location.x, location.y, p.location.x, p.location.y);
      
      if (distance < breadth/2 + p.breadth/2) {
        giveEffect(p);
        destroy();
        break;
      }
    }
  }
  
  void giveEffect(Player p) {
    switch(type) {
      case(0): p.heal(3); break;
      case(1): p.weapon = new SMG(p); break;
    }
  }
  
  void destroy() {
    theDrops.remove(this);
  }
  
  void update() {
    hasHit();
  }
  
  void display() {
    fill(colNorm);
    ellipse(location.x, location.y, breadth, breadth);
    noFill();
  }
  
}
