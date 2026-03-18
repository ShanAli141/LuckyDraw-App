import 'package:flutter/material.dart';

class RandomShuffleDisplay extends StatelessWidget {
  final String? name;
  final bool isAnimating;

  const RandomShuffleDisplay({
    super.key,
    required this.name,
    required this.isAnimating,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final displayName = name ?? 'Tap "Start" to pick a winner';

    return AnimatedDefaultTextStyle(
      duration: const Duration(milliseconds: 150),
      style: theme.textTheme.displayMedium!.copyWith(
        color: isAnimating
            ? theme.colorScheme.primary
            : theme.textTheme.displayMedium!.color,
      ),
      child: Center(
        child: Text(
          displayName,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}