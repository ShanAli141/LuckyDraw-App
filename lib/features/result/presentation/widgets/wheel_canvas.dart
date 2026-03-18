import 'dart:math';

import 'package:flutter/material.dart';
import 'package:luckywinner/features/participants/data/participant_mode.dart';


class WheelCanvas extends StatelessWidget {
  final List<Participant> participants;
  final double angle;

  const WheelCanvas({
    super.key,
    required this.participants,
    required this.angle,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Transform.rotate(
        angle: angle,
        child: CustomPaint(
          painter: _WheelPainter(
            participants: participants,
            textStyle: Theme.of(context).textTheme.bodySmall ??
                const TextStyle(fontSize: 12),
          ),
        ),
      ),
    );
  }
}

class _WheelPainter extends CustomPainter {
  final List<Participant> participants;
  final TextStyle textStyle;

  _WheelPainter({
    required this.participants,
    required this.textStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final count = participants.isEmpty ? 1 : participants.length;
    final sliceAngle = 2 * pi / count;
    final radius = size.shortestSide / 2;
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()..style = PaintingStyle.fill;

    final colors = [
      Colors.deepPurple,
      Colors.deepPurpleAccent,
      Colors.purple,
      Colors.indigo,
      Colors.blueAccent,
    ];

    for (var i = 0; i < count; i++) {
      final startAngle = i * sliceAngle;
      paint.color = colors[i % colors.length].withOpacity(0.9);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sliceAngle,
        true,
        paint,
      );

      final label =
          participants.isEmpty ? 'No\nParticipants' : participants[i].name;
      final textSpan = TextSpan(
        text: label,
        style: textStyle.copyWith(color: Colors.white),
      );
      final tp = TextPainter(
        text: textSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
        maxLines: 2,
      )..layout(maxWidth: radius * 0.8);

      final labelAngle = startAngle + sliceAngle / 2;
      final labelRadius = radius * 0.6;
      final labelOffset = Offset(
        center.dx + cos(labelAngle) * labelRadius - tp.width / 2,
        center.dy + sin(labelAngle) * labelRadius - tp.height / 2,
      );
      tp.paint(canvas, labelOffset);
    }

    final centerPaint = Paint()
      ..color = Colors.white.withOpacity(0.9);
    canvas.drawCircle(center, radius * 0.18, centerPaint);
  }

  @override
  bool shouldRepaint(covariant _WheelPainter oldDelegate) {
    return oldDelegate.participants != participants ||
        oldDelegate.textStyle != textStyle;
  }
}