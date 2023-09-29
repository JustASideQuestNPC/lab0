/* variable definitions */
// if you have a variable that's a constant (i.e. it will never be changed),
// it's convention to make it "static final"
// size of the *canvas* - this is the size that can be drawn to
static final int canvasWidth = 128;
static final int canvasHeight = 128;

// how large each pixel is
static final int pixelSize = 6;

// anything pixelated is drawn to this before being upscaled and drawn to the screen
PGraphics pixelCanvas;

// all this gets loaded from data/config.json during setup()
int targetFramerate;    // the program will attempt to run at this framerate. set to -1 to uncap
boolean showFPSTracker; // whether to display the actual framerate in the top left corner

// the color palette for drawing things that aren't an image. for this lab, i'm using the
// Sweetie 16 palette by Grafxkid (lospec.com/palette-list/sweetie-16)
color black, purple, red, orange, yellow, lime, green, teal, blue, lightBlue, darkBlue,
  cyan, white, gray, lightGray, darkGray, transparent;

color[] colorArray; // array containing all colors, can be used to loop through them

// stuff for debugging
FPSTracker fpsTracker;

/* main program loop */
void setup() {
  // create the window and set it to the correct size
  size(100, 100);
  windowResize(canvasWidth * pixelSize, canvasHeight * pixelSize);

  // initialize the canvas to draw pixels to
  pixelCanvas = createGraphics(canvasWidth, canvasHeight);

  // noSmooth() prevents images from becoming blurred when scaled up and makes them
  // become pixelated instead
  noSmooth();

  // load the config file from the data folder
  loadConfig("../assets/config.json");

  // set the target framerate
  frameRate(targetFramerate);

  // setup the fps tracker if it is enabled
  if (showFPSTracker) fpsTracker = new FPSTracker();
}

int t = 0;
void draw() {
  // update the fps tracker if it is enabled
  if (showFPSTracker) fpsTracker.update();

  // draw pixelated things to the canvas
  pixelCanvas.beginDraw();
    // after beginDraw, drawing to a PGraphics object works exactly the same as drawing
    // to the normal window, except that everything starts with "[name]."
    pixelCanvas.background(white);

    pixelCanvas.pushMatrix();
    pixelCanvas.translate(canvasWidth / 2, canvasHeight / 2);
    pixelCanvas.rotate(atan2(mouseY - height / 2, mouseX - width / 2));

    pixelCanvas.noStroke();
    pixelCanvas.fill(orange);
    pixelCanvas.rect(-24, -24, 48, 48);

    pixelCanvas.popMatrix();

  pixelCanvas.endDraw();

  // PGraphics objects can be drawn to the screen in the same way as PImage objects
  image(pixelCanvas, 0, 0, width, height);

  // draw the framerate tracker over the upscaled image if it is enabled
  if (showFPSTracker) fpsTracker.display(0, 0, 1.5);

  // ++t is functionally identical to t++, but ++t is *slightly* faster. granted, the
  // difference is so small that it'll never matter, but i'm also a perfectionist.
  ++t;
}

/* config loading */
void loadConfig(String path) {
  println("loading config from " + path);

  // load the entire config file into a variable
  JSONObject config = loadJSONObject(path);
  
  // load graphics config
  targetFramerate = config.getInt("target framerate");

  // load debug toggles
  showFPSTracker = config.getBoolean("show fps");

  // load color palette
  JSONObject palette = config.getJSONObject("sweetie 16 palette");
  
  // .json doesn't support using 0x for hex numbers, so they have to be
  // stored as strings and then converted back when loaded
  black = unhex(palette.getString("black"));
  purple = unhex(palette.getString("purple"));
  red = unhex(palette.getString("red"));
  orange = unhex(palette.getString("orange"));
  yellow = unhex(palette.getString("yellow"));
  lime = unhex(palette.getString("lime"));
  green = unhex(palette.getString("green"));
  teal = unhex(palette.getString("teal"));
  blue = unhex(palette.getString("blue"));
  lightBlue = unhex(palette.getString("light blue"));
  darkBlue = unhex(palette.getString("dark blue"));
  cyan = unhex(palette.getString("cyan"));
  white = unhex(palette.getString("white"));
  gray = unhex(palette.getString("gray"));
  lightGray = unhex(palette.getString("light gray"));
  darkGray = unhex(palette.getString("dark gray"));
  // the transparent color isn't part of the the palette, but it's nice to
  // have it stored somewhere
  transparent = 0x00ffffff;

  // add all colors into the color array
  colorArray = new color[]{ black, purple, red, orange, yellow, lime, green, teal,
    blue, lightBlue, darkBlue, cyan, white, gray, lightGray, darkGray, transparent };

  println("config loaded successfully!");
}