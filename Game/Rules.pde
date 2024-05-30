import java.util.*;
  
  boolean isValid(int pokerHand, ArrayList<Card> selection) {
    if (pokerHand == 0) {
      return isSingle(selection) || isDouble(selection) || isTriple(selection) || isCombination(selection);
    }
    if (pokerHand == 1 && isSingle(selection)) {
      return true;
    } else if (pokerHand == 2 && isDouble(selection)) {
      return true;
    } else if (pokerHand == 3 && isTriple(selection)) {
      return true;
    } else if (pokerHand == 5 && isCombination(selection)) {
      return true;
    } else {
      return false;
    }
  }
  
  boolean isHigher(int pokerHand, ArrayList<Card> pre, ArrayList<Card> selection) {
    if (pokerHand == 0) {
       return true; 
    }
    else if (pokerHand == 1 || pokerHand == 3) {
       if (selection.get(0).getValue() == pre.get(0).getValue()) {
         return selection.get(0).getSuit() > pre.get(0).getSuit();
       }
       else {
         return selection.get(0).getValue() > pre.get(0).getValue(); 
       }
    }
    else if (pokerHand == 2) {
      if (selection.get(0).getValue() == pre.get(0).getValue()) {
        Card highestOne;
        if (pre.get(0).getSuit() > pre.get(1).getSuit()) {
          highestOne = pre.get(0);
        }
        else {
          highestOne = pre.get(1);
        }
        Card highestTwo;
        if (selection.get(0).getSuit() > selection.get(1).getSuit()) {
          highestTwo = selection.get(0);
        }
        else {
          highestTwo = selection.get(1);
        }
        return highestTwo.getSuit() > highestOne.getSuit();
      }
      else {
        return selection.get(0).getValue() > pre.get(0).getValue(); 
      }
    }
    else if (pokerHand == 5) {
       
    }
    return false;
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
    return isFourOfAKind(curr) || isFullHouse(curr) || isFlush(curr) || isStraight(curr);
  }
  
  boolean isFourOfAKind(ArrayList<Card> curr) {
     sortCards(curr); 
     return (curr.get(0).getValue() == curr.get(3).getValue()) || (curr.get(1).getValue() == curr.get(4).getValue());
  }
  
  boolean isFullHouse(ArrayList<Card> curr) {
     sortCards(curr);
     return ((curr.get(0).getValue() == curr.get(2).getValue()) && (curr.get(3).getValue() == curr.get(4).getValue())) || ((curr.get(0).getValue() == curr.get(1).getValue()) && (curr.get(2).getValue() == curr.get(4).getValue()));
  }
  
  boolean isStraight(ArrayList<Card> curr) {
     sortCards(curr);
     boolean straight = true;
     for (int i = 0; i < curr.size() - 1; i++) {
      if (curr.get(i + 1).getValue() != curr.get(i).getValue() + 1) {
        straight = false;
        break;
       }
      }
      return straight;
  }
  
  boolean isFlush(ArrayList<Card> curr) {
    sortCards(curr);
    boolean flush = true;
    int firstSuit = curr.get(0).getSuit();
    for (Card card : curr) {
      if (card.getSuit() != firstSuit) {
        flush = false;
        break;
      }
    }
    return flush;
  }
  
  boolean isStraightFlush(ArrayList<Card> curr) {
    return isFlush(curr) && isStraight(curr); 
  }
  
  boolean isRoyalFlush(ArrayList<Card> curr) {
    sortCards(curr);
    return isFlush(curr) && isStraight(curr) && curr.get(0).getValue() == 10; 
  }
