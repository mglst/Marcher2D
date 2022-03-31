void setup() {
  size(800, 800);
  noSmooth();
  pixelDensity(2);
  setupObjects();
}

void draw() {
  mergg(mouseLastClicked, mouseLastClicked_, 0.2);
  mergg(mouse, new PVector(mouseX, mouseY), 0.2);

  background(0);
  //castSingleRay();
  //castWebRays(mouseLastClicked, 30, 5);
  castWebRays(mouseLastClicked, 360, 25);
  object.display();
}

final int MAX_ITERATION = 200;

PVector direction;

void castSingleRay() {
  PVector origin = mouseLastClicked.copy();
  PVector current = origin.copy();
  PVector direction_ = PVector.sub(mouse, origin).normalize();
  //if (direction_.mag)>0)
  if (!mousePressed)direction = direction_;

  noFill();
  stroke(255);
  for (int iteration = 0; iteration < MAX_ITERATION; iteration++) {
    float de = object.DE(current.copy());
    float alpha = 255*min(sigg(current.x/width), sigg(current.y/height));
    if (alpha<0) break;
    stroke(255, alpha);
    ellipse(current.x, current.y, de*2, de*2);
    current.add(PVector.mult(direction, de));
  }
  stroke(255);
  line(current.x, current.y, origin.x, origin.y);
  println();
}

void castWebRays (PVector origin, int RAYS, int MAX_ITERATIONS) {
  PVector[] directions = new PVector[RAYS];
  PVector[] currents = new PVector[RAYS];
  PVector[] olds = new PVector[RAYS];
  for (int i = 0; i < RAYS; i++) {
    float angle = map(i, 0, RAYS, 0, TWO_PI);
    directions[i] = new PVector(cos(angle), sin(angle));
    olds[i] = currents[i] = origin.copy();
  }
  /*
  for (int iteration = 0; iteration < MAX_ITERATIONS; iteration++) {
   // noFill();
   // stroke(255);
   noStroke();
   fill(255, 10);
   beginShape();
   for (int i = 0; i < RAYS; i++) {
   currents[i].add(PVector.mult(directions[i], object.DE(currents[i].copy())));
   vertex(currents[i].x, currents[i].y);
   }
   endShape(CLOSE);
   }*/
  for (int iteration = 0; iteration < MAX_ITERATIONS; iteration++) {
    for (int i = 0; i < RAYS; i++) {
      olds[i] = currents[i].copy();
      currents[i].add(PVector.mult(directions[i], object.DE(currents[i].copy())));
    }
    colorMode(HSB);
    noStroke();
    for (int i = 0; i < RAYS; i++) {
      int j = (i+1)%RAYS;
      color col = color(i*255/RAYS, 190, 255*(1-1.*iteration/MAX_ITERATIONS));
      fill(col);
      //noFill();
      //stroke(255);
      noStroke();
      beginShape(QUAD);
      vertex(olds[i].x, olds[i].y);
      vertex(currents[i].x, currents[i].y);
      vertex(currents[j].x, currents[j].y);
      vertex(olds[j].x, olds[j].y);
      endShape(CLOSE);
    }
    colorMode(RGB);
  }
}

float sigg(float x) {
  // A sort of sigmoid that looks like __/‾\__
  // sigg(x) = 1 for 0<x<1
  // sigg(-1) = 0
  // sigg(2)  = 0 // linear interpolation anywhere in between
  return min(1, min(x+1, 2-x));
}

void mergg(PVector a, PVector b, float smooth) {
  a.add(PVector.sub(b, a).mult(smooth));
}

PVector mouseLastClicked_ = new PVector(70, 100);

PVector mouse = new PVector(0, 0);
PVector mouseLastClicked = mouseLastClicked_.copy();

void mouseClicked() {
  mouseLastClicked_.set(mouseX, mouseY);
}

void mouseDragged() {
  mouseClicked();
}
