/* game engine class - handles updates and rendering for many entities at once */
public class GameEngine {
  // array of all stored entities
  private ArrayList<EntitySuper> entities;

  // constructor
  GameEngine() {
    entities = new ArrayList<EntitySuper>();
  }

  // adds any object that inherits from EntitySuper and then returns a reference
  // to that object...i love generic/template functions :)
  <Ent extends EntitySuper> Ent addEntity(Ent entity) {
    entity.engine = this;
    entities.add(entity);
    return entity;
  }

  // updates all loaded entities
  void updateAll(float dt) {
    // calls the update method of every entity in the list
    entities.forEach((ent) -> ent.update(dt));
  }

  // draws all loaded entities to the given canvas object
  void renderAll(PGraphics canvas) {
    // calls the render method of every entity in the list
    entities.forEach((ent) -> ent.render(canvas));
  }

  // renderAll overload that draws all entities to the main window
  void renderAll() {
    renderAll(g);
  }
}