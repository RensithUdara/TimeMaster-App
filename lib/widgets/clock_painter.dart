import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ClockPainterView extends ConsumerWidget {
  const ClockPainterView(this.dateTime, {super.key});
  final DateTime dateTime;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.width * 0.8, // Keep it square
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          isComplex: true,
          painter: ClockPainter(datetime: dateTime),
          willChange: true,
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  ClockPainter({required this.datetime});
  final DateTime datetime;

  //60 sec 360 = 1 sec - 6degree
  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);
    var fillBrush = Paint()..color = Color(0xFF444974);
    var outlineBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..strokeWidth = size.width * 0.05
      ..style = PaintingStyle.stroke;
    var centerBrush = Paint()..color = Color(0xFFEAECFF);
    var secondHandBrush = Paint()
      ..color = Colors.orange.shade300
      ..shader = RadialGradient(
              colors: [Colors.amberAccent, Colors.amberAccent.shade400])
          .createShader(
        Rect.fromCircle(center: center, radius: radius),
      )
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width * 0.02;

    var minuteHandBrush = Paint()
      ..color = Colors.orange.shade300
      ..shader = RadialGradient(colors: [Colors.lightBlue, Colors.pinkAccent])
          .createShader(
        Rect.fromCircle(center: center, radius: radius),
      )
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width * 0.0275;
    var hourondHandBrush = Paint()
      ..color = Colors.orange.shade300
      ..shader =
          RadialGradient(colors: [Colors.pink, Colors.pinkAccent]).createShader(
        Rect.fromCircle(center: center, radius: radius),
      )
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width * 0.04;

    var dashBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..strokeWidth = size.width * 0.01
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius - size.width * 0.15, fillBrush);
    canvas.drawCircle(center, radius - size.width * 0.15, outlineBrush);
    var hourHandX = centerX +
        (radius * 0.5) *
            cos((datetime.hour * 30 + datetime.minute * 0.5) * pi / 180);
    var hourHandY = centerY +
        (radius * 0.5) *
            sin((datetime.hour * 30 + datetime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourondHandBrush);
    var minuteHandX =
        centerX + (radius * 0.5) * cos(datetime.minute * 6 * pi / 180);
    var minuteHandY =
        centerY + (radius * 0.5) * sin(datetime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minuteHandX, minuteHandY), minuteHandBrush);
    var secondHandX =
        centerX + (radius * 0.55) * cos(datetime.second * 6 * pi / 180);
    var secondHandY =
        centerY + (radius * 0.55) * sin(datetime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secondHandX, secondHandY), secondHandBrush);
    canvas.drawCircle(center, 16, centerBrush);

    var outerCircleRadius = radius;
    var innerCircleRadius = radius - size.width * 0.05;
    for (var i = 0; i < 360; i += 12) {
      var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
      var y1 = centerY + outerCircleRadius * sin(i * pi / 180);
      var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centerY + innerCircleRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
