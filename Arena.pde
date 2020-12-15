import java.util.Iterator;

boolean[] keys = new boolean[256];
Walls w = new Walls(20);
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Powerup> powerups = new ArrayList<Powerup>();
Player p1 = new Player(0, 0, bullets, #000000, #ffffff);
Player p2 = new Player(0, 0, bullets, #ffffff, #000000);
int powerupTimer = 0;
int s1, s2; // scores
boolean removeAllParticles;

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

void reset() {
  p1.x = 1110; 
  p1.y = 700;
  p2.x = 70; 
  p2.y = 700;
  p1.left = true;
  p2.left = false;
  p1.powerup = p2.powerup = -1;
  removeAllParticles = true;
}

void draw() {
  background(#89b0c9);

  if (!removeAllParticles) {
    Iterator<Bullet> bItr = bullets.iterator();
    while (bItr.hasNext()) {
      Bullet b = bItr.next();
      if (b.hitWall(w.walls)) {
        bItr.remove(); 
        continue;
      }
      if (b.hitPlayer(p1.x, p1.y, p1.size)) {
        bItr.remove(); 
        reset();
        s1++;
        continue;
      }
      if (b.hitPlayer(p2.x, p2.y, p2.size)) {
        bItr.remove(); 
        reset();
        s2++;
        continue;
      }
      b.draw();
    }
  } else {
    bullets.clear();
    powerups.clear();
    removeAllParticles = false;
  }

  if (powerups.size() < 20) {
    if (powerupTimer > 100) {
      powerupTimer = 0;
      powerups.add(new Powerup());
    } else {
      powerupTimer++;
    }
  }


  Iterator<Powerup> pItr = powerups.iterator();
  while (pItr.hasNext()) {
    Powerup p = pItr.next();
    if (p.draw(p1, p2))
      pItr.remove();
  }


  p1.update(keys['J'], keys['L'], keys['I'], keys['H']);
  p2.update(keys['A'], keys['D'], keys['W'], keys['F']);

  w.update(p1);
  w.update(p2);

  p1.display();
  p2.display();

  textSize(32);
  fill(0);
  text("white: " + s1, 50, 60);
  text("black: " + s2, 1020, 60);
}

void keyPressed() {
  keys[keyCode]=true;
};

void keyReleased() {
  keys[keyCode]=false;
};
