import 'package:flutter/material.dart';

class WheelPointer extends StatelessWidget {
  const WheelPointer({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Align(
      alignment: Alignment.topCenter,
      child: Transform.translate(
        offset: const Offset(0, -8),
        child: CustomPaint(
          size: const Size(32, 32),
          painter: _PointerPainter(color: color),
        ),
      ),
    );
  }
}

class _PointerPainter extends CustomPainter {
  final Color color;

  _PointerPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawShadow(path, Colors.black.withOpacity(0.3), 3, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _PointerPainter oldDelegate) => false;
}