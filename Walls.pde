public class Walls {
    int w = 1200;
    int h = 800;
    int t = 20; // thickness
    color wallColor = #283e51;
    color bouncyWallColor = #5614B0;

    Walls(int thickness) {
        t = thickness;
    }
    
    // each wall is {x, y, width, height, bouncyWall?}
    int[][] walls = {
        {0, 0, w, t, 0}, 
        {0, h-t, w, t, 1}, 
        {0, 0, t, h, 1}, 
        {w-t, 0, t, h, 1}, 
        {200, 570, 400, 30, 0}, 
        {250, 540, 50, 30, 0}, 
        {500, 540, 50, 30, 0}, 
        {300, 500, 200, 10, 0}, 
        {600, 480, 200, 20, 0}, 
        {0, 480, 200, 20, 0}, 
        {800, 300, 20, 600, 1}, 
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
            fill(wallColor);

            if (walls[i][4] == 1)
                fill(bouncyWallColor);

            int wallRight = walls[i][0]+walls[i][2];
            int wallBottom = walls[i][1]+walls[i][3];
            boolean inXRange = p.x+p.size > walls[i][0] && p.x < wallRight;
            
            if (p.x+p.xv+p.size > walls[i][0] && p.x+p.xv < wallRight && p.y+p.size > walls[i][1] && p.y<wallBottom)
                p.xv=0;

            if (inXRange && p.y+p.yv+p.size > walls[i][1] && p.y < wallBottom) {
                p.yv=0;
                p.gravity=0;
                p.falling = false;
                p.jumpTimer = 0;
            }

            if (inXRange && p.y+p.size > walls[i][1] && p.y+p.yv < wallBottom) {
                p.yv=0;
                p.gravity=0;
            }

            rect(walls[i][0], walls[i][1], walls[i][2], walls[i][3]);
        }
    }
}