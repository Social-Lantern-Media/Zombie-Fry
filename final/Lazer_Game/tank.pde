class Particle {
    
     float x;
    float y;
    
    float x1;
    float y1;
    
    float x2;
    float y2;
    
    float velX;
    float velY;
    
    float drag;
    
    color c;
    
    float size;
    float shrink;
    
    float gravity,opacity;
    int fade;
    
    Particle(){
      
      rectMode(CENTER);
      imageMode(CENTER); 
        if (fire1 == true) { 
          fire2 = false;
          fire3 = false;
          
        x = 400;
        y = 300;
        
        size = random(1 , 5);
        shrink = 0.54;
         drag = 0.37;
        gravity = -0.10;
        opacity = 255;
        fade = 2;
      }
      
      
      if (fire2 == true) { 
        fire1= false;
        fire2=true;
        fire3= false;
        
      //  x1 = 400-110;
       // y1 =300-110;
       
       size = random(1 , 7);
        shrink = 0.84;
         drag = 0.67;
        gravity = -0.15;
        opacity = 255;
        fade = 4;
      }
      
      if (fire3 == true) { 
        fire1= false;
        fire2=false;
        fire3= true;
       // x2 = 400+120;
        //y2 = 300+120;
        
        size = random(1 , 10);
        shrink = 1.04;
         drag = 0.97;
        gravity = -0.20;
        opacity = 255;
        fade = 7;
      }
        
        velX = random(-2 , 2);
        velY = random(-2 , 2);
        
       
        
        c = color(255);
        
       // size = random(2 , 10);
        //shrink = 1.04;
        
       // gravity = -0.20;
       // opacity = 255;
       // fade = 5;
       
    }//end of constructor
    
    void update(){
        
        velX *= drag;
        velY *= drag;
        
        velY += gravity;
        
        x += velX;
        y += velY;
        
        //x1 += velX;
       // y1 += velY;
        
       // x2 += velX;
       // y2 += velY;
        
        size *= shrink;
        
        opacity -= fade;
        
        c = color(255 - fade , map(255 - size, 0 , width ,10 , 255), 255);
        
        if(opacity > 0){
          noStroke(); 
            fill(c , opacity);
            ellipse( x , y , size , size);
            // ellipse( x1 , y1 , size , size);
             // ellipse( x2 , y2 , size , size);
            //rect( x - 10 , y , size, size);
        }
    
    }//end of update
    

}
