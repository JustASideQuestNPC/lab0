// NOTE: if you have a variable that's a constant (i.e. it will never be changed), it's convention to make it "static final"

/* canvas/graphics declarations */
static final int canvasWidth = 196;   // max drawable width
static final int canvasHeight = 196;  // max drawable height
static final int pixelSize = 4;       // how large each pixel is
PGraphics pixelCanvas;                // anything pixelated is drawn to this before being upscaled and drawn to the screen

// the color palette used in all sprites - this is the Sweetie 16 palette by Grafxkid (lospec.com/palette-list/sweetie-16)
color black, purple, red, orange, yellow, lime, green, teal, blue, lightBlue, darkBlue, cyan, white, gray, lightGray, darkGray, transparent;
color[] colorArray; // array containing all colors, can be used to loop through them

/* config vars - these are set from config.json during setup() */
String configPath = "../assets/config.json";  // the path to the .json file containing all settings and other data
int targetFramerate;                          // the program will attempt to run at this framerate
boolean showFPSTracker;                       // whether to display the actual framerate in the top left corner

/* debug stuff */
FPSTracker fpsTracker;

/* clock/engine stuff */
int dt; // time since the last update
GameClock clock = new GameClock();
GameEngine engine = new GameEngine();

/* entity data set from config.json */
JSONObject playerSpriteJson;