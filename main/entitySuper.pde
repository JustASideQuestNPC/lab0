/* template entity class that all entities inherit from */
public abstract class EntitySuper {
  // all entities hold a reference to the engine holding them
  GameEngine engine;
  // each entity type has different tags, but they all have them
  Tag[] tags;

  abstract void update(float dt);
  abstract void render(PGraphics canvas);

  // returns whether the entity has a tag
  boolean hasTag(Tag t) {
    // you don't need brackets if there's only one line in your dfor loop, and you *also* don't need brackets if there's only one line on your if statement
    for (Tag i : tags) if (i == t) return true;
    return false;
  }
}