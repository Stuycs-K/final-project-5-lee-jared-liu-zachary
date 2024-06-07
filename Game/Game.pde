 import processing.sound.*;

import java.util.*;

SoundFile casino, firstPlayer;

void setup() {
  size(1250, 800);
  casino = new SoundFile(this, "Sound/bettercasino.mp3");
  casino.loop();
  casino.amp(0.5);
}

void draw() {
  firstPlayer = new SoundFile(this, "Sound/firstplayer.mp3");
  if (isStartScreen) {
    startScreen();
  }
  else if (isLoadingScreen) {
    if (switchScreen < 220) {
      loadingScreen(); 
      switchScreen++;
    }
    else if (switchScreen <  400) {
      firstPlayerScreen();
      if (switchScreen == 225) {
        firstPlayer.play();
      }
      switchScreen++;
    }
    else {
      isLoadingScreen = false;
    }
  }
  else {
    gameScreen(); 
  }
}
