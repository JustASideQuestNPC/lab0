/* diving enemy class */
class Diver extends EntitySuper {
  private float angle, moveSpeed, turnSpeed, spawnLagTimer;
  private int dmg, score;

  Diver(float x, float y) {
    // call the parent constructor
    super(diverJson, x, y, new EntityTag[]{EntityTag.DIVER, EntityTag.ENEMY});

    // load other data
    moveSpeed = diverJson.getFloat("movement speed");
    turnSpeed = radians(diverJson.getFloat("rotation speed"));
    spawnLagTimer = diverJson.getFloat("spawn lag");
    dmg = diverJson.getInt("damage");
    score = diverJson.getInt("score");

    angle = PI * 3 / 2;

    displayLayer = 0;
  }

  void update(float dt) {
    // divers won't turn toward the player or deal damage for a short time after being spawned
    if (spawnLagTimer <= 0) {
      // find the angle to the player and how much the diver needs to turn to face it
      float targetAngle = atan2(player.position.y - position.y, player.position.x - position.x) + PI;
      float angleDelta = targetAngle - angle;
      if (angleDelta < -PI) angleDelta += TWO_PI;
      else if (angleDelta > PI) angleDelta -= TWO_PI;

      // if the target angle is less than the amount the diver could turn on this frame, snap to the target angle...
      if (abs(angleDelta) <= turnSpeed * dt) {
        angle = targetAngle;
      }
      // ...otherwise, turn as much as possible toward the darget angle
      else {
        if (angleDelta < 0) angle -= turnSpeed * dt;
        else angle += turnSpeed * dt;
      }
    }
    else {
      spawnLagTimer -= dt;
    }

    // update the displayed frame based on the diver's facing angle
    // PS: i'd like to thank desmos for doing the heavy lifting on this equation
    angle = (angle + TWO_PI) % TWO_PI;
    sprite.setFrame((int((angle - PI / 16) / (PI / 8)) + 9) % 16);

    PVector moveDelta = PVector.fromAngle(angle + PI);
    moveDelta.mult(moveSpeed);
    position.add(PVector.mult(moveDelta, dt));

    // destroy the diver if it moves all the way off the left, right, or bottom of the screen (but not the top because divers spawn slightly offscreen)
    if (position.x < -halfWidth || position.x > canvasWidth + halfWidth || position.y > canvasHeight + halfHeight) {
      deleteMe = true;
      --manager.numDivers; // decrement the enemy manager's counter
      return;
    }

    // update hitbox position
    hitbox.x = position.x + hboxOffsetX;
    hitbox.y = position.y + hboxOffsetY;

    // do collision checks if the spawn lag is finished
    if (spawnLagTimer <= 0) { 
      // check for collisions with enemies, because divers can friendly-fire
      ArrayList<EntitySuper> enemies = engine.getTagged(EntityTag.ENEMY); // get all enemies
      for (int i = 0; i < enemies.size(); ++i) {
        // skip ourselves
        if (enemies.get(i) == this) continue;
        if (hitbox.intersects(enemies.get(i).hitbox)) {
          enemies.get(i).damage(dmg);
          deleteMe = true;
          --manager.numDivers;
          return;
        }
      }

      // check for a collision with the player
      if (hitbox.intersects(player.hitbox)) {
        player.damage(dmg);
        deleteMe = true;
        --manager.numDivers;
        return;
      }
    }
  }

  @Override void onDeath() {
    playerScore += score;
    --manager.numDivers;
  }
}