/* the ufo is a basic enemy that fires untargeted lasers */
class Ufo extends EntitySuper {
  private float moveSpeed, shotInterval, shotTimer;
  private int moveDirection, shotChance;
  private boolean firing;
  private PVector shotOffset;

  // constructor
  Ufo(float x, float y) {
    // call the parent constructor to set position, load the sprite, and create the tag list
    super(ufoJson, x, y, new EntityTag[]{EntityTag.UFO, EntityTag.ENEMY});

    // ufos only play their animation when they fire a laser
    sprite.loopAnimation = false;
    sprite.playDirection = 0;

    // load other data
    moveSpeed = ufoJson.getFloat("movement speed");
    moveDirection = 1; // 1 = moving right, -1 = moving left

    // ufos have a chance to fire a laser every few seconds
    shotInterval = ufoJson.getFloat("shot interval");
    shotChance = ufoJson.getInt("shot chance");

    // randomly offset when the ufo gets to fire a laser so that ufos don't all shoot at the same time
    shotTimer = random(shotInterval);

    // lasers are positioned to line up with the firing animation when they spawn
    JSONArray shotOffsetRaw = ufoJson.getJSONArray("shot spawn offset");
    shotOffset = new PVector(shotOffsetRaw.getFloat(0), shotOffsetRaw.getFloat(1));

    // set display layer
    displayLayer = 0;
  }

  // called every frame to update position, hitboxes, etc.
  void update(float dt) {
    // update sprite - this will do nothing if the ufo isn't firing
    sprite.update(dt);

    // ufos only move and attempt to fire if they aren't currently playing their firing animation
    if (sprite.getFrameIndex() == 0) {

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

      // update shot timer and attempt to fire a laser
      shotTimer -= dt;
      if (shotTimer <= 0) {
        shotTimer = shotInterval;
        if (dcCheck(100, 100 - shotChance, 0)) {
          // ufos fire after playing their firing animation
          sprite.playDirection = 1;
          sprite.setFrame(1);
        }
      }
    }
    // the last frame in the ufo's animation is the same as the first, and is only there to indicate
    // when to spawn a laser
    else if (sprite.getFrameIndex() == 19) {
        // spawn a laser and reset the animation
        engine.addEntity(new SpiralLaser(position.x + shotOffset.x, position.y + shotOffset.y));
        sprite.playDirection = 0;
        sprite.setFrame(0);
    }

    // update hitbox position
    hitbox.x = position.x + hboxOffsetX;
    hitbox.y = position.y + hboxOffsetY;
  }

  @Override void onDeath() {
    // decrement the enemy manager's counter
    --manager.numUfos;
  }
}