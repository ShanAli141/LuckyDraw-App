import 'package:flutter/material.dart';

class WinnerBanner extends StatelessWidget {
  final String winnerName;

  const WinnerBanner({
    super.key,
    required this.winnerName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.emoji_events,
            color: theme.colorScheme.onPrimary,
            size: 48,
          ),
          const SizedBox(height: 12),
          Text(
            'Winner',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            winnerName,
            textAlign: TextAlign.center,
            style: theme.textTheme.displayMedium?.copyWith(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}