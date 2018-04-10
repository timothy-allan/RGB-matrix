import processing.serial.*;

Serial myPort;       

int numFrames = 570;  // The number of frames in the animation
int currentFrame = 0;
PImage[] images = new PImage[numFrames];

color r;    
color g;    
color b; 


/*
Each 'pixel' is made up of 3 RGB 'rects'
 */
int pixelsWide = 200;
int pixelsHigh = 113;
int rectsWide = pixelsWide * 3;// 14 TRIADS across /3 for R, G and B tiles
int pixelAcross, pixelDown;

void setup() {
  size(1920, 1080);
  frameRate(24);
  noStroke();
  colorMode(HSB, 100);

  printArray(Serial.list());

  myPort = new Serial(this, Serial.list()[7], 9600);


  for (int i = 0; i < numFrames; i++) {
    String imageName = "goldenWavesJPG_" + nf(i, 5) + ".png";
    images[i] = loadImage(imageName);
  }
} 

void draw() { 
  background(40);

  // do some maths for pixel and rect sizes

  int rectWidth = width/rectsWide;
  int rectHeight = height/pixelsHigh;
  int pixelWidth = (rectWidth * 3) + 2; // + 2 so we have a gap between 'pixels' - see also offset below
  
  int offsetAcross;
  int offsetDown;
  

  float colourMultiplier = 1.0;

  currentFrame = (currentFrame+1) % numFrames;  // Use % (modulo) to cycle through frames
  //image(images[(currentFrame)], 0, 0);


  for (pixelAcross = 0; pixelAcross < pixelsWide; pixelAcross++) {
    for (pixelDown = 0; pixelDown < pixelsHigh; pixelDown++) { 

      // offsets for each 'pixel' across & down
      offsetAcross = (pixelAcross * pixelWidth) + 3; // + 3 so we have a gap between 'pixels'
      offsetDown = (pixelDown * rectHeight) + 3; 

      // get RGB values from the loaded images
      r = int(red((images[(currentFrame)]).get(pixelAcross, pixelDown)));
      g = int(green((images[(currentFrame)]).get(pixelAcross, pixelDown)));
      b = int(blue((images[(currentFrame)]).get(pixelAcross, pixelDown)));



      //myPort.write(r);
      //myPort.write("'");

      //myPort.write(g);
      //myPort.write("'");

      //myPort.write(b);
      //myPort.write("'");

      //myPort.write('\n');



      // draw each rgb 'rect' -  1/3rd the width of a 'pixel'
      fill(255, 0, 0, r);
      rect(offsetAcross, offsetDown, rectWidth, rectHeight-2);

      fill(0, 255, 0, g);
      rect(offsetAcross + rectWidth, offsetDown, rectWidth, rectHeight-2);

      fill(0, 0, 255, b);
      rect(offsetAcross +  (rectWidth * 2), offsetDown, rectWidth, rectHeight-2);
    }
  }
}
