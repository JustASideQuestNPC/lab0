/* globals */
static final int frameBufferSize = 60; // the number of frame times to average when finding the framerate
static final color fpsTrackerBackgroundColor = 0xc0000000; // slightly transparent black
static final color fpsTrackerTextColor = 0xffffffff; // white

/* fps tracker class */
public class FPSTracker {
  // holds the time since the last frame
  private int lastTimeDelta;
  // holds the frame times to average when finding the framerate
  private int[] frameTimes;
  // the index to store the next frame time in
  private int frameIndex = 0;

  // constructor
  FPSTracker() {
    // initialize the frame times array - items in an int array default to 0, so there's no need to set them
    frameTimes = new int[frameBufferSize];
  }

  // updates the frame tracker with the time since the last frame
  void update(int dt) {
    // update the time since the last frame and add it to the array
    lastTimeDelta = dt;
    frameTimes[frameIndex] = dt;
    // update the frame index - using the modulo operator (%) here makes the index wrap to the beginning of the array once it reaches the end
    frameIndex = (frameIndex + 1) % frameBufferSize;
  }

  // draws the tracker to the canvas. x and y are the top left corner
  void display(int x, int y, float scaleFactor) {
    // sum the values in the tracker and divide to find the average frame time
    float avgDelta = 0;
    for (int i : frameTimes) avgDelta += i;
    avgDelta /= frameBufferSize;

    // divide to find the estimated frame rate, then round down to get a number that isn't 20 digits long
    int estimatedFramerate = floor(1000 / avgDelta);

    // pushStyle and popStyle will reset all calls to fill(), stroke(), and similar style functions
    pushStyle();
      // pushMatrix and popMatrix do the same thing with calls to translate(), rotate() and scale()
      pushMatrix();
        translate(x, y);
        scale(scaleFactor);
        noStroke();
        fill(fpsTrackerBackgroundColor);
        rect(0, 0, 150, 30);
        fill(fpsTrackerTextColor);
        textAlign(LEFT, TOP);
        textSize(12);
        text("time since last frame: " + lastTimeDelta + "ms\nest. framerate: " + estimatedFramerate + "fps", 5, 2);
      popMatrix();
    popStyle();
  }

  // overload to make scaleFactor default to 1
  void display(int x, int y) { display(x, y, 1); }

}
