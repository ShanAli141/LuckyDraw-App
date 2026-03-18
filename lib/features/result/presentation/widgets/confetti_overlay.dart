import 'package:flutter/material.dart';

class ConfettiOverlay extends StatefulWidget {
  final bool show;

  const ConfettiOverlay({
    super.key,
    required this.show,
  });

  @override
  State<ConfettiOverlay> createState() => _ConfettiOverlayState();
}

class _ConfettiOverlayState extends State<ConfettiOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    _opacity = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
  }

  @override
  void didUpdateWidget(covariant ConfettiOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.show && !oldWidget.show) {
      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.show) return const SizedBox.shrink();

    return IgnorePointer(
      child: FadeTransition(
        opacity: _opacity,
        child: CustomPaint(
          painter: _ConfettiPainter(
            color: Theme.of(context).colorScheme.primary,
          ),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

class _ConfettiPainter extends CustomPainter {
  final Color color;

  _ConfettiPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color.withOpacity(0.4);
    final random = List.generate(60, (i) => i);

    for (final i in random) {
      final dx = (i * 37) % size.width;
      final dy = (i * 59) % size.height;
      final rect = Rect.fromLTWH(dx.toDouble(), dy.toDouble(), 6, 10);
      canvas.save();
      canvas.translate(rect.center.dx, rect.center.dy);
      canvas.rotate((i * 18) * 3.1415 / 180);
      canvas.translate(-rect.center.dx, -rect.center.dy);
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(2)),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) => false;
}