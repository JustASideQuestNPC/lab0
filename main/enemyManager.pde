/* handles enemy spawning */
class EnemyManager extends EntitySuper {
  // entity limits
  int maxUfos, maxDivers;

  // data for entity spawning
  int[] ufoSpawnHeights;

  // entity counters
  int numUfos, numDivers;

  // constructor
  EnemyManager() {
    // the entity manager doesn't have an associated json config, but the parent
    // constructor will skip loading anything from it if it's null
    super(null, 0, 0, new EntityTag[]{});

    // load entity limits
    maxUfos = gameplayJson.getInt("max ufos");
    maxDivers = gameplayJson.getInt("max divers");

    // load spawn data
    ufoSpawnHeights = jsonToIntArray(gameplayJson.getJSONArray("ufo spawn heights"));

    // initialize entity counters
    numUfos = 0;
    numDivers = 0;
  }

  // updates entity spawns
  void update(float dt) {
    // do spawn checks for every entity - if the maximum number of entities are spawned,
    // the loop for it will fall through without being executed
    while (numUfos < maxUfos) {
      Ufo ufo = engine.addEntity(new Ufo(random(canvasWidth), ufoSpawnHeights[randInt(ufoSpawnHeights.length)]));
      ufo.manager = this;
      ++numUfos;
    }

    while(numDivers < maxDivers) {
      Diver diver = engine.addEntity(new Diver(random(canvasWidth), -15));
      diver.manager = this;
      ++numDivers;
    }
  }

  // @Override isn't required here - this will compile and run just fine without it - but
  // it's a good way to indicate that the speedline render method replaces ("overrides") the
  // render method from its parent class (the reason the update methods don't have this is
  // because update is abstract and isn't defined in the parent class, so it will always
  // be an override)
  @Override void render(PGraphics canvas) { return; }
}