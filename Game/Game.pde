import java.util.*;

static int numPlayers = 4, currentTurn, currentPokerHand;
static ArrayList<Player> playerList = new ArrayList<Player>();
static ArrayList<Card> discardPile;
PImage img;
static ArrayList<Card> previousCard;

void setup() {
  size(500,500);
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
  text("" + currentTurn, 20, 20);
}

void mouseClicked() {
  updateTurn();
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

boolean isGameOver() {
  return true;
}
