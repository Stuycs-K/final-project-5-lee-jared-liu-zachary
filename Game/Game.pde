import java.util.*;

static int numPlayers = 4, currentTurn, currentPokerHand;
static ArrayList<Player> playerList = new ArrayList<Player>();
static ArrayList<Card> discardPile;
PImage img;

void setup() {
  size(500,500);
  Deck test = new Deck();
  test.shuffleDeck();
  for (int i = 0; i < numPlayers; i++) {
    ArrayList<Card> giveToPlayer = new ArrayList<Card>();
    //System.out.println(test.deck.size());
    for (int j = 0 + (13*i); j < 13 + (13*i); j++) {
      giveToPlayer.add(test.deck.get(j));
    }
    playerList.add(new Player("Player " + (i + 1), giveToPlayer));
  }
  //test.shuffleDeck();
  //System.out.println("\n" + test);
  //img = loadImage(test.deck.get(1).getImage());
  //img.resize(75,0);
  for (int i = 0; i < playerList.size(); i++) {
    System.out.println(playerList.get(i).getName() + " cards: " + playerList.get(i).getCards()); 
  }
}

void draw() {
  //image(img, 0, 0);
}

boolean isGameOver() {
  return true;
}
