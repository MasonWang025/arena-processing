public class Bullet {
    float x, y, v, size;
    int type;
    color bColor;

    Bullet(float x, float y, float v, int type, float size, color bColor) {
        this.x = x;
        this.y = y;
        this.v = v;
        this.type = type;
        this.size = size;
        this.bColor = bColor;
    }

    boolean hitWall(int[][] walls) {
        // for each wall
        for (int i = 0; i < walls.length; i++)  {
            int wallRight = walls[i][0]+walls[i][2];
            int wallBottom = walls[i][1]+walls[i][3];
            
            if (x+size > walls[i][0] && x < wallRight && y+size > walls[i][1] && y<wallBottom) {
                if (walls[i][4] == 1 && Math.abs(0.75 * v) > 2.5) {
                    v = -0.75 * v;
                    x += v;
                    return false;
                }
                return true;
            }
        }
        
        return false;
    }

    boolean hitPlayer(float px, float py, float psize) {      
        if (x > px && px + psize > x &&  y > py && y < py + psize) {
            return true;
        }
        return false;
    }

    void draw() {
        x += v;

        fill(bColor);

        ellipse(x, y, size, size);
    }
}
