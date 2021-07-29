import 'dart:math';

import 'package:flutter/material.dart';

class WGradientRing extends StatelessWidget {
  /// Creates a instagram-story style gradient ring around your widget.
  /// 
  /// Wrap this around your story widget, that is make this the parent of the story widget. For example:
  /// 
  /// ```dart
  /// WGradientRing(
  ///   child: CircleAvatar(foregroundImage: NetworkImage("ImageUrl")) // Assuming the story is [CircleAvatar]
  /// )
  /// ```
  const WGradientRing({ Key? key, this.width = 4.0, this.padding = 0.0, required this.child }) 
  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RingPainter(width),
      child: Container(        
        padding: EdgeInsets.all(padding + width),
        child: child
      )
    );
  }


  /// The width(thickness) of the gradient ring. 
  /// 
  /// Defaults to 4.0.
  final double width;
  /// The space between the ring and its child.
  /// 
  /// Defaults to 0.
  final double padding;
  final Widget child;
}

class RingPainter extends CustomPainter {
  RingPainter(this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width/2, size.height/2);
    final double radius = min(size.width, size.height)/2 - strokeWidth/2;
    const SweepGradient gradient = SweepGradient(
      colors: <Color>[Colors.purple, Colors.orange, Colors.purple]
    );

    final Paint brush = Paint()
    ..color = Colors.red
    ..shader = gradient.createShader(
      Rect.fromCenter(center: center, width: size.width, height: size.height)
    )
    ..style = PaintingStyle.stroke
    ..strokeWidth = strokeWidth;

    
    canvas.drawCircle(center, radius, brush);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;


  final double strokeWidth;
}