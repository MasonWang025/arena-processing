public class Player {
    float x, y, xv, yv, speed, size;
    color body;
    color eyes;

    // jumping
    float gravity, gravityForce, jumpForce;
    boolean falling = true, left; 
    int jumpTimer;

    // shooting
    ArrayList<Bullet> bullets;
    boolean canShoot;
    float bulletV;
    int reloadTimer;
    int reloadTime;

    Player(float x, float y, ArrayList<Bullet> bullets, color body, color eyes) {
        this.x = x;
        this.y = y;
        this.bullets = bullets;
        this.body = body;
        this.eyes = eyes;
        speed = 2; 
        size = 25;
        gravityForce = 0.4;
        jumpForce = 10;
        bulletV = 10;
        reloadTime = 25;
    }

    void update(boolean left, boolean right, boolean up, boolean shoot) {
        // reset to zero velocity
        xv = 0;
        yv = 0;
        text(jumpTimer, 100, 100);
        
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
        if (up && !falling) {
            gravity -= jumpForce;
            jumpTimer = 0;
        }
            
        if (shoot && canShoot) {
            float v = this.left ? -bulletV : bulletV;
            float sx = this.left ? x - size - 1 : x + size + 2;
            bullets.add(new Bullet(sx, y + (size/2), v, 0, 6.9));
            canShoot = false;
        }

        if (!canShoot) {
            if (reloadTimer >= reloadTime)  {
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

        rect(xd1, y+5, 3, 10);
        rect(xd2, y+5, 3.2, 10);
    }
}