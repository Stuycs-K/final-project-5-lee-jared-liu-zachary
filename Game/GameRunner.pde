static int numPlayers = 4, currentTurn, currentPokerHand;
static ArrayList<Player> playerList = new ArrayList<Player>();
static ArrayList<Card> discardPile;
static ArrayList<Card> playerSelection = new ArrayList<Card>();
static ArrayList<Card> previousCards = new ArrayList<Card>();
static boolean selection = false;

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
  for (int i = 0; i < cards.size(); i++) {
    PImage card = loadImage(cards.get(i).getImage());
    card.resize(75, 0);
    image(card, (width/2 - ((float)(cards.size()/2))* 80) + (i*80), 675);
  }

  PImage faceDownV = loadImage("./PlayingCardsS/b2.png");
  PImage faceDownH = loadImage("./PlayingCardsS/b2.1.png");
  faceDownV.resize(75, 0);
  faceDownH.resize(0, 75);
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
  
void displayPlacedCards() {
  for (int i = 0; i < previousCards.size(); i++) {
    PImage card = loadImage(previousCards.get(i).getImage());
    card.resize(75, 0);
    image(card, (width/2 - 175) + (i*80), height/2-50);
  }
}

void updateTurn() {
  previousCards = playerSelection;
  playerSelection = new ArrayList<Card>();
  currentTurn++;
  currentTurn %= numPlayers;
}

boolean isGameOver() {
  for (int i = 0; i < playerList.size(); i++) {
     if (playerList.get(i).getCards().size() == 0) {
       text("" + playerList.get(i).getName() + " wins", width/2, height/2);
       return true;
     }
  }
  return false;
}

void mouseClicked() {
  ArrayList<Card> cards = playerList.get(currentTurn).getCards();
  if (mouseY > 675 && mouseY < 780 && selection == false) {
    int i = (mouseX - (width/2) + (cards.size()/2*80))/80;
    Card toAdd = cards.get(i);
    if (!playerSelection.contains(toAdd) && playerSelection.size() < 5) {
      playerSelection.add(cards.get(i));
    }
    else {
      playerSelection.remove(toAdd); 
    }
  }
  if (mouseX < width/2 + 440 && mouseX > width/2 - 440 && mouseY > height/2 - 220 && mouseY < height/2 + 220) {
    playerList.get(currentTurn).updateHand(playerSelection);
    selection = true;
    delay(500);
    updateTurn();
    selection = false;
  }
}


//void keyPressed() {
//  updateTurn();
//  selection = false;
//}
