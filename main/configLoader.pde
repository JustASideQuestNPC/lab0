/* loads the data from config.json into assorted variables */
void loadConfig(String path) {
  println("loading config from " + path);

  // load the entire config file into a variable
  JSONObject config = loadJSONObject(path);
  
  // load graphics config
  targetFramerate = config.getInt("target framerate");

  // load debug toggles
  showFPSTracker = config.getBoolean("show fps");

  // load color palette
  JSONObject palette = config.getJSONObject("color palette");
  
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

  // set up inputs
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

    // do some questionable stuff to turn the set of keys - which are stored
    // in the JSON as an array of strings - into a *real* array of strings
    JSONArray controlKeysRaw = controlBind.getJSONArray("keys");
    String[] controlKeys = new String[controlKeysRaw.size()];
    for (int j = 0; j < controlKeys.length; ++j) controlKeys[j] = controlKeysRaw.getString(j);

    inputs.addInput(controlName, controlKeys, controlMode);
  }

  // load entity data
  JSONObject entityJson = config.getJSONObject("entities");
  playerJson = entityJson.getJSONObject("player");
  missileJson = entityJson.getJSONObject("missile");
  spiralLaserJson = entityJson.getJSONObject("spiral laser");

  println("config loaded successfully!");
}