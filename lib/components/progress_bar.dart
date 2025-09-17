import 'dart:ui';

import 'package:flame/components.dart';

class ProgressBar extends PositionComponent {
  final double maxValue;
  double currentValue;
  final Color backgroundColor;
  final Color foregroundColor;
  final double width;
  final double height;
  final bool showBorder;
  final Color borderColor;
  final double borderWidth;

  ProgressBar({
    required this.maxValue,
    required this.currentValue,
    this.backgroundColor = const Color(0xFF555555),
    this.foregroundColor = const Color(0xFF00FF00),
    required this.width,
    required this.height,
    this.showBorder = true,
    this.borderColor = const Color(0xFF000000),
    this.borderWidth = 2,
    super.position,
  });

  @override
  void render(Canvas canvas) {
    final backgroundPaint = Paint()..color = backgroundColor;
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, width, height),
            Radius.circular(10)
        ),
        backgroundPaint
    );

    final progressWidth = (currentValue / maxValue) * width;
    final progressPaint = Paint()..color = foregroundColor;
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, progressWidth, height),
            Radius.circular(10)
        ),
        progressPaint
    );

    if (showBorder) {
      final borderPaint = Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth;
      canvas.drawRRect(
          RRect.fromRectAndRadius(
              Rect.fromLTWH(0, 0, width, height),
              Radius.circular(10)),
          borderPaint
      );
    }
  }

  void updateValue(double newValue) {
    currentValue = newValue.clamp(0, maxValue);
  }
}