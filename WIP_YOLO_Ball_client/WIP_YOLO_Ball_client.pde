import processing.net.*;

//network stuff
Client c;
String input;
float[] data = {0, width/2+20, width/2, height/2}; //content: [player1X, player2X, ballX, ballY]

ArrayList<Ball> ballList = new ArrayList <Ball>();
int scoreTeam1 = 0;
int scoreTeam2 = 0;

Player player1;
Player player2;
Walls net;

void settings() {
  int canvasSize = 60;
  size(canvasSize*16, canvasSize*9);
}

void setup() {
  player1 = new Player(0, width/2-20);
  player2 = new Player(width/2+20, width);
  net = new Walls();

  c = new Client(this, "10.128.136.193", 8080);
}

void draw() {  
  c.write(mouseX + "\n");

  if (c.available() > 0) {
    data = readFromServer();
  }

  background(0);
  fill(255);
  player1.movement(data[0]);
  player2.movement(data[0]);
  ellipse(data[2], data[3], 30, 30);
  drawNet();
}

void mousePressed() {
  c.write(-1 + "\n");  //start command
  println("sent started");
}

float[] readFromServer() {
  input = c.readString(); 
  input = input.substring(0, input.indexOf("\n"));
  float[] array = float(split(input, ' '));

  return array;
}