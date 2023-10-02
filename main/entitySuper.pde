/* parent entity class that all entities inherit from */
public abstract class EntitySuper {
  // each entity type has different tags, but they all have them.
  // PS this is an ArrayList instead of an array because some
  // entities will need to change their tags depending on context
  ArrayList<EntityTag> tags;
  
  // all entities have a sprite and position
  protected AnimatedSprite sprite;
  protected float halfWidth, halfHeight;
  PVector position;

  // used in the engine to always display some entities on top of others
  int displayLayer;
  // entities that are no longer necessary are removed from the engine to free up memory and improve performance
  boolean deleteMe;

  // base constructor that is shared by all entities
  EntitySuper(JSONObject spriteJson, float x, float y, EntityTag[] tagList) {
    position = new PVector(x, y);
    sprite = new AnimatedSprite(spriteJson);
    halfWidth = sprite.frameWidth / 2;
    halfHeight = sprite.frameHeight / 2;
    deleteMe = false;

    // i'm pretty sure there's a way to initialize an ArrayList with values
    // already inside it, but it seems like it's more trouble than it's worth
    tags = new ArrayList<EntityTag>();
    for (EntityTag t : tagList) tags.add(t);
  }

  // every entity updates differently, so this is "pure abstract"
  abstract void update(float dt);

  // all entities will render their sprite, so this is defined oncec here
  void render(PGraphics canvas) {
    // floor the position to an integer to prevent the image from stretching when the position
    // is between two pixels
    sprite.render(floor(position.x - halfWidth), floor(position.y - halfHeight), canvas);
  }

  // returns whether the entity has a tag
  boolean hasTag(EntityTag t) {
    // you don't need brackets if there's only one line in your for loop, and you *also* don't need brackets if there's only one line on your if statement
    for (EntityTag i : tags) if (i == t) return true;
    return false;
  }
}