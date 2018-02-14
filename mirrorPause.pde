// Freezy Mirror
// Much of this is from the example code here: https://processing.org/reference/libraries/video/Capture.html


import processing.video.*;

Capture cam;

float screenAspect = 0;
float scale = 1;

float lowestDifference = 0;
float highestDifference = 0;
float currentDifference = 0;
PImage previous;

String mode = "mirror";

void setup() {
  //size(640, 480);
  fullScreen();

  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }

    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[0]);
    cam.start();

    while (!cam.available()) {
      delay(100);
    } 
    cam.read();
    previous = cam;
  }

  screenAspect = width / float(height);
}

float imageAspect(PImage img) {
  float aspect = img.width / float( img.height );
  return aspect;
}

void imageFillScreen(PImage img) {
  if (imageAspect(img) < screenAspect) {
    // image wider than screen
    scale = width / float(img.width);
  } else {
    // image narrower than screen
    scale = height / float( img.height );
  }
  image(img, width/2, height/2, (img.width * scale), (img.height * scale) );
}


void draw() {
  if (cam.available() == true) {
    //// how different is this frame from the last one?
    //image(cam, 0, 0);
    //blend(previous, 0, 0, previous.width, previous.height, 0, 0, previous.width, previous.height, DIFFERENCE);
    //previous = get(0, 0, previous.width, previous.height);
    //previous.resize(1, 1);
    ////println( brightness(previous.get(0, 0)) );
    //currentDifference = brightness(previous.get(0, 0));
    //if ((currentDifference - lowestDifference) <= (( highestDifference - lowestDifference ) * 0.25 ) ) {
    //  mode = "freeze";
    //} else { 
    //  mode = "mirror";
    //}
    //println(lowestDifference, currentDifference, highestDifference);
    //if (currentDifference > highestDifference) {
    //  highestDifference = currentDifference;
    //} 
    //if (currentDifference < lowestDifference) {
    //  lowestDifference = currentDifference;
    //}

    if ( mode == "freeze") {
      delay(2000);
      mode = "mirror";
    } else if ( mode == "mirror" ) {
      imageMode(CENTER);
      // flop
      scale(-1, 1);
      translate(-width, 0);
      cam.read();
      imageFillScreen(cam);
    }
    // The following does the same, and is faster when just drawing the image
    // without any additional resizing, transformations, or tint.
    //set(0, 0, cam);


    if ((second() % 5) == 0) {
      mode = "freeze";
    } else {
    mode = "mirror";
    }
  }
}