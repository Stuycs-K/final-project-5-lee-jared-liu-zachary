import java.util.*;

public class Deck {
  ArrayList<Card> deck = new ArrayList<Card>(52);
  final String[] suitNames = new String[] {"Diamonds", "Clubs", "Hearts", "Spades"};
  
  public Deck() {
    for (int i = 3; i <= 15; i++) {
      for (int j = 0; j <= 3; j++) {
        if (i == 11) {
          deck.add(new Card(i, j, "Jack of " + suitNames[j], "" + i + j));
        }
        else if (i == 12) {
          deck.add(new Card(i, j, "Queen of " + suitNames[j], "" + i + j));
        }
        else if (i == 13) {
          deck.add(new Card(i, j, "King of " + suitNames[j], "" + i + j));
        }
        else if (i == 14) {
          deck.add(new Card(i, j, "Ace of " + suitNames[j], "" + i + j));
        }
        else if (i == 15) {
          deck.add(new Card(i, j, "Two of " + suitNames[j], "" + i + j));
        }
        else {
           deck.add(new Card(i, j, i + " of " + suitNames[j], "" + i + j));
        }
      }
    }
  }
  
  public void shuffleDeck() {
     Collections.shuffle(deck);
  }
  
  public String toString() {
    return Arrays.toString(deck.toArray());
  }
}
