/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/81640*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
Lazer lazer;
PFont font;
SmudgeEngine smudges;
EnemyEngine enemyEngine;
DecalEngine decalEngine;
ExplosionEngine explosionEngine;

Particle[] particleArr = new Particle[0];
int maxParticles = 100;
boolean clicked = true;
boolean pause = false; 
boolean fire1 = false; 
boolean fire2 = false; 
boolean fire3 = false; 

int prevMillis;
int gamecheck = 0 ;
int gamestart = 0; 
int highscore = 100; 
int recharge = 1000; 
int rechargecounter =0; 
int supplycounter =0; 
int hlcounter = 0; 
int hlcounterr = 0; 
int oilcounterr = 0; 
int oilcounter = 0; 
int win = 100;
int life = 0; 
int gain = 10; 

boolean welcome = true;
boolean playing;
boolean restart;
boolean shooter;
boolean respawn; 
boolean buildinghit = false; 

float prevX;
float prevY;

PImage bground;
PImage trees;
PImage frontpage;
PImage aboutpage;
PImage endpage;

void setup()
{
  size(800, 600);
  frameRate(60);
 // noCursor();
  smooth();
  
  lazer = new Lazer(width / 2, height / 2);
  smudges = new SmudgeEngine();
  enemyEngine = new EnemyEngine(5);
  decalEngine = new DecalEngine();
  explosionEngine = new ExplosionEngine();

  
  
  //Make Some Enemies
  if (respawn = true) {
    for (int i=0; i<=10; i++)
    {
      enemyEngine.RandomEnemy();
    }
  }



  prevMillis = millis();

  bground = loadImage("background.png");
  trees = loadImage ("trees.png"); 
  frontpage = loadImage ("Titlepage.png"); 
  aboutpage = loadImage ("aboutscreen.png"); 
  endpage = loadImage ("Endscreen.png");
  
    image(frontpage, 0, 0);
}

void title() {
}

void play() {
  if (playing == true)
  {
    gamecheck =2;
    gamestart =2;
    background(bground);
    decalEngine.Run();
    explosionEngine.Run();

    smudges.Run();


    //add smudges
    if (lazer.shooting)
      smudges.Add(mouseX, mouseY, prevX, prevY);

    prevX = mouseX;
    prevY = mouseY;



   

    //HUD



   

    lazer.Run();

    // text("POWER:  " + lazer.power, width / 2, 52);

    fill(255);
    textSize(32);
    text("SCORE: " + lazer.score, width / 2, height - 52);
    
    //configure respawn challenge for time duration and kills == 
    if (millis() >= prevMillis + 10000)
    {
      prevMillis = millis();
      enemyEngine.RandomEnemy();
    }
     //Enemies
    enemyEngine.Run(lazer);
    
  }
   image(trees, 390, 305);
}

void finish() {

  playing = false;
  restart = false; 
  welcome = true;  
  respawn = false; 
  fire1 = false;
  fire2 = false;
  fire3 = false;

  decalEngine.Stop();
  enemyEngine.Stop();

  // add achievements 

  image(endpage, 400, 300); 
  textSize(24);
  fill(255, 255, 0);
  text("GAME OVER", width / 2, height / 2);
  text("Final Score: " + lazer.score, width / 2, height / 2 + 24);

  if (lazer.score >= highscore) {
    highscore = lazer.score;
  }
  text("High Score: " + highscore, width / 2 - 40, height / 2 + 44);
  //
  if (mousePressed && gamecheck == 2) {

    restart();
  }
}

/// configure award/achievements rest
void restart() {
  respawn = true; 
  restart = true; 
  playing = true;
  fire1 = false;
  fire2 = false;
  fire3 = false;
  hlcounterr = 0; 
  gamecheck = 0;
  gamestart = 0; 
  hlcounter = 0; 
  oilcounter = 0; 
  lazer.health = 100;
  lazer.score = 0;
  recharge = 1000; 
  rechargecounter =0; 
  supplycounter =0; 

  welcome = true;   
  welcome();
  
  // pause = false;
  //pause(); 
}

void welcome() {

  //background(0);
  //image(frontpage, 400, 300);
  

  if (mousePressed && gamestart == 2) {
    welcome = false;  
    playing = true;
    play();
  }
}


void draw()
{

  if (welcome == true) {  
    welcome();
  }

  if (welcome == false) {
    play();
  }
  // if(pause == true) {
    
 // }


  if (lazer.health < 0) {
    finish();
  }

  ///POWER UP POINTS / Badges  ////////////////////////// add void state and counter to reset 

  //if (power > 1100 && power < 1300) {
  if (recharge == 1200) {

    fill(0, 247, 39); 
    //image badge
     // pause = false;
  //pause(); 
    text("Power Level 1 ", width / 2, 152);
    lazer.score = lazer.score + 5000 ;
    recharge = recharge + 1500;
  }
  // if (power > 1300 && power < 1500) {
  if (recharge == 5000) {

    fill(0, 247, 39); 
    //image badge
     // pause = false;
  //pause(); 
    text("Power Level 2 ", width / 2, 152);
    lazer.score = lazer.score+ 10000;
    recharge = recharge + 3000;
  }
  // if (power > 1500 ) {
  if (recharge == 13000) {

    fill(0, 247, 39); 
    //image badge
     // pause = false;
  //pause(); 
    text("Power Level 3 ", width / 2, 152);
    lazer.score = lazer.score+ 5000000;
    recharge = recharge + 10000000;
  }
  
  if (fire1 == true | fire2 == true | fire3 == true) {
  
   for(int i =0; i < 2 ; i++)
        particleArr = (Particle[]) append(particleArr , new Particle());
    
    for(int i = 0; i < particleArr.length; i++)
        particleArr[i].update();
        
    while(particleArr.length > maxParticles)
        particleArr = (Particle[]) subset(particleArr , 1);
  }
}


void mousePressed()
{
  lazer.StartShooting();
  lazer.prevMillis = millis();
  gamecheck = 2;
  gamestart = 2;
  
   clicked = !clicked;
   
   
    
    if(clicked && pause == true)
        noLoop();
    else
        loop();
  
}

void mouseReleased()
{
  lazer.StopShooting();
}

void mouseClicked() {
  
}
void keyPressed()
{
}

void keyReleased()
{
}
