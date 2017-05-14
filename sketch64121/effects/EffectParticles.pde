class EffectParticles extends Effect {
  int particleNumber = 900;
// max radius particle bowl
int maxRadius = 180;

// particle class
EffectParticle[] particleEllipse; 

// alhpa background
int alphaBG = 100;

// particle size
int partSize = 64;
  EffectParticles(int width, int height, int nParticles, int radius, int particleSize) {
    super(width,height);
    particleNumber=nParticles;
    partSize=particleSize;
      // multiply because maxRadius will be sqrt in draw
  maxRadius = radius*radius;

  // init particles
  makeParticles();
  }
  void begin(int x, int y) {
    super.begin();
    for (int i=0;i<particleEllipse.length;i++) {
    particleEllipse[i].display();
    particleEllipse[i].move(x, y);
    particleEllipse[i].tweak(maxRadius, partSize);
  }   
  }
   PImage end(boolean complement) {
     return end();
   }
   PImage end() {
   pg.updatePixels();
   pg.endDraw();
   pg.popStyle();
   return pg;
  }
  void makeParticles() {
  // init particles, particleNumber = the number of particles that will be made
  particleEllipse = new EffectParticle[particleNumber];
  for (int i=0;i<particleEllipse.length;i++) {
    particleEllipse[i] = new EffectParticle(int(random(maxRadius)));
  }
  }
  /* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/52842*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
// Particle Ellipse 
// By Apewire
class EffectParticle {
  // ellipse center position
  float centerX;
  float centerY;  
  // previous particle x,y pos
  float prevX;
  float prevY;
  // new particle x and y pos 
  float nextX;
  float nextY;
  // current particle x and y pos
  float currX;
  float currY;
  // lerp
  float lerpValue = 0;
  float lerpSpeed = 0.5;
  // particle size
  float partSize = random(16); 
  // particle color;
  color partColor;
  int maxPartAlhpa = 150;
  int partAlpha = maxPartAlhpa;
  boolean newAlpha = false;

  // max ellipse radius
  int partBorder; 

  EffectParticle(int _partBorder) {
    partBorder = _partBorder;
    partColor = color(random(255), random(255), random(255));
  }

  void tweak(int _partBorder, int _partSize) {
    partBorder = _partBorder;
    partSize = random(_partSize);
  }

  void display() {
    pg.noStroke();
    pg.fill(partColor, partAlpha);
    pg.ellipse(currX, currY, partSize, partSize);
  }

  void move() {
    centerX = width/2;
    centerY = height/2;
    position();
  } 

  // overrides move -> set costom center position (middle of the ellipse)
  void move(float _centerX, float _centerY) {
    centerX = _centerX;
    centerY = _centerY;
    position();
  } 

  // calculates particle positions 
  void position() {
    if (lerpValue >= 1) {
      // radius = square root (random(maxsize)); use sqrt for an even distribution
      float radius = sqrt(random(partBorder));
      // set random angles/positions, make a circle (TWO_PI)
      float angle = random(TWO_PI);
      // set previous position
      prevX = nextX;
      prevY = nextY;
      // set new position
      nextX = centerX + cos(angle) * radius;
      nextY = centerY + sin(angle) * radius;

      // set lerpSpeed -> distance between prevpos (x,y) & nextpos (x,y) * 0.0002
      lerpSpeed = calculateDist() * 0.0008;
      // reset lerp values
      lerpValue = 0;
      newAlpha = false;
    }
    else {
      currX = lerp(prevX, nextX, lerpValue);
      currY = lerp(prevY, nextY, lerpValue);
      lerpValue += lerpSpeed;
      if (newAlpha == false) {  
        partAlpha += 1;
        if (partAlpha >= maxPartAlhpa) {
          newAlpha = true;
        }
      }
      else if (partAlpha >= 10) {
        partAlpha -= 8;
      }
    }
  }

  // calculate distance between prev position and next position
  float calculateDist() {
    float dx = prevX - nextX;
    float dy = prevY - nextY;
    float distance = sqrt(dx*dx + dy*dy);
    return distance;
  }
}
}
