import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luckywinner/features/participants/presentation/bloc/participants_cubit.dart';
import 'package:luckywinner/features/participants/presentation/bloc/participants_state.dart';
import 'package:luckywinner/features/participants/presentation/widgets/participants_input_bar.dart';
import 'package:luckywinner/features/participants/presentation/widgets/participants_list.dart';

import '../../../../core/widgets/app_scaffold.dart';


class ParticipantsPage extends StatelessWidget {
  const ParticipantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ParticipantsView();
  }
}

class _ParticipantsView extends StatelessWidget {
  const _ParticipantsView();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Participants',
      body: Column(
        children: [
          ParticipantInputBar(
            onSubmit: (name) =>
                context.read<ParticipantsCubit>().addParticipant(name),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BlocBuilder<ParticipantsCubit, ParticipantsState>(
              builder: (context, state) {
                if (state.status == ParticipantsStatus.loading &&
                    state.participants.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ParticipantList(
                  participants: state.participants,
                  onDelete: (p) => context
                      .read<ParticipantsCubit>()
                      .deleteParticipant(p.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}