public class Walls {
    int w = 1200;
    int h = 700;
    int t = 20; // thickness

    Walls(int thickness) {
        t = thickness;
    }
    
    // each wall is {x, y, width, height, bouncyWall?}
    int[][] walls = {
        {0, 0, w, t, 0}, 
        {0, h-t, w, t, 0}, 
        {0, 0, t, h, 0}, 
        {w-t, 0, t, h, 0}, 
        {200, 570, 400, 30, 0}, 
        {250, 540, 50, 30, 0}, 
        {500, 540, 50, 30, 0}, 
        {300, 500, 200, 10, 0}, 
        {600, 480, 200, 20, 0}, 
        {0, 480, 200, 20, 0}, 
        {375, 560, 50, 40, 1}, 
        {70, 470, 30, 10, 1}, 
        {0, 430, 20, 10, 0}, 
        {700, 470, 30, 10, 1}, 
        {780, 430, 20, 10, 0}, 
        {110, 380, 200, 20, 0}, 
        {490, 380, 200, 20, 0},
    };
    
    void update(Player p) {
        // for each wall
        for (int i = 0; i < walls.length; i++)  {
            fill(100);

            if (walls[i][4] == 1)
                fill(255, 0, 0);

            int wallRight = walls[i][0]+walls[i][2];
            int wallBottom = walls[i][1]+walls[i][3];
            boolean inXRange = p.x+p.size > walls[i][0] && p.x < wallRight;
            
            if (p.x+p.xv+p.size > walls[i][0] && p.x+p.xv < wallRight && p.y+p.size > walls[i][1] && p.y<wallBottom)
                p.xv=0;

            if (inXRange && p.y+p.yv+p.size > walls[i][1] && p.y < wallBottom) {
                p.yv=0;
                p.gravity=0;
                p.falling = false;
            }

            if (inXRange && p.y+p.size > walls[i][1] && p.y+p.yv < wallBottom) {
                p.yv=0;
                p.gravity=0;
            }

            rect(walls[i][0], walls[i][1], walls[i][2], walls[i][3]);
        }
    }
}