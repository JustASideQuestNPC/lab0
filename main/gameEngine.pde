/* game engine class - handles updates and rendering for many entities at once */
public class GameEngine {
  // array of all stored entities
  ArrayList<EntitySuper> entities;

  // constructor
  GameEngine() {
    entities = new ArrayList<EntitySuper>();
  }

  // adds any object that inherits from EntitySuper and then returns a reference
  // to that object...i love generic/template functions :)
  <Ent extends EntitySuper> Ent addEntity(Ent entity) {
    entities.add(entity);
    return entity;
  }

}