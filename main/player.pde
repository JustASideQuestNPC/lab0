/* player class */
public class Player extends EntitySuper {
  private float moveSpeed;

  // for timing missile shots
  private float shotDelay, shotTimer;
  

  // constructor
  Player(float x, float y) {
    // call the parent constructor to load the sprite and set the position
    super(playerJson.getJSONObject("sprite"), x, y);

    // load other data from json
    moveSpeed = playerJson.getInt("movement speed");
    shotDelay = playerJson.getFloat("shot delay");
    shotTimer = 0;

    // tags have to be set in the constructor because arrays are weird in java
    tags = new EntityTag[]{ EntityTag.PLAYER };
  }
  
  // updates the player
  void update(float dt) {
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
      engine.addEntity(new Missile(position.x, position.y), -1);
      shotTimer = shotDelay;
    }

    // multiply move delta by dt and apply to position
    moveDelta.mult(dt);
    position.add(moveDelta);

    // clamp position to keep the player onscreen
    position.x = constrain(position.x, halfWidth, canvasWidth - halfWidth);
    position.y = constrain(position.y, halfHeight, canvasHeight - halfHeight);
  }
}