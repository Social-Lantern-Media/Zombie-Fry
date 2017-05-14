/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/64121*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
/* I am a big believer in software reuse.  I took some great examples and made them more useful.
 * The complement argument will apply the effect to any black pixel if true, non-black if false.
 * bobcook47@hotmail.com  feel free to send improvements or additions
 */
EffectFireworks pg;
EffectFire pg1;
EffectGradientLinear pg2;
EffectGradientRadial pg3;
EffectGradientWave pg4;
EffectLightning pg5;
EffectMetaball pg6;
EffectParticles pg7;
EffectPlasma pg8;
EffectSpray pg9;

void setup(){
  size(640, 360);
  // Create buffered image for effect
  pg = new EffectFireworks(100,100);
  pg1 = new EffectFire(100,100);
  pg2 = new EffectGradientLinear(100,100);
  pg3 = new EffectGradientRadial(100,100);
  pg4 = new EffectGradientWave(100,100);
  pg5 = new EffectLightning(100,100,4);
  pg6 = new EffectMetaball(100,100,6,20000,1,180,1);
  pg7 = new EffectParticles(100,100,200,100,18);
  pg8 = new EffectPlasma(100,100);
  pg9 = new EffectSpray(200,200);
}

void draw()
{
  // Output into a buffered image for reuse
  pg.begin();
  pg.fill(0xff0000);
  pg.textSize(48);
  pg.text("HI",20,50); 
  // display the results
  image(pg.end(),0,0);//,width,height);
  
  pg1.begin();
  pg1.fill(0xff0000);
  pg1.textSize(48);
  pg1.text("HI",20,50); 
  // display the results
  image(pg1.end(true),100,0);
  pg1.begin();
  pg1.fill(0xff0000);
  pg1.ellipse(40,40,70,50); 
  // display the results
  image(pg1.end(false),200,0);
  
  pg2.begin(0xff00,0xff,true);
  pg2.fill(0xff0000);
  pg2.textSize(48);
  pg2.text("HI",20,50); 
  // display the results
  image(pg2.end(true),300,0);
  pg2.begin(0xff00,0xff,true);
  pg2.fill(0xff0000);
  pg2.textSize(80);
  pg2.text("HI",20,70); 
  // display the results
  image(pg2.end(false),400,0);

  pg3.begin(50,50,50,0xff00,0xff);
  pg3.fill(0xff0000);
  pg3.textSize(80);
  pg3.text("HI",11,76); 
  // display the results
  image(pg3.end(false),500,0);
  pg3.begin(50,50,50,0xff00,0xff);
  pg3.fill(0xff0000);
  pg3.textSize(80);
  pg3.text("HI",11,76); 
  // display the results
  image(pg3.end(true),0,100);

  pg4.begin();
  pg4.fill(0xff0000);
  pg4.textSize(80);
  pg4.text("HI",20,70); 
  // display the results
  image(pg4.end(false),100,100);
  pg4.begin();
  pg4.fill(0xff0000);
  pg4.textSize(80);
  pg4.text("HI",20,70); 
  // display the results
  image(pg4.end(true),200,100);

  pg5.begin();
  pg5.fill(0xff0000);
  pg5.textSize(80);
  pg5.text("HI",20,70); 
  // display the results
  image(pg5.end(),300,100);

  pg6.begin();
  pg6.fill(0xff0000);
  pg6.textSize(80);
  pg6.text("HI",20,70); 
  // display the results
  image(pg6.end(true),400,100);
  pg6.begin();
  pg6.fill(0xff0000);
  pg6.textSize(80);
  pg6.text("HI",20,70); 
  // display the results
  image(pg6.end(false),500,100);

  pg7.begin(50,50);
  pg7.fill(0xff0000);
  pg7.textSize(80);
  pg7.text("HI",20,70); 
  // display the results
  image(pg7.end(),0,200);

  pg8.begin();
  pg8.fill(0xff0000);
  pg8.textSize(80);
  pg8.text("HI",20,70); 
  // display the results
  image(pg8.end(true),100,200);
  pg8.begin();
  pg8.fill(0xff0000);
  pg8.textSize(80);
  pg8.text("HI",20,70); 
  // display the results
  image(pg8.end(false),200,200);

  pg9.begin(0xff00,4);
  pg9.fill(0xffffff);
  pg9.textSize(80);
  pg9.text("HI",20,70); 
  // display the results
  image(pg9.end(),200,200);  
}

