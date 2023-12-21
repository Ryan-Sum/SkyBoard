// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class BackgroundPainter extends CustomPainter {
  final Color primaryColor;

  BackgroundPainter({
    required this.primaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;

    final halfHeight = height * 0.75;

    Path wave = Path();
    wave.moveTo(width * 0.3719302, halfHeight * 0.1900599);
    wave.cubicTo(width * 0.1918128, halfHeight * 0.1646064, width * 0.1532163,
        halfHeight * 0.1527891, 0, halfHeight * 0.2845989);
    wave.lineTo(0, halfHeight);
    wave.lineTo(width, halfHeight);
    wave.lineTo(width, halfHeight * 0.02825281);
    wave.cubicTo(width * 0.8678372, halfHeight * -0.02174338, width * 0.7817698,
        halfHeight * 0.1286613, width * 0.7204674, halfHeight * 0.1555162);
    wave.cubicTo(width * 0.5918140, halfHeight * 0.2118766, width * 0.5520465,
        halfHeight * 0.2155118, width * 0.3719302, halfHeight * 0.1900599);
    wave.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = primaryColor;
    canvas.drawPath(wave.shift(Offset(0, halfHeight * 0.5)), paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
