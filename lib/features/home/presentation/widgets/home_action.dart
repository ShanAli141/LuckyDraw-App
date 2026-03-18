import 'package:flutter/material.dart';

import '../../../../config/routes.dart';

class HomeActions extends StatelessWidget {
  const HomeActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Get started',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _ActionCard(
                title: 'Participants',
                subtitle: 'Add & manage names',
                icon: Icons.group_outlined,
                tint: const Color(0xFF6C5CE7),
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.participants),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ActionCard(
                title: 'Random picker',
                subtitle: 'Fast fair winner',
                icon: Icons.casino_outlined,
                tint: const Color(0xFF00C896),
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.randomPicker),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _ActionCard(
          title: 'Spin wheel',
          subtitle: 'Fun animated draw',
          icon: Icons.rotate_right,
          tint: const Color(0xFFFFC857),
          onTap: () => Navigator.of(context).pushNamed(AppRoutes.spinWheel),
          wide: true,
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color tint;
  final VoidCallback onTap;
  final bool wide;

  const _ActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.tint,
    required this.onTap,
    this.wide = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bg = isDark
        ? theme.colorScheme.surface.withValues(alpha: 0.60)
        : Colors.white;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: theme.colorScheme.primary.withValues(alpha: isDark ? 0.22 : 0.10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.18 : 0.06),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        tint.withValues(alpha: 0.18),
                        tint.withValues(alpha: 0.08),
                      ],
                    ),
                  ),
                  child: Icon(icon, color: tint, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.75),
                        ),
                      ),
                    ],
                  ),
                ),
                if (wide) ...[
                  const SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.55),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}