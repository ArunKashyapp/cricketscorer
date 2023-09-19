import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class Team {
  final String t1;
  final String t2;

  Team({
    required this.t1,
    required this.t2,
  });

  Team copyWith({
    String? t1,
    String? t2,
  }) {
    return Team(
      t1: t1 ?? this.t1,
      t2: t2 ?? this.t2,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'t1': t1});
    result.addAll({'t2': t2});

    return result;
  }

  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
      t1: map['t1'] ?? '',
      t2: map['t2'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Team.fromJson(String source) => Team.fromMap(json.decode(source));

  @override
  String toString() => 'Team(t1: $t1, t2: $t2)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Team && other.t1 == t1 && other.t2 == t2;
  }

  @override
  int get hashCode => t1.hashCode ^ t2.hashCode;
}

class TeamDb {
  final String dbName;

  TeamDb({required this.dbName});
  Database? _db;

  

  Future<bool> open() async {
    if (_db != null) {
      return true;
    }
    final directory = await getApplicationCacheDirectory();
    final path = '${directory.path}/$dbName';

    try {
      final db = await openDatabase(path);
      _db = db;



      const create = '''CREATE TABLE "TEAM" (
	"TEAM_ID"	INTEGER NOT NULL,
	"TEAM_NAME"	TEXT NOT NULL,
	PRIMARY KEY("TEAM_ID" AUTOINCREMENT)

);''';

      await db.execute(create);

//read all the existing person object from the db
      db.update(
        'TEAM',
        {'TEAM_NAME': ''},
      );

      return true;
    } catch (e) {
      print('Error in open method $e');
      return false;
    }
  }
}
