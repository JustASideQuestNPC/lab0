/* player class */
public class Player extends EntitySuper {
  String foo = "player";

  // constructor
  Player() {
    tags = new Tag[]{ Tag.PLAYER };
  }
  
  // update method
  void update(float dt) {}

  // render method
  void render(PGraphics canvas) {}
}