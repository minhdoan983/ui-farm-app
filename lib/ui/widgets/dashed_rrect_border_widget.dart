import 'package:flutter/material.dart';

class DashedRRectBorder extends StatelessWidget {
  const DashedRRectBorder({
    super.key,
    required this.child,
    this.radius = 12,
    this.strokeWidth = 1.5,
    this.dashWidth = 6,
    this.dashGap = 4,
    this.color = Colors.black,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  });

  final Widget child;
  final double radius;
  final double strokeWidth;
  final double dashWidth;
  final double dashGap;
  final Color color;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedRRectPainter(
        radius: radius,
        strokeWidth: strokeWidth,
        dashWidth: dashWidth,
        dashGap: dashGap,
        color: color,
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}

class _DashedRRectPainter extends CustomPainter {
  _DashedRRectPainter({
    required this.radius,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashGap,
    required this.color,
  });

  final double radius;
  final double strokeWidth;
  final double dashWidth;
  final double dashGap;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final rrect = RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(radius));

    final path = Path()..addRRect(rrect);
    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        canvas.drawPath(metric.extractPath(distance, distance + dashWidth), paint);
        distance += dashWidth + dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedRRectPainter oldDelegate) {
    return oldDelegate.radius != radius ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.dashGap != dashGap ||
        oldDelegate.color != color;
  }
}
