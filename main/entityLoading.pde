/* functions for loading entities into the engine */
// this loads persistent entities like the speedline particles, and is called once at the end of setup()
void initializeEntityList() {
  // remove all entities from the engine - it probably won't be holding any, but better safe than sorry
  engine.purgeEntities(true);

  // stop execution if speedlines are disabled, otherwise create a bunch of speedlines
  if (noSpeedlines) return;

  for (int i = 0; i < speedlineLengths.length; ++i) {
    for (int j = 0; j < speedlinesPerLayer[i]; ++j) {
      engine.addEntity(new Speedline(speedlineLengths[i], speedlineSpeeds[i]));
    }
  }
}

// reloads the player, enemy manager, and enemies
void reloadGame() {
  // ensure all non-persistent entities have been removed from the list
  engine.purgeEntities();

  player = engine.addEntity(new Player(canvasWidth / 2, canvasHeight - 15));
  
  EnemyManager manager = engine.addEntity(new EnemyManager());
  manager.update(0); // update the manager manually to spawn all enemies

  playerScore = 0;
}