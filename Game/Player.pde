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
  
  void updateHand(ArrayList<Card> selected) {
    for (int i = 0; i < selected.size(); i++) {
      hand.remove(selected.get(i)); 
    }
  }
  
  ArrayList<Card> getCards() {
    return hand; 
  }
  
  ArrayList<Card> makeSelection() {
    return new ArrayList<Card>();
  }
}
