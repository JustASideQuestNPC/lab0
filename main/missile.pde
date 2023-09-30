/* missile class */
public class Missile extends EntitySuper {
  private float moveSpeed;

  Missile(float x, float y) {
    // call the parent constructor to load the sprite
    super(missileJson.getJSONObject("sprite"), x, y);

    // load other data
    moveSpeed = missileJson.getFloat("movement speed");

    // tags have to be set in the constructor because arrays are weird in java
    tags = new EntityTag[]{ EntityTag.MISSILE };
  }

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