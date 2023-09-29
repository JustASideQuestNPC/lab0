/* animated sprite class - holds multiple PImages and swaps between them to do some simple animations */
class AnimatedSprite {
  private PImage spriteSheet;
  private PImage[] frames;
  private int currentFrame, numFrames, frameWidth, frameHeight;
  private float framesPerSecond, secondsPerFrame, frameTime; // used for timing

  // positive values play the animation normally, negative values play it in reverse, and 0 pauses it.
  // setting it to < -1 or > 1 produces undefined behavior (in other words, I have no idea what will
  // happen, but it probably won't be good).
  public int playDirection;

  // constructor, takes a JSONObject with all the sprite data (can you tell I like using .json yet?)
  AnimatedSprite(JSONObject json) {
    // load metadata
    numFrames = json.getInt("frames");
    frameWidth = json.getInt("frame width");
    frameHeight = json.getInt("frame height");
    
    setFrameRate(json.getFloat("frame rate"));

    // load the sprite sheet
    spriteSheet = loadImage(json.getString("sprite sheet"));

    // initialize the frames array with the correct number of frames
    frames = new PImage[numFrames];

    // split the sprite sheet into the individual frames
    for (int i = 0; i < numFrames; ++i) {
      frames[i] = spriteSheet.get(i * frameWidth, 0, frameWidth, frameHeight);
    }

    // start at the first frame
    currentFrame = 0;
    // frameTime is the time spent displaying the current frame
    frameTime = 0;
    // start out playing forward
    playDirection = 1;
  }

  // updates the animation with the current time delta *in seconds* and changes to the next frame if needed
  void update(float dt) {
    frameTime += dt;
    if (frameTime >= secondsPerFrame) {
      frameTime = 0;
      // adding the number of frames to this seems unnecessary, but it's required when the animation is
      // playing backwards to prevent currentFrame from becoming negative and crashing the program
      currentFrame = (currentFrame + playDirection + numFrames) % numFrames;
    }
  }

  // draws the current frame to the canvas at the current position. optionally takes width and height
  // arguments, as well as a PGraphics object for drawing somewhere other than the main canvas
  // NOTE: canvas.beginDraw() MUST have been called before this is called!!
  void render(float x, float y, float w, float h, PGraphics canvas) {
    canvas.pushStyle();
      canvas.imageMode(CORNER);
      canvas.image(frames[currentFrame], x, y, w, h);
    canvas.popStyle();
  }

  // overloads for default parameters and such
  void render(float x, float y, PGraphics canvas) {
    render(x, y, frameWidth, frameHeight, canvas);
  }
  void render(float x, float y, float w, float h) {
    // the main canvas is actually just another PGraphics object, but it doesn't require a classname to
    // use in most cases. if you want to use the classname (for example, if you want to use it in a
    // function that *does* use the classname), it's equal to "g". Kinda confusing, tbh.
    render(x, y, w, h, g);
  }
  void render(float x, float y) {
    render(x, y, frameWidth, frameHeight, g);
  }

  // sets the play speed in frames per second. setting it to 0 will cause the animation to change frames
  // every time update() is called
  void setFrameRate(float fps) {
    framesPerSecond = fps;
    // ternary to prevent a divide by 0 when the framerate is set to 0
    secondsPerFrame = (fps != 0 ? 1 / fps : 0);
  }

  // multiplies the current play speed by a scalar - a scalar of 2 will double the speed, and
  // a scalar of 0.5 will halve it. a scalar of 0 has the same effect as setting the frame rate
  // to 0, and a negative scalar will swap the play direction
  void ScaleFrameRate(float scalar) {
    if (scalar < 0) {
      scalar *= -1;
      playDirection *= -1;
    }
    setFrameRate(framesPerSecond * scalar);
  }

  // sets the animation to a specific frame. does not check whether the frame at that index exists!
  void setFrame(int f) {
    currentFrame = f;
  }

  // moves the animation forward (relative to the play direction) by so many frames (to move backward,
  // use a negative number). will wrap to the beginning/end of the animation if needed
  void advanceFrame(int f) {
    currentFrame = (currentFrame + (f *playDirection) + numFrames) % numFrames;
  }
}