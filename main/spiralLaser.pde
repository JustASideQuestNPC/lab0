/* spiral laser class */
class SpiralLaser extends EntitySuper {
  private float moveSpeed;
  private int lastPos;

  // constructor
  SpiralLaser(float x, float y) {
    // call the parent constructor to set position, load the sprite, and create the tag list
    super(spiralLaserJson, x, y, new EntityTag[]{EntityTag.SPIRAL_LASER});

    // load other data
    moveSpeed = spiralLaserJson.getFloat("movement speed");
    lastPos = int(y);

    // set display layer
    displayLayer = -2;
  }

  // called every frame to update position, hitboxes, etc.
  void update(float dt) {
    // move the laser toward the top of the screen
    position.y += moveSpeed * dt;

    // lasers advance their animation based on their position - the animation moves forward one
    // frame each time the laser moves forward one pixel
    if (int(position.y) - lastPos != 0) {
      sprite.advanceFrame(int(position.y) - lastPos);
      lastPos = int(position.y);
    }

    // destroy the laser if it moves all the way off the screen
    if (position.x < -halfWidth || position.x > canvasWidth + halfWidth || position.y < -halfHeight || position.y > canvasHeight + halfHeight) {
      deleteMe = true;
      return;
    };

    // update hitbox position
    hitbox.x = position.x + hboxOffsetX;
    hitbox.y = position.y + hboxOffsetY;
  }
}