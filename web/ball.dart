import 'dart:html' as dom hide Text;
import 'dart:svg' as ds;

class Ball {
  ds.CircleElement circle;
  
  double vx = 0.1; //should be vector with random direction and that velocity
  double vy = 0.1;
   
  double cxOld = 100.0;
  double cyOld = 100.0;
  
  Ball() {
    circle = new ds.CircleElement()
      ..attributes['r'] = '24'
      ..attributes['cx'] = '$cxOld'
      ..attributes['cy'] = '$cyOld';
  }
  double get cx {
    return double.parse(circle.attributes['cx']);
  }
  void set cx(double cx) {
    circle.attributes['cx'] = '$cx';
  }
  double get cy {
    return double.parse(circle.attributes['cy']);
  }
  void set cy(double cy) {
     circle.attributes['cy'] = '$cy';
   }
  double get r {
    return double.parse(circle.attributes['r']);
  }
}