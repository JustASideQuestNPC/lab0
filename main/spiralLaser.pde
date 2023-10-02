/* spiral laser class */
class SpiralLaser extends EntitySuper {
  private float moveSpeed;

  // constructor
  SpiralLaser(float x, float y) {
    // call the parent constructor to set position, load the sprite, and create the tag list
    super(spiralLaserJson.getJSONObject("sprite"), x, y, new EntityTag[]{ EntityTag.SPIRAL_LASER });

    // load other data
    moveSpeed = spiralLaserJson.getFloat("movement speed");

    // set display layer
    displayLayer = -2;
  }

  // called every frame to update position, hitboxes, etc.
  void update(float dt) {
    // update sprite animation
    sprite.update(dt);

    // move the laser toward the top of the screen
    position.y += moveSpeed * dt;

    // destroy the laser if it moves all the way off the screen
    if (position.x < -halfWidth || position.x > canvasWidth + halfWidth ||
      position.y < -halfHeight || position.y > canvasHeight + halfHeight) deleteMe = true;
  }
}