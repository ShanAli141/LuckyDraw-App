import 'package:flutter/material.dart';
import 'package:luckywinner/core/theme/app_button.dart';

import '../../../../../config/routes.dart';

class PickAgainActions extends StatelessWidget {
  const PickAgainActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppButton(
          label: 'Pick Again',
          icon: Icons.refresh,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        const SizedBox(height: 8),
        AppButton(
          label: 'Back to Home',
          isPrimary: false,
          icon: Icons.home_outlined,
          onPressed: () {
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
          },
        ),
      ],
    );
  }
}
