class Paddle {
  int playerNum;
  float x;
  float y;
  
  Paddle(int player) {
    playerNum = player;
    if (playerNum == 1) {
      x = 30;
    } else if (playerNum == 2) {
      x = width - 30;
    }
    y = height/2;
  }
  
  void update() {
    //y = mouseY;
    if (playerNum == 1) {
      y = map(sensor0, 0, 1024, 0, height);
    } else if (playerNum == 2) {
      y = map(sensor1, 0, 1024, 0, height);
    }
    
    if (ball.pos.x > x-10 && ball.pos.x < x+10) {
       if (ball.pos.y > y-50 && ball.pos.y < y+50) {
          ball.contact(); 
       }
    }    
  }
  
  void display() {
    rectMode(CENTER);
    rect(x,y,20,100);
  }
  
}