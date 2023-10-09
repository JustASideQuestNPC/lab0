/* draws the HUD with health and other data */
void drawHud(PGraphics canvas, float dt) {
  // draw the background 
  canvas.image(hpBarBackground, 0, 0);

  // draw one healthbar segment for each remaining hit point
  for (int i = 0; i < player.currentHealth; ++i) {
    canvas.image(hpBarSegment, i * 12 + 19, 2);
  }

  canvas.noStroke();

  // draw and update the caution indicator and caution text if the player is at 1 hp
  if (player.currentHealth <= 1) {
    hpBarCaution.update(dt);
    hpBarCaution.render(31, 2, canvas);
    canvas.fill(hpBarCaution.currentFrame == 0 ? white : orange);
    canvas.textAlign(CENTER, TOP);
    canvas.text("CRITICAL DAMAGE", canvasWidth / 2, 120);
  }

  // draw the text - this is drawn over the first healthbar to make the little segment at the end
  canvas.fill(black);
  canvas.rect(1, 1, 26, 8);

  canvas.fill(white);
  canvas.textAlign(LEFT, TOP);
  canvas.text("HULL", 2, 2);

  canvas.textAlign(RIGHT, TOP);
  canvas.text(playerScore, canvasWidth - 2, 2);
}