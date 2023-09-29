/* player class */
public class Player extends EntitySuper {
  String foo = "player";
  AnimatedSprite sprite;

  // constructor
  Player() {
    tags = new EntityTag[]{ EntityTag.PLAYER };
    sprite = new AnimatedSprite(playerSpriteJson);
  }
  
  // update method
  void update(float dt) {}

  // render method
  void render(PGraphics canvas) {
    sprite.render(0, 0, canvas);
  }
}