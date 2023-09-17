import 'dart:convert';

class ScoreModel {
  final int totalScore;
  final int totalOvers;
  final int totalWickets;
  final int currentOver;
  final int totalBalls;
  final int currentBall;
  final double requiredRunRate;
  final int fours;
  final int sixes;
  final int twos;
  final int threes;
  final int ones;

  final int dotBalls;

  ScoreModel({
    required this.totalScore,
    required this.totalOvers,
    required this.totalWickets,
    required this.currentOver,
    required this.totalBalls,
    required this.currentBall,
    required this.requiredRunRate,
    required this.fours,
    required this.sixes,
    required this.twos,
    required this.threes,
    required this.ones,
    required this.dotBalls,
  });

  ScoreModel copyWith({
    int? totalScore,
    int? totalOvers,
    int? totalWickets,
    int? currentOver,
    int? totalBalls,
    int? currentBall,
    double? requiredRunRate,
    int? fours,
    int? sixes,
    int? twos,
    int? threes,
    int? ones,
    int? dotBalls,
  }) {
    return ScoreModel(
      totalScore: totalScore ?? this.totalScore,
      totalOvers: totalOvers ?? this.totalOvers,
      totalWickets: totalWickets ?? this.totalWickets,
      currentOver: currentOver ?? this.currentOver,
      totalBalls: totalBalls ?? this.totalBalls,
      currentBall: currentBall ?? this.currentBall,
      requiredRunRate: requiredRunRate ?? this.requiredRunRate,
      fours: fours ?? this.fours,
      sixes: sixes ?? this.sixes,
      twos: twos ?? this.twos,
      threes: threes ?? this.threes,
      ones: ones ?? this.ones,
      dotBalls: dotBalls ?? this.dotBalls,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'totalScore': totalScore});
    result.addAll({'totalOvers': totalOvers});
    result.addAll({'totalWickets': totalWickets});
    result.addAll({'currentOver': currentOver});
    result.addAll({'totalBalls': totalBalls});
    result.addAll({'currentBall': currentBall});
    result.addAll({'requiredRunRate': requiredRunRate});
    result.addAll({'fours': fours});
    result.addAll({'sixes': sixes});
    result.addAll({'twos': twos});
    result.addAll({'threes': threes});
    result.addAll({'ones': ones});
    result.addAll({'dotBalls': dotBalls});
  
    return result;
  }

  factory ScoreModel.fromMap(Map<String, dynamic> map) {
    return ScoreModel(
      totalScore: map['totalScore']?.toInt() ?? 0,
      totalOvers: map['totalOvers']?.toInt() ?? 0,
      totalWickets: map['totalWickets']?.toInt() ?? 0,
      currentOver: map['currentOver']?.toInt() ?? 0,
      totalBalls: map['totalBalls']?.toInt() ?? 0,
      currentBall: map['currentBall']?.toInt() ?? 0,
      requiredRunRate: map['requiredRunRate']?.toDouble() ?? 0.0,
      fours: map['fours']?.toInt() ?? 0,
      sixes: map['sixes']?.toInt() ?? 0,
      twos: map['twos']?.toInt() ?? 0,
      threes: map['threes']?.toInt() ?? 0,
      ones: map['ones']?.toInt() ?? 0,
      dotBalls: map['dotBalls']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ScoreModel.fromJson(String source) => ScoreModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ScoreModel(totalScore: $totalScore, totalOvers: $totalOvers, totalWickets: $totalWickets, currentOver: $currentOver, totalBalls: $totalBalls, currentBall: $currentBall, requiredRunRate: $requiredRunRate, fours: $fours, sixes: $sixes, twos: $twos, threes: $threes, ones: $ones, dotBalls: $dotBalls)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ScoreModel &&
      other.totalScore == totalScore &&
      other.totalOvers == totalOvers &&
      other.totalWickets == totalWickets &&
      other.currentOver == currentOver &&
      other.totalBalls == totalBalls &&
      other.currentBall == currentBall &&
      other.requiredRunRate == requiredRunRate &&
      other.fours == fours &&
      other.sixes == sixes &&
      other.twos == twos &&
      other.threes == threes &&
      other.ones == ones &&
      other.dotBalls == dotBalls;
  }

  @override
  int get hashCode {
    return totalScore.hashCode ^
      totalOvers.hashCode ^
      totalWickets.hashCode ^
      currentOver.hashCode ^
      totalBalls.hashCode ^
      currentBall.hashCode ^
      requiredRunRate.hashCode ^
      fours.hashCode ^
      sixes.hashCode ^
      twos.hashCode ^
      threes.hashCode ^
      ones.hashCode ^
      dotBalls.hashCode;
  }
}
