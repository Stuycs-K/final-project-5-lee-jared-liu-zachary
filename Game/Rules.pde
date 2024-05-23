public class Rules {
  
  boolean isValid() {
    return false;
  }
  
  boolean isSingle(ArrayList<Card> curr) {
    return curr.size() == 1;
  }
  
  boolean isDouble(ArrayList<Card> curr) {
    return curr.size() == 2;
  }
  
  boolean isTriple(ArrayList<Card> curr) {
    return curr.size() == 3;
  }
  
  boolean isCombination(ArrayList<Card> curr) {
    if (curr.size() == 5) {
      int count = 0;
      for (int i = 0; i < curr.size()-1; i++) {
        
      }
  }
  
}
