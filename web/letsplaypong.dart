import 'dart:html' as dom hide Text;
//import 'dart:svg';
import 'dart:js';
import 'package:smartcanvas/smartcanvas.dart';



void main() {
  dom.Element pongCourt = dom.document.querySelector("#pongCourt");
  //RectElement barA = new RectElement();
  //barA.height = 50;
  //barA.width = 50;
  //pongCourt.append(barA);


  dom.document.querySelector("#sample_text_id")
      ..text = "Click me!"
      ..onClick.listen(reverseText);

  //TODO write wrapper for Raffael
  // should be simply importable
  // or look into dart svg


  Rect rect = new Rect({
    WIDTH: 100,
    HEIGHT: 100,
    FILL: 'red',
    OFFSET_X: -100,
    OFFSET_Y: -100
  });

  dom.Element svgContainer = dom.document.querySelector('.svg-canvas');
  Stage svgStage = new Stage(svgContainer, svg, {});

  //dom.Element canvasContainer = dom.document.querySelector('.canvas-canvas');
  //Stage canvasStage = new Stage(canvasContainer, canvas, {});

  //var shapes = dom.document.querySelectorAll('input[type=checkbox]:checked');

  //shapes.forEach((shape) {
  var node, svgNode, canvasNode;

  node = rect;
  svgNode = node.clone({
    DRAGGABLE: true
  });
  svgNode.on(MOUSEDOWN, (e) {
    svgNode.moveToTop();
  });
  svgStage.addChild(svgNode);


  //querySelector("#playerA")
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
