class Rectangle implements Object {
  PVector center; // Center of rectanlge
  PVector size; // Half of width, half of height

  public Rectangle(PVector center, PVector size) {
    this.center = center;
    this.size = size;
  }

  float DE(PVector point) {
    float dx = abs(point.x - center.x) - size.x;
    float dy = abs(point.y - center.y) - size.y;
    return dist(0, 0, max(dx, 0), max(dy, 0)) + min(0, max(dx, dy));
  }

  void display() {
    noStroke();
    fill(255);
    rectMode(RADIUS);
    rect(center.x, center.y, size.x, size.y);
    rectMode(CORNER);
  }
}
