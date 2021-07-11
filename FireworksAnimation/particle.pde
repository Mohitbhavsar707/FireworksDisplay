// class for the particle that shoots into the air (before the firework occurs)

class Particle{
 float x; // x position
 float y; // y position
 float speed; 
 float lifespan;  
 color colour;  // personal preference
 float particleWidth;
 
  // sets default values to variables
 Particle(float posX, float posY, float sp){
   x = posX;
   y = posY;
   speed = sp;
   lifespan = 255;
   particleWidth = 12;
   colour  = color(255, 226, 3) ;
   Rocket.play(); // plays the audio file as the particle goes upwards
 
 }
 
    
 void update(){
  float randomX = random(-2,2); // changes the x position continously
  x -= randomX; // creates a squiggly pattern when going upwards
  y -= speed; // moves upwards
  lifespan -= random(0,5);    // decreases transparency randomly - allows a random duration of the particle
  
 }
 

 

 
 void show(){ // displays the particle
   fill(colour, lifespan); // personal preference for colour
   ellipse(x, y, particleWidth, particleWidth);
 }
 
 
 boolean isDead() { // checks to see if particle is still visible
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
 
}
