import processing.sound.*;
ButtonSprite[] keys;
final static String inputs = "12345678";
final static float BTN_SCL = 50.0/230;
int startTime = 0;
int lastTime=0;
int delta;
SoundFile file;

ArrayList<FallingSprite> falls;
ArrayList<FallingSprite> onDisp;
Feedback[] texts = new Feedback[9];
String fileName = "thrlines";
boolean over = false;
int score = 0;
int leng;
int count = 0;
void setup() {
  falls = new ArrayList<FallingSprite>();
  onDisp = new ArrayList<FallingSprite>();
  size(800, 600);
  imageMode(CENTER);
  keys = new ButtonSprite[9];
  for (int i = 1; i < 9; i++) {
    keys[i] = new ButtonSprite(i+".png", BTN_SCL, 93.75*i, 500, i);
  }
  prepNotes(fileName + ".csv");
  frameRate(30);
  file = new SoundFile(this, fileName + ".mp3");
  file.play();
  startTime = millis();
}

void draw() {
  background(255);
  fill(0);
  if ((falls.size() == 0 && onDisp.size() == 0)) {
    over = true;
    textSize(50);
    text("Northern Desert (remake) \n by threelines3", 0, 100);
    text("Accuracy: " + ((int) ((1.0 * score) / (leng * 50) * 10000 + 0.5)) / 100.0 + "%", 0, 300);
  }
  if (!over) {
    delta = millis()-lastTime;
    int curTime = millis()-startTime;
    if (millis() > 1000) {
      textSize(50);
      text("Score: " + score + ", Time: " + (curTime) / 1000.0 + "\n Accuracy: " + (count == 0 ? 100.0 : ((int) ((1.0 * score) / (count * 50) * 10000 + 0.5)) / 100.0), 50, 50);
    }
    
    checkFalling(curTime + 1200); 
    for (int i = 1; i < 9; i++) {
      keys[i].display();
    }
    updateFalling(delta);
    lastTime = millis();
    textSize(25);
    for (int i = 1; i < 9; i++) {
      if (texts[i] != null) {
        if (millis() < texts[i].until) {
          text(texts[i].text, texts[i].num * 93.75 - 20, 575);
        }
      }
    }
  }
  
}

void keyPressed() {
  if (inputs.contains("" + key)) {
    keys[Integer.valueOf(""+key)].press();
    checkIfAccurate(Integer.valueOf(""+key));
  }
}

void keyReleased() {
  if (inputs.contains("" + key)) {
    keys[Integer.valueOf(""+key)].unpress();
  }
}

void prepNotes(String filename) {
  String[] lines = loadStrings(filename);
  String[] times = split(lines[0], ",");
  String[] notes = split(lines[1], ",");
  for (int i = 0; i < times.length; i++) {
     falls.add(new FallingSprite((min(Integer.valueOf(notes[i]), 8)) + "p.png", BTN_SCL, 93.75 * cvt(min(Integer.valueOf(notes[i]), 8)), 0, min(Integer.valueOf(notes[i]), 8), Float.valueOf(times[i])));
  }
  leng = times.length;
  print(falls.get(1).time);
}

void checkFalling(int lastT) {
  for (int i = 0; i < falls.size(); i++) {
    if (falls.get(i).time < lastT) {
        onDisp.add(falls.get(i)); 
        falls.remove(i);
        i--;
    }
  }
}
int cvt(int num) {
  return num;
}
void updateFalling(int delta) {
   for (int i = 0; i < onDisp.size(); i++) {
     if (onDisp.get(i).getTop() > keys[cvt(onDisp.get(i).num)].getBottom()) {
       texts[onDisp.get(i).num] = new Feedback(onDisp.get(i).num, "Miss", millis() + 2000);
       onDisp.remove(i);
       count++;
       i--;
     }
     else {
       onDisp.get(i).update(delta);
       onDisp.get(i).display();
     }
   }  
}

void checkIfAccurate(int num) {
   for (int i = 0; i < onDisp.size(); i++) {
     if (onDisp.get(i).num != num) {
       continue;
     }
     if (onDisp.get(i).cy < (keys[cvt(num)].cy + 12) && onDisp.get(i).cy > (keys[cvt(num)].cy - 12)){
       // success
       onDisp.remove(i);
       texts[num] = new Feedback(num, "Perfect!", millis() + 500);
       score += 50;
       i--;
       count++;
       break;
     }
     else if (onDisp.get(i).cy < (keys[cvt(num)].cy + 35) && onDisp.get(i).cy > (keys[cvt(num)].cy - 35)){
       // success
       onDisp.remove(i);
       texts[num] = new Feedback(num, "Good!", millis() + 500);
       score += 45;
       i--;
       count++;
       break;
     }
     else if (onDisp.get(i).checkIn(keys[cvt(num)].getTop(), keys[cvt(num)].getBottom())) {
       // success
       onDisp.remove(i);
       texts[num] = new Feedback(num, "OK!", millis() + 500);
       score += 40;
       i--;
       count++;
       break;
     }
     else if (onDisp.get(i).checkIn(keys[cvt(num)].getTop() - 50, keys[cvt(num)].getTop())) {
       // fail
       onDisp.remove(i);
       texts[num] = new Feedback(num, "Miss :(", millis() + 500);
       i--;
       count++;
       break;
     }
     
   }
}
