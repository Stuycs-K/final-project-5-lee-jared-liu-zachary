import java.util.*;

static int numPlayers, currentTurn, currentPokerHand;
static ArrayList<Player> playerList;
static ArrayList<Card> discardPile;
PImage img;

void setup() {
  size(500,500);
  Deck test = new Deck();
  System.out.println(test);
  //test.shuffleDeck();
  //System.out.println("\n" + test);
  System.out.println(test.deck.get(0).getImage());
  img = loadImage(test.deck.get(1).getImage());
  img.resize(75,0);
}

void draw() {
  image(img, 0, 0);
}

boolean isGameOver() {
  return true;
}
