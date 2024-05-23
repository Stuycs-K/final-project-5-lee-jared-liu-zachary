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
  
  ArrayList<Card> getCards() {
    return hand; 
  }
  
  void updateHand() {
    
  }
  
  ArrayList<Card> makeSelection() {
    return new ArrayList<Card>();
  }
}
