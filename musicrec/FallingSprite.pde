public class FallingSprite extends Sprite {
  int num;
  float time;
  public FallingSprite(String f, float sc, float x, float y, int num, float time) {
    super(f, sc, x, y);
    this.num = num;
    this.dy = -500;
    this.time = time;
  }
  public FallingSprite(String f, float sc, int num, float time) {
    this(f, sc, 0, 0, num, time);
  }
  public FallingSprite(PImage img, float sc, int num, float time) {
    super(img, sc);
    this.num = num;
    this.time = time;
  }
  
  public boolean checkIn(float lowtop, float higbot) {
      if (lowtop <= getBottom() && lowtop > cy) {
        return true;
      }
      if (cy < higbot && cy > lowtop) {
        return true;
      }
      if (higbot < cy && higbot >= getTop()) {
        return true;
      }
      return false;
  }
   
  
}
