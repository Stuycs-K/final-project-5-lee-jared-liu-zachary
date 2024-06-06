import processing.sound.*;

static int numPlayers, currentTurn, currentPokerHand = 0;
static ArrayList<Player> playerList = new ArrayList<Player>();
static ArrayList<Card> discardPile;
static ArrayList<Card> playerSelection = new ArrayList<Card>();
static ArrayList<Card> previousCards = new ArrayList<Card>();
static boolean selection = false, isStartScreen = true, isLoadingScreen = false, restart = false;
String placedCardText = "";
static int playerPass = 0;
SoundFile cardClicked, cardPlaced;
PFont pixel, pixel2;

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
      background(color(72, 120, 96));
      textSize(100);
      fill(color(230,182,39));
      text("" + playerList.get(i).getName() + " wins!", width/2, height/2);
      textSize(20);
      fill(255);
      text("Press [r] to start a new game", width/2, height/2 + 75);
      selection = true;
      restart = true;
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
      isStartScreen = false;
      isLoadingScreen = true;
      setupGame();
    } else if (mouseX > 500 && mouseX < 750 && mouseY > 500 && mouseY < 580) {
      numPlayers = 3;
      isStartScreen = false;
      isLoadingScreen = true;
      setupGame();
    } else if (mouseX > 900 && mouseX < 1150 && mouseY > 500 && mouseY < 580) {
      numPlayers = 4;
      isStartScreen = false;
      isLoadingScreen = true;
      setupGame();
    }
  } else if (!isLoadingScreen) {
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
        placedCardText(playerSelection);
        cardPlaced = new SoundFile(this, "Sound/cardplaced.mp3");
        cardPlaced.play();
        updateTurn();
        selection = false;
      }
    }
  }
}

void placedCardText(ArrayList<Card> selection) {
  if (isSingle(selection)) {
    placedCardText = "Single " + selection.get(0).getNameOfCard().substring(0,selection.get(0).getNameOfCard().indexOf(" ")); 
  }
  else if (isDouble(selection)) {
    placedCardText = "Pair " + selection.get(0).getNameOfCard().substring(0,selection.get(0).getNameOfCard().indexOf(" ")) + "s"; 
  }
  else if (isTriple(selection)) {
    placedCardText = "Triple " + selection.get(0).getNameOfCard().substring(0,selection.get(0).getNameOfCard().indexOf(" ")) + "s"; 
  }
  else if (isRoyalFlush(selection)) {
    placedCardText = "Royal Flush";
  }
  else if (isStraightFlush(selection)) {
     placedCardText = "" + selection.get(4).getNameOfCard().substring(0,selection.get(4).getNameOfCard().indexOf(" ")) + "-High Straight Flush";
  }
  else if (isFourOfAKind(selection)) { 
    placedCardText = "Quad " + selection.get(2).getNameOfCard().substring(0,selection.get(2).getNameOfCard().indexOf(" ")) + "s"; 
  }
  else if (isFullHouse(selection)) {
    placedCardText = "Full House " + selection.get(2).getNameOfCard().substring(0,selection.get(2).getNameOfCard().indexOf(" ")) + "s Full Of ";
    if (selection.get(2).getNameOfCard().substring(0,selection.get(2).getNameOfCard().indexOf(" ")).equals(selection.get(0).getNameOfCard().substring(0,selection.get(0).getNameOfCard().indexOf(" ")))) {
      placedCardText += selection.get(4).getNameOfCard().substring(0,selection.get(4).getNameOfCard().indexOf(" ")) + "s";
    }
    else {
      placedCardText += selection.get(0).getNameOfCard().substring(0,selection.get(0).getNameOfCard().indexOf(" ")) + "s";
    }
  }
  else if (isFlush(selection)) {
    placedCardText = "" + selection.get(4).getNameOfCard().substring(0,selection.get(4).getNameOfCard().indexOf(" ")) + "-High Flush"; 
  }
  else if (isStraight(selection)) {
    placedCardText = "" + selection.get(4).getNameOfCard().substring(0,selection.get(4).getNameOfCard().indexOf(" ")) + "-High Straight"; 
  }
}

void keyPressed() {
  if (key == 'p') {
    passTurn();
  }
  if (key == 's') {
    sortCards(playerList.get(currentTurn).getCards());
  }
  if (restart) {
    if (key == 'r') {
      isStartScreen = true;
      isLoadingScreen = false;
      selection = false;
      restart = false;
      playerList = new ArrayList<Player>();
      currentPokerHand = 0;
      playerSelection = new ArrayList<Card>();
      previousCards = new ArrayList<Card>();
      placedCardText = "";
      playerPass = 0;
      countdown = 0;
      musicOn = 1;
      switchScreen = 0;
    }
  }
}
