import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luckywinner/core/utils/ad_services.dart';
import 'package:luckywinner/features/result/presentation/bloc/result_cubit.dart';
import 'package:luckywinner/features/result/presentation/bloc/result_state.dart';
import 'package:luckywinner/features/result/presentation/widgets/confetti_overlay.dart';
import 'package:luckywinner/features/result/presentation/widgets/pick_again_action.dart';
import 'package:luckywinner/features/result/presentation/widgets/winner_banner.dart';

import '../../../../../core/widgets/app_scaffold.dart';

class ResultPage extends StatelessWidget {
  final Object? arguments;

  const ResultPage({super.key, this.arguments});

  @override
  Widget build(BuildContext context) {
    final args = (arguments is Map) ? arguments as Map : const {};
    final winnerName = (args['winnerName'] ?? 'Winner') as String;

    return BlocProvider(
      create: (_) => ResultCubit(winnerName),
      child: const _ResultView(),
    );
  }
}

class _ResultView extends StatelessWidget {
  const _ResultView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResultCubit, ResultState>(
      builder: (context, state) {
        return Stack(
          children: [
            AppScaffold(
              title: 'Result',
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(height: 24),
                  // Winner banner and actions
                ],
              ),
            ),
            AppScaffold(
              title: 'Result',
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WinnerBanner(winnerName: state.winnerName),
                  const SizedBox(height: 32),
                  const PickAgainActions(),
                  const SizedBox(height: 32),
                  const Center(child: BannerAdContainer()),
                ],
              ),
            ),
            ConfettiOverlay(show: state.showConfetti),
          ],
        );
      },
    );
  }
}
