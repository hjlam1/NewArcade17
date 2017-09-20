class Ball {
  PVector pos;
  PVector vel;
  
  Ball() {
    pos = new PVector(width/2, height/2);
    vel = new PVector(9, random(-5,5));
  }
  
  void contact() {
    pos.x = pos.x - vel.x;
    vel = new PVector(-vel.x, random(-5,5));
  }
  
  void update() {
    if (pos.x < 0) {
      p2Score++;
      pos = new PVector(width/2, height/2);
      vel = new PVector(-9, random(-5,5));
    }
    if (pos.x > width) {
      p1Score++;    
      pos = new PVector(width/2, height/2);
      vel = new PVector(9, random(-5,5));
    }
    if (pos.y < 0 || pos.y > height) {
      vel.y = -vel.y;
    }
    pos.add(vel);
  }
  
  void display() {
    rectMode(CENTER);
    rect(pos.x, pos.y, 20, 20);
  }
  
}