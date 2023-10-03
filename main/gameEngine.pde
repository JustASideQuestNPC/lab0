/* game engine class - handles updates and rendering for many entities at once */
public class GameEngine {
  // array of all stored entities
  private ArrayList<EntitySuper> entities;

  // used to render some entities on top of others
  private int maxDisplayLayer = 0;
  private int minDisplayLayer = 0;

  // constructor
  GameEngine() {
    entities = new ArrayList<EntitySuper>();
  }

  // adds any object that inherits from EntitySuper and then returns a reference
  // to that object...i love polymorphism :)
  <Ent extends EntitySuper> Ent addEntity(Ent entity) {
    // update the highest/lowest display layers
    if (entity.displayLayer < minDisplayLayer) minDisplayLayer = entity.displayLayer;
    else if (entity.displayLayer > maxDisplayLayer) maxDisplayLayer = entity.displayLayer;

    entities.add(entity);
    return entity;
  }

  // returns every entity with the specified tag
  ArrayList<EntitySuper> getTagged(EntityTag tag) {
    ArrayList<EntitySuper> taggedEntities = new ArrayList<EntitySuper>();
    for (int i = 0; i < entities.size(); ++i) {
      if (entities.get(i).hasTag(tag)) {
        taggedEntities.add(entities.get(i));
      }
    }
    return taggedEntities;
  }

  // updates all loaded entities
  void updateAll(float dt) {
    // calls the update method of every entity in the list
    for (int i = 0; i < entities.size(); ++i) {
      entities.get(i).update(dt);
    }
  }

  // draws all loaded entities to the given canvas object
  void renderAll(PGraphics canvas) {
    // repeatedly loop through the entities and draw them layer by layer
    for (int i = minDisplayLayer; i <= maxDisplayLayer; ++i) {
      final int layer = i;
      // forEach does basically the same thing as updateAll does: it loops
      // through an array and does something to every item in it (in this case,
      // it renders each entity on the current display later). If you're
      // wondering why I didn't use this in updateAll, it's because some entities
      // add new entities to the engine (like when the player fires a missile),
      // and doing that in the middle of a forEach will instantly throw an error
      // and freeze the window until task manager kills it :/
      entities.forEach((ent) -> {
        if (ent.displayLayer == layer) ent.render(canvas);
      });
    }
  }

  // removes entities that are no longer needed
  void garbageCollect() {
    entities.removeIf(e -> (e.deleteMe));
  };
}