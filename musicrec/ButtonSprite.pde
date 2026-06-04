public class ButtonSprite extends Sprite {
  int num;
  boolean pressed = false;
  public ButtonSprite(String f, float sc, float x, float y, int num) {
    super(f, sc, x, y);
    this.num = num;
  }
  public ButtonSprite(String f, float sc, int num) {
    this(f, sc, 0, 0, num);
  }
  public ButtonSprite(PImage img, float sc, int num) {
    super(img, sc);
    this.num = num;
  }
  
  public void press() {
    if (!pressed) {
      image = loadImage(num + "i.png");
      pressed = true;
    }
  }
  
  public void unpress() {
    if (pressed) {
      image = loadImage(num + ".png");
      pressed = false;
    }
  }
  
}
