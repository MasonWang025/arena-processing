public class Player {
    float x, y, xv, yv, speed, size;
    float gravity;
    boolean falling = true; 

    Player(float x, float y) {
        this.x = x;
        this.y = y;
        this.speed = 5; 
        this.size = 25;
    }

    void update(boolean left, boolean right, boolean up) {
        // reset to zero velocity
        xv = 0;
        yv = 0;

        // velocity based on key input
        if (left)
            xv = -speed;
        if (right)
            xv = speed;
        if (up && !falling)
            gravity -= 7;
        yv += gravity;
        gravity += 0.5;

        falling = true;
    } 
    
    void display() {
        x += xv;
        y += yv;
  
        fill(255, 0, 0);

        rect(x, y, size, size);
    }
}