gear g1,g2,g3,g4;
gear[] GearList = new gear[4];
//float forceConstant = 0;
float angV = 0.01;

void setup(){
  size(800,800);
  g1 = new gear(0,new PVector(500,300), 12, 80);
  g2 = new gear(1,new PVector(295,300), 24, 120);
  g3 = new gear(2,new PVector(500,505), 6, 120);
  g4 = new gear(2,new PVector(250,500), 8, 30);
  GearList[0] = g1;
  GearList[1] = g2;
  GearList[2] = g3;
  GearList[3] = g4;

}
void draw(){
  background(200,200,255);
  pointer();
  
  g1.updateGear();
  g2.updateGear();
  g3.updateGear();
  g4.updateGear();
  
  g1.locateGears();
  g2.locateGears();
  g3.locateGears();
  g4.locateGears();
  
  g1.DetermineRotation();
  g2.DetermineRotation();
  g3.DetermineRotation();
  g4.DetermineRotation();
  
  GearList[0].RotVal += angV; //Supplied angular velocity
}

void pointer(){
  if(frameCount % 60 == 0){
    println("MouseX: ",mouseX);
    println("MouseY: ",mouseY);
    println("------");
  }
  pushStyle();
  rectMode(CENTER);
  fill(255,255,0);
  rect(mouseX,mouseY,8,8);
  popStyle();
}
