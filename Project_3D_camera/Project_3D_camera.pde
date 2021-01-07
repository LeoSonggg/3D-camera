import java.awt.Robot;

Robot rbt;

//camera variables
float eyex, eyey, eyez, focusx, focusy, focusz, upx, upy, upz;

boolean wkey, akey, skey, dkey;

//rotation variable
float leftRightAngle;
float upDownAngle;

void setup() {
  //noCursor();
  try {
    rbt = new Robot(); 
  }
  catch(Exception e) {
    e.printStackTrace();  
  }
  size(displayWidth, displayHeight, P3D); 
  eyex = width/2;
  eyey = height/2;
  eyez = height/2;
  
  focusx = eyex;
  focusy = eyey;
  focusz = eyez - 100;
  
  upx = 0;
  upy = 1;
  upz = 0;
  
  leftRightAngle = 3*PI/2;
  upDownAngle = 0;
}

void draw() {
  background(0);
  
  camera(eyex, eyey, eyez, focusx, focusy, focusz, upx, upy, upz);
  
  move();
  
  drawAxis();
  drawFloor(-2000, 3000, 800, 100);
  drawFloor(-2000, 3000, 0, 100);
  drawInterface();
}

void drawInterface() {
  stroke(255, 0, 0);
  strokeWeight(5);
  line(width/2 - 15, height/2, width/2 + 15, height/2);
  line(width/2, height/2 - 15, width/2, height/2 + 15);
}

void drawAxis() {
  stroke(255,0,0);
  strokeWeight(1);
  line(0,0,0, 1000,0,0); //x axis
  line(0,0,0, 0,1000,0); //y axis
  line(0,0,0, 0,0,1000); //z axis
}

void drawFloor(int floorStart, int floorEnd, int floorHeight, int floorSpacing) {
  stroke(255);
  for(int i = floorStart; i < floorEnd; i+=floorSpacing) {
    line(i, floorHeight, floorStart, i, floorHeight, floorEnd);
    line(floorStart, floorHeight, i, floorEnd, floorHeight, i);
  }
    
  //line(width/2 -100, height, -1000, width/2 -100, height, 1000);
  //line(width/2 +100, height, -1000, width/2 +100, height, 1000);
}

void move() {
  
  pushMatrix();
  translate(focusx, focusy, focusz);
  sphere(0.5);
  popMatrix();
 
  if(wkey) eyez -= 10;
  if(akey) eyex -= 10;
  if(skey) eyez += 10;
  if(dkey) eyex += 10;
  
  if(upDownAngle > PI/2.5) upDownAngle = PI/2.5;
  if(upDownAngle < -PI/2.5) upDownAngle = -PI/2.5;
  
  if(mouseX > width-2) rbt.mouseMove(3, mouseY);
  if(mouseX < 2) rbt.mouseMove(width-3, mouseY);
  
  focusx = eyex + cos(leftRightAngle)*300;
  focusy = eyey + upDownAngle*300;
  focusz = eyez + sin(leftRightAngle)*300;
  
  if(abs(mouseX - pmouseX) < width - 10) leftRightAngle += (mouseX - pmouseX)*0.01;
  upDownAngle += (mouseY - pmouseY)*0.01;
}
