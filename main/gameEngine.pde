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
    println("updating entities...");
    // calls the update method of every entity in the list
    for (int i = 0; i < entities.size(); ++i) {
      entities.get(i).update(dt);
    }
    println("update complete");
  }

  // draws all loaded entities to the given canvas object
  void renderAll(PGraphics canvas) {
    println("rendering entities...");
    // repeatedly loop through the entities and draw them layer by layer
    for (int i = minDisplayLayer; i <= maxDisplayLayer; ++i) {
      final int layer = i;
      for (int j = 0; j < entities.size(); ++j) {
        entities.get(j).render(canvas);
      }
    }
    println("rendering complete");
  }

  // removes entities that are no longer needed
  void garbageCollect() {
    entities.removeIf(e -> (e.deleteMe));
  };

  // removes all entities from the entity list. if ignoreTags is false, entities
  // with the PURGE_EXEMPT tag are not removed
  void purgeEntities(boolean ignoreTags) {
    if (ignoreTags) {
      entities.clear();
    }
    else {
      entities.removeIf(e -> !e.hasTag(EntityTag.PURGE_EXEMPT));
    }
  }

  // overload to make ignoreTags default to false
  void purgeEntities() {
    purgeEntities(false);
  }
}