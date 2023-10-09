/* player class */
public class Player extends EntitySuper {
  private float moveSpeed;

  // for timing missile shots
  private float shotDelay, shotTimer;

  // the player briefly becomes invincible after taking damage
  private float iFrames, iFrameFlashTimer, iFrameFlashSpeed, maxIFrames;
  
  // constructor
  Player(float x, float y) {
    // call the parent constructor to set position, load the sprite, and create the tag list
    super(playerJson, x, y, new EntityTag[]{EntityTag.PLAYER});
    sprite.playDirection = 0; // the player's sprite is only updated during the i-frame flashing

    // load other data
    moveSpeed = playerJson.getInt("movement speed");

    shotDelay = playerJson.getFloat("shot delay");
    shotTimer = 0;

    maxIFrames = playerJson.getFloat("i-frames per hit");
    iFrameFlashSpeed = playerJson.getFloat("i-frame flash speed");
    iFrames = maxIFrames;
    iFrameFlashTimer = iFrameFlashSpeed;

    // set display layer
    displayLayer = 0;
  }
  
  // called every frame to update position, hitboxes, etc.
  void update(float dt) {
    // decrement i-frames if the player has any
    if (iFrames > 0) {
      iFrames -= dt;

      // update the sprite
      iFrameFlashTimer -= dt;
      if (iFrameFlashTimer <= 0) {
        iFrameFlashTimer = iFrameFlashSpeed;
        sprite.advanceFrame(1);
      }

      // if the player is out of i-frames, make sure their sprite is visible
      if (iFrames <= 0) {
        sprite.setFrame(0);
      }
    }

    // update sprite animation
    sprite.update(dt);

    // holds how much the player should move on this update cycle; is scaled
    // to dt and applied to position at the end of the update
    PVector moveDelta = new PVector(0, 0);

    // check for control input
    PVector moveInput = new PVector(0, 0);
    if (inputs.getState("move left")) --moveInput.x;
    if (inputs.getState("move right")) ++moveInput.x;
    if (inputs.getState("move up")) --moveInput.y;
    if (inputs.getState("move down")) ++moveInput.y;

    // normalize the movement vector to prevent diagonal movement from being 41% faster
    moveInput.normalize();

    // multiply the input vector by movement speed and add it to move delta
    moveInput.mult(moveSpeed);
    moveDelta.add(moveInput);

    // do shooting checks
    if (shotTimer > 0) shotTimer -= dt;

    if (inputs.getState("shoot") && shotTimer <= 0) {
      // add a missile entity to the engine (this is why entities hold a reference to their engine)
      engine.addEntity(new Missile(position.x, position.y));
      shotTimer = shotDelay;
    }

    // multiply move delta by dt and apply to position
    moveDelta.mult(dt);
    position.add(moveDelta);

    // clamp position to stay onscreen
    position.x = constrain(position.x, halfWidth, canvasWidth - halfWidth);
    position.y = constrain(position.y, halfHeight, canvasHeight - halfHeight);

    // update hitbox position
    hitbox.x = position.x + hboxOffsetX;
    hitbox.y = position.y + hboxOffsetY;
  }

  // override to prevent taking damage if the player has i-frames
  @Override void damage(int dmg) {
    if (iFrames <= 0) {
      currentHealth -= dmg;
      if (currentHealth <= 0) {
        deleteMe = true;
      }
      iFrames = maxIFrames;
      iFrameFlashTimer = iFrameFlashSpeed;
    }
  }
}