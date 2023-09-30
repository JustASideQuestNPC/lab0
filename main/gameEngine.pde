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
  // to that object...i love generic/template functions :)
  <Ent extends EntitySuper> Ent addEntity(Ent entity, int displayLayer) {
    // set display layer
    entity.displayLayer = displayLayer;
    if (displayLayer < minDisplayLayer) minDisplayLayer = displayLayer;
    else if (displayLayer > maxDisplayLayer) maxDisplayLayer = displayLayer;

    entities.add(entity);
    return entity;
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
      entities.forEach((ent) -> {
        if (ent.displayLayer == layer) ent.render(canvas);
      });
    }
  }

  // renderAll overload that draws all entities to the main window
  void renderAll() {
    renderAll(g);
  }

  // removes entities that are no longer needed
  void garbageCollect() {
    entities.removeIf(e -> (e.deleteMe));
  };
}