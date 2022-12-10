class gear{
  PVector pos = new PVector(0,0);
  int gearNum;
  int rad;
  int ID;
  float RotVal = 0; //Start with 0 angularVelocity, unless supplied in setup
  ArrayList<gear> coupled = new ArrayList<gear>();
  
  gear(int GearIdentity, PVector position, int NumberOfGears, int radius){
    pos.x = position.x;
    pos.y = position.y;
    gearNum = NumberOfGears;
    rad = radius;
    ID = GearIdentity;
  } //<>//
  
  // Update Gear element positions
  void updateGear(){
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(RotVal); // Setup for each frames' rotation
    
    ellipse(0,0,2*rad,2*rad); // Drawing gears
    for (float i=0;i<(2*PI);i+=(2*PI)/gearNum){ //<>//
      pushMatrix();
      rotate(i);
      ellipse(0, -rad, 10,10);
      popMatrix(); //<>//
    }
    pushStyle(); // Marker Nodule
    fill(255,100,100);
    ellipse(0,-rad,5,5);
    popStyle(); //--------------
    
    popMatrix();
  }
  
  // Draw lines to gears, finding sufficently close gears(green)
  void locateGears(){
    for (int i=0; i<( (GearList).length ) ; i+=1){
      float Abs = sqrt( pow( (GearList[i].pos.x)-(pos.x) ,2) + pow( (GearList[i].pos.y)-(pos.y) ,2) );
      float ExDis = (GearList[i].rad) + rad;
      Boolean close1 = (Abs)< (ExDis +10); Boolean close2 = (ExDis -10) <(Abs); Boolean close3 = close1 && close2;
      pushStyle();
      if (close3){
        if ( AlreadyCoupled(ID, i) == false ){//If not already in arraylist
          coupled.add(GearList[i]);
        }
        stroke(100,255,100);
      }
      else{
        stroke(255,100,100);
      }
      strokeWeight(3);
      line(pos.x, pos.y, GearList[i].pos.x, GearList[i].pos.y);
      popStyle();
    }
  }
  
  void DetermineRotation(){
    for (int i=0;i<coupled.size();i+=1){ //Make coupled gears know whether cw or ccw rot
      float gearRatio = float(gearNum)/float(GearList[(coupled.get(i).ID)].gearNum);
      GearList[(coupled.get(i).ID)].RotVal = -RotVal*gearRatio;
    }
  }
  
}

Boolean AlreadyCoupled(int Identity, int ObservedIdentity){
  for (int i=0;i<GearList[Identity].coupled.size();i+=1){
    if (GearList[Identity].coupled.get(i).ID == ObservedIdentity){
      return true;
    }
  }
  return false;
}
