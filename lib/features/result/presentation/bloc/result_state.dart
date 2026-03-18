class ResultState {
  final String winnerName;
  final bool showConfetti;

  const ResultState({
    required this.winnerName,
    required this.showConfetti,
  });

  factory ResultState.initial(String winnerName) {
    return ResultState(
      winnerName: winnerName,
      showConfetti: true,
    );
  }

  ResultState copyWith({
    String? winnerName,
    bool? showConfetti,
  }) {
    return ResultState(
      winnerName: winnerName ?? this.winnerName,
      showConfetti: showConfetti ?? this.showConfetti,
    );
  }
}