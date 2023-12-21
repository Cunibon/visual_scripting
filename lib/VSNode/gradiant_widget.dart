import 'package:flutter/material.dart';

class GradientLineShader extends StatelessWidget {
  final Offset? startPoint;
  final Color? startColor;

  final Offset? endPoint;
  final Color? endColor;

  final Widget child;

  const GradientLineShader({
    super.key,
    this.startPoint,
    this.startColor,
    this.endPoint,
    this.endColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (startPoint == null || endPoint == null) return child;

    var colors = [startColor ?? Colors.grey, endColor ?? Colors.grey];
    if (endPoint!.dx < 0) colors = colors.reversed.toList();

    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: colors,
          stops: const [0.0, 1.0], // Define stops for the gradient
        ).createShader(Rect.fromPoints(startPoint!, endPoint!));
      },
      blendMode: BlendMode.srcATop,
      child: child,
    );
  }
}
