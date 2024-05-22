import java.util.*;

public class Deck {
  ArrayList<Card> deck = new ArrayList<Card>(52);
  final String[] suitNames = new String[] {"Diamonds", "Clubs", "Hearts", "Spades"};
  
  public Deck() {
    for (int i = 3; i <= 15; i++) {
      for (int j = 0; j <= 3; j++) {
        deck.add(new Card(i, j, i + " of " + suitNames[j], "" + i + j));
      }
    }
  }
  
  public String toString() {
    return Arrays.toString(deck.toArray());
  }
}
