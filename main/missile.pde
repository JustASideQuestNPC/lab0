/* missile class */
public class Missile extends EntitySuper {
  private float moveSpeed;

  // constructor
  Missile(float x, float y) {
    // call the parent constructor to set position, load the sprite, and create the tag list
    super(missileJson.getJSONObject("sprite"), x, y, new EntityTag[]{ EntityTag.MISSILE });

    // load other data
    moveSpeed = missileJson.getFloat("movement speed");

    // set display layer
    displayLayer = -1;
  }

  // called every frame to update position, hitboxes, etc.
  void update(float dt) {
    // update sprite animation
    sprite.update(dt);

    // move the missile toward the top of the screen
    position.y -= moveSpeed * dt;

    // destroy the missile if it moves all the way off the screen
    if (position.x < -halfWidth || position.x > canvasWidth + halfWidth ||
      position.y < -halfHeight || position.y > canvasHeight + halfHeight) deleteMe = true;
  }
}