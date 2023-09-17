import 'package:cricket/features/model.dart';
import 'package:riverpod/riverpod.dart';

class CricketScoreNotifier extends StateNotifier<ScoreModel> {
  CricketScoreNotifier(ScoreModel state) : super(state);

  // Update the score based on the runs scored
  void updateScore(int runs) {
    state = state.copyWith(
      totalScore: state.totalScore + runs,
      // Update other relevant fields based on your app's logic
    );
  }

  // Get the total wickets
  int getWickets(int w) {
    state = state.copyWith(
      totalWickets: state.totalWickets + w,
    );

    return state.totalWickets;
  }

  // Get the current run rate
  double getRunRate() {
    if (state.totalOvers > 0) {
      return state.totalScore / state.totalOvers;
    } else {
      return 0.0;
    }
  }

  // Get the total dot balls
  int getDotBalls() {
    return state.dotBalls;
  }

  // Get the total fours
  int getFours() {
    return state.fours;
  }

  // Get the total sixes
  int getSixes() {
    return state.sixes;
  }

  // Get the total twos
  int getTwos() {
    return state.twos;
  }

  // Get the total threes
  int getThrees() {
    return state.threes;
  }

  // Get the total ones
  int getOnes() {
    return state.ones;
  }
}

// Create a provider for the repository using StateNotifier
final cricketScoreProvider =
    StateNotifierProvider<CricketScoreNotifier, ScoreModel>((ref) {
  return CricketScoreNotifier(
    ScoreModel(
      totalScore: 0,
      totalOvers: 10,
      totalWickets: 0,
      currentOver: 0,
      totalBalls: 0,
      currentBall: 0,
      requiredRunRate: 0.0,
      fours: 0,
      sixes: 0,
      twos: 0,
      threes: 0,
      ones: 0,
      dotBalls: 0,
    ),
  );
});
