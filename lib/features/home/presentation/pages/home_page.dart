import 'package:flutter/material.dart';
import 'package:luckywinner/core/utils/ad_services.dart';
import 'package:luckywinner/features/home/presentation/widgets/home_action.dart';
import 'package:luckywinner/features/home/presentation/widgets/lucky_draw_banner.dart';

import '../../../../core/widgets/app_scaffold.dart';
import '../widgets/home_header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(title: null, body: const _HomeBody());
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LuckyDrawBanner(),

                HomeHeader(),
                SizedBox(height: 20),
                HomeActions(),
                SizedBox(height: 20),
                Center(child: BannerAdContainer()),
              ],
            ),
          ),
        );
      },
    );
  }
}
