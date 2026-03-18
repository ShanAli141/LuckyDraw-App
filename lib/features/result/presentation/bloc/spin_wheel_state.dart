import 'package:luckywinner/features/participants/data/participant_mode.dart';


enum SpinWheelStatus { idle, spinning, done, error }

class SpinWheelState {
  final SpinWheelStatus status;
  final double angle;
  final Participant? winner;
  final String? errorMessage;

  const SpinWheelState({
    required this.status,
    required this.angle,
    this.winner,
    this.errorMessage,
  });

  factory SpinWheelState.initial() {
    return const SpinWheelState(
      status: SpinWheelStatus.idle,
      angle: 0,
    );
  }

  SpinWheelState copyWith({
    SpinWheelStatus? status,
    double? angle,
    Participant? winner,
    String? errorMessage,
  }) {
    return SpinWheelState(
      status: status ?? this.status,
      angle: angle ?? this.angle,
      winner: winner ?? this.winner,
      errorMessage: errorMessage,
    );
  }
}