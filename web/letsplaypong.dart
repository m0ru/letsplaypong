import 'dart:html';
import 'dart:svg' as ds;
import 'dart:js';
import 'dart:math';

//import 'package:smartcanvas/smartcanvas.dart';

import 'player.dart';
import 'ball.dart';
import 'keyboard.dart';

void main() {
  Element svgRootE = document.querySelector('.svg-canvas');
  var svgRoot = (svgRootE as ds.SvgSvgElement);
  svgRoot.focus();
  
  var game = new Game(svgRoot);
  
  window.animationFrame.then(game);
}

//TODO replace key listener with active polling per frame to get a more fluid animation
//TODO global speed variable that accelerates
//TODO split into model and controller classes (e.g. Game -> Game & PongCourt)
//TODO speed should decrease less later on and even stop increasing after a while
//     run game once to a very difficult level and print speeds till there
//     and use that speed as asymptotic maximum (if there is one). Using log
//     should also work.
//TODO reset speed to 50% the increase of what it was when the game ended
class Game extends Function {
  //final Player leftPlayer = new Player(119,115); //keys: w=119, s=115
  final Player leftPlayer = new Player(KeyCode.W, KeyCode.S);
  final Player rightPlayer = new Player(KeyCode.W, KeyCode.S);
  final Ball ball = new Ball();
  ds.SvgSvgElement svgRoot;
  bool running = true;
  double speed = 1.0;
  Keyboard keyboard = new Keyboard();
  double lastFrameTime = 0.0;
  
  Game(ds.SvgSvgElement this.svgRoot) //automatically assigns svgRoot
  {       
    rightPlayer.x = width - rightPlayer.width; //TODO hardcode
    svgRoot.children
       ..add(leftPlayer.rect)
       ..add(rightPlayer.rect)
       ..add(ball.circle);
    
    for(var player in [leftPlayer, rightPlayer]) {
       window.onKeyPress.listen((KeyboardEvent e) {
         var yMove = 0;
         
         if(e.keyCode == player.upKey) {
           yMove = -20;
         } else if (e.keyCode == player.downKey) {
           yMove = 20;
         }
         double y = player.y + yMove;
         
         //make sure the player stays within the court
         y = max(y, 0.0);
         y = min(y, height - player.height); //TODO dirty hard-coding
         
         player.y = y;
       });
    }
  }
  
  
  void call(double timeSinceStart) {
    ball.cyOld = ball.cy;
    var deltaT = timeSinceStart - lastFrameTime;
    
    moveBall(deltaT);
    collisionWithWalls();
    
    for(var player in [leftPlayer, rightPlayer]) {
      playerMove(player, deltaT);
      collisionWithPlayer(player);
    }
    
    speed += 0.001;
    
    lastFrameTime = timeSinceStart;
    
    //reqeue animation
    if(running)
      window.animationFrame.then(this); // TODO only runs if tab is visible!
  }
  
  void playerMove(player, deltaT) {
    var yMove = 0;
    if (keyboard.isPressed(player.upKey)) {
      yMove = -player.maxVelocity * deltaT * speed;
    } else if (keyboard.isPressed(player.downKey)) {
      yMove = player.maxVelocity * deltaT * speed;
    }
    double y = player.y + yMove;
    
    //make sure the player stays within the court
    y = max(y, 0.0);
    y = min(y, height - player.height); //TODO dirty hard-coding
   
    player.y = y;
  }
  
  void moveBall(deltaT) {
    ball.cx = ball.cx + deltaT * ball.vx * speed;
    ball.cy = ball.cy + deltaT * ball.vy * speed;
  }
  
  void collisionWithWalls() {
    var cx = ball.cx;
    var cy = ball.cy;
    var r = ball.r;
    
    //collision with top/bottom wall
    if(cy - r <= 0.0) {
      ball.vy = ball.vy.abs();
    } else if (cy + r >= height) {
      ball.vy = -ball.vy.abs();
    }
    
    //TODO tmp replace with scoring
    // Collisionn with left/right wall
    if(cx - r <= 0.0) {
      ball.vx = ball.vx.abs();
    } else if (cx + r >= width) {
      ball.vx = -ball.vx.abs();
    }
  }
  
  void collisionWithPlayer(player) {
    var cx = ball.cx;
    var cy = ball.cy;
    var r = ball.r;
    var left = player.x;
    var right = left + player.width;
    var top = player.y;
    var bottom = top + player.height;
    
    //TODO ignore collision on top and bottom and focus on corners (these flip both directions)
    if (left <= cx && cx <= right) {
      if (cy < top && (cy + r) >= top) {
        //touch top
      } else if (cy > bottom && (cy - r) <= bottom) {
        //touch bottom
      }
    }
    
    //TODO deal with speedup (reverse also if old position was on one and new on other side)
    if (top <= cy && cy <= bottom) {
      if(ball.cxOld < left && (cx + r) >= left) { //touch from left
        ball.vx = -ball.vx.abs();
        print("hit from left");
      } else if(ball.cxOld > right && (cx - r) <= right) { //touch from right
        ball.vx = ball.vx.abs();
        print("hit from right");
      }
    }
  }
  
  int get height => svgRoot.clientHeight;
    //return double.parse(svgRoot.attributes['height']);
  
  int get width {
    //return double.parse(svgRoot.attributes['width']);
    return svgRoot.clientWidth;
  }
}



