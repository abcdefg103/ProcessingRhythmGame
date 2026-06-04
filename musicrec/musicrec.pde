import processing.sound.*;
ButtonSprite[] keys;
final static String inputs = "12345678";
final static float BTN_SCL = 50.0/230;
int startTime = 0;
int lastTime=0;
int delta;
SoundFile file;
String filename = "nausicaa.mp3";
ArrayList<FallingSprite> onDisp;
int score = 0;
String csvTimes = "";
String csvNotes = "";
void setup() {
  onDisp = new ArrayList<FallingSprite>();
  size(800, 600);
  imageMode(CENTER);
  keys = new ButtonSprite[9];
  for (int i = 1; i < 9; i++) {
    keys[i] = new ButtonSprite(i+".png", BTN_SCL, 93.75*i, 500, i);
  }
  //prepNotes("notes.csv");
  frameRate(30);
  file = new SoundFile(this, filename);
  file.play();
  startTime = millis();
}

void draw() {
  delta = millis()-lastTime;
  background(255);
  textSize(50);
  fill(0);
  int curTime = millis()-startTime;
  text("Score: " + score + ", Time: " + (curTime) / 1000.0, 50, 50);
  
  for (int i = 1; i < 9; i++) {
    keys[i].display();
  }
  updateFalling(delta);
  lastTime = millis();
}

void keyPressed() {
  if (inputs.contains("" + key)) {
    keys[Integer.valueOf(""+key)].press();
    csvTimes += (millis() - startTime) + ",";
    csvNotes += (key) + ",";
    onDisp.add(new FallingSprite(""+ key + "p.png", BTN_SCL, 93.75 * cvt(Integer.valueOf("" + key)), 500, Integer.valueOf("" + key), Float.valueOf((millis() - startTime))));
    //checkIfAccurate(Integer.valueOf(""+key));
  }
  if (key == 'a') {
    println(csvTimes);
    println(csvNotes);
  }
}

void keyReleased() {
  if (inputs.contains("" + key)) {
    keys[Integer.valueOf(""+key)].unpress();
    
  }
}

//void prepNotes(String filename) {
//  String[] lines = loadStrings(filename);
//  String[] times = split(lines[0], ",");
//  String[] notes = split(lines[1], ",");
//  for (int i = 0; i < times.length; i++) {
//     falls.add(new FallingSprite(notes[i] + "p.png", BTN_SCL, 75 * Integer.valueOf(notes[i]), 0, Integer.valueOf(notes[i]), Float.valueOf(times[i])));
//  }
//  print(falls.get(1).time);
//}

//void checkFalling(int lastTime) {
//  for (int i = 0; i < falls.size(); i++) {
//    if (falls.get(i).time < lastTime) {
//        onDisp.add(falls.get(i)); 
//        falls.remove(i);
//        i--;
//    }
//  }
//}
int cvt(int num) {
  if (num != 0) {
    return num;
  }
  return 10;
}
void updateFalling(int delta) {
   for (int i = 0; i < onDisp.size(); i++) {
     if (onDisp.get(i).getBottom() < 0) {
       onDisp.remove(i);
       i--;
     }
     else {
       onDisp.get(i).update(delta);
       onDisp.get(i).display();
     }
   }  
}

//void checkIfAccurate(int num) {
//   for (int i = 0; i < onDisp.size(); i++) {
//     if (onDisp.get(i).num != num) {
//       continue;
//     }
//     if (onDisp.get(i).checkIn(keys[cvt(num)].getTop(), keys[cvt(num)].getBottom())) {
//       // success
//       onDisp.remove(i);
//       score += 50;
//       i--;
//     }
//     else if (onDisp.get(i).checkIn(keys[cvt(num)].getTop() - 50, keys[cvt(num)].getTop())) {
//       // fail
//       onDisp.remove(i);
//       i--;
//     }
     
//   }
//}
