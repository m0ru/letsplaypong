import 'dart:html';
import 'dart:svg';


void main() {
  Element pongCourt = querySelector("#pongCourt");
  RectElement barA = new RectElement();
  //barA.height = 50;
  //barA.width = 50;
  pongCourt.append(barA);
  
  
  querySelector("#sample_text_id")
      ..text = "Click me!"
      ..onClick.listen(reverseText);
  
  //querySelector("#playerA")
}

void reverseText(MouseEvent event) {
  var text = querySelector("#sample_text_id").text;
  var buffer = new StringBuffer();
  for (int i = text.length - 1; i >= 0; i--) {
    buffer.write(text[i]);
  }
  querySelector("#sample_text_id").text = buffer.toString();
}
