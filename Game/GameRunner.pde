import processing.sound.*;

static int numPlayers = 4, currentTurn, currentPokerHand = 0;
static ArrayList<Player> playerList = new ArrayList<Player>();
static ArrayList<Card> discardPile;
static ArrayList<Card> playerSelection = new ArrayList<Card>();
static ArrayList<Card> previousCards = new ArrayList<Card>();
static boolean selection = false;
static int playerPass = 0;
SoundFile cardClicked, cardPlaced;

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
      }
      else {
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
  }
  else if (numPlayers == 3) {
     for (int i = 0; i < cards.size(); i++) {
      PImage card = loadImage(cards.get(i).getImage());
      card.resize(75, 0);
      if (playerSelection.contains(cards.get(i))) {
        image(card, (width/2 - ((float)(cards.size()/2))* 80) + (i*80), 650);
      }
      else {
        image(card, (width/2 - ((float)(cards.size()/2))* 80) + (i*80), 675);
      }
    }
    
    for (int i = 0; i < playerList.get((currentTurn+1) % numPlayers).getCards().size(); i++) {
      image(faceDownH, 50, (height/2 - ((float)(cards.size()/2))* 30) + (i*25));
    }
  
    for (int i = 0; i < playerList.get((currentTurn+2) % numPlayers).getCards().size(); i++) {
      image(faceDownV, (width/2 - ((float)(cards.size()/2))* 55) + (i*50), 25);
    }
  }
  else {
    for (int i = 0; i < cards.size(); i++) {
      PImage card = loadImage(cards.get(i).getImage());
      card.resize(75, 0);
      if (playerSelection.contains(cards.get(i))) {
        image(card, (width/2 - ((float)(cards.size()/2))* 80) + (i*80), 650);
      }
      else {
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
 }
 else {
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
  ArrayList<Card> cards = playerList.get(currentTurn).getCards();
  if (mouseY > 675 && mouseY < 780 && selection == false) {
    int i = (mouseX - (width/2) + (cards.size()/2*80))/80;
    if (i < cards.size()) {
      Card toAdd = cards.get(i);
      if (!playerSelection.contains(toAdd) && playerSelection.size() < 5) {
        playerSelection.add(cards.get(i));
        cardClicked = new SoundFile(this, "Sound/cardclicked.mp3");
        cardClicked.play();
      }
      else {
        playerSelection.remove(toAdd);
        cardClicked = new SoundFile(this, "Sound/cardclicked.mp3");
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


void keyPressed() {
  if (key == 'p') {
    passTurn();
  }
  if (key == 's') {
    sortCards(playerList.get(currentTurn).getCards()); 
  }
}
