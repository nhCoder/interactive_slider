import 'package:flutter/material.dart';
import 'package:interactive_slider/interactive_slider.dart';

class InteractiveSliderPainter extends CustomPainter {
  InteractiveSliderPainter({
    required this.progress,
    this.secondaryProgress,
    Color secondaryColor = Colors.pink,
    required Color color,
    this.gradient,
    required this.gradientSize,
  })  : _paint = Paint()..color = color,
        _secondaryPaint = Paint()..color = secondaryColor,
        super(repaint: Listenable.merge([progress, secondaryProgress]));

  final ValueNotifier<double> progress;
  final ValueNotifier<double>? secondaryProgress;
  final Gradient? gradient;
  final GradientSize gradientSize;
  final Paint _paint;
  final Paint _secondaryPaint;

  @override
  void paint(Canvas canvas, Size size) {
    final progressRect =
        Rect.fromLTWH(0, 0, progress.value * size.width, size.height);

    if (gradient case var gradient?) {
      final sizeRect = switch (gradientSize) {
        GradientSize.totalWidth => Rect.fromLTWH(0, 0, size.width, size.height),
        GradientSize.progressWidth => progressRect,
      };
      _paint.shader = gradient.createShader(sizeRect);
    }
    //secondaryProgress
    if (secondaryProgress != null) {
      // print('secondaryProgress: ${secondaryProgress?.value}');
      final secondaryProgressRect = Rect.fromLTWH(
          0, 0, (secondaryProgress?.value)! * size.width, size.height);

      canvas.drawRect(secondaryProgressRect, _secondaryPaint);
    }

    canvas.drawRect(progressRect, _paint);
  }

  @override
  bool shouldRepaint(InteractiveSliderPainter oldDelegate) =>
      progress.value != oldDelegate.progress.value ||
      _paint.color != oldDelegate._paint.color ||
      secondaryProgress?.value != oldDelegate.secondaryProgress?.value ||
      _secondaryPaint.color != oldDelegate._secondaryPaint.color;
}
