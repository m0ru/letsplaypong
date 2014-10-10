import 'dart:html' as dom hide Text;
import 'dart:svg' as ds;
import 'dart:js';
import 'dart:math';
//import 'package:smartcanvas/smartcanvas.dart';




void main() {
  var game = new Game();
  dom.window.animationFrame.then(game);
}

class Game extends Function {
  
  PongCourt pongCourt;
  bool running;
  
  Game() {
    running = true;
    dom.Element svgRootE = dom.document.querySelector('.svg-canvas');
    var svgRoot = (svgRootE as ds.SvgSvgElement);
    svgRoot.focus();
    pongCourt = new PongCourt(svgRoot);
    //var start = new DateTime.now().millisecond; //uses the moon landing as 0 ^^
    
    //TODO collision
  }
  
  void call(double deltaT) {
    var ball = pongCourt.ball;
    
    ball.move(deltaT);
    
    if(running)
      dom.window.animationFrame.then(this); // TODO only runs if tab is visible!
  }
}



class Ball {
  ds.CircleElement circle;
  double velocity = 0.001; //should be vector with random direction and that velocity
  final double acceleration = 0.0;
  
  Ball() {
    circle = new ds.CircleElement()
      ..attributes['r'] = '24'
      ..attributes['cx'] = '100'
      ..attributes['cy'] = '100';
  }
  
  void move(double deltaT) {
    var currX = double.parse(circle.attributes['cx']);
    var cx = currX + deltaT * velocity;
    circle.attributes['cx'] = '$cx';
    velocity += acceleration * deltaT;
  }
}

class PongCourt {
  final Player leftPlayer, rightPlayer;
  final Ball ball;
  ds.SvgSvgElement svgRoot;
  
  PongCourt(ds.SvgSvgElement this.svgRoot) //automatically assigns svgRoot
      : ball = new Ball(),
        leftPlayer = new Player(119,115), //keys: w=119, s=115
        rightPlayer = new Player(119,115)
  { 
    //this.svgRoot.attributes['viewBox'] = '0 0 600 400';
    print("");
    print(this.svgRoot.offsetWidth);
    print(this.svgRoot.clientWidth);
    print(this.rightPlayer.width);
    
    this.rightPlayer.x = this.svgRoot.clientWidth - this.rightPlayer.width; //TODO hardcode
    svgRoot.children
       ..add(this.leftPlayer.rect)
       ..add(this.rightPlayer.rect)
       ..add(this.ball.circle);
  }
}

class Player {
  ds.RectElement rect;
  
  void set x(int x) {
    rect.attributes['x'] = '$x';
  }
  
  int get x {
    return int.parse(rect.attributes['x']);
  }
  
  int get width {
    return int.parse(rect.attributes['width']);
  }
  
  Player(int upKey, int downKey) {
    this.rect = new ds.RectElement()
        ..attributes['width'] = '20'
        ..attributes['height'] = '110'
        ..attributes['y'] = '10'
        ..attributes['x'] = '0';
    
    dom.window.onKeyPress.listen((dom.KeyboardEvent e) {
        int yMove = 0;
        if(e.keyCode == upKey) {
          yMove = -10;
        //} else if (e.keyCode == dom.KeyCode.S) {
        } else if (e.keyCode == downKey) {
          yMove = 10;
        }
        int y = int.parse(rect.attributes['y']) + yMove;
        rect.attributes['y'] = '$y';
      });
  }
  
  void moveUp() {
    move(-10);
  }
  
  void moveDown() {
    move(10);
  }
  
  void move(int yMove) {
    int y = int.parse(player.attributes['y']) + yMove;
    rect.attributes['y'] = '$y';
  }
}