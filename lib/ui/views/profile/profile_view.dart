import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_farm/resources/resources.dart';

@RoutePage()
class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18).copyWith(top: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  ClipOval(
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: Assets.images.logoJpg.image(fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 40,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        CupertinoIcons.pencil_outline,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text("UI Farm", style: TextStyle(fontSize: 20)),
            ),
            const SizedBox(height: 10),
            const Text('Name'),
            const SizedBox(height: 10),
            const DashedRRectBorder(
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(CupertinoIcons.person),
                  hint: Text('Nguyen Van A'),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text('Your Email'),
            const SizedBox(height: 10),
            DashedRRectBorder(
              padding: EdgeInsets.zero,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F2EE),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(CupertinoIcons.mail),
                    hintText: 'abc@gmail.com',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text('Phone Number'),
            const SizedBox(height: 10),
            const DashedRRectBorder(
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(CupertinoIcons.phone),
                  hint: Text('0123456789'),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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

    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );

    final path = Path()..addRRect(rrect);
    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final len = dashWidth;
        canvas.drawPath(metric.extractPath(distance, distance + len), paint);
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
