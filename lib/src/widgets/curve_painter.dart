import 'package:flutter/material.dart';
import '../../app_colors.dart';

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = raspberry;
    // create a path
    var path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.300,
        size.width * 0.5, size.height * 0.760);
    path.quadraticBezierTo(size.width * 0.75, size.height * 1.3, size.width * 1,
        size.height * 0.940);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
