// imports audio files and uploads the images

import processing.sound.*;
SoundFile Rocket;
SoundFile explosion;
PImage spaceship;
  
ArrayList<Particle> particles;
ArrayList<Explosion> fireworks;


int timer; // used to release new particle into the air
color randomCol; // selects a random index from the colours array 
float ballWidth; 

color [] colours = { // array to store favourite colours of fireworks
     color(255,0,0), // red
     color(255,128,0), // orange 
     color(255,255,0), // yellow
     color(0,255,255), // turquoise
     color(0,128,255), // blue
     color(0,0,255), // dark blue
     color(153,51,255), // purple
     color(255,0,255), // pink
     color(255,0,127), // magenta
};

 //used to make the circular shape of the firework
 float rotation;
 float Z;
 
 float numFireworks;
 float alphaCounter;

void setup(){
  fullScreen(P2D);
 
  particles = new ArrayList<Particle>();
  fireworks = new ArrayList<Explosion>();
  background(0); 
 
  spaceship = loadImage("C:\\Users\\MOHIT\\Desktop\\spaceship.png");  
  Rocket = new SoundFile(this, "C:\\Users\\MOHIT\\Desktop\\Rocket.wav");
  explosion = new SoundFile(this, "C:\\Users\\MOHIT\\Desktop\\FireworkExplode.wav");

  Rocket.amp(0.025); // used to set volume of audio file
  explosion.amp(0.08); // used to set volume of audio file

  numFireworks = random(500,1000); // stores random number of firework objects 
  alphaCounter = random(5,10);
}

void draw(){
  
  image(spaceship, mouseX -50 , mouseY -50  , 100,100); // sets position of image to exact mouse location
  
  
  ballWidth = random(3,15); // different sizes of fireworks
  randomCol = colours[(int)random(0,colours.length)]; // different colours of fireworks
  
  // used to obtain trailing effect
  fill(0,30) ; 
  rect(0,0, width, height);  
 
 
 // releases new firework every second
   if (millis() - timer >= 1000){
     particles.add(new Particle(random(width),height, random(2,5)) ); // obtained from Particle class
     timer = millis(); // resets timer for next duration 
 
   }
   
 //declares new explosion object and calls methods to display and move the fireworks 
   setFirework();

// decalres new particle object 
  for( int i = 0; i < particles.size() - 1; i ++){
    Particle p = particles.get(i);
    p.show();
    p.update();
    
    
    // checks to see if particle has disappeared
    if (p.isDead()){
       particles.remove(i);
           explosion.play();

    //creates the firework objects based on the locations of the particle before it disappears
       for(int j = 0; j < numFireworks; j++){ //this adds multiple balls to the list
       
       //full circle
         rotation= random(0, 2*PI);
          Z = random(0, 3);
         
          if (frameCount % 2 == 0){          //releases normal of fireworks based on framecount
             fireworks.add(new Explosion(p.x,p.y,  Z*sin(rotation), Z*cos(rotation),  ballWidth, randomCol, alphaCounter) );
             fireworks.add(new Explosion(p.x ,p.y,  Z*sin(rotation), Z*cos(rotation), ballWidth/2, randomCol + 1, alphaCounter)) ; // adds a second colour in between
             
             
          } else if (frameCount % 3 == 0){          // releases 2 new shapes of fireworks    
             fireworks.add(new Explosion(p.x,p.y,  random(5, -5),  random(5, -5),  ballWidth, randomCol, alphaCounter) ); // shoots firework to the bottom right corner
             fireworks.add(new Explosion(p.x,p.y,  random(-5, -5),  random(-5, -5),  ballWidth, randomCol, alphaCounter) ); // shoots firework to the top left corner
             fireworks.add(new Explosion(p.x,p.y,  5,  -5,  ballWidth, randomCol, alphaCounter) ); // shoots firework to top right corner
             fireworks.add(new Explosion(p.x,p.y,  -5,  5,  ballWidth, randomCol, alphaCounter) ); // shoots firework to bottom left corner
             fireworks.add(new Explosion(p.x,p.y,  random(-4,4),  random(-4,4),  ballWidth, randomCol, alphaCounter) ); // creates firework in between in rectangular shape
             
          } else { // creates new shape with a circular ring engulfed within a normal firework pattern
               fireworks.add(new Explosion(p.x,p.y,  Z*sin(rotation), Z*cos(rotation),  ballWidth, randomCol, alphaCounter) );
               fireworks.add(new Explosion(p.x,p.y,  sin(rotation), cos(rotation),  ballWidth, randomCol, alphaCounter) ); // circular ring pattern
          }
       }
    }
  }

  starBackgroundPattern(); 
}

void starBackgroundPattern(){ // adds shapes to the background to make it seem like a starry night
  float starWidth = random(3,6); 
  
  fill(0,10);
  rect(0,0, width, height);
  
  fill(255);
  noStroke();
  ellipse(random(width), random(height), starWidth, starWidth);
}


void setFirework(){  //declares new explosion object and calls methods to display and move the fireworks 

  for(int i = 0; i < fireworks.size(); i++){
      Explosion b = fireworks.get(i); //set the ball from the list to the variable b
      b.displayFirework();
      b.move();
      
    if(b.removeList()){ // checks if the firework can be removed from the list
        fireworks.remove(i);
       }
  }
}






 
