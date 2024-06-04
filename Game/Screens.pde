int countdown = 0, musicOn = 1, switchScreen = 0;
SoundFile shuffling;

void startScreen() {
  background(color(72, 120, 96));
  pixel = createFont("Pixel.ttf", 50);
  pixel2 = createFont("Pixel2.otf", 23);
  textFont(pixel);
  textAlign(CENTER);
  fill(color(255, 74, 89));
  text("Chinese", width/2-50, height/2-175);
  fill(color(38, 28, 29));
  text("Poker", width/2+90, height/2-100);
  fill(color(255));
  textFont(pixel, 20);
  text("Select Number of Players:", width/2, height/2+25);
  stroke(color(255, 74, 89));
  strokeWeight(3);
  fill(color(255));
  if (mouseX > 100 && mouseX < 350 && mouseY > 500 && mouseY < 580) {
    fill(color(255, 74, 89));
  }
  rect(100, 500, 250, 80);
  fill(color(255));
  if (mouseX > 500 && mouseX < 750 && mouseY > 500 && mouseY < 580) {
    fill(color(255, 74, 89));
  }
  rect(500, 500, 250, 80);
  fill(color(255));
  if (mouseX > 900 && mouseX < 1150 && mouseY > 500 && mouseY < 580) {
    fill(color(255, 74, 89));
  }
  rect(900, 500, 250, 80);
  fill(color(38, 28, 29));
  text("2 Players", 225, 545);
  text("3 Players", 625, 545);
  text("4 Players", 1025, 545);
}

void loadingScreen() {
  background(color(72, 120, 96));
  if (musicOn == 1) {
    shuffling = new SoundFile(this, "Sound/shuffling.mp3");
    shuffling.play();
    musicOn--;
  }
  if (countdown <= 20) {
    text("Shuffling Deck.", width/2, height/2);
    countdown++;
  }
  else if (countdown <= 40) {
    text("Shuffling Deck..", width/2, height/2);
    countdown++;
  }
  else if (countdown <= 60) {
    text("Shuffling Deck...", width/2, height/2);
    countdown++;
  }
  else {
    countdown = 0; 
  }
}

void firstPlayerScreen() {
   background(color(72, 120, 96));
   fill(color(255, 74, 89));
   text(playerList.get(currentTurn).getName() + " is the first player", width/2, height/2);
}

void gameScreen() {
  textFont(pixel2);
  background(color(72, 120, 96));
  fill(color(72, 120, 96));
  stroke(color(53, 101, 77));
  strokeWeight(10);
  ellipse(width/2, height/2, 800, 400);
  stroke(color(255));
  strokeWeight(2);
  ellipse(width/2, height/2, 790, 390);
  displayPlayerCards(playerList.get(currentTurn));
  stroke(color(53, 101, 77));
  strokeWeight(4);
  rectMode(CENTER);
  rect(width/2-183, height/2+3, 80, 110, 10);
  rect(width/2-93, height/2+3, 80, 110, 10);
  rect(width/2-3, height/2+3, 80, 110, 10);
  rect(width/2+87, height/2+3, 80, 110, 10);
  rect(width/2+177, height/2+3, 80, 110, 10);
  fill(255);
  text("Player " + currentTurn + "'s Turn", 80, 30);
  textAlign(CENTER);
  text("" + playerSelection, width/2, 635);
  text(placedCardText, width/2, 330);
  displayPlacedCards();
  isGameOver();
}
