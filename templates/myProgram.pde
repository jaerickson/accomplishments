float L = 50;
float angle = 0;
import processing.sound.*;
SoundFile file;


float [] temp = new float[2];

float x, y, j, dy, i, rb, dangle, inp;
float scene = 0;
float asteroidSize=1;
PImage img, end;
int h = 0;
int frame =0;
int stuff = 200;
boolean start = false;
boolean title = false;
float xc = 400;
float yc = 500;

void setup()
{ 
  img = loadImage("blue-sky.jpg");
  end = loadImage("stegoDrawing.jpg");
  size(800, 600);
  image(img, 0, 0);
  loadPixels();
  file = new SoundFile(this, "Explosion.mp3");
}

void draw()
{
  Stegosaurus T1 = new Stegosaurus(xc, yc, L);
  noStroke();
  if (scene == 1)
  {

    updatePixels();
    pushMatrix();
    sceneone();
    lake();
    threeTrees();
    rightArrow();
    popMatrix();
    T1.moveHead(dangle);
    T1.drawSteg(#279007);
  }
  if (scene == 2)
  {
    pushMatrix();
    noLoop();
    updatePixels();
    scenetwo();
    leftArrow();
    popMatrix();
    T1.drawSteg(#279007);
  } else if (scene == 0)
  {
    pushMatrix();
    updatePixels();
    sceneone();
    lake();
    threeTrees();
    fill(255);
    title();
    popMatrix();
    title = false;
  }

  if (title == true)
  {
    h++;
    if (h >= 1000)
    {
      frame +=2;
      if (frame % stuff == 0)
      {
        i+=1;
        dy+=2;
        if (stuff > 51)
        {
          stuff -=50;
        }
        rb+=2;
      }
      asteroidSize = asteroidSize+.09*i*i;
      asteroid(width/2, dy, color(178-(rb*7.74), 23-rb, 23-rb));
      translate(width/2, height/2);
      fill(0, 0, 0, asteroidSize/150);
      rect(-width/2, -height/2, width, height);
      if (asteroidSize > 400 && asteroidSize < 410)
      {
        inp++;
        sound(inp);
      }
      if (asteroidSize > 1400)
      {
        translate(-width/2, -height/2);
        image(end, (width-end.width)/2, (height-end.height)/2);
      }
    }
  }
}
void mouseClicked()
{
  if (((mouseX > 325 && mouseX < 475) && (mouseY > 495 && mouseY < 670)))
  {
    scene = 1;
    title = true;
  } else if (((mouseX > 0) && (mouseX < 75)) && ((mouseY > 525) && (mouseY < 600)) && scene == 2)
  {
    noLoop();
    updatePixels();
    scene = 1;
    loop();
  } else if (((mouseX > 725) && (mouseX < 800)) && ((mouseY > 525) && (mouseY < 600)) && scene == 1)
  {
    updatePixels();
    scene = 2;
  }
}
void sound(float in)
{

  if (in == 1)
  {
    file.play();
  }
}
void keyPressed()
{
  if (key == 't')
  {
    dangle += .1;
  }
  if (key == 'r')
  {
    dangle -= .1;
  }
  if (key == CODED) {
    if (keyCode == LEFT && xc > 100)
    {
      xc -= 7;
    }
    if (keyCode == RIGHT && xc < 725)
    {
      xc += 7;
    }
    if (keyCode == UP && yc > 475)
    {
      L -= 4*L/yc;
      yc -= 3;
    }
    if (keyCode == DOWN && yc < 550)
    {
      L += 4*L/yc;
      yc += 3;
    }
  }
}

class Quad
{
  float x1, y1, x2, y2, x3, y3, x4, y4, anchorX, anchorY, deltaX, deltaY, theta;

  Quad(float anchX, float anchY, float hstart, float hend, float w, float angle)
  {
    anchorX = anchX;
    anchorY = anchY;
    x1 = 0;
    y1 = -hstart/2;
    x2 = 0;
    y2 = hstart/2;
    x3 = w;
    y3 = hend/2;
    x4 = w;
    y4 = -hend/2;

    theta = angle;
  }

  void setAngle(float angle)
  {

    theta = angle;
  }

  float[] getAnchor()
  {
    deltaX = x4*cos(theta);
    deltaY = x4*sin(theta);
    float[] data = {
      anchorX + deltaX, anchorY + deltaY
    };
    return data;
  }

  void setAnchorX(float Xin)
  {
    anchorX = Xin;
  }
  void setAnchorY(float Yin)
  {
    anchorY = Yin;
  }


  void drawQuad(color c)
  {

    fill(c);
    pushMatrix();
    translate(anchorX, anchorY);
    rotate(theta);
    quad(x1, y1, x2, y2, x3, y3, x4, y4);
    popMatrix();
  }
}

class tailTriangle
{
  float x1, y1, x2, y2, x3, y3, anchorX, anchorY, theta;

  tailTriangle(float anchX, float anchY, float h, float w)
  {
    anchorX = anchX;
    anchorY = anchY;
    x1 = 0;
    y1 = -h/2;
    x2 = 0;
    y2 = h/2;
    x3 = w;
    y3 = 0;
    theta = 0;
  }
  void setAnchorX(float Xin)
  {
    anchorX = Xin;
  }
  void setAnchorY(float Yin)
  {
    anchorY = Yin;
  }
  void setAngle(float angle)
  {
    theta = angle;
  }

  void drawTriangle(color c)
  {

    fill(c);
    pushMatrix();
    translate(anchorX, anchorY);
    rotate(theta);
    triangle(x1, y1, x2, y2, x3, y3);
    popMatrix();
  }
}



class leg
{
  float x1, y1, x2, y2, x3, y3, x4, y4, anchorX, anchorY;

  leg(float anchX, float anchY, float L)
  {
    anchorX = anchX;
    anchorY = anchY;
    x1 = -0.25*L;
    y1 = 0;
    x2 = -0.25*L;
    y2 = L;
    x3 = 0.25*L;
    y3 = L;
    x4 = 0.25*L;
    y4 = 0.25*L;
  }

  void drawLeg()
  {

    pushMatrix();
    translate(anchorX, anchorY);
    quad(x1, y1, x2, y2, x3, y3, x4, y4);
    popMatrix();
  }
}

class Oval
{
  float xs, xe, ys, ye, centerX, centerY, thick, theta, w;
  float[] middle = center();

  Oval(float x1, float y1, float x2, float y2)
  {
    xs = x1;
    ys = y1;
    xe = x2;
    ye = y2;
    thick = 20;
    theta = angle();
    w = diameter();
  }

  void setXstart(float x)
  {
    float dx = xe - xs;
    xs = x;
    xe = x + dx;
  }

  void setYstart(float y)
  {
    float dy = ye - ys;
    ys = y;
    ye = ys + dy;
  }

  void setXend(float x)
  {
    float dx = xe - xs;
    xe = x;
    xs = x-dx;
  }

  void setYend (float y)
  {
    float dy = ye - ys;
    ye = y;
    ys = y -dy;
  }

  void setXcenter(float x)
  {
    xs = 2*x - xe;
  }

  void setYcenter(float y)
  {
    ys = 2*y - ye;
  }

  void setAngle(float angle)
  {
    float d = diameter();
    theta = angle;
    xs = centerX - (d/2)*cos(angle);
    ys = centerY - (d/2)*sin(angle);
    xe = centerX + (d/2)*cos(angle);
    ye = centerY + (d/2)*sin(angle);
  }


  float[] center()
  {
    centerX = (xs + xe)/2;
    centerY = (ys + ye)/2;
    float []  c = {
      centerX, centerY
    };
    return  c;
  }

  float diameter()
  {
    return sqrt( (xs-xe)*(xs-xe) + (ys-ye)*(ys-ye));
  }

  float angle()
  { 
    theta = 3;//atan((ys-ye)/(xs-xe));
    return theta;
  }

  float[] getStart()
  {
    float[] data = {
      xs, ys
    };
    return data;
  }

  float[] getEnd()
  {
    float[] data = {
      xe, ye
    };
    return data;
  }

  void setCenter(float x, float y)
  {
    float dx = (xs-xe)/2;
    float dy = (ys-ye)/2;
    xs = x + dx;
    xe = x - dx;
    ys = y + dy;
    ye = y - dy;
  }

  void drawOval(color c, float ho)
  {
    fill(c);
    thick = ho;
    pushMatrix();
    translate(middle[0], middle[1]);
    rotate(theta);
    ellipse(xs, ys, w, thick);
    fill(0);
    ellipse(1.5*xs, ys, w/5, w/5);
    popMatrix();
  }
}

class Head
{
  float xs, xe, ys, ye, centerX, centerY, thick;
  Oval head;
  Head(float anchX, float anchY, float w, float h)
  {
    xs = anchX;
    ys = anchY;
    xe = anchX + w;
    ye = anchY + h;
    head = new Oval(xs, ys, xe, ye);
  }

  void setXstart()
  {
    head.setXstart((xe-xs)/2);
  }

  void setYstart(float y)
  {
    head.setYstart(y);
  }

  void setAngle(float theta)
  {
    head.setAngle(theta);
  }

  void drawHead(color c)
  {

    head.drawOval(c, ye-ys);
  }
}

class Legs
{
  float FlegsAnchorX, FlegsAnchorY, BlegsAnchorX, BlegsAnchorY, theta, L;
  leg FCL;
  leg FFL;
  leg BCL;
  leg BFL;
  Legs(float FLAX, float FLAY, float BLAX, float BLAY, float lngth)
  {
    FlegsAnchorX = FLAX;
    FlegsAnchorY = FLAY;
    BlegsAnchorX = BLAX;
    BlegsAnchorY = BLAY;
    L = lngth;
    FCL = new leg(-.75*L, 0, L);
    FFL = new leg(-.75*L, 0, L);
    BCL = new leg(.5*L, 0, L);
    BFL = new leg(.5*L, 0, L);
  }


  void drawLegs(color c)
  {
    fill(c);
    pushMatrix();
    translate(FlegsAnchorX, FlegsAnchorY);
    FCL.drawLeg();
    FFL.drawLeg();
    popMatrix();
    pushMatrix();
    translate(BlegsAnchorX, BlegsAnchorY);
    BCL.drawLeg();
    BFL.drawLeg();
    popMatrix();
  }
}

class Stegosaurus
{
  float cx, cy, L, headtheta;
  color clr;
  Tail Tail;
  Torso Torso;
  Head Head;
  Legs Legs;

  Stegosaurus(float centerX, float centerY, float lngth)
  {
    cx = centerX;
    cy = centerY;
    L = lngth;
    headtheta = 3;
    Tail = new Tail(cx + .8*L, cy, .5*L, .3*L, .75*L, .3*L, .1*L, .6*L, .1*L);
    Torso = new Torso(cx, cy, 2*L, 2*L);
    Head = new Head(0, 0, .8*L, .5*L);
    Legs = new Legs(cx -.001*L, cy, cx + .15*L, cy, L);
  }

  void moveHead(float headangle)
  {
    headtheta = 3;
  }


  void drawSteg(color c)
  {

    Tail.drawTail(c);
    Torso.drawTorso(c);
    pushMatrix();
    noLoop();
    translate(cx-L, cy);
    fill(0);
    Head.setXstart();
    Head.setYstart(0);
    Head.drawHead(c);
    Head.setAngle(headtheta);
    fill(255);
    loop();
    popMatrix();
    Legs.drawLegs(c);
  }
}

class Tail
{

  float anchLQX, anchLQY, anchSQX, anchSQY, anchTX, anchTY, LQStartH, LQEndH, LQW, SQStartH, SQEndH, SQW, TH, TW, theta;
  Quad one; 
  float[] anchorPointS;
  Quad two; 
  float[] anchorPointT;
  tailTriangle three;
  color green;


  Tail(float anchX, float anchY, float lQhstart, float lQhend, float lQw, float sQhstart, float sQhend, float sQw, float Th) 
  {
    anchLQX = anchX;
    anchLQY = anchY;
    LQStartH = lQhstart;
    LQEndH = lQhend;
    LQW = lQw;
    SQStartH = sQhstart;
    SQEndH = sQhend;
    SQW = sQw;
    TH = Th;

    one = new Quad(anchLQX, anchLQY, LQStartH, LQEndH, LQW, theta);
    anchorPointS = one.getAnchor();
    two = new Quad(anchorPointS[0], anchorPointS[1], SQStartH, SQEndH, SQW, theta);
    anchorPointT = two.getAnchor();
    three = new tailTriangle(anchorPointT[0], anchorPointT[1], TH, TW);
  }


  void setAnchorX(float Xin)
  {
    anchLQX = Xin;
  }
  void setAnchorY(float Yin)
  {
    anchLQY = Yin;
  }

  void setAngle(float angle)
  {
    theta = angle;
  }    
  void drawTail(color c)
  { 
    one.setAngle(angle);
    temp = one.getAnchor();
    two.setAngle(angle);
    two.setAnchorX(temp[0]);
    two.setAnchorY(temp[1]); 
    one.drawQuad(c);
    two.drawQuad(c);
    temp = two.getAnchor();
    three.setAngle(angle);
    three.setAnchorX(temp[0]);
    three.setAnchorY(temp[1]);
    three.drawTriangle(c);
  }
}

class Torso
{
  float x1, y1, x2, y2, x3, y3, eheight, ewidth, centerX, centerY;

  Torso(float x, float y, float h, float w)
  {
    eheight = h;
    ewidth = w;
    x1 = x - w/2;
    y1 = y;
    x2 = x;
    y2 = y - h/2;
    x3 = x + w/2;
    y3 = y;
    centerX = x;
    centerY = y;
  }

  void setCenterX(float Xin)
  {
    centerX = Xin;
  }


  void setCenterY(float Yin)
  {
    centerY = Yin;
  }

  void drawTorso(color c)
  {
    fill(c);
    triangle(x1, y1, x2, y2, x3, y3);
    ellipse(centerX, centerY, ewidth, eheight/2);
    arc(centerX, centerY, ewidth, eheight, PI, 2*PI);
  }
}

PImage trees;
int input;
void mountains()
{
  fill(#646467);
  triangle(width/4, -20, -width/4, -20, 0, -height/6-20);
  fill(79, 79, 80, 200);
  triangle(width/4, -20, -width/4, -20, 0, -height/6-20);
  fill(#646467);
  triangle(-width/2, -20, -width/4, -height/5-15, 0, -20);
  triangle(width/2, -20, width/4, -height/5-15, 0, -20);
  fill(117, 117, 118, 20);
  triangle(width/2, -20, width/4, -height/5-15, 0, -20);
  triangle(-width/2, -20, -width/4, -height/5-15, 0, -20);
}

void lake()
{
  fill(#254F89);
  arc(width/4-20, -20, width/2, 90, 0, PI);
  fill(93, 233, 237, 20);
  arc(width/4-20, -20, width/3, 60, 0, PI);
  fill(43, 155, 250, 20);
  arc(width/4-20, -20, width/4, 45, 0, PI);
}
void asteroid(float ax, float ay, color clr)
{
  fill(clr);
  ellipse(ax, ay, asteroidSize, asteroidSize);
}
void forest(float in)
{
  trees = loadImage("forest.png");
  if (in == 1)
  {  
    for (int i = 0; i<200; i++)
    {
      x= random(-400, 400);
      y = random(-20, 100);
      tree(x, y, 30, 60);
    }
    saveFrame("forest.png");
  } else
  {
    image(trees, -400, -300);
  }
}
void tree(float x, float y, float w, float h)
{
  fill(#624941);
  rect(x-(w/2), y, w, h);
  fill(#16641B);
  ellipse(x-(w/2), y, w, w);
  ellipse(x-(w/4), y-(w/2), w, w);
  ellipse(x+(w/4), y-(w/2), w, w);
  ellipse(x, y+(w/4), w, w);
  ellipse(x+(w/2), y, w, w);
}

void leftArrow()
{
  fill(#624941);
  rect(-400, 225, 75, 75, 10); //arrow
  fill(#F0CF91);
  rect(-370, 250, 30, 25);
  triangle(-370, 237.5, -390, 262.5, -370, 287.5); //arrow
}

void rightArrow()
{
  fill(#624941);
  rect(325, 225, 75, 75, 10); //arrow
  fill(#F0CF91);
  rect(340, 250, 30, 25);
  triangle(370, 237.5, 390, 262.5, 370, 287.5); //arrow
}

void sceneone()
{

  translate(width/2, height/2);
  fill(#32C63D);
  rect(-400, -20, 800, 320); //grass
  fill(#F0CF91);
  rect(-400, 150, 800, 250); //path
  mountains();
}


void threeTrees()
{
  tree(0, 120, 30, 60);
  tree(width/4, 120, 30, 60);
  tree(-width/4, 120, 30, 60);
}
void scenetwo()
{
  noLoop();
  sceneone();
  input++;
  forest(input);
}

void title()
{

  textSize(100);
  textAlign(CENTER);
  text("STEGO 2.0", 0, -185);
  textSize(20);
  text("by Max Mendoza, Kristiana Budke, and Jessica Erickson", 0, -155);
  text("Use Arrow Keys to Move", 0, 55);
  fill(#1A7972);
  rect(-75, 195, 150, 75, 15);
  fill(255);
  textSize(50);
  text("Start", 0, 250);
}
