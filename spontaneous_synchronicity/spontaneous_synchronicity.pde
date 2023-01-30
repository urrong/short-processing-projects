boolean[][] cells;
float[][] timers;
float[][] blinking;
float[][] next;
float blink_interval = 2;
float blink_time = 0.2;
int cell_width = 20;
int window_width = 800;
int num_cells = window_width / cell_width;
int previous_time = 0;

void setup() {
    size(800, 800);
    cells = new boolean[num_cells][num_cells];
    timers = new float[num_cells][num_cells];
    blinking = new float[num_cells][num_cells];
    next = new float[num_cells][num_cells];
    randomize();
    previous_time = millis();
}

void randomize() {
    for (int i = 0; i < cells.length; i++) {
        for(int j = 0; j < cells[0].length; j++){
            timers[i][j] = random(blink_interval);
            //timers[i][j] = blink_interval;
            //cells[i][j] = random(2) >= 1.0;
        }
    }
}

void draw() {
    int current_time = millis();
    float difference = (current_time - previous_time) / 1000.0;
    previous_time = current_time;
    for (int i = 0; i < cells.length; i++) {
        for(int j = 0; j < cells[0].length; j++){
            timers[i][j] -= difference;
        }
    }
    for (int i = 0; i < cells.length; i++) {
        for(int j = 0; j < cells[0].length; j++){
            if (timers[i][j] <= 0){
                blink(i, j);
            }
        }
    }
    for (int i = 0; i < cells.length; i++) {
        for(int j = 0; j < cells[0].length; j++){
            if (timers[i][j] <= 0 && blinking[i][j] <= 0){
                blinking[i][j] = blink_time;
                timers[i][j] = blink_interval + timers[i][j];
            }
            
            if (blinking[i][j] > 0) {
                fill(255);
            } else {
                fill(0);
            }
            rect(j * cell_width, i * cell_width, cell_width - 3, cell_width - 3);
            
            blinking[i][j] -= difference;
            if(blinking[i][j] <= 0){
              blinking[i][j] = 0;
            }
        }
    }
}

void blink(int i, int j){
    float p = 0.8;
    for(int d1 = -1; d1 <= 1; d1++){
        for(int d2 = -1; d2 <= 1; d2++){
          if(d1 == 0 && d2 == 0) continue;
          //if(abs(d1) == 1 && abs(d2) == 1) continue;
          
          int ii = (i + d1 + cells.length) % cells.length;
          int jj = (j + d2 + cells.length) % cells.length;
          if(timers[ii][jj] > 0 && timers[ii][jj] < blink_interval / 2){
              timers[ii][jj] *= p;
              if(timers[ii][jj] < 0.01 * blink_interval){
                  timers[ii][jj] = 0;
                  blink(ii, jj);
              }
          }
          else if(timers[ii][jj] >= blink_interval / 2){
              timers[ii][jj] += (blink_interval - timers[ii][jj]) * (1 - p);
          }
       }
    }
}
