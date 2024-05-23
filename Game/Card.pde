public class Card {
  int value, suit;
  String name, image;
 
  public Card(int value, int suit, String name, String image) {
    this.value = value;
    this.suit = suit;
    this.name = name;
    this.image = image;
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
  
  //String getImage() {
  //  return image;
  //}
  
  public String toString() {
     return name; 
  }
}
