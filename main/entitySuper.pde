/* parent entity class that all entities inherit from */
public abstract class EntitySuper {
  // each entity type has different tags, but they all have them.
  // PS this is an ArrayList instead of an array because some
  // entities will need to change their tags depending on context
  ArrayList<EntityTag> tags;
  
  // all entities have these
  protected AnimatedSprite sprite;
  protected float halfWidth, halfHeight; // used for centering the sprite
  PVector position;
  CollideRect hitbox;
  protected float hboxOffsetX, hboxOffsetY;
  int maxHealth, currentHealth;

  // used in the engine to always display some entities on top of others
  int displayLayer;
  // entities that are no longer necessary are removed from the engine to free up memory and improve performance
  boolean deleteMe;

  // base constructor that is shared by all entities
  EntitySuper(JSONObject entityJson, float x, float y, EntityTag[] tagList) {
    position = new PVector(x, y);

    // create sprite
    sprite = new AnimatedSprite(entityJson.getJSONObject("sprite"));
    halfWidth = sprite.frameWidth / 2;
    halfHeight = sprite.frameHeight / 2;

    // create bounding box
    JSONObject hitboxJson = entityJson.getJSONObject("hitbox");
    hboxOffsetX = hitboxJson.getFloat("x");
    hboxOffsetY = hitboxJson.getFloat("y");
    hitbox = new CollideRect(0, 0, hitboxJson.getFloat("width"), hitboxJson.getFloat("height"));

    // load other data
    maxHealth = entityJson.getInt("max hp");
    currentHealth = maxHealth;

    // i'm pretty sure there's a way to initialize an ArrayList with values
    // already inside it, but it seems like it's more trouble than it's worth
    tags = new ArrayList<EntityTag>();
    for (EntityTag t : tagList) tags.add(t);

    deleteMe = false;
  }

  // every entity updates differently, so this doesn't need to be defined
  abstract void update(float dt);

  // all entities will render their sprite, so this is defined oncec here
  void render(PGraphics canvas) {
    // floor the position to an integer to prevent the image from stretching when the position
    // is between two pixels
    sprite.render(floor(position.x - halfWidth), floor(position.y - halfHeight), canvas);

    // draw the hitbox if the debug toggle for it is enabled
    if (showHitboxes) {
      canvas.noFill();
      canvas.stroke(255, 0, 0);
      canvas.rect(floor(hitbox.x), floor(hitbox.y), hitbox.w, hitbox.h);
    }
  }

  // called whenever something deals damage to an entity
  void damage(int dmg) {
    currentHealth -= dmg;
    if (currentHealth <= 0) deleteMe = true;
  }

  // returns whether the entity has a tag
  boolean hasTag(EntityTag t) {
    // you don't need brackets if there's only one line in your for loop, and you *also* don't need brackets if there's only one line on your if statement
    for (EntityTag i : tags) if (i == t) return true;
    return false;
  }
}