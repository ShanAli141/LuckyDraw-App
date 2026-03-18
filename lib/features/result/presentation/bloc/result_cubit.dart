import 'package:bloc/bloc.dart';

import 'result_state.dart';

class ResultCubit extends Cubit<ResultState> {
  ResultCubit(String winnerName) : super(ResultState.initial(winnerName));

  void replayConfetti() {
    emit(state.copyWith(showConfetti: false));
    emit(state.copyWith(showConfetti: true));
  }
}