class Gun {
  /**** Fields ****/
  Player owner;
  boolean firing;
  // Type: 0 = SemiAuto, 1 = FullyAuto
  byte type;
  
  
  /**** Constructors ****/
  Gun(Player tempOwner) {
    owner = tempOwner;
    firing = false;
    type = 0;
  }
  
  /**** Methods *****/
  void fire() {
    if (owner.alive) {
      if (firing) {
        theBullets.add(new Bullet(owner));
        firing = false;
      }
    }
  }
  
  void update() {
    fire();
  }
  
}


class Pistol extends Gun {
  /**** Constructors ****/
  Pistol(Player tempOwner) {
    super(tempOwner);
  }
}


class SMG extends Gun {
  /**** Fields ****/
  Timer fireRate;
  int ammoMax;
  int ammoCur;
  
  /**** Constructors ****/
  SMG(Player tempOwner) {
    super(tempOwner);
    type = 1;
    fireRate = new Timer(115);
    ammoMax = 100;
    ammoCur = ammoMax;
  }
  
  
  /**** Methods *****/
  // This fires the gun like an automatic weapon.
  void fire() {
    if (owner.alive) {
      if (firing && fireRate.isFinished() && ammoCur > 0) {
        // Fire off a bullet and reduce ammo count.
        theBullets.add(new Bullet(owner));
        ammoCur--;
        
        // If we have more ammo, restart the firing cooldown.
        // Otherwise, give the player back the pistol.
        if (ammoCur > 0) {
          fireRate.start();
        } else {
          owner.weapon = new Pistol(owner);
        }
      }
    }
  }
}
