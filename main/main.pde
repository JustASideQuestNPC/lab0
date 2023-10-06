/* setup and draw functions */
void setup() {
  // create the window and set it to the correct size
  size(100, 100);
  windowResize(canvasWidth * pixelSize, canvasHeight * pixelSize);

  // initialize the canvas to draw pixels to
  pixelCanvas = createGraphics(canvasWidth, canvasHeight);

  // noSmooth() prevents images from becoming blurred when scaled up and makes them become pixelated instead
  noSmooth();
  pixelCanvas.noSmooth();

  // initialize the input handler
  inputs = new InputHandler();

  // load the config file from the data folder
  loadConfig(configPath);

  // set the target framerate
  frameRate(targetFramerate);

  // initialize the fps tracker if it is enabled
  if (showFPSTracker) fpsTracker = new FPSTracker();

  // initialize the engine/clock
  clock = new GameClock();
  engine = new GameEngine();

  // add initial entities and set the game state
  initializeEntityList();
  gameState = GameState.START_MENU;
}

void draw() {
  // update the input handler
  inputs.update();

  // tick the clock
  dt = clock.tick();

  // update the fps tracker if it is enabled
  if (showFPSTracker) fpsTracker.update(dt);

  // all other updates expect dt in seconds
  dt /= 1000;

  // update all loaded entities - the clock returns dt in milliseconds for extra precision, but 
  // game entities expect it in seconds
  engine.updateAll(dt);

  // do different updates based on the game state - switch statements function identically to
  // if/else if chains, but they're significantly faster (and more readable imo)
  switch (gameState) {
    case GAMEPLAY:
      // remove entities that are no longer needed
      engine.garbageCollect();
      // if the player should be deleted, they are also dead
      if (player.deleteMe) {
        println("player is dead");
        engine.purgeEntities();
        gameState = GameState.GAME_OVER;
      }
      break; // break ends the switch statement without checking the rest of the cases
    case START_MENU:
      if (inputs.getState("menu 1")) {
        reloadGame();
        gameState = GameState.GAMEPLAY;
      }
      else if (inputs.getState("menu 2")) {
        gameState = GameState.HOW_TO_PLAY;
      }
      break;
    case HOW_TO_PLAY:
      if (inputs.getState("menu 1")) {
        gameState = GameState.START_MENU;
      }
      break;
    case GAME_OVER:
      if (inputs.getState("menu 1")) {
        gameState = GameState.START_MENU;
      }
      break;
  }

  // draw pixelated things to the canvas
  pixelCanvas.beginDraw();
    pixelCanvas.textFont(font);
    // after beginDraw, drawing to a PGraphics object works exactly the same as drawing
    // to the normal window, except that everything starts with "name."
    pixelCanvas.background(black);

    // render all loaded entities
    engine.renderAll(pixelCanvas);

    // render some things to the canvas based on the game state
    switch(gameState) {
      case GAMEPLAY:
        // render the hud
        pixelCanvas.textSize(16);
        drawHud(pixelCanvas, dt);
        break;
      case START_MENU:
        pixelCanvas.fill(white);
        pixelCanvas.textAlign(CENTER, CENTER);

        pixelCanvas.textSize(32);
        pixelCanvas.text("GALACTIC INTRUDERS", canvasWidth / 2, canvasHeight / 4);

        pixelCanvas.textSize(16);
        pixelCanvas.text("Press Z or K to Play\nPress X or L for Instructions\nPress Alt+F4 to Quit", canvasWidth / 2, 2 * canvasHeight / 3);
        break;
      case HOW_TO_PLAY:
        pixelCanvas.fill(white);
        pixelCanvas.textAlign(CENTER, CENTER);

        pixelCanvas.textSize(32);
        pixelCanvas.text("HOW TO PLAY", canvasWidth / 2, canvasHeight / 4);

        pixelCanvas.textSize(16);
        pixelCanvas.text("Use WASD/Arrow Keys to Move\nUse Z to Fire Missiles\nDon't Die", canvasWidth / 2, canvasHeight / 2);
        pixelCanvas.text("Press Z or K to Return to Main Menu", canvasWidth / 2, 2 * canvasHeight / 3);
        break;
      case GAME_OVER:
        pixelCanvas.fill(white);
        pixelCanvas.textAlign(CENTER, CENTER);

        pixelCanvas.textSize(32);
        pixelCanvas.text("YOU ARE DEAD", canvasWidth / 2, canvasHeight / 4);

        pixelCanvas.textSize(16);
        pixelCanvas.text("Press Z or K to Try Again\nPress Alt+F4 to Quit", canvasWidth / 2, 2 * canvasHeight / 3);
        break;
    }

  pixelCanvas.endDraw();

  // PGraphics objects can be drawn to the screen in the same way as PImage objects
  image(pixelCanvas, 0, 0, width, height);

  // draw the framerate tracker over the upscaled image if it is
  if (showFPSTracker) fpsTracker.display(0, 0, 1.5);
}