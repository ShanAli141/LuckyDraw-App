import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luckywinner/config/routes.dart';
import 'package:luckywinner/core/theme/app_button.dart';
import 'package:luckywinner/features/participants/presentation/bloc/participants_cubit.dart';
import 'package:luckywinner/features/participants/presentation/bloc/participants_state.dart';
import 'package:luckywinner/features/result/presentation/bloc/spin_wheel_cubit.dart';
import 'package:luckywinner/features/result/presentation/bloc/spin_wheel_state.dart';

import '../../../../../core/widgets/app_scaffold.dart';

import '../widgets/wheel_canvas.dart';
import '../widgets/wheel_pointer.dart';

class SpinWheelPage extends StatelessWidget {
  const SpinWheelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParticipantsCubit, ParticipantsState>(
      builder: (context, participantsState) {
        final participants = participantsState.participants;
        final participantsKey = Object.hashAll(participants.map((p) => p.id));

        return BlocProvider(
          key: ValueKey(participantsKey),
          create: (_) => SpinWheelCubit(participants),
          child: const _SpinWheelView(),
        );
      },
    );
  }
}

class _SpinWheelView extends StatelessWidget {
  const _SpinWheelView();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Spin Wheel',
      body: Column(
        children: [
          const SizedBox(height: 16),
          BlocBuilder<ParticipantsCubit, ParticipantsState>(
            builder: (context, state) {
              return Text(
                'Participants: ${state.participants.length}',
                style: Theme.of(context).textTheme.bodyMedium,
              );
            },
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                BlocBuilder<SpinWheelCubit, SpinWheelState>(
                  builder: (context, state) {
                    final participants = context
                        .read<SpinWheelCubit>()
                        .participants;
                    return WheelCanvas(
                      participants: participants,
                      angle: state.angle,
                    );
                  },
                ),
                const WheelPointer(),
              ],
            ),
          ),
          const SizedBox(height: 16),
          BlocBuilder<SpinWheelCubit, SpinWheelState>(
            builder: (context, state) {
              final isSpinning = state.status == SpinWheelStatus.spinning;
              final hasWinner = state.winner != null;

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppButton(
                    label: isSpinning
                        ? 'Spinning...'
                        : (hasWinner ? 'Spin Again' : 'Spin'),
                    icon: Icons.rotate_right,
                    onPressed: isSpinning
                        ? null
                        : () => context.read<SpinWheelCubit>().spin(),
                  ),
                  const SizedBox(width: 12),
                  if (hasWinner)
                    AppButton(
                      label: 'View Result',
                      isPrimary: false,
                      icon: Icons.emoji_events_outlined,
                      onPressed: () {
                        final winnerName = state.winner?.name ?? 'Winner';
                        Navigator.of(context).pushNamed(
                          AppRoutes.result,
                          arguments: {'winnerName': winnerName},
                        );
                      },
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
