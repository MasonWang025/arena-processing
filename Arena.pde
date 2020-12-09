Player p1 = new Player(1000, 500);
Player p2 = new Player(500, 100);
boolean[] keys = new boolean[256];
Walls w = new Walls(20);

void setup() {
  size(1200, 700);
  pixelDensity(2);

  noStroke();
  noSmooth();
  frameRate(60);
}

void draw() {
  background(250);
  
  p1.update(keys[LEFT], keys[RIGHT], keys[UP]);
  p2.update(keys['A'], keys['D'], keys['W']);

  w.update(p1);
  w.update(p2);

  p1.display();
  p2.display();

  textSize(32);
  text("x: "+mouseX+" y: "+mouseY, 50, 50);
  fill(255, 0, 0);
}

void keyPressed() {
  keys[keyCode]=true;
};

void keyReleased() {
  keys[keyCode]=false;
};
