/* clock class - keeps simulation speed consistent regardless of framerate */
public class GameClock {
  private int currentTime;
  // constructor
  GameClock() {
    currentTime = millis();
  }
  // tick returns the time since tick() was last called, in milliseconds
  int tick() {
    int duration = millis() - currentTime;
    currentTime = millis();
    return duration;
  }
}