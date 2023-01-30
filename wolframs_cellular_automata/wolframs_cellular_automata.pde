//float angle = PI/2; //initial angle
//float amplitude = 1; // amplitude of the pendulum
//float originX, originY;
//float g = 90.8; // acceleration due to gravity
//float length1 = 200; // length of the pendulum
//float t = 0;
//float dampen = 1;

//void setup() {
//  size(800, 600);
//  originX = width/2;
//  originY = height/2;
//  background(255);
//}

//void draw() {
//  background(255);
//  angle =  PI/4 * cos(sqrt(g/length1) * t) * dampen;
//  dampen *= 0.999;
//  float pendulumX = originX + length1 * sin(angle);
//  float pendulumY = originY + length1 * cos(angle);
//  strokeWeight(4);
//  stroke(0);
//  line(originX, originY, pendulumX, pendulumY);
//  fill(175);
//  ellipse(pendulumX, pendulumY, 32, 32);
//  t += 0.1;
//}

int[] cells;
int[] next;
int cell_width = 5;
int window_width = 800;
int num_cells = window_width / cell_width;
int generation = 0;

void setup() {
    size(800, 800);
    cells = new int[num_cells];
    next = new int[num_cells];
    cells[num_cells / 2] = 1;
    //randomize();
}

void randomize() {
    for (int i = 0; i < cells.length; i++) {
        cells[i] = int(random(2));
    }
    generation = 0;
}

void draw() {
    for (int i = 0; i < cells.length; i++) {
        if (cells[i] == 1) {
            fill(0);
        } else {
            fill(255);
        }
        rect(i * cell_width, generation * cell_width, cell_width, cell_width);
    }
    nextGeneration();
    generation++;
    if (generation * cell_width > height) {
        noLoop();
    }
}

void nextGeneration() {
    for (int i = 1; i < cells.length-1; i++) {
        int left = cells[i-1];
        int me = cells[i];
        int right = cells[i+1];
        next[i] = rules90(left, me, right);
    }
    int[] temp = cells;
    cells = next;
    next = temp;
}

int rules30(int a, int b, int c) {
    if (a == 1 && b == 1 && c == 1) return 0;
    if (a == 1 && b == 1 && c == 0) return 0;
    if (a == 1 && b == 0 && c == 1) return 0;
    if (a == 1 && b == 0 && c == 0) return 1;
    if (a == 0 && b == 1 && c == 1) return 1;
    if (a == 0 && b == 1 && c == 0) return 1;
    if (a == 0 && b == 0 && c == 1) return 1;
    if (a == 0 && b == 0 && c == 0) return 0;
    return 0;
}

int rules90(int a, int b, int c) {
    if (a == 1 && b == 1 && c == 1) return 0;
    if (a == 1 && b == 1 && c == 0) return 1;
    if (a == 1 && b == 0 && c == 1) return 0;
    if (a == 1 && b == 0 && c == 0) return 0;
    if (a == 0 && b == 1 && c == 1) return 8;
    if (a == 0 && b == 1 && c == 0) return 4;
    if (a == 0 && b == 0 && c == 1) return 0;
    if (a == 0 && b == 0 && c == 0) return 1;
    return 0;
}
