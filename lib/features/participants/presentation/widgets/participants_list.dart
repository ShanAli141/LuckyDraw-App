import 'package:flutter/material.dart';
import 'package:luckywinner/features/participants/data/participant_mode.dart';


class ParticipantList extends StatelessWidget {
  final List<Participant> participants;
  final ValueChanged<Participant>? onTap;
  final ValueChanged<Participant>? onDelete;

  const ParticipantList({
    super.key,
    required this.participants,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (participants.isEmpty) {
      return Center(
        child: Text(
          'No participants yet.\nAdd some names to get started.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    return ListView.separated(
      itemCount: participants.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final participant = participants[index];
        return Material(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          child: ListTile(
            title: Text(participant.name),
            onTap: onTap != null ? () => onTap!(participant) : null,
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed:
                  onDelete != null ? () => onDelete!(participant) : null,
            ),
          ),
        );
      },
    );
  }
}