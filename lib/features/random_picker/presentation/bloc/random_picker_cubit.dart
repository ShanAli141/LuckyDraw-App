import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:luckywinner/features/participants/data/participant_mode.dart';

import 'random_picker_state.dart';

class RandomPickerCubit extends Cubit<RandomPickerState> {
  final List<Participant> _participants;
  final _rand = Random();
  Timer? _timer;

  RandomPickerCubit(List<Participant> participants)
      : _participants = participants,
        super(RandomPickerState.initial());

  Future<void> startShuffle() async {
    if (_participants.isEmpty) {
      emit(
        state.copyWith(
          status: RandomPickerStatus.error,
          errorMessage: 'Add at least one participant first.',
        ),
      );
      return;
    }

    _timer?.cancel();
    emit(RandomPickerState.initial().copyWith(
      status: RandomPickerStatus.animating,
    ));

    const totalDuration = Duration(seconds: 2);
    const tickDuration = Duration(milliseconds: 80);
    var elapsed = Duration.zero;

    _timer = Timer.periodic(tickDuration, (timer) {
      elapsed += tickDuration;
      final randomIndex = _rand.nextInt(_participants.length);
      final highlight = _participants[randomIndex];

      emit(
        state.copyWith(
          status: RandomPickerStatus.animating,
          currentHighlight: highlight,
        ),
      );

      if (elapsed >= totalDuration) {
        timer.cancel();
        final winnerIndex = _rand.nextInt(_participants.length);
        final winner = _participants[winnerIndex];

        // ResultSoundPlayer.playWinnerSound();

        emit(
          state.copyWith(
            status: RandomPickerStatus.done,
            currentHighlight: winner,
            winner: winner,
          ),
        );
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}