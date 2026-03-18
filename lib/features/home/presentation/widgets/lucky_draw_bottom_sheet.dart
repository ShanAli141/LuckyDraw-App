import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

/// Model — swap out with remote config / Firestore later
class LuckyDrawConfig {
  static const String title = 'Monthly Lucky Draw';
  static const String prize = 'Rs. 500 Cash Prize';
  static const String entryFee = 'Rs. 1';
  static const String drawDate = 'March 31, 2025';
  static const String totalSlots = '500';
  static const String remainingSlots = '214';
  static const String easyPaisaNumber = '03XX-XXXXXXX'; // ← your number
  static const String jazzCashNumber = '03XX-XXXXXXX'; // ← your number
  static const String googleFormUrl =
      'https://forms.gle/XXXXXXXXXXXXXXXXX'; // ← your form
  static const String paymentNote = 'LUCKY'; // note in payment app
}

class LuckyDrawBottomSheet extends StatelessWidget {
  const LuckyDrawBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bottomPadding =
        MediaQuery.of(context).viewInsets.bottom +
        MediaQuery.of(context).padding.bottom;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F0A1E) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.fromLTRB(20, 12, 20, 20 + bottomPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          const SizedBox(height: 20),

          // Header
          _DrawHeader(isDark: isDark),
          const SizedBox(height: 20),

          // Stats row
          _StatsRow(),
          const SizedBox(height: 20),

          // How to enter
          _HowToEnterCard(isDark: isDark),
          const SizedBox(height: 16),

          // Payment buttons
          _PaymentButton(
            label: 'Pay via Easypaisa',
            number: LuckyDrawConfig.easyPaisaNumber,
            color: const Color(0xFF00A651),
            icon: Icons.account_balance_wallet_rounded,
            onTap: () => _copyAndHint(
              context,
              LuckyDrawConfig.easyPaisaNumber,
              'Easypaisa',
            ),
          ),
          const SizedBox(height: 10),
          _PaymentButton(
            label: 'Pay via JazzCash',
            number: LuckyDrawConfig.jazzCashNumber,
            color: const Color(0xFFED1C24),
            icon: Icons.account_balance_wallet_rounded,
            onTap: () => _copyAndHint(
              context,
              LuckyDrawConfig.jazzCashNumber,
              'JazzCash',
            ),
          ),
          const SizedBox(height: 16),

          // Register button
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () => _openForm(context),
              icon: const Icon(Icons.how_to_reg_rounded),
              label: const Text('Register After Payment'),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF6D28D9),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                textStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),

          Text(
            'Send Rs. 1 with note "${LuckyDrawConfig.paymentNote}", '
            'then fill the registration form.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  void _copyAndHint(BuildContext context, String number, String label) {
    Clipboard.setData(ClipboardData(text: number));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label number copied — open your app and paste!'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF6D28D9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Future<void> _openForm(BuildContext context) async {
    final uri = Uri.parse(LuckyDrawConfig.googleFormUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open registration form')),
        );
      }
    }
  }
}

// ── Sub-widgets ────────────────────────────────────────────────────────────

class _DrawHeader extends StatelessWidget {
  final bool isDark;
  const _DrawHeader({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFFEAB308), Color(0xFFF59E0B)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Icon(
            Icons.emoji_events_rounded,
            color: Color(0xFF1A0533),
            size: 28,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LuckyDrawConfig.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                '🎁 Prize: ${LuckyDrawConfig.prize}',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? const Color(0xFFEAB308)
                      : const Color(0xFF92400E),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatChip(
          icon: Icons.calendar_today_rounded,
          label: 'Draw Date',
          value: LuckyDrawConfig.drawDate,
          color: const Color(0xFF6D28D9),
        ),
        const SizedBox(width: 10),
        _StatChip(
          icon: Icons.people_rounded,
          label: 'Slots Left',
          value:
              '${LuckyDrawConfig.remainingSlots}/${LuckyDrawConfig.totalSlots}',
          color: const Color(0xFF059669),
        ),
        const SizedBox(width: 10),
        _StatChip(
          icon: Icons.local_offer_rounded,
          label: 'Entry Fee',
          value: LuckyDrawConfig.entryFee,
          color: const Color(0xFFEAB308),
        ),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: isDark ? 0.15 : 0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 10.5,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HowToEnterCard extends StatelessWidget {
  final bool isDark;
  const _HowToEnterCard({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : const Color(0xFFF5F3FF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFF6D28D9).withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'How to enter',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          _Step(
            n: '1',
            text:
                'Send Rs. 1 to our Easypaisa or JazzCash number below with note "${LuckyDrawConfig.paymentNote}"',
          ),
          _Step(n: '2', text: 'Tap "Register After Payment" and fill the form'),
          _Step(
            n: '3',
            text:
                'Winner announced on ${LuckyDrawConfig.drawDate} inside the app',
          ),
        ],
      ),
    );
  }
}

class _Step extends StatelessWidget {
  final String n;
  final String text;
  const _Step({required this.n, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            margin: const EdgeInsets.only(top: 1),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF6D28D9).withValues(alpha: 0.15),
            ),
            child: Center(
              child: Text(
                n,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF6D28D9),
                ),
              ),
            ),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12.5,
                height: 1.45,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.75),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentButton extends StatelessWidget {
  final String label;
  final String number;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  const _PaymentButton({
    required this.label,
    required this.number,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          side: BorderSide(color: color.withValues(alpha: 0.5)),
          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          backgroundColor: color.withValues(alpha: 0.06),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    number,
                    style: TextStyle(
                      fontSize: 12,
                      color: color.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.copy_rounded,
              size: 18,
              color: color.withValues(alpha: 0.6),
            ),
          ],
        ),
      ),
    );
  }
}
