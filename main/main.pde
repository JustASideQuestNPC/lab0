/* setup and draw functions */
void setup() {
  // create the window and set it to the correct size
  size(100, 100);
  windowResize(canvasWidth * pixelSize, canvasHeight * pixelSize);

  // initialize the canvas to draw pixels to
  pixelCanvas = createGraphics(canvasWidth, canvasHeight);

  // noSmooth() prevents images from becoming blurred when scaled up and makes them become pixelated instead
  noSmooth();

  // load the config file from the data folder
  loadConfig(configPath);

  // set the target framerate
  frameRate(targetFramerate);

  // setup the fps tracker if it is enabled
  if (showFPSTracker) fpsTracker = new FPSTracker();
}

void draw() {
  dt = clock.tick();

  // update the fps tracker if it is enabled
  if (showFPSTracker) fpsTracker.update(dt);

  // draw pixelated things to the canvas
  pixelCanvas.beginDraw();
    // after beginDraw, drawing to a PGraphics object works exactly the same as drawing
    // to the normal window, except that everything starts with "[name]."
    pixelCanvas.background(black);

    // draw everything in the engine to the canvas
    engine.renderAll();

  pixelCanvas.endDraw();

  // PGraphics objects can be drawn to the screen in the same way as PImage objects
  image(pixelCanvas, 0, 0, width, height);

  // draw the framerate tracker over the upscaled image if it is enabled
  if (showFPSTracker) fpsTracker.display(0, 0, 1.5);
}