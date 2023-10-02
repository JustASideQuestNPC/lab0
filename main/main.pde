/* setup and draw functions */
void setup() {
  // create the window and set it to the correct size
  size(100, 100);
  windowResize(canvasWidth * pixelSize, canvasHeight * pixelSize);

  // initialize the canvas to draw pixels to
  pixelCanvas = createGraphics(canvasWidth, canvasHeight);

  // noSmooth() prevents images from becoming blurred when scaled up and makes them become pixelated instead
  noSmooth();

  // initialize the input handler
  inputs = new InputHandler();

  // load the config file from the data folder
  loadConfig(configPath);

  // set the target framerate
  frameRate(targetFramerate);

  // setup the fps tracker if it is enabled
  if (showFPSTracker) fpsTracker = new FPSTracker();

  // engine setup - this is for debugging and will be removed/replaced later
  clock = new GameClock();
  engine = new GameEngine();
  engine.player = engine.addEntity(new Player(98, 180));
  engine.addEntity(new Ufo(98, 15));
}

void draw() {
  // update the input handler
  inputs.update();

  // tick the clock
  dt = clock.tick();

  // update the fps tracker if it is enabled
  if (showFPSTracker) fpsTracker.update(dt);

  // update all loaded entities - the clock returns dt in milliseconds for extra precision, but 
  // game entities expect it in seconds
  engine.updateAll((float)dt / 1000);

  // remove entities that are no longer needed
  engine.garbageCollect();

  // draw pixelated things to the canvas
  pixelCanvas.beginDraw();
    // after beginDraw, drawing to a PGraphics object works exactly the same as drawing
    // to the normal window, except that everything starts with "[name]."
    pixelCanvas.background(black);

    // render all loaded entities
    engine.renderAll(pixelCanvas);

  pixelCanvas.endDraw();

  // PGraphics objects can be drawn to the screen in the same way as PImage objects
  image(pixelCanvas, 0, 0, width, height);

  // draw the framerate tracker over the upscaled image if it is enabled
  if (showFPSTracker) fpsTracker.display(0, 0, 1.5);
}