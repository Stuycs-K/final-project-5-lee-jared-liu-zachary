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
  for (int i = 0; i < playerList.size(); i++) {
    System.out.println(playerList.get(i).getName() + " cards: " + playerList.get(i).getCards());
  }
  currentTurn = findFirstPlayer();
  System.out.println(currentTurn);
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
