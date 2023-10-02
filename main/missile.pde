/* missile class */
public class Missile extends EntitySuper {
  private float moveSpeed;

  // constructor
  Missile(float x, float y) {
    // call the parent constructor to set position, load the sprite, and create the tag list
    super(missileJson, x, y, new EntityTag[]{EntityTag.MISSILE});

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
    if (position.x < -halfWidth || position.x > canvasWidth + halfWidth || position.y < -halfHeight || position.y > canvasHeight + halfHeight) {
      deleteMe = true;
      return;
    };

      // update hitbox position
    hitbox.x = position.x + hboxOffsetX;
    hitbox.y = position.y + hboxOffsetY;

    // check for collisions with enemies
    ArrayList<EntitySuper> enemies = engine.getTagged(EntityTag.ENEMY); // get all enemies
    for (int i = 0; i < enemies.size(); ++i) {
      if (hitbox.intersects(enemies.get(i).hitbox)) {
        enemies.get(i).deleteMe = true;
        deleteMe = true;
        return;
      }
    }
  }
}