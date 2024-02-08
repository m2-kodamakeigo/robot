float baseH = 60;
float armL1 = 40;
float armL2 = 40;
float armL3 = 40;
float armL4 = 40;
float armL5 = 40;
float brushL = 10;
float armW1 = 10;
float armW2 = 10;
float armW3 = 8;
float armW4 = 6;
float armW5 = 4;
float brushW = 4;
float angle1;
float angle1Direction = 1;
float angle1speed = 0.3;
float angle2;
float angle2Direction = 1;
float angle2speed = 0.3;
float angle3;
float angle3Direction = 1;
float angle3speed = 1.5;
float angle5;
float l5   ;
float l5Direction = 1;
float l5speed = 1.5   ;
float dif = 1.0;

boolean manualMode = true;

void setup() {
  size(1000, 800, P3D);
  camera(100, 100, 150, 0, 0, 0, 0, 0, -1);
}

void draw() {
  background(0);
  
  if (manualMode) {
    manualMode();
  } else {
    autoMode();
  }

  drawRoboticArm();
}

void keyPressed() {
  if (key == 'k') { // マニュアルモードに設定
    manualMode = true;
  } else if (key == 'a') { // オートモードに設定
    manualMode = false;
  }
}

void manualMode() {
  if (keyPressed) {
    // 各キーボード操作
    if (key == 'b') {
      angle1 = constrain(angle1 + angle1speed * dif, -45, 45);
    } else if (key == 'v') {
      angle1 = constrain(angle1 - angle1speed * dif, -45, 45);
    } else if (key == 'm') {
      angle2 = constrain(angle2 + angle2speed * dif, -45, 45);
    } else if (key == 'n') {
      angle2 = constrain(angle2 -  angle2speed * dif, -45, 45);
    } else if (key == 's') {
      if ((angle3 > 5) || (angle3 < -5)) {
        angle3Direction = -angle3Direction;
      }
      angle3 = angle3 +  angle3speed * dif * angle3Direction;
    } else if (key == 'e') {
      angle5 = constrain(angle5 + dif, -90, 90);
    } else if (key == 'w') {
      angle5 = constrain(angle5 - dif, -90, 90);
    } else if (key == 'd') {
      if ((l5 > 10) || (l5 < 0)) {
        l5Direction = -l5Direction;
      }
      l5 = l5 + l5speed * dif * l5Direction;
    }
  }
}

void autoMode() {
  // オートモードの動作
  angle1 += angle1speed * angle1Direction; 
  angle2 += angle2speed * angle2Direction;
  angle3 += angle3speed * angle3Direction; 
if ((angle1 > 22.5) || (angle1 < 0)) {
    angle1Direction = -angle1Direction;
  } 
 if ((angle2 > 22.5) || (angle2 < 0)) {
    angle2Direction = -angle2Direction;
  }
 if ((angle3 > 5) || (angle3 < -5)) {
    angle3Direction = -angle3Direction;
  }
}

void drawRoboticArm() {
  // ロボットアームの描画
  //L0ベース
  translate(0, 0, baseH / 2);
  fill(255);
  box(10, 10, baseH);

  //L1リンク
  translate(0, 0, baseH / 2 + armW1 / 2);
  rotateZ(radians(angle1));
  translate(armL1 / 2 - armW1 / 2, 0, 0);
  fill(255);
  box(armL1, armW1, armW1);

 //L2リンク
  translate(armL1/2-armW1/2, 0, armW1 / 2 + armW2 / 2);
  rotateZ(radians(angle2));
  translate(armL2 / 2 - armW2 / 2, 0, 0);
  fill(255);
  box(armL2, armW2, armW2);

  //L3リンク
  translate(armL2 / 2 + armW3 / 2, 0, 0);
  rotateX(radians(angle3));
  translate(0, -armL3 / 2 + armW3 / 2, 0);
  fill(255);
  box(armW3, armL3, armW3);

  //L4リンク
  translate(armW3 / 2 + armW4 / 2, -armL3 / 2 + armW3 / 2, 0);
  rotateX(radians(-angle3));
  translate(0, armL4 / 2 - armW4 / 2, 0);
  fill(255);
  box(armW4, armL4, armW4);


  //L5リンク
  rotateY(radians(angle5));
  translate(0, armL4 / 2 + armL5 / 2 - l5, 0);
  fill(0, 191, 255);
  box(armW5, armL5, armW5);

//ブラシ
  translate(-armW5 / 2 - brushW / 2 , armL5 / 2 - brushL / 2, 0);
  fill(255);
  box(brushW,brushL,brushW);
}
