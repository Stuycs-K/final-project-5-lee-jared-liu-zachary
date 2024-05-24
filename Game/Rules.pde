import java.util.*;

public class Rules {
  
  boolean isValid() {
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
  
  boolean isCombination(ArrayList<Card> curr) {
    if (curr.size() != 5) {
      return false;
    }
  }
  
}
