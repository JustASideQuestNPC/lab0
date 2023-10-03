/* draws the HUD with health and other data */
void drawHud(PGraphics canvas, float dt) {
  // draw the background 
  canvas.image(hpBarBackground, 0, 0);

  // draw one healthbar segment for each remaining hit point
  for (int i = 0; i < player.currentHealth; ++i) {
    canvas.image(hpBarSegment, i * 12 + 19, 2);
  }

  // draw and update the caution indicator if the player is at 1 hp
  if (player.currentHealth <= 1) {
    hpBarCaution.update(dt);
    hpBarCaution.render(31, 2, canvas);
  }

  // draw the text - this is drawn over the first healthbar to make the little segment at the end
  canvas.image(hpBarText, 2, 2);
}