/* player class */
public class Player extends EntitySuper {
  PVector position;
  AnimatedSprite sprite;
  int moveSpeed;

  // constructor
  Player(float x, float y) {
    // set position
    position = new PVector(x, y);

    // load sprite from json
    sprite = new AnimatedSprite(playerJson.getJSONObject("sprite"));

    // load other data from json
    moveSpeed = playerJson.getInt("movement speed");

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

    // multiply move delta by dt and apply to position
    moveDelta.mult(dt);
    position.add(moveDelta);

    // clamp position to keep the player onscreen
    position.x = constrain(position.x, 8, canvasWidth - 8);
    position.y = constrain(position.y, 8, canvasHeight - 8);
  }

  // draws the player to the canvas
  void render(PGraphics canvas) {
    // center the sprite on the player's position
    sprite.render(floor(position.x) - 8, floor(position.y) - 8, canvas);
  }
}