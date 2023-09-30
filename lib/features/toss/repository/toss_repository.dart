import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class MatchDb {
  String dbName;

  MatchDb({required this.dbName});

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

      const create = ''' 
        CREATE TABLE "MATCH" (
          "MATCH_ID" INTEGER NOT NULL,
          "TEAM_ID1" INTEGER NOT NULL,
          "TEAM_ID2" INTEGER NOT NULL,
          "TOSS_WINNER_ID" INTEGER NOT NULL,
          "MATCH_DATE" NUMERIC NOT NULL,
          "TOSS_LOOSER_ID" INTEGER NOT NULL,
          PRIMARY KEY("MATCH_ID"),
          FOREIGN KEY("TEAM_ID1") REFERENCES "TEAM"("TEAM_ID"),
          FOREIGN KEY("TOSS_WINNER_ID") REFERENCES "TEAM"("TEAM_ID"),
          FOREIGN KEY("TEAM_ID2") REFERENCES "TEAM"("TEAM_ID"),
          FOREIGN KEY("TOSS_LOOSER_ID") REFERENCES "TEAM"("TEAM_ID")
        )
      ''';

      db.execute(create);
      return true;
    } catch (e) {
      print('Error in the MatchDb open method $e');
      return false;
    }
  }

  Future<bool> createMatch(
      String teamName1, String teamName2, String tossWinnerName) async {
    final db = _db;
    if (db == null) {
      return false;
    }

    try {
      // Get Team IDs
      final teamId1 = await getTeamIdByName(teamName1);
      final teamId2 = await getTeamIdByName(teamName2);
      final tossWinnerId = await getTeamIdByName(tossWinnerName);

      if (teamId1 != null && teamId2 != null && tossWinnerId != null) {
        // Insert into 'MATCH' table
        final matchId = await db.insert('MATCH', {
          'TEAM_ID1': teamId1,
          'TEAM_ID2': teamId2,
          'TOSS_WINNER_ID': tossWinnerId,
          'MATCH_DATE': DateTime.now().toUtc().millisecondsSinceEpoch,
          'TOSS_LOOSER_ID': tossWinnerId == teamId1 ? teamId2 : teamId1,
        });

        print('Match created with ID: $matchId');
        final matches = await db.query('MATCH', columns: [
          'MATCH_ID',
          'TEAM_ID1',
          'TEAM_ID2',
          'TOSS_WINNER_ID',
          'MATCH_DATE',
          'TOSS_LOOSER_ID'
        ]);
        print(matches);

        return true;
      } else {
        print('Error: One or more teams not found.');
        return false;
      }
    } catch (e) {
      print('Error in createMatch: $e');
      return false;
    }
  }

  Future<int?> getTeamIdByName(String teamName) async {
    final db = _db;
    if (db == null) {
      return null;
    }

    try {
      final result = await db.query('TEAM',
          columns: ['TEAM_ID'], where: 'TEAM_NAME = ?', whereArgs: [teamName]);

      if (result.isNotEmpty) {
        return result.first['TEAM_ID'] as int;
      } else {
        return null; // Team name not found in the database
      }
    } catch (e) {
      print('Error fetching team ID: $e');
      return null;
    }
  }
}
