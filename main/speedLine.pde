/* a small particle class to make graphics a bit cooler */
class Speedline extends EntitySuper {
  private int length, speed, layer;
  private color lineColor;

  // constructor
  Speedline(int l, int s) {
    // Speedlines don't have an associated json config, but the parent constructor will
    // skip loading anything from it if it's null
    super(null, random(5, canvasWidth - 5), random(canvasHeight), new EntityTag[]{EntityTag.PARTICLE});

    // set other data
    length = l;
    speed = s;
    lineColor = coinFlip() ? gray : coinFlip() ? lightGray : darkGray;
    displayLayer = -3;
  }

  // updates position and wraps back to the top of the screen
  void update(float dt) {
    position.y += speed * dt;

    // speedlines are drawn with the bottom of the line at their position
    if (position.y >= canvasHeight + length) {
      // wrap back to the top at a random horizontal position
      position.set(random(5, canvasWidth - 5), random(-50, 0));
      // set a random color
      lineColor = coinFlip() ? gray : coinFlip() ? lightGray : darkGray;
    }
  }

  // @Override isn't required here - this will compile and run just fine without it - but
  // it's a good way to indicate that Speedline's render method replaces ("overrides") the
  // render method from its parent class (the reason the update methods don't have this is
  // because update is abstract and isn't defined in the parent class, so it will always
  // be an override).
  @Override void render(PGraphics canvas) {
    canvas.stroke(lineColor);

    canvas.strokeWeight(1);
    canvas.line(position.x, position.y - length, position.x, position.y);
  }
}