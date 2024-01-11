import 'dart:convert';

class MatchModel {
  int? id;
  final int teamId1;
  final int teamId2;
  final int tossWinnerId;
  final DateTime matchData;
  final int tossLooserId;
  final int? battingTeamId;
  MatchModel({
    this.id,
    required this.teamId1,
    required this.teamId2,
    required this.tossWinnerId,
    required this.matchData,
    required this.tossLooserId,
    required this.battingTeamId,
  });

  MatchModel copyWith({
    int? id,
    int? teamId1,
    int? teamId2,
    int? tossWinnerId,
    DateTime? matchData,
    int? tossLooserId,
    int? battingTeamId,
  }) {
    return MatchModel(
      id: id ?? this.id,
      teamId1: teamId1 ?? this.teamId1,
      teamId2: teamId2 ?? this.teamId2,
      tossWinnerId: tossWinnerId ?? this.tossWinnerId,
      matchData: matchData ?? this.matchData,
      tossLooserId: tossLooserId ?? this.tossLooserId,
      battingTeamId: battingTeamId ?? this.battingTeamId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(id != null){
      result.addAll({'id': id});
    }
    result.addAll({'teamId1': teamId1});
    result.addAll({'teamId2': teamId2});
    result.addAll({'tossWinnerId': tossWinnerId});
    result.addAll({'matchData': matchData.millisecondsSinceEpoch});
    result.addAll({'tossLooserId': tossLooserId});
    result.addAll({'battingTeamId': battingTeamId});
  
    return result;
  }

  factory MatchModel.fromMap(Map<String, dynamic> map) {
    return MatchModel(
      id: map['id']?.toInt(),
      teamId1: map['teamId1']?.toInt() ?? 0,
      teamId2: map['teamId2']?.toInt() ?? 0,
      tossWinnerId: map['tossWinnerId']?.toInt() ?? 0,
      matchData: DateTime.fromMillisecondsSinceEpoch(map['matchData']),
      tossLooserId: map['tossLooserId']?.toInt() ?? 0,
      battingTeamId: map['battingTeamId']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory MatchModel.fromJson(String source) =>
      MatchModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MatchModel(id: $id, teamId1: $teamId1, teamId2: $teamId2, tossWinnerId: $tossWinnerId, matchData: $matchData, tossLooserId: $tossLooserId, battingTeamId: $battingTeamId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MatchModel &&
      other.id == id &&
      other.teamId1 == teamId1 &&
      other.teamId2 == teamId2 &&
      other.tossWinnerId == tossWinnerId &&
      other.matchData == matchData &&
      other.tossLooserId == tossLooserId &&
      other.battingTeamId == battingTeamId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      teamId1.hashCode ^
      teamId2.hashCode ^
      tossWinnerId.hashCode ^
      matchData.hashCode ^
      tossLooserId.hashCode ^
      battingTeamId.hashCode;
  }
}
