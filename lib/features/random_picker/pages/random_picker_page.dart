import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luckywinner/core/theme/app_button.dart';
import 'package:luckywinner/features/participants/presentation/bloc/participants_cubit.dart';
import 'package:luckywinner/features/participants/presentation/bloc/participants_state.dart';
import 'package:luckywinner/features/random_picker/presentation/bloc/random_picker_cubit.dart';
import 'package:luckywinner/features/random_picker/presentation/bloc/random_picker_state.dart';
import 'package:luckywinner/features/random_picker/presentation/widgets/random_shuffle_display.dart';

import '../../../../core/widgets/app_scaffold.dart';
import '../../../../config/routes.dart';


class RandomPickerPage extends StatelessWidget {
  const RandomPickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParticipantsCubit, ParticipantsState>(
      builder: (context, participantsState) {
        final participants = participantsState.participants;
        final participantsKey = Object.hashAll(participants.map((p) => p.id));

        return BlocProvider(
          key: ValueKey(participantsKey),
          create: (_) => RandomPickerCubit(participants),
          child: const _RandomPickerView(),
        );
      },
    );
  }
}

class _RandomPickerView extends StatelessWidget {
  const _RandomPickerView();

  void _goToResult(BuildContext context, String winnerName) {
    Navigator.of(context).pushNamed(
      AppRoutes.result,
      arguments: {'winnerName': winnerName},
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Random Picker',
      body: Column(
        children: [
          const SizedBox(height: 24),
          BlocBuilder<ParticipantsCubit, ParticipantsState>(
            builder: (context, state) {
              return Text(
                'Participants: ${state.participants.length}',
                style: Theme.of(context).textTheme.bodyMedium,
              );
            },
          ),
          const SizedBox(height: 24),
          Expanded(
            child: BlocBuilder<RandomPickerCubit, RandomPickerState>(
              builder: (context, state) {
                final isAnimating =
                    state.status == RandomPickerStatus.animating;
                return RandomShuffleDisplay(
                  name: state.currentHighlight?.name,
                  isAnimating: isAnimating,
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          BlocBuilder<RandomPickerCubit, RandomPickerState>(
            builder: (context, state) {
              final isAnimating =
                  state.status == RandomPickerStatus.animating;
              final hasWinner = state.winner != null;

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppButton(
                    label: isAnimating
                        ? 'Picking...'
                        : (hasWinner ? 'Pick Again' : 'Start'),
                    icon: Icons.play_arrow,
                    onPressed: isAnimating
                        ? null
                        : () {
                            context
                                .read<RandomPickerCubit>()
                                .startShuffle();
                          },
                  ),
                  const SizedBox(width: 12),
                  if (hasWinner)
                    AppButton(
                      label: 'View Result',
                      isPrimary: false,
                      icon: Icons.emoji_events_outlined,
                      onPressed: () {
                        final winnerName =
                            state.winner?.name ?? 'Unknown';
                        _goToResult(context, winnerName);
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