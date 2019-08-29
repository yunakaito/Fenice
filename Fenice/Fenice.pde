/*

 OL_Fenice.pde
 
 ■　■　■　■
 ■■■　■■■
 ■　■　■　■
 ■■■　■■■
 ■　■　■　■
 
 
 --
 
 創作言語を構築する
 右クリックで保存、左クリックで新規生成です。
 
 悠(@Yu_Urs)
 
 */

import processing.pdf.*;

//枠数(縦 × 横)
final int blockW = 13;
final int blockH = 13;

//線の長さ
final int lineSize = 12;

//描画部分の大きさ
final int boxSize = blockW * lineSize;

//簡単さ(大きくなるほど少なくなる)
final int complexity = 0;

//色設定
final color bg = #990727;
final color color1 = #E2CB9E;
final color color2 = #A08655;

// Initialize
ArrayList<GridPoint> points = new ArrayList<GridPoint>();
PFont uiFont;

String textcode = "";

void setup() {

  //settings
  //noSmooth();
  size(300, 400);
  strokeCap(SQUARE);


  //タイルの大きさを設定
  float tileWidth = lineSize; 
  float tileHeight = lineSize;

  //フォント設定
  uiFont = loadFont("CourierNewPSMT-12.vlw");
  textAlign(CENTER, CENTER);
  textFont(uiFont, 12); 
  
  //init
  
  translate(width/2-boxSize/2, height/2-boxSize/4*3);

  for (float x = 0; x < blockW; x ++) {
    for (float y = 0; y < blockH; y ++) {
      points.add(
        new GridPoint(x * tileWidth, y* tileHeight, tileWidth, tileHeight, 0)
        );
    }
  }
  
//draw UI----------------------------------------------------------------------------

  background(bg);

  //draw frame
  for (GridPoint a : points) {
    a.drawDots();
  }
  
  pushMatrix();
  fill(color1);
  translate(-width/2+boxSize/2, -height/2+boxSize/4*3);
  text("F e n i c e  -  v 0", width/2, height/2+75);
  textcode = "000-000-000";
  text("TextCode: "+ textcode, width/2, height/2+120);
  popMatrix();

  //draw UI----------------------------------------------------------------------------
}

void draw() {
  translate(width/2-boxSize/2, height/2-boxSize/4*3);
}

void mousePressed() {
  
  if (mouseButton == LEFT) {
    runes();
  }
  
  if (mouseButton == RIGHT) {
    //record
    beginRecord(PDF, "output\\ Fenice-"+textcode+".pdf");
    
    saveRunes();
    
    //record-stop
    endRecord();
  }
}

void runes() {
  background(bg);
  int codeA = 0;
  int codeB = 0;
  int codeC = 0;

  //draw frame
  for (GridPoint a : points) {
    a.drawDots();
    a.act = 0;
  }

  //rules------------------------------------------------------------------------------

  //主画の設定
  for (float x = 1; x < blockW-1; x ++) {
    int r = (int)random(1, blockH/2);


    if (r % 2 == 0) r = 1;

    for (float y = r; y < blockH-r; y ++) {
      float i = blockH * x + y;

      if (x % 2 == 1) {
        points.get((int)i).act = 1;
        codeA++;
      }
    }
  }

  //従属画の設定
  for (float x = 1; x < blockW-1; x ++) {
    for (float y = 1; y < blockH-1; y += 2) {
      float i = blockH * x + y;
      int r = (int)random(0, 2);
      if (x%4 == 2) {
        if (r == 0) {
          points.get((int)i).act = 1;
          codeB++;
        }
      }
    }
  }

  //rules------------------------------------------------------------------------------


  //draw-------------------------------------------------------------------------------

  for (float x = 1; x < blockW-1; x ++) {
    for (float y = 1; y < blockH-1; y ++) {
      float i = blockH * x + y;

      if (points.get((int)i).act == 1) {
        //離れてるやつは書かない

        if (x%2 == 0) {
          float backI = (blockH) * (x-1) + y;
          float frontI = (blockH) * (x+1) + y;

          if (points.get((int)backI).act + points.get((int)frontI).act > 0) {
            points.get((int)i).drawLine();
            codeC++;
          }
        } else {
          points.get((int)i).drawLine();
          codeC++;
        }
      }
    }
  }

  //draw-------------------------------------------------------------------------------

  //draw UI----------------------------------------------------------------------------

  pushMatrix();
  fill(color1);
  translate(-width/2+boxSize/2, -height/2+boxSize/4*3);
  text("F e n i c e  -  v 0", width/2, height/2+75);
  textcode = hex(codeA, 3)+"-"+hex(codeB, 3)+"-"+hex(codeC, 3);
  text("TextCode: "+ textcode, width/2, height/2+120);
  popMatrix();

  //draw UI----------------------------------------------------------------------------
}


void saveRunes(){
 
    for (float x = 1; x < blockW-1; x ++) {
      for (float y = 1; y < blockH-1; y ++) {
        float i = blockH * x + y;

        if (points.get((int)i).act == 1) {
          //離れてるやつは書かない

          if (x%2 == 0) {
            float backI = (blockH) * (x-1) + y;
            float frontI = (blockH) * (x+1) + y;

            if (points.get((int)backI).act + points.get((int)frontI).act > 0) {
              points.get((int)i).drawLine();
            }
          } else {
            points.get((int)i).drawLine();
          }
        }
      }
    }
 
}
