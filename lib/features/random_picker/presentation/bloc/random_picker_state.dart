import 'package:luckywinner/features/participants/data/participant_mode.dart';


enum RandomPickerStatus { idle, animating, done, error }

class RandomPickerState {
  final RandomPickerStatus status;
  final Participant? currentHighlight;
  final Participant? winner;
  final String? errorMessage;

  const RandomPickerState({
    required this.status,
    this.currentHighlight,
    this.winner,
    this.errorMessage,
  });

  factory RandomPickerState.initial() {
    return const RandomPickerState(status: RandomPickerStatus.idle);
  }

  RandomPickerState copyWith({
    RandomPickerStatus? status,
    Participant? currentHighlight,
    Participant? winner,
    String? errorMessage,
  }) {
    return RandomPickerState(
      status: status ?? this.status,
      currentHighlight: currentHighlight ?? this.currentHighlight,
      winner: winner ?? this.winner,
      errorMessage: errorMessage,
    );
  }
}