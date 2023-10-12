 /* Variable declaration for pretty much anything that will get set when loading the config
  * NOTE: if you have a variable that's a constant (i.e. it will never be changed),
  * it's convention to make it "static final" */

/* canvas */
int canvasWidth;        // max drawable width
int canvasHeight;       // max drawable height
int pixelSize;          // how large each pixel is
PGraphics pixelCanvas;  // anything pixelated is drawn to this before being upscaled and drawn to the screen

/* graphics */
// the color palette used in all sprites - i'm using the Sweetie 16 palette by Grafxkid (lospec.com/palette-list/sweetie-16) for this lab
color black, purple, red, orange, yellow, lime, green, teal, blue, lightBlue, darkBlue, cyan, white, gray, lightGray, darkGray, transparent;
// speedline configs
int[] speedlineLengths, speedlineSpeeds, speedlinesPerLayer;
PFont font;

/* config vars - these are set from config.json during setup() */
String configPath = "../assets/config.json";  // the path to the .json file containing settings and other data
int targetFramerate;

/* debug stuff */
boolean showFPSTracker;
FPSTracker fpsTracker;
boolean showHitboxes;
boolean noSpeedlines;

/* clock/engine stuff */
float dt; // time since the last update in milliseconds
GameClock clock;
GameEngine engine;
Player player; // used mainly for drawing the hud, also referenced by other entitites
GameState gameState;
int playerScore;

/* entity data set from config.json */
JSONObject gameplayJson;
JSONObject playerJson;
JSONObject missileJson;
JSONObject spiralLaserJson;
JSONObject ufoJson;
JSONObject diverJson;

/* input stuff */
InputHandler inputs;

/* hud stuff */
PImage hpBarBackground, hpBarSegment;
AnimatedSprite hpBarCaution;