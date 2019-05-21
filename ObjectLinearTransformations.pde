class ObjectTranslation implements Object {
  Object o;
  PVector translation;

  ObjectTranslation (Object o, PVector translation) {
    this.o = o;
    this.translation = translation;
  }

  float DE(PVector point) {
    point.sub(translation);
    return o.DE(point);
  }

  void display() {
    translate(translation.x, translation.y);
    o.display();
  }
}
