import java.util.*;

static int numPlayers, currentTurn, currentPokerHand;
static ArrayList<Player> playerList;
static ArrayList<Card> discardPile;

void setup() {
  Deck test = new Deck();
  System.out.println(test);
  test.shuffleDeck();
  System.out.println("\n" + test);
}

void draw() {
  
}

boolean isGameOver() {
  return true;
}
