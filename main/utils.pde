/* this is just random utility stuff that didn't fit into any of the other
 * files. feel free to steal anything here for yourself :) */

/* random generators */
// returns a random integer between min (inclusive) and max(exclusive)
int randInt(int min, int max) {
  // casting to int automatically rounds floats down (and handles floats that
  // are too large to contain in an integer)
  return int(random(min, max));
}

// overload for randInt that returns a random integer between 0 (inclusive) and max (exclusive)
int randInt(int max) {
  return int(random(max));
}

// does a D&D-style check: rolls a random integer between 1 and sides,
// adds the modifier, and returns true if the result is >= the DC
boolean dcCheck(int sides, int dc, int modifier) {
  return (randInt(1, sides + 1) + modifier) >= dc;
}

// returns either true or false
boolean coinFlip() {
  return random(1) > 0.5;
}

/* converts json arrays into normal arrays of either int, float, string, or boolean */
int[] jsonToIntArray(JSONArray json) {
  int[] arr = new int[json.size()];
  for (int i = 0; i < arr.length; ++i) arr[i] = json.getInt(i);
  return arr;
}

float[] jsonToFloatArray(JSONArray json) {
  float[] arr = new float[json.size()];
  for (int i = 0; i < arr.length; ++i) arr[i] = json.getFloat(i);
  return arr;
}

String[] jsonToStringArray(JSONArray json) {
  String[] arr = new String[json.size()];
  for (int i = 0; i < arr.length; ++i) arr[i] = json.getString(i);
  return arr;
}

boolean[] jsonToBoolArray(JSONArray json) {
  boolean[] arr = new boolean[json.size()];
  for (int i = 0; i < arr.length; ++i) arr[i] = json.getBoolean(i);
  return arr;
}