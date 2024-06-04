import processing.sound.*;

static int numPlayers, currentTurn, currentPokerHand = 0;
static ArrayList<Player> playerList = new ArrayList<Player>();
static ArrayList<Card> discardPile;
static ArrayList<Card> playerSelection = new ArrayList<Card>();
static ArrayList<Card> previousCards = new ArrayList<Card>();
static boolean selection = false;
static boolean isStartScreen = true;
static int playerPass = 0;
SoundFile cardClicked, cardPlaced;
PFont pixel, pixel2;

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
  displayPlacedCards();
  isGameOver();
}

void setupGame() {
  Deck test = new Deck();
  test.shuffleDeck();
  for (int i = 0; i < numPlayers; i++) {
    ArrayList<Card> giveToPlayer = new ArrayList<Card>();
    for (int j = 0 + (13*i); j < 13 + (13*i); j++) {
      giveToPlayer.add(test.deck.get(j));
    }
    playerList.add(new Player("Player " + (i), giveToPlayer));
  }
  currentTurn = findFirstPlayer();
}

int findFirstPlayer() {
  int firstPlayer = 0;
  Card lowest = new Card(15, 3, "", "");
  for (int i = 0; i < playerList.size(); i++) {
    ArrayList<Card> cards = playerList.get(i).getCards();
    for (int j = 0; j < 13; j++) {
      Card curr = cards.get(j);
      if (curr.lower(lowest)) {
        lowest = curr;
        firstPlayer = i;
      }
    }
  }
  return firstPlayer;
}

void displayPlayerCards(Player curr) {
  ArrayList<Card> cards = curr.getCards();
  PImage faceDownV = loadImage("./PlayingCardsS/b2.png");
  PImage faceDownH = loadImage("./PlayingCardsS/b2.1.png");
  faceDownV.resize(75, 0);
  faceDownH.resize(0, 75);
  if (numPlayers == 4) {
    for (int i = 0; i < cards.size(); i++) {
      PImage card = loadImage(cards.get(i).getImage());
      card.resize(75, 0);
      if (playerSelection.contains(cards.get(i))) {
        image(card, (width/2 - ((float)(cards.size()/2))* 80) + (i*80), 650);
      } else {
        image(card, (width/2 - ((float)(cards.size()/2))* 80) + (i*80), 675);
      }
    }

    for (int i = 0; i < playerList.get((currentTurn+1) % numPlayers).getCards().size(); i++) {
      image(faceDownH, 50, (height/2 - ((float)(cards.size()/2))* 30) + (i*25));
    }

    for (int i = 0; i < playerList.get((currentTurn+2) % numPlayers).getCards().size(); i++) {
      image(faceDownV, (width/2 - ((float)(cards.size()/2))* 55) + (i*50), 25);
    }

    for (int i = 0; i < playerList.get((currentTurn+3) % numPlayers).getCards().size(); i++) {
      image(faceDownH, 1100, (height/2 - ((float)(cards.size()/2))* 30) + (i*25));
    }
  } else if (numPlayers == 3) {
    for (int i = 0; i < cards.size(); i++) {
      PImage card = loadImage(cards.get(i).getImage());
      card.resize(75, 0);
      if (playerSelection.contains(cards.get(i))) {
        image(card, (width/2 - ((float)(cards.size()/2))* 80) + (i*80), 650);
      } else {
        image(card, (width/2 - ((float)(cards.size()/2))* 80) + (i*80), 675);
      }
    }

    for (int i = 0; i < playerList.get((currentTurn+1) % numPlayers).getCards().size(); i++) {
      image(faceDownH, 50, (height/2 - ((float)(cards.size()/2))* 30) + (i*25));
    }

    for (int i = 0; i < playerList.get((currentTurn+2) % numPlayers).getCards().size(); i++) {
      image(faceDownV, (width/2 - ((float)(cards.size()/2))* 55) + (i*50), 25);
    }
  } else {
    for (int i = 0; i < cards.size(); i++) {
      PImage card = loadImage(cards.get(i).getImage());
      card.resize(75, 0);
      if (playerSelection.contains(cards.get(i))) {
        image(card, (width/2 - ((float)(cards.size()/2))* 80) + (i*80), 650);
      } else {
        image(card, (width/2 - ((float)(cards.size()/2))* 80) + (i*80), 675);
      }
    }

    for (int i = 0; i < playerList.get((currentTurn+1) % numPlayers).getCards().size(); i++) {
      image(faceDownV, (width/2 - ((float)(cards.size()/2))* 55) + (i*50), 25);
    }
  }
}

void displayPlacedCards() {
  for (int i = 0; i < previousCards.size(); i++) {
    PImage card = loadImage(previousCards.get(i).getImage());
    card.resize(75, 0);
    image(card, (width/2 - 220) + (i*90), height/2-50);
  }
}

void updateTurn() {
  previousCards = playerSelection;
  playerSelection = new ArrayList<Card>();
  currentTurn++;
  currentTurn %= numPlayers;
}

void passTurn() {
  playerPass++;
  if (playerPass == numPlayers - 1) {
    playerPass = 0;
    currentPokerHand = 0;
    currentTurn++;
    currentTurn %= numPlayers;
  } else {
    currentTurn++;
    currentTurn %= numPlayers;
  }
}

boolean isGameOver() {
  for (int i = 0; i < playerList.size(); i++) {
    if (playerList.get(i).getCards().size() == 0) {
      textSize(100);
      fill(0);
      text("" + playerList.get(i).getName() + " wins!", width/2, height/2);
      textSize(20);
      fill(255);
      selection = true;
      return true;
    }
  }
  return false;
}

void mouseClicked() {
  cardClicked = new SoundFile(this, "Sound/cardclicked.mp3");
  if (isStartScreen) {
    if (mouseX > 100 && mouseX < 350 && mouseY > 500 && mouseY < 580) {
      numPlayers = 2;
      cardClicked.play();
      delay(500);
      setupGame();
      isStartScreen = false;
    } else if (mouseX > 500 && mouseX < 750 && mouseY > 500 && mouseY < 580) {
      numPlayers = 3;
      cardClicked.play();
      delay(500);
      setupGame();
      isStartScreen = false;
    } else if (mouseX > 900 && mouseX < 1150 && mouseY > 500 && mouseY < 580) {
      numPlayers = 4;
      cardClicked.play();
      delay(500);
      setupGame();
      isStartScreen = false;
    }
  } else {
    ArrayList<Card> cards = playerList.get(currentTurn).getCards();
    if (mouseY > 675 && mouseY < 780 && selection == false) {
      int i = (mouseX - (width/2) + (cards.size()/2*80))/80;
      if (i < cards.size()) {
        Card toAdd = cards.get(i);
        if (!playerSelection.contains(toAdd) && playerSelection.size() < 5) {
          playerSelection.add(cards.get(i));
          cardClicked.play();
        } else {
          playerSelection.remove(toAdd);
          cardClicked.play();
        }
      }
    }
    if (mouseX < width/2 + 300 && mouseX > width/2 - 300 && mouseY > height/2 - 200 && mouseY < height/2 + 200) {
      if (isValid(currentPokerHand, previousCards, playerSelection) && isHigher(currentPokerHand, previousCards, playerSelection)) {
        playerList.get(currentTurn).updateHand(playerSelection);
        currentPokerHand = playerSelection.size();
        playerPass = 0;
        selection = true;
        delay(500);
        cardPlaced = new SoundFile(this, "Sound/cardplaced.mp3");
        cardPlaced.play();
        updateTurn();
        selection = false;
      }
    }
  }
}


void keyPressed() {
  if (key == 'p') {
    passTurn();
  }
  if (key == 's') {
    sortCards(playerList.get(currentTurn).getCards());
  }
}
