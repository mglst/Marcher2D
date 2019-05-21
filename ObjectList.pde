class ObjectList implements Object {
  Iterable<Object> list;

  ObjectList(Iterable<Object> list) {
    this.list = list;
  }

  float DE (PVector point) {
    float smallest = Float.MAX_VALUE;
    for (Object o : list) smallest = min(smallest, o.DE(point));
    return smallest;
  }

  void display() {
    for (Object o : list) o.display();
  }
}
