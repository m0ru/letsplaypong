import 'dart:html' as dom hide Text;
import 'dart:svg' as ds;
import 'dart:js';
//import 'package:smartcanvas/smartcanvas.dart';



void main() {
  
  // INIT
  
  dom.document.querySelector("#sample_text_id")
        ..text = "Click me!"
        ..onClick.listen(reverseText);
  
  //dom.Element pongCourt = dom.document.querySelector("#pongCourt");
  
  dom.Element pongCourtE = dom.document.querySelector('.svg-canvas');
  ds.SvgSvgElement pongCourt = (pongCourtE as ds.SvgSvgElement);
  
  
  ds.RectElement leftPlayer = createPlayer(0, 119, 115); //w == 119, s == 115
  
  int rightX = pongCourt.clientWidth - 20; //TODO hacky hardcoding
  ds.RectElement rightPlayer = createPlayer(rightX, 119, 115); //w == 119, s == 115
  
  ds.CircleElement ball = new ds.CircleElement()
    ..attributes['r'] = '24'
    ..attributes['cx'] = '100'
    ..attributes['cy'] = '100';
  
  pongCourt.children
    ..add(leftPlayer)
    ..add(rightPlayer)
    ..add(ball);
  
  // INIT END
  
  
  // MAIN LOOP
  
  while(true) {
    
  }
  
  
}



ds.RectElement createPlayer(int x, int upKey, int downKey) {
  for (String side in ['left', 'right']) {
    print(side);
  }
  ds.RectElement player = new ds.RectElement()
    ..attributes['width'] = '20'
    ..attributes['height'] = '110'
    ..attributes['y'] = '10'
    ..attributes['x'] = '$x';
  
  dom.window.onKeyPress.listen((dom.KeyboardEvent e) {
    int yMove = 0;
    if(e.keyCode == upKey) {
      yMove = -10;
    //} else if (e.keyCode == dom.KeyCode.S) {
    } else if (e.keyCode == downKey) {
      yMove = 10;
    }
    int y = int.parse(player.attributes['y']) + yMove;
    player.attributes['y'] = '$y';
  });
  
  return player;
}

void reverseText(dom.MouseEvent event) {
  var text = dom.document.querySelector("#sample_text_id").text;
  var buffer = new StringBuffer();
  for (int i = text.length - 1; i >= 0; i--) {
    buffer.write(text[i]);
  }
  dom.document.querySelector("#sample_text_id").text = buffer.toString();

  
  // BEGIN Dart2Js
  print("");
  print("printing js-helloStr in dart: ");
  print(context['helloStr']);
  print('');
  context.callMethod('sayHello');
  context.callMethod('myPrint', ['some args to be printed']);
  // END Dart2Js
}
