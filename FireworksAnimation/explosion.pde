 // Class to display the actual firework in the air


class Explosion {

  float x; // x position of firework
  float y; // y position of firework
  float a; //alpha (transparency)
  float w; //width of the ball
  float mx; //movement amount x direction
  float my; // movement amount y direction
  float g; // gravity applied to fireworks
  color c; // colour of firework
  float aCounter; // transparency 
 

//constructor method to set the default properties of the variables declared
Explosion(float tempX, float tempY, float moveX, float moveY, float tempW, color tempC, float aC) {
  x = tempX;
  y = tempY;
  w = tempW;
  a = 255;
  mx = moveX;
  my = moveY;
  g = 0.1;
  c = tempC;
  aCounter = aC;
}



  void move() {
    x+= mx; // moves the firewors outwards according to x and y movement
    y+= my;
    my += g; // adds gravity to y movement
    a-= aCounter; // decreases alpha value by the associated aCounter value
   }

  Boolean removeList(){
    //if the ball is totally transparent remove from the list
    if(a > 0){
      return false;
    } else {
      return true;
    }
 }

    
   
   void displayFirework(){ // sets random blinking pattern to fireworks and sets their colour + size
       a = random(1,255);
       fill(c, a);
       noStroke();
       ellipse(x, y, w, w);
   }  
 }
