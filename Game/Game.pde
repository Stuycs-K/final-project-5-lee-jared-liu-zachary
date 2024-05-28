import java.util.*;

static int numPlayers = 4, currentTurn, currentPokerHand;
static ArrayList<Player> playerList = new ArrayList<Player>();
static ArrayList<Card> discardPile;
static ArrayList<Card> playerSelection = new ArrayList<Card>();
static ArrayList<Card> previousCard;

void setup() {
  size(1250, 800);
  Deck test = new Deck();
  test.shuffleDeck();
  for (int i = 0; i < numPlayers; i++) {
    ArrayList<Card> giveToPlayer = new ArrayList<Card>();
    for (int j = 0 + (13*i); j < 13 + (13*i); j++) {
      giveToPlayer.add(test.deck.get(j));
    }
    playerList.add(new Player("Player " + (i), giveToPlayer));
  }
  for (int i = 0; i < playerList.size(); i++) {
    System.out.println(playerList.get(i).getName() + " cards: " + playerList.get(i).getCards());
  }
  currentTurn = findFirstPlayer();
  System.out.println(currentTurn);
}

void draw() {
  //image(img, 0, 0);
  background(color(72, 120, 96));
  fill(color(72, 120, 96));
  stroke(color(53, 101, 77));
  strokeWeight(10);
  ellipse(width/2, height/2, 850, 450);
  stroke(color(255));
  strokeWeight(2);
  ellipse(width/2, height/2, 840, 440);
  displayCards(playerList.get(currentTurn));
  fill(255);
  text("" + currentTurn, 20, 20);
  text("" + playerSelection, 20, 40);
}

void mouseClicked() {
  ArrayList<Card> cards = playerList.get(currentTurn).getCards();
  if (mouseY > 675 && mouseY < 780) {
    int i = (mouseX - (width/2) + (cards.size()/2*80))/80;
    playerSelection.add(cards.get(i));
  }
}

void keyPressed() {
  playerList.get(currentTurn).updateHand();
  updateTurn();
}

void makeSelection() {
  
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

void updateTurn() {
  currentTurn++;
  currentTurn %= numPlayers;
}

void displayCards(Player curr) {
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

boolean isGameOver() {
  return true;
}
