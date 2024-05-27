public class Card {
  int value, suit;
  String name, image;
 
  public Card(int value, int suit, String name, String image) {
    this.value = value;
    this.suit = suit;
    this.name = name;
    this.image = image + ".png";
  }
 
  int getValue() {
    return value;
  }
  
  int getSuit() {
    return suit;
  }
  
  String getNameOfCard() {
    return name;
  }
  
  String getImage() {
    return image;
  }
  
  boolean lower(Card other) {
    if (this.value == other.value) {
      if (this.suit < other.suit) {
        return true;
      }
    }
    else if (this.value < other.value) { 
       return true; 
    }
    return false;
  }
  
  public String toString() {
     return name; 
  }
}
