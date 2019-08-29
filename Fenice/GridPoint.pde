class GridPoint {
  float x1;
  float y1;
  float fw1;
  float fh1;
  int act;

  //initialize
  GridPoint(float x, float y, float fw, float fh, int a) {
    x1 = x;
    fw1 = fw;
    y1 = y;
    fh1 = fh;
    act = a;
  }

  //draw dots
  void drawDots() {
    fill(color2);
    noStroke();

    int size = 2;

    if (x1 % (4*fw1) == 0 && y1 %  (4*fh1) == 0) {
      fill(color1);
      size = 4;
    }
    ellipse(x1+fw1/2, y1+fh1/2, size, size);
  }


  void drawLine() {
    fill(color1);
    noStroke();

    rect(x1, y1, lineSize, lineSize);
    //line(x1+fw1/2, y1, x1+fw1/2, y1+fh1);
  }
}
