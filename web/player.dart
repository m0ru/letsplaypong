import 'dart:html' as dom hide Text;
import 'dart:svg' as ds;
import 'dart:math';

class Player {
  ds.RectElement rect;
  
  void set x(double x) {
    rect.attributes['x'] = '$x';
  }
  
  double get x {
    return double.parse(rect.attributes['x']);
  }
  
  double get width {
    return double.parse(rect.attributes['width']);
  }
  
  double get y {
    return double.parse(rect.attributes['y']);
  }
  
  double get height {
    return double.parse(rect.attributes['height']);
  }
  
  Player(int upKey, int downKey) {
    this.rect = new ds.RectElement()
        ..attributes['width'] = '20'
        ..attributes['height'] = '110'
        ..attributes['y'] = '10'
        ..attributes['x'] = '0';
    
    dom.window.onKeyPress.listen((dom.KeyboardEvent e) {
        var yMove = 0;
        if(e.keyCode == upKey) {
          yMove = -20;
        //} else if (e.keyCode == dom.KeyCode.S) {
        } else if (e.keyCode == downKey) {
          yMove = 20;
        }
        var y = double.parse(rect.attributes['y']) + yMove;
        
        //make sure the player stays within the court
        y = max(y, 0);
        y = min(y, 400 - height); //TODO dirty hard-coding
        
        rect.attributes['y'] = '$y';
      });
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