import java.util.*;

public class Player {
  String name;
  ArrayList<Card> hand;
  
  public Player(String name, ArrayList<Card> hand) {
    this.name = name;
    this.hand = hand;
  }
  
  String getName() {
    return name;
  }
  
  ArrayList<Card> getHand() {
    return hand;
  }
  
  void updateHand(ArrayList<Card> selected) {
    for (int i = 0; i < hand.size(); i++) {
      for (int j = 0; j < selected.size(); j++) {
        if (hand.get(i).getValue() == selected.get(j).getValue() && hand.get(i).getSuit() == selected.get(j).getSuit()) {
          hand.remove(i);
          i--;
        }
      }
    }   
  }
  
  ArrayList<Card> makeSelection() {
    return new ArrayList<Card>();
  }
}
