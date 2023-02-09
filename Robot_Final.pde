PShape base, shoulder, upArm, loArm, end;
float rotX, rotY;

float upArm_x = 0;
float frArm_x = 0;
float enArm_x = 0;
float shoulder_y = 0;
float sphere_x = random(-75, 69);
float sphere_y = random(-75, 69);
float sphere_z = random(-75, 69);

float sx=0; 
float sy=0;
float sz=-50;


void setup(){
  
    size(1200, 800, P3D);
    
    base = loadShape("r5.obj");
    shoulder = loadShape("r1.obj");
    upArm = loadShape("r2.obj");
    loArm = loadShape("r3.obj");
    end = loadShape("r4.obj");
    
    shoulder.disableStyle();
    upArm.disableStyle();
    loArm.disableStyle(); 
}

void draw(){ 
  
  /*　可動域が自由だと表示バグが起きる
  if(keyPressed){
    if(key == CODED){
      if(keyCode == RIGHT){
        shoulder_y += 0.01;
      }
      if(keyCode == LEFT){
        shoulder_y -= 0.01;
      }
    }
    //upperArm
    if((key == 'q') || (key == 'Q')){
      upArm_x += 0.01;
    }
    if((key == 'w') || (key == 'W')){
      upArm_x -= 0.01;
    }
    //frontArm
    if((key == 'a') || (key == 'A')){
      frArm_x += 0.01;
    }
    if((key == 's') || (key == 'S')){
      frArm_x -= 0.01;
    }
    //endParts
    if((key == 'z') || (key == 'Z')){
      enArm_x = enArm_x+0.03;
    }
    if((key == 'x') || (key == 'X')){
      enArm_x = enArm_x-0.03;
    }
    
  }*/

   background(220);
   smooth();
   lights();
   writePos();
   
   fill(#FFE308); 
   noStroke();
   
   translate(width/2,height/2);
   rotateX(rotX);
   rotateY(-rotY); 
   scale(3.5);
   
   pushMatrix();
   
   translate(0,-40,0); //土台の位置   
     shape(base);
     
   translate(0, 4, 0); //肩の位置
   rotateY(shoulder_y); 
     shape(shoulder);
      
   translate(0, 25, 0); //上腕の位置
   rotateY(PI);
   rotateX(upArm_x);
   //print(upArm_x);
     shape(upArm);
      
   translate(0, 0, 50); //前腕の位置
   rotateY(PI);
   rotateX(frArm_x);
     shape(loArm);
     
   
   translate(sx, sy, sz); //先端部品の位置
   //rotateY(PI);
   rotateX(enArm_x);
     shape(end);
     
   
   
   popMatrix();
   
   translate(sphere_x, sphere_y, sphere_z);
   sphere(10);
   /*　ターゲットに当たると色が変わるようにしたかったが、うまく行かず断念
   println(sphere_x - sx);
   println(sphere_y - sy);
   println(sphere_z - sz);
   
   if ((sphere_y - sy < 20) && (sphere_y - sy > -20)){
   fill(255, 0, 0);
   sphere(10);
   } else {
   fill(255, 255, 255);
   sphere(10);
   } */
}



void mouseDragged(){
    rotY -= (mouseX - pmouseX) * 0.01;
    rotX -= (mouseY - pmouseY) * 0.01;
}

float strictValue(float target_v,float min_v,float max_v){
  float temp;
  temp = min(target_v,max_v);
  temp = max(temp,min_v);
  
  return temp;
}

//if arg >= -1.5
float linerValueLeft(float arg){
  /*
  float temp;
  arg = max(-1.5,arg);
  float d = arg - (-1.5);
  temp = -2.7 + (arg / d) * 1.25;
  return temp;
  */
  float temp;
  arg = min(-1.5,arg);
  temp = (1.25/1.95)*arg+2.7+(1.25/1.75)*1.5;
  return temp;
}

//if arg >= -1.5
float linerValueRight(float arg){
  /*
  float temp;
  arg = min(-1.5,arg);
  float d = arg - (-3.45);
  temp = 1.45 + (arg / d) * 1.25;
  */
  float temp;
  arg = max(-1.5,arg);
  temp = (1.25/1.95)*arg-2.7+(1.25/1.75)*1.5;
  return temp;
}


void writePos(){
  if(keyPressed){
    //print(upArm_x + " | ");
    
    if(key == CODED){
      if(keyCode == RIGHT){
        shoulder_y += 0.01;
      }
      if(keyCode == LEFT){
        shoulder_y -= 0.01;
      }
    }
    
    //upperArm
    if((key == 'q') || (key == 'Q')){
      upArm_x = min(upArm_x+0.01,0.45) ;
      frArm_x = strictValue(frArm_x,linerValueRight(upArm_x),linerValueLeft(upArm_x));
    }
    if((key == 'w') || (key == 'W')){
      upArm_x = max(upArm_x-0.01,-3.40) ;
      frArm_x = strictValue(frArm_x,linerValueRight(upArm_x),linerValueLeft(upArm_x));
    }
    
    //frontArm
    if((key == 'a') || (key == 'A')){
      //frArm_x = min(frArm_x+0.01,0.45) ;
      frArm_x += 0.01;
      frArm_x = strictValue(frArm_x,linerValueRight(upArm_x),linerValueLeft(upArm_x));
      print(frArm_x);
    }
    if((key == 's') || (key == 'S')){
      //frArm_x = max(frArm_x-0.01,-3-0.45) ;
      frArm_x -= 0.01;
      frArm_x = strictValue(frArm_x,linerValueRight(upArm_x),linerValueLeft(upArm_x));
      print(frArm_x);
    }
    
    //endParts
    if((key == 'z') || (key == 'Z')){
      enArm_x = enArm_x+0.03;
    }
    if((key == 'x') || (key == 'X')){
      enArm_x = enArm_x-0.03;
    }
    
  }
}
