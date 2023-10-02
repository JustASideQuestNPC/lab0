/* the ufo is a basic enemy that fires untargeted lasers */
class Ufo extends EntitySuper {
  private float moveSpeed;
  private int moveDirection; // 1 = moving right, -1 = moving right

  // constructor
  Ufo(float x, float y) {
    // call the parent constructor to set position, load the sprite, and create the tag list
    super(ufoJson.getJSONObject("sprite"), x, y, new EntityTag[]{ EntityTag.UFO });

    // load other data
    moveSpeed = ufoJson.getFloat("movement speed");
    moveDirection = 1;

    // set display layer
    displayLayer = 0;
  }

  // called every frame to update position, hitboxes, etc.
  void update(float dt) {
    // ufos just bounce between the left and right sides of the screen
    position.x += moveSpeed * dt * moveDirection;

    // check if the ufo has hit a wall and bounce
    if (position.x < halfWidth) {
      position.x = halfWidth;
      moveDirection = 1;
    }
    else if (position.x > canvasWidth - halfWidth) {
      position.x = canvasWidth - halfWidth;
      moveDirection = -1;
    }
  }
}