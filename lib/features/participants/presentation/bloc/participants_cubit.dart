import 'package:bloc/bloc.dart';
import 'package:luckywinner/features/participants/data/participant_mode.dart';
import 'package:uuid/uuid.dart';

import '../../data/participants_local_data_source.dart';
import 'participants_state.dart';

class ParticipantsCubit extends Cubit<ParticipantsState> {
  final ParticipantsLocalDataSource _localDataSource;
  final _uuid = const Uuid();

  ParticipantsCubit(this._localDataSource) : super(ParticipantsState.initial());

  Future<void> load() async {
    emit(state.copyWith(status: ParticipantsStatus.loading));
    try {
      final list = await _localDataSource.loadParticipants();
      emit(
        state.copyWith(
          status: ParticipantsStatus.loaded,
          participants: list,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ParticipantsStatus.error,
          errorMessage: 'Failed to load participants',
        ),
      );
    }
  }

  Future<void> addParticipant(String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;

    final exists = state.participants.any(
      (p) => p.name.toLowerCase() == trimmed.toLowerCase(),
    );
    if (exists) return;

    final updated = [
      ...state.participants,
      Participant(id: _uuid.v4(), name: trimmed),
    ];
    await _persistAndEmit(updated);
  }

  Future<void> updateParticipant(String id, String newName) async {
    final trimmed = newName.trim();
    if (trimmed.isEmpty) return;

    final exists = state.participants.any(
      (p) => p.id != id && p.name.toLowerCase() == trimmed.toLowerCase(),
    );
    if (exists) return;

    final updated = state.participants
        .map((p) => p.id == id ? p.copyWith(name: trimmed) : p)
        .toList();
    await _persistAndEmit(updated);
  }

  Future<void> deleteParticipant(String id) async {
    final updated =
        state.participants.where((p) => p.id != id).toList();
    await _persistAndEmit(updated);
  }

  Future<void> clearAll() async {
    await _persistAndEmit([]);
  }

  Future<void> _persistAndEmit(List<Participant> updated) async {
    emit(state.copyWith(participants: updated));
    try {
      await _localDataSource.saveParticipants(updated);
    } catch (_) {
      // keep optimistic state
    }
  }
}