/* CollideRects are bounding boxes that can check for collisions with both single points and other CollideRects */
public class CollideRect {
  float x, y, w, h;
  // constructor
  CollideRect(float x, float y, float w, float h) {
    // "this" is required since the constructor arguments have the same name as the CollideRect's member variables
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  // returns true if a point is inside the rect
  boolean contains(float px, float py) {
    // traditionally, px would be the first variable in all of these checks, so this would be "px > x && px < x + w",
    // but i prefer this format since it's as close as you can get to "x < px < x + w", which is much easier to read
    return (x < px && px < x + w) && (y < py && py < y + h);
  }

  // overload that takes a PVector instead of two floats
  boolean contains(PVector p) {
    return contains(p.x, p.y);
  }

  // returns true if a rectangle intersects with this rectangle
  boolean intersects(float rx, float ry, float rw, float rh) {
    return (x <= (rx + rw) && rx <= (x + w) && y <= (ry + rh) && ry <= (y + h));
  }

  // overload that takes another CollideRect
  boolean intersects(CollideRect other) {
    return intersects(other.x, other.y, other.w, other.h);
  }
}