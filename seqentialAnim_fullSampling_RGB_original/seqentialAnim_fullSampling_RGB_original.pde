int numFrames = 119;  // The number of frames in the animation
int currentFrame = 0;
PImage[] images = new PImage[numFrames];

color r;    
color g;    
color b; 

/*
Each 'pixel' is made up of 3 RGB 'rects'
 */
int pixelsWide = 14;
int pixelsHigh = 22;
int rectsWide = pixelsWide * 3;// 14 TRIADS across /3 for R, G and B tiles
int pixelAcross, pixelDown;

void setup() {
  size(504, 792);
  //frameRate(24);
  noStroke();

  // If you don't want to load each image separately
  // and you know how many frames you have, you
  // can create the filenames as the program runs.
  // The nf() command does number formatting, which will
  // ensure that the number is (in this case) 5 digits.
  for (int i = 0; i < numFrames; i++) {
    String imageName = "quietForest_" + nf(i, 5) + ".png";
    images[i] = loadImage(imageName);
  }
} 

void draw() { 
  background(0);
  // do some maths for pixel and rect sizes

  int rectWidth = width/rectsWide;
  int rectHeight = height/pixelsHigh;
  int pixelWidth = (rectWidth * 3) + 2; // + 2 so we have a gap between 'pixels' - see also offset below
  
  int offsetAcross;
  int offsetDown;

  currentFrame = (currentFrame+1) % numFrames;  // Use %modulo to cycle through frames
  //image(images[(currentFrame)], 0, 0);



  for (pixelAcross = 0; pixelAcross < 14; pixelAcross++) {
    for (pixelDown = 0; pixelDown < 22; pixelDown++) { 

      // offsets for each 'pixel' across & down
      offsetAcross = (pixelAcross * pixelWidth) + 3; // + 3 so we have a gap between 'pixels'
      offsetDown = (pixelDown * rectHeight) + 3; 
      
      // get RGB values from the loaded images
      r = int(red((images[(currentFrame)]).get(pixelAcross, pixelDown)));
      g = int(green((images[(currentFrame)]).get(pixelAcross, pixelDown)));
      b = int(blue((images[(currentFrame)]).get(pixelAcross, pixelDown)));

      // draw rgb 'pixels'
      fill(r, 0, 0);
      rect(offsetAcross, offsetDown, rectWidth, rectHeight-2);
      println(currentFrame);

      fill(0, g, 0);
      rect(offsetAcross + rectWidth, offsetDown, rectWidth, rectHeight-2);


      fill(0, 0, b);
      rect(offsetAcross +  (rectWidth * 2), offsetDown, rectWidth, rectHeight-2);
    }
  }
}
