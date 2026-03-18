import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'lucky_draw_bottom_sheet.dart';

class LuckyDrawBanner extends StatefulWidget {
  const LuckyDrawBanner({super.key});

  @override
  State<LuckyDrawBanner> createState() => _LuckyDrawBannerState();
}

class _LuckyDrawBannerState extends State<LuckyDrawBanner>
    with TickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final AnimationController _shimmerController;
  late final AnimationController _floatController;

  late final Animation<double> _pulseAnim;
  late final Animation<double> _shimmerAnim;
  late final Animation<double> _floatAnim;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat(reverse: true);

    _pulseAnim = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _shimmerAnim = Tween<double>(begin: -1.5, end: 2.5).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );

    _floatAnim = Tween<double>(begin: -3, end: 3).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _shimmerController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  void _openBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const LuckyDrawBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: Listenable.merge([_pulseAnim, _shimmerAnim, _floatAnim]),
      builder: (context, child) {
        return Transform.scale(
          scale: _pulseAnim.value,
          child: Transform.translate(
            offset: Offset(0, _floatAnim.value),
            child: GestureDetector(
              onTap: _openBottomSheet,
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF1A0533),
                      Color(0xFF3B0764),
                      Color(0xFF6D28D9),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF7C3AED).withValues(alpha: 0.5),
                      blurRadius: 20,
                      spreadRadius: 1,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: [
                      // Background orbs
                      Positioned(
                        right: -30,
                        top: -30,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.06),
                          ),
                        ),
                      ),
                      Positioned(
                        left: -20,
                        bottom: -20,
                        child: Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(
                              0xFFEAB308,
                            ).withValues(alpha: 0.12),
                          ),
                        ),
                      ),
                      // Shimmer sweep
                      Positioned.fill(
                        child: ShaderMask(
                          shaderCallback: (rect) {
                            return LinearGradient(
                              begin: Alignment(_shimmerAnim.value - 1, 0),
                              end: Alignment(_shimmerAnim.value, 0),
                              colors: [
                                Colors.transparent,
                                Colors.white.withValues(alpha: 0.07),
                                Colors.transparent,
                              ],
                            ).createShader(rect);
                          },
                          child: Container(color: Colors.white),
                        ),
                      ),
                      // Content
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 16,
                        ),
                        child: Row(
                          children: [
                            // Trophy icon with glow ring
                            _PulsingTrophy(pulse: _pulseAnim.value),
                            const SizedBox(width: 14),
                            // Text
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 3,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFEAB308),
                                          borderRadius: BorderRadius.circular(
                                            999,
                                          ),
                                        ),
                                        child: const Text(
                                          'LIVE DRAW',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w800,
                                            color: Color(0xFF1A0533),
                                            letterSpacing: 0.8,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      _BlinkingDot(),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  const Text(
                                    'Lucky Draw — Win Big!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      height: 1.2,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Entry: Rs. 1 only · Tap to join',
                                    style: TextStyle(
                                      color: Colors.white.withValues(
                                        alpha: 0.75,
                                      ),
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Arrow
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.18),
                                ),
                              ),
                              child: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PulsingTrophy extends StatelessWidget {
  final double pulse;
  const _PulsingTrophy({required this.pulse});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFEAB308).withValues(alpha: 0.15 * pulse),
          ),
        ),
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFEAB308), Color(0xFFF59E0B)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFEAB308).withValues(alpha: 0.4),
                blurRadius: 12,
                spreadRadius: 1,
              ),
            ],
          ),
          child: const Icon(
            Icons.emoji_events_rounded,
            color: Color(0xFF1A0533),
            size: 26,
          ),
        ),
      ],
    );
  }
}

class _BlinkingDot extends StatefulWidget {
  @override
  State<_BlinkingDot> createState() => _BlinkingDotState();
}

class _BlinkingDotState extends State<_BlinkingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _ctrl,
      child: Container(
        width: 7,
        height: 7,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF4ADE80),
        ),
      ),
    );
  }
}
