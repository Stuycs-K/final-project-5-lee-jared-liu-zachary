import java.util.*;

public class Rules {
  
  boolean isValid(ArrayList<Card> pre, ArrayList<Card> curr) {
    if (isSingle(pre) && isSingle(curr)) {
      return true;
    } else if (isDouble(pre) && isDouble(curr)) {
      return true;
    } else if (isTriple(pre) && isTriple(curr)) {
      return true;
    } else if (isCombination(pre) && isCombination(curr)) {
      return true;
    } else {
      return false;
    }
  }
  
  boolean isSingle(ArrayList<Card> curr) {
    return curr.size() == 1;
  }
  
  boolean isDouble(ArrayList<Card> curr) {
    if (curr.size() != 2) {
      return false;
    }
    return curr.get(0).getValue() == curr.get(1).getValue();
  }
  
  boolean isTriple(ArrayList<Card> curr) {
    if (curr.size() != 3) { 
      return false;
    }
    return curr.get(0).getValue() == curr.get(1).getValue() && curr.get(1).getValue() == curr.get(2).getValue();
  }
  
  void sortCards(ArrayList<Card> cards) {
    for (int i = 0; i < cards.size() - 1; i++) {
      for (int j = i + 1; j < cards.size(); j++) {
        if (cards.get(i).getValue() > cards.get(j).getValue()) {
          Card temp = cards.get(i);
          cards.set(i, cards.get(j));
          cards.set(j, temp);
        }
      }
    }
  }
  
  boolean isCombination(ArrayList<Card> curr) {
    if (curr.size() != 5) {
      return false;
    }
    sortCards(curr);
    
    boolean fourOfAKind = (curr.get(0).getValue() == curr.get(3).getValue()) || (curr.get(1).getValue() == curr.get(4).getValue());
    
    boolean fullHouse = ((curr.get(0).getValue() == curr.get(2).getValue()) && (curr.get(3).getValue() == curr.get(4).getValue())) || ((curr.get(0).getValue() == curr.get(1).getValue()) && (curr.get(2).getValue() == curr.get(4).getValue()));
    
    boolean flush = true;
    int firstSuit = curr.get(0).getSuit();
    for (Card card : curr) {
      if (card.getSuit() != firstSuit) {
        flush = false;
        break;
      }
    }
    
    boolean straight = true;
    for (int i = 0; i < curr.size() - 1; i++) {
      if (curr.get(i + 1).getValue() != curr.get(i).getValue() + 1) {
        straight = false;
        break;
      }
    }
    return fourOfAKind || fullHouse || flush || straight;
  }
  
}
