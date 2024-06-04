import processing.sound.*;

import java.util.*;

SoundFile casino;

void setup() {
  size(1250, 800);
  //casino = new SoundFile(this, "Sound/bettercasino.mp3");
  //casino.amp(0);
  //casino.loop();
}

void draw() {
  if (isStartScreen) {
    startScreen();
  }
  else {
    gameScreen(); 
  }
}
