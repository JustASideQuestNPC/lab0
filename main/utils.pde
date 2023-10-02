/* this is just random utility stuff that didn't fit into any of the other
 * files. feel free to steal anything here for yourself :) */

/* random integer generator - has two overloads for default parameters */
// returns a random integer between min (inclusive) and max(exclusive)
int randInt(int min, int max) {
  // casting to int automatically rounds floats down (and handles floats that
  // are too large to contain in an integer)
  return int(random(min, max));
}

// returns a random integer between 0 (inclusive) and max (exclusive)
int randInt(int max) {
  return int(random(max));
}

// does a D&D-style check: rolls a random integer between 1 and sides,
// adds the modifier, and returns true if the result is >= the DC
boolean dcCheck(int sides, int dc, int modifier) {
  return (randInt(1, sides + 1) + modifier) >= dc;
}