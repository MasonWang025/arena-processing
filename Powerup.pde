public class Powerup {
  float x;
  float y;
  int type;
  color c0;
  color c1;

  Powerup() {
    this.type = (int) (Math.random() * 2) + 1;
    do {
      x = (int) (Math.random() * 1000) + 120;
      y = (int) (Math.random() * 690) + 110;
    } while (!(get((int) x, (int) y) == #89b0c9 && get((int) x + 10, (int) y + 10) == #89b0c9 && (get((int) x + 25, (int) y + 25) == #89b0c9) && (get((int) x, (int) y + 25) == #89b0c9)));

    switch (type) {
    case 1:
      c0 = #4a99ff;
      c1 = #003170;
      break;
    case 2:
      c0 = #e95eff;
      c1 = #610070;
      break;
    }
  }
  
  boolean checkCollisionPlayer(Player p) {
    // give the powerup a bounding box
    float r = x + 28;
    float b = y + 28;  // x and y values for borders
    boolean inXRange = p.x+p.size > x && p.x < r;
    
    boolean recievePowerup = false;
    
    if (p.x+p.xv+p.size > x && p.x+p.xv < r && p.y+p.size > y && p.y<b)
      recievePowerup = true;

    if (inXRange && p.y + p.yv + p.size > y && p.y + p.size < b)
      recievePowerup = true;

    if (inXRange && p.y+p.size > y && p.y+p.yv < b)
      recievePowerup = true;  
    
    if (recievePowerup) {
      p.powerup = type;
      switch (type) {
        case 1: 
          p.bulletV = 25;
          p.reloadTime = 10;
          p.bColor = c1;
          p.powerupTimer = 500;
          break;
        case 2: 
          p.bulletV = 8;
          p.reloadTime = 1;
          p.bColor = c1;
          p.powerupTimer = 250;
          break;
      }
    }
    
    return recievePowerup;
  }

  boolean draw(Player p1, Player p2) {
    if (checkCollisionPlayer(p1) || checkCollisionPlayer(p2))
      return true;
    
    fill(c0);
    ellipse(x, y, (float) (21 + (Math.random() * 10)), (float) (21 + (Math.random() * 10)));

    fill(c1);
    ellipse(x, y, (float) (10 + (Math.random() * 5)), (float) (10 + (Math.random() * 5)));
    
    return false;
  }
}
