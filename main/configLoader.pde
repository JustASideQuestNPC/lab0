/* loads the data from config.json into assorted variables */
void loadConfig(String path) {
  println("loading config from " + path);
  float startTime = millis();

  // load the entire config file into a variable
  JSONObject config = loadJSONObject(path);
  
  // load graphics config and hud images
  print("loading graphics config...");
  JSONObject graphics = config.getJSONObject("graphics");

  // load speedline configs
  speedlineLengths = jsonToIntArray(graphics.getJSONArray("speedline lengths"));
  speedlineSpeeds = jsonToIntArray(graphics.getJSONArray("speedline speeds"));
  speedlinesPerLayer = jsonToIntArray(graphics.getJSONArray("speedlines per layer"));

  // load hud assets
  hpBarBackground = loadImage("../assets/sprites/healthbar-background.png");
  hpBarSegment = loadImage("../assets/sprites/healthbar-segment.png");
  hpBarCaution = new AnimatedSprite(config.getJSONObject("healthbar caution sprite"));
  
  // load font
  font = loadFont("../assets/monogram-extended-48.vlw");

  // load misc data
  targetFramerate = graphics.getInt("target framerate");

  println("complete");

  // load debug toggles
  print("loading debug toggles...");
  JSONObject debug = config.getJSONObject("debug");
  showFPSTracker = debug.getBoolean("show fps");
  showHitboxes = debug.getBoolean("show hitboxes");
  noSpeedlines = debug.getBoolean("disable speedlines");
  

  // load color palette
  print("loading colors...");
  JSONObject palette = config.getJSONObject("color palette");
  
  // json doesn't support using 0x for hex numbers, so they have to be
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
  println("complete");

  // set up inputs
  print("loading input bindings...");
  JSONArray controlBinds = config.getJSONArray("controls");
  for (int i = 0; i < controlBinds.size(); ++i) {
    // load bind json and name
    JSONObject controlBind = controlBinds.getJSONObject(i);
    String controlName = controlBind.getString("name");

    // convert activation mode from a string to the correct int
    int controlMode = 0;
    switch(controlBind.getString("mode")) {
      case "continuous":
        controlMode = CONTINUOUS;
        break;
      case "press only":
        controlMode = PRESS_ONLY;
        break;
      case "release only":
        controlMode = RELEASE_ONLY;
        break;
    }

    // convert keys from a JSONArray of strings to a real array of strings
    String[] controlKeys = jsonToStringArray(controlBind.getJSONArray("keys"));

    inputs.addInput(controlName, controlKeys, controlMode);
  }
  println("complete");

  // load entity data
  print("loading entity data...");
  gameplayJson = config.getJSONObject("gameplay");
  JSONObject entityJson = config.getJSONObject("entities");
  playerJson = entityJson.getJSONObject("player");
  missileJson = entityJson.getJSONObject("missile");
  spiralLaserJson = entityJson.getJSONObject("spiral laser");
  ufoJson = entityJson.getJSONObject("ufo");
  diverJson = entityJson.getJSONObject("diver");
  println("complete");

  println("config loaded successfully in " + (millis() - startTime) + "ms");
}