import java.util.Iterator;

boolean[] keys = new boolean[256];
Walls w = new Walls(20);
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
Player p1 = new Player(0, 0, bullets, #000000, #ffffff);
Player p2 = new Player(0, 0, bullets, #ffffff, #000000);


void setup() {
  size(1200, 800);
  pixelDensity(2);

  p1.x = 1110; 
  p1.y = 700;
  p2.x = 70; 
  p2.y = 700;
  p1.left = true;

  noStroke();
  noSmooth();
  frameRate(60);
}

void draw() {
  background(#89b0c9);

  Iterator<Bullet> bItr = bullets.iterator();
  while (bItr.hasNext()) {
    Bullet b = bItr.next();
    if (b.hitWall(w.walls)) {
      bItr.remove(); 
      continue;
    }
    if (b.hitPlayer(p1.x, p1.y, p1.size)) {
      bItr.remove(); 
      continue;
    }
    if (b.hitPlayer(p2.x, p2.y, p2.size)) {
      bItr.remove(); 
      continue;
    }
    b.draw();
  }

  p1.update(keys['J'], keys['L'], keys['I'], keys['H']);
  p2.update(keys['A'], keys['D'], keys['W'], keys['F']);

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
