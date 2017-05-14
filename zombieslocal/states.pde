int score = 0;
int highscore = 0;

void gameUpdate() {
  /**** Miscellaneous ****/
  background(50);
  if (gamestate == 1) {
    enemySpawn();
    dropSpawn();
  }
  
  /**** Updates ****/
  // Player
  for (int i = 0; i < thePlayers.size(); i++) {
    thePlayers.get(i).update();
  }
  
  // Bullets
  for (int i = 0; i < theBullets.size(); i++) {
    theBullets.get(i).update();
  }
  
  // Enemies
  for (int i = 0; i < theEnemies.size(); i++) {
    theEnemies.get(i).update();
  }
  
  // Drops
  for (int i = 0; i < theDrops.size(); i++) {
    theDrops.get(i).update();
  }
}

void gameDraw() {
  /**** Displays ****/
  // Player
  for (int i = 0; i < thePlayers.size(); i++) {
    thePlayers.get(i).display();
  }
  
  // Bullets
  for (int i = 0; i < theBullets.size(); i++) {
    theBullets.get(i).display();
  }
  
  // Enemies
  for (int i = 0; i < theEnemies.size(); i++) {
    theEnemies.get(i).display();
  }
  
  // Drops
  for (int i = 0; i < theDrops.size(); i++) {
    theDrops.get(i).display();
  }
}

void gameoverDraw() {
  // Draw a big transparent square over the window and
  // slowly make the square become less transparent.
  fill(0, 0, 0, screenFade);
  screenFade = constrain(screenFade + .8, 0, 255);
  rect(0, 0, width, height);
  noFill();
  // Write the gameover text.
  textAlign(CENTER);
  textSize(24);
  fill(255, 0, 0);
  text("You were Consumed by the Horde!", width / 2, 50);
  noFill();
  textSize(16);
  text("Score: " +myPlayer.score, width / 2, 75);
  
  if (myPlayer.score > highscore){
    highscore= myPlayer.score ; 
  }
  
 text("Highscore: " + highscore, width / 2, 95);
  textSize(14);
  text("Tap to restart", width / 2, 110);
  textSize(12);
}
