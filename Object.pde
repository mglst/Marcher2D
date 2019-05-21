interface Object {
  float DE (PVector point); // WARNING: some objects will transform the PVector, make sure to pass a copy
  void display ();
}

Object object;

void setupObjects () {
  object = setupGridCircle(3, 20);
  // object = setupSingleCircle();
  //object = setupSingleRectangle();
}

ObjectList setupGridCircle(int count, float radius) {
  ArrayList<Object> list = new ArrayList(count*count);
  float offx = 0.5*width/(count+1);
  float offy = 0.5*height/(count+1);
  for (int i = 0; i < count; i++) {
    for (int j = 0; j < count; j++) {
      float x = offx + map(i, 0, count, 0, width);
      float y = offy + map(j, 0, count, 0, height);
      list.add(new Circle(new PVector(x, y), radius));
    }
  }
  return new ObjectList(list);
}

Circle setupSingleCircle() {
  return new Circle(new PVector(400, 400), 80);
}

Rectangle setupSingleRectangle() {
  return new Rectangle(new PVector(width/2, height/2), new PVector(150, 100));
}
