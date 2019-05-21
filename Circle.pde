class Circle implements Object {
  PVector center;
  float radius;

  Circle (PVector center, float radius) {
    this.center = center;
    this.radius = radius;
  }

  float DE (PVector point) {
    return PVector.dist(center, point) - radius;
  }

  void display () {
    noStroke();
    fill(128);
    ellipse(center.x, center.y, radius*2, radius*2);
  }
}
