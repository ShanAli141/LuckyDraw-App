import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:luckywinner/features/participants/data/participant_mode.dart';

import 'spin_wheel_state.dart';

class SpinWheelCubit extends Cubit<SpinWheelState> {
  final List<Participant> _participants;
  final _rand = Random();
  Timer? _timer;

  SpinWheelCubit(List<Participant> participants)
      : _participants = participants,
        super(SpinWheelState.initial());

  List<Participant> get participants => _participants;

  void spin() {
    if (_participants.isEmpty) {
      emit(
        state.copyWith(
          status: SpinWheelStatus.error,
          errorMessage: 'Add at least one participant first.',
        ),
      );
      return;
    }

    _timer?.cancel();

    final extraSpins = 4 + _rand.nextInt(3);
    final winnerIndex = _rand.nextInt(_participants.length);
    final sliceAngle = (2 * pi) / _participants.length;
    final targetAngle =
        (2 * pi * extraSpins) + (winnerIndex * sliceAngle) + sliceAngle / 2;

    const totalDuration = Duration(seconds: 3);
    const tick = Duration(milliseconds: 16);
    var elapsed = Duration.zero;

    emit(state.copyWith(
      status: SpinWheelStatus.spinning,
      winner: null,
    ));

    _timer = Timer.periodic(tick, (timer) {
      elapsed += tick;
      final t = (elapsed.inMilliseconds / totalDuration.inMilliseconds)
          .clamp(0.0, 1.0);
      final eased = 1 - pow(1 - t, 3);
      final angle = targetAngle * eased;

      emit(state.copyWith(
        angle: angle,
        status: SpinWheelStatus.spinning,
      ));

      if (t >= 1.0) {
        timer.cancel();
        final normalized = angle % (2 * pi);
        final index = (normalized / sliceAngle).floor() % _participants.length;
        final winner = _participants[index];

       // ResultSoundPlayer.playWinnerSound();

        emit(state.copyWith(
          status: SpinWheelStatus.done,
          angle: normalized,
          winner: winner,
        ));
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}