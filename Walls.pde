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
        {0, 0, w, t, 0}, // top boundary
        {0, h-t, w, t, 0},  // bottom boundary
        {0, 0, t, h, 1}, // left boundary
        {w-t, 0, t, h, 0}, // right boundary
        {150, 700, t, h-700-t, 0}, // left bottom vertical
        {w-150-t, 700, t, h-700-t, 0}, // right ^
        {250, 500, w-500-t, t, 0}, // center platform 1
        {100, 625, 130, t, 0}, // left bottom vertical
        {w-230, 625, 130, t, 0},
        {400, 400, t, 55, 1},
        {600, 200, 150, t, 1},
        {50, 300, 170, t, 0},
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

            if (inXRange && p.y + p.yv + p.size > walls[i][1] && p.y + p.size < wallBottom) {
                p.yv = p.xv = p.gravity = p.jumpTimer = p.numJumps = 0;
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
