public class Sprite {
  PImage image;
  float cx, cy;
  float dx, dy;
  float w, h;
  
  public Sprite(String f, float sc, float x, float y) {
    image = loadImage(f);
    w = image.width * sc;
    h = image.height * sc;
    cx = x;
    cy = y;
    dx = 0; 
    dy = 0;
  }
  public Sprite(String f, float sc) {
    this(f, sc, 0, 0);
  }
  public Sprite(PImage img, float sc) {
    image = img;
    w = image.width * sc;
    h = image.height * sc;
    cx = 0;
    cy = 0;
    dx = 0; 
    dy = 0;
  
  }
  
  public void display() {
    image(image, cx, cy, w, h);
  }
  public void update(int delta) {
    cx += dx * delta / 1000.0;
    cy += dy * delta / 1000.0;
  }
  
  public float getLeft() {
    return cx - w/2;
  }
  
  public float getRight() {
    return cx + w/2;
  }
  
  public float getTop() {
    return cy - h/2;
  }
  
  public float getBottom() {
    return cy + h/2;
  }
  
  public void setLeft(float l) {
    cx = l + w/2;
  }
  
  public void setRight(float r) {
    cx = r - w/2;
  }
  public void setTop(float t) {
    cy = t + h/2;
  }
  public void setBottom(float b) {
    cy = b - h/2;
  }
}
