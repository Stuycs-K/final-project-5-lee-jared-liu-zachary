public class Card {
  int value;
  String suit, name, image;
 
  public Card(int value, String suit, String name, String image) {
    this.value = value;
    this.suit = suit;
    this.name = name;
    this.image = image;
  }
 
  int getValue() {
    return value;
  }
  
  String getSuit() {
    return suit;
  }
  
  String getNameOfCard() {
    return name;
  }
  
  //String getImage() {
  //  return image;
  //}
}
