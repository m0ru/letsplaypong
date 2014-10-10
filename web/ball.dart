import 'dart:html' as dom hide Text;
import 'dart:svg' as ds;

class Ball {
  ds.CircleElement circle;
  
  double vx = 0.001; //should be vector with random direction and that velocity
  double vy = 0.001;
  final double acceleration = 0.0000;
  
  Ball() {
    circle = new ds.CircleElement()
      ..attributes['r'] = '24'
      ..attributes['cx'] = '100'
      ..attributes['cy'] = '100';
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

  void move(double deltaT) {
    cx = cx + deltaT * vx;
    //vx += acceleration * deltaT;
    
    cy = cy + deltaT * vy;
    //vy += acceleration * deltaT;
  }
}