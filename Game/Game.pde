import java.util.*;

static int numPlayers = 2, currentTurn, currentPokerHand;
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
    //System.out.println(test.deck.size());
    for (int j = 0 + (13*i); j < 13 + (13*i); j++) {
      giveToPlayer.add(test.deck.get(j));
    }
    playerList.add(new Player("Player " + (i), giveToPlayer));
  }
  //test.shuffleDeck();
  //System.out.println("\n" + test);
  //img = loadImage(test.deck.get(1).getImage());
  //img.resize(75,0);
  for (int i = 0; i < playerList.size(); i++) {
    System.out.println(playerList.get(i).getName() + " cards: " + playerList.get(i).getCards()); 
  }
  //Card card1 = new Card(15,3,"","");
  //Card card2 = new Card(15,2,"","");
  //System.out.println(card2.lower(card1));
  System.out.println(findFirstPlayer());
}

void draw() {
  //image(img, 0, 0);
}

int findFirstPlayer() {
  int firstPlayer = 0;
  Card lowest = new Card(15, 3, "", "");
  for (int i = 0; i < playerList.size(); i++) {
    ArrayList<Card> cards = playerList.get(i).getCards();
    //System.out.println(cards);
    for (int j = 0; j < 13; j++) {
      Card curr = cards.get(j);
      //System.out.println(curr);
      if (curr.lower(lowest)) {
         lowest = curr;
         //System.out.println(lowest);
         firstPlayer = i;
      }
    }
  }
  return firstPlayer;
}

boolean isGameOver() {
  return true;
}
