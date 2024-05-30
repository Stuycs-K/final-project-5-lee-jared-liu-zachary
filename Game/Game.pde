import java.util.*;

void setup() {
  size(1250, 800);
  Deck test = new Deck();
  test.shuffleDeck();
  for (int i = 0; i < numPlayers; i++) {
    ArrayList<Card> giveToPlayer = new ArrayList<Card>();
    for (int j = 0 + (13*i); j < 13 + (13*i); j++) {
      giveToPlayer.add(test.deck.get(j));
    }
    playerList.add(new Player("Player " + (i), giveToPlayer));
  }
  //for (int i = 0; i < playerList.size(); i++) {
  //  System.out.println(playerList.get(i).getName() + " cards: " + playerList.get(i).getCards());
  //}
  currentTurn = findFirstPlayer();
  //System.out.println(currentTurn);
  ArrayList<Card> pre = new ArrayList<Card>();
  ArrayList<Card> selection = new ArrayList<Card>();
  pre.add(new Card(8, 2, "2 diamonds", ""));
  pre.add(new Card(7, 2, "2 spades", ""));
  pre.add(new Card(6, 1, "2 spades", ""));
  pre.add(new Card(5, 1, "2 clubs", ""));
  pre.add(new Card(4, 1, "2 hearts", ""));
  selection.add(new Card(8, 1, "2 diamonds", ""));
  selection.add(new Card(7, 2, "2 spades", ""));
  selection.add(new Card(6, 3, "2 spades", ""));
  selection.add(new Card(5, 2, "2 clubs", ""));
  selection.add(new Card(4, 2, "2 hearts", ""));
  //System.out.println(testa);
  //System.out.println(testb);
  System.out.println(isHigher(5,pre,selection));
}

void draw() {
  background(color(72, 120, 96));
  fill(color(72, 120, 96));
  stroke(color(53, 101, 77));
  strokeWeight(10);
  ellipse(width/2, height/2, 850, 450);
  stroke(color(255));
  strokeWeight(2);
  ellipse(width/2, height/2, 840, 440);
  displayPlayerCards(playerList.get(currentTurn));
  fill(255);
  text("" + currentTurn, 20, 20);
  textSize(20);
  textAlign(CENTER);
  text("" + playerSelection, width/2, 660);
  displayPlacedCards();
  isGameOver();
}
