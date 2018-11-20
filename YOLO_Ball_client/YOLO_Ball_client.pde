ArrayList<Ball> ballList = new ArrayList <Ball>();
int scoreTeam1 = 0;
int scoreTeam2 = 0;
boolean startScreen = true;

Player startScreenPlayer;
Player player1;
Player player2;
Walls net;

void settings() {
  int canvasSize = 60;
  size(canvasSize*16, canvasSize*9);
}

void setup() {
  player1 = new Player(0,width/2-20);
  player2 = new Player(width/2+20, width);
  startScreenPlayer = new Player(0,width);
  net = new Walls();
  noSmooth();
}

void draw() {
  if (startScreen) {
    startScreen();
    startScreenPlayer.movement();
    if(keyPressed && key == ' ') {
      ballList.clear();
      startScreen = false;
    }
  }
  else {
    background(0);
    fill(255);
    player1.movement();
    player2.movement();
    drawInGame();
  }

  //ball calculation
  for (int i = 0; i < ballList.size(); i++) {
    ballList.get(i).movement();
    if (ballList.get(i).outOfBounds()) {
      ballList.remove(i);
    }
  }
}

void mousePressed() {
  Ball newBall = new Ball();
  ballList.add(newBall);
}
