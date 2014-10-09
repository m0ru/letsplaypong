import 'dart:html' as dom hide Text;
import 'dart:svg' as ds;
import 'dart:js';
//import 'package:smartcanvas/smartcanvas.dart';



void main() {
  
  // INIT
  
  dom.Element pongCourtE = dom.document.querySelector('.svg-canvas');
  ds.SvgSvgElement pongCourt = (pongCourtE as ds.SvgSvgElement);
  
  PongCourt court = new PongCourt(pongCourt); //w == 119, s == 115
  
  ds.CircleElement ball = new ds.CircleElement()
    ..attributes['r'] = '24'
    ..attributes['cx'] = '100'
    ..attributes['cy'] = '100';
  
  /*pongCourt.children
    ..add(leftPlayer)
    ..add(rightPlayer)
    ..add(ball);*/

  
  // MAIN LOOP

  //dom.window.animationFrame
  //dom.window.animationFrame.then
  
  
}

class Ball {
  
}

class PongCourt {
  Player leftPlayer;
  Player rightPlayer;
  Ball ball;
  ds.SvgSvgElement svgRoot;
  
  PongCourt(ds.SvgSvgElement svgRoot) {
    
    this.svgRoot = svgRoot;
    this.ball = new Ball();
    this.leftPlayer = new Player(119,115);
    this.rightPlayer = new Player(119,115);
    
    print("");
    print(this.svgRoot.offsetWidth);
    print(this.svgRoot.clientWidth);
    print(this.rightPlayer.width);
    
    this.rightPlayer.x = this.svgRoot.clientWidth - this.rightPlayer.width; //TODO hardcode
    svgRoot.children
       ..add(this.leftPlayer.rect)
       ..add(this.rightPlayer.rect);
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