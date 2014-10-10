import 'dart:html' as dom hide Text;
import 'dart:svg' as ds;
import 'dart:math';

class Player {
  ds.RectElement rect;
  int upKey, downKey;
  final double maxVelocity = 0.1;
  
  void set x(double x) {
    rect.attributes['x'] = '$x';
  }
  
  double get y {
     return double.parse(rect.attributes['y']);
   }
  
  void set y(double y) {
    rect.attributes['y'] = '$y';
  }
  
  double get x {
    return double.parse(rect.attributes['x']);
  }
  
  double get width {
    return double.parse(rect.attributes['width']);
  }

  double get height {
    return double.parse(rect.attributes['height']);
  }
  
  Player(this.upKey, this.downKey) {
    this.rect = new ds.RectElement()
        ..attributes['width'] = '20'
        ..attributes['height'] = '110'
        ..attributes['y'] = '10'
        ..attributes['x'] = '0';
  }
  
  /*void moveUp() {
    move(-10);
  }
  
  void moveDown() {
    move(10);
  }
  
  void move(int yMove) {
    int y = int.parse(player.attributes['y']) + yMove;
    rect.attributes['y'] = '$y';
  }*/
}