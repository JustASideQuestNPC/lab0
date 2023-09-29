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