import 'dart:html' as dom hide Text;
import 'dart:svg' as ds;
import 'dart:js';
import 'dart:math';
//import 'package:smartcanvas/smartcanvas.dart';

import 'player.dart';
import 'ball.dart';


void main() {
  dom.Element svgRootE = dom.document.querySelector('.svg-canvas');
  var svgRoot = (svgRootE as ds.SvgSvgElement);
  svgRoot.focus();
  var game = new Game(svgRoot);
  dom.window.animationFrame.then(game);
}


//TODO split into model and controller classes (e.g. Game -> Game & PongCourt)
class Game extends Function {
  final Player leftPlayer, rightPlayer;
  final Ball ball;
  ds.SvgSvgElement svgRoot;
  bool running;
  
  Game(ds.SvgSvgElement this.svgRoot) //automatically assigns svgRoot
      : ball = new Ball(),
        leftPlayer = new Player(119,115), //keys: w=119, s=115
        rightPlayer = new Player(119,115),
        running = true
  { 
    //this.svgRoot.attributes['viewBox'] = '0 0 600 400';
    print("");
    print(svgRoot.offsetWidth);
    print(svgRoot.clientWidth);
    print(rightPlayer.width);
    
    rightPlayer.x = width - rightPlayer.width; //TODO hardcode
    svgRoot.children
       ..add(leftPlayer.rect)
       ..add(rightPlayer.rect)
       ..add(ball.circle);
  }
  
  
  void call(double deltaT) {
    ball.move(deltaT);
  
    var player = rightPlayer;
    
    var left = player.x;
    var right = left + player.width;
    var top = player.y;
    var bottom = top + player.height;
    
    var cx = ball.cx;
    var cy = ball.cy;
    var r = ball.r;
    
    
    if(cy - r < 0) {
      ball.vy = ball.vy.abs();
    } else if (cy + r > height) {
      ball.vy = -ball.vy.abs();
    }
    
    //TODO tmp replace with scoring
    if(cx - r < 0) {
      ball.vx = ball.vx.abs();
    } else if (cx + r > width) {
      ball.vx = -ball.vx.abs();
    }
    
    
    
    if (left <= cx && cx <= right) {
      if (cy < top && (cy + r) >= top) {
        //touch top
      } else if (cy > bottom && (cy - r) <= bottom) {
        //touch bottom
      }
    }
    
    if (top <= cy && cy <= bottom) {
      
    }
    
    print(bottom);
    
    
    
    //collision pseudo code
    //le
    
    
    if(running)
      dom.window.animationFrame.then(this); // TODO only runs if tab is visible!
  }
  
  int get height => svgRoot.clientHeight;
    //return double.parse(svgRoot.attributes['height']);
  
  int get width {
    //return double.parse(svgRoot.attributes['width']);
    return svgRoot.clientWidth;
  }
}



