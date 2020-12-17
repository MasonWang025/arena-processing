public class Player {
  float x, y, xv, yv, speed, size;
  color body;
  color eyes;

  // jumping
  float gravity, gravityForce, jumpForce;
  boolean falling = true, left; 
  int jumpTimer, numJumps;

  // shooting
  ArrayList<Bullet> bullets;
  boolean canShoot;
  color bColor;
  float bulletV;
  int reloadTimer;
  int reloadTime;
   
  // powerup
  int powerup  = -1;
  int powerupTimer; // time left

  Player(float x, float y, ArrayList<Bullet> bullets, color body, color eyes) {
    this.x = x;
    this.y = y;
    this.bullets = bullets;
    this.body = body;
    this.eyes = eyes;
    speed = 6.9; 
    size = 25;
    gravityForce = 0.4;
    jumpForce = 10;
    bulletV = 16;
    reloadTime = 25;
    bColor = #000000;
  }

  void update(boolean left, boolean right, boolean up, boolean shoot) {
    // reset to zero velocity
    xv = 0;
    yv = 0;

    if (falling)
      jumpTimer++;

    // velocity based on key input
    if (left) {
      xv = -speed;
      this.left = true;
    }
    if (right) {
      xv = speed;
      this.left = false;
    }
    if (up && !falling && numJumps < 2) {
      gravity = Math.min(gravity - jumpForce, -jumpForce);
      numJumps++;
      jumpTimer = 0;
    }

    if (shoot && canShoot) {
      float v = this.left ? -bulletV : bulletV;
      float sx = this.left ? x - size - 5 : x + size + 10;
      bullets.add(new Bullet(sx, y + (size/2), v, 0, 6.9, bColor));
      canShoot = false;
    }

    if (!canShoot) {
      if (reloadTimer >= reloadTime) {
        canShoot = true;
        reloadTimer = 0;
      }
      reloadTimer++;
    }

    yv += gravity;
    gravity += gravityForce;

    falling = jumpTimer < 20;
  } 

  void display() {
    x += xv;
    y += yv;

    fill(body);

    rect(x, y, size, size);

    fill(eyes);

    float xd1 = x + size - 6;
    float xd2 = x + size - 12.2;

    if (left) {
      xd1 = x + 3;
      xd2 = x + 9;
    }

    rect(xd1, y+5+gravity/2.1, 3, 10);
    rect(xd2, y+5+gravity/2.1, 3.2, 10);
    
    if (powerup < 0 || powerupTimer < 0)  {
      bulletV = 16;
      reloadTime = 25;
      bColor = #000000;
      powerup = -1;
      return;
    }
    switch (powerup) {
      case 1:
        fill(#4a99ff);
        break;
      case 2:
        fill(#e95eff);
        break;
    }
    ellipse(x + size/2, y - 12, 9, 9);
    powerupTimer -= 1;
  }
}
