import processing.serial.*;

Serial myPort;

Ball ball;
Paddle p1;
Paddle p2;

int sensor0 = 0;
int sensor1 = 0;

int p1Score = 0;
int p2Score = 0;

void setup() {
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.bufferUntil('\n');
  
  size(1000, 700);
  background(5);
  fill(255);
  ball = new Ball();
  p1 = new Paddle(1);
  p2 = new Paddle(2);
  textSize(80);
}

void draw() {
  background(5);
  ball.update();
  ball.display();
  p1.update();
  p1.display();
  p2.update();
  p2.display();
  
  text(p1Score, width/2-50, 100);
  text(p2Score, width/2+50, 100);
}

void serialEvent(Serial myPort) {
  String inString = myPort.readStringUntil('\n');
  if (inString != null) {
    inString = trim(inString);
    int[] sensors = int(split(inString, ","));
    if (sensors.length >= 2) {
      sensor0 = sensors[0];
      sensor1 = sensors[1];
    }
    
  }
  
  
}