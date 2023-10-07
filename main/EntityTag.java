/* Don't worry about this being a java file and not a pde, there's nothing in here
 * that will actually get run. I just really wanted to use a real enum for once,
 * and they can only be declared in a .java file for some reason. Anyway, this is
 * a bunch of different attributes that entities can have.
 */
public enum EntityTag {
  PLAYER,
  UFO,
  DIVER,
  MISSILE,
  SPIRAL_LASER,
  PARTICLE,
  ENEMY,        // entities with this tag can be damaged by player missiles
  PURGE_EXEMPT, // entities with this tag will not be removed by GameEngine.purgeEntities(), unless ignoreTags is set to true
};