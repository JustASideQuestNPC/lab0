/* functions for loading entities into the engine */
// this loads some extra entities like the speedline particles, and is called once at the end of setup()
void initializeEntityList() {
  // remove all entities from the engine - it probably won't be holding any, but better safe than sorry
  engine.purgeEntities();

  // this is hard-coded for debug purposes and will be reworked or removed later
  player = engine.addEntity(new Player(canvasWidth / 2, 170));
  
  // add an enemy manager, then update it to populate the entity list with enemies
  EnemyManager manager = engine.addEntity(new EnemyManager());
  manager.update(0);

  // stop execution if speedlines are disabled, otherwise create a bunch of speedlines
  if (noSpeedlines) return;

  for (int i = 0; i < speedlineLengths.length; ++i) {
    for (int j = 0; j < speedlinesPerLayer[i]; ++j) {
      engine.addEntity(new Speedline(speedlineLengths[i], speedlineSpeeds[i]));
    }
  }
}