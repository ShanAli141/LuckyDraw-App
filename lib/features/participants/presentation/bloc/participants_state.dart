import 'package:luckywinner/features/participants/data/participant_mode.dart';


enum ParticipantsStatus { initial, loading, loaded, error }

class ParticipantsState {
  final ParticipantsStatus status;
  final List<Participant> participants;
  final String? errorMessage;

  const ParticipantsState({
    required this.status,
    required this.participants,
    this.errorMessage,
  });

  factory ParticipantsState.initial() {
    return const ParticipantsState(
      status: ParticipantsStatus.initial,
      participants: [],
    );
  }

  ParticipantsState copyWith({
    ParticipantsStatus? status,
    List<Participant>? participants,
    String? errorMessage,
  }) {
    return ParticipantsState(
      status: status ?? this.status,
      participants: participants ?? this.participants,
      errorMessage: errorMessage,
    );
  }
}