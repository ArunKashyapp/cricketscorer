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
       CREATE TABLE IF NOT EXISTS "MATCH" (
	"MATCH_ID"	INTEGER NOT NULL,
	"TEAM_ID1"	INTEGER NOT NULL,
	"TEAM_ID2"	INTEGER NOT NULL,
	"TOSS_WINNER_ID"	INTEGER NOT NULL,
	"MATCH_DATE"	NUMERIC NOT NULL,
	"TOSS_LOOSER_ID"	INTEGER NOT NULL,
	"BATTING_TEAM_ID"	INTEGER,
	FOREIGN KEY("TEAM_ID1") REFERENCES "TEAM"("TEAM_ID"),
	FOREIGN KEY("TOSS_WINNER_ID") REFERENCES "TEAM"("TEAM_ID"),
	FOREIGN KEY("TOSS_LOOSER_ID") REFERENCES "TEAM"("TEAM_ID"),
	FOREIGN KEY("TEAM_ID2") REFERENCES "TEAM"("TEAM_ID"),
	FOREIGN KEY("BATTING_TEAM_ID") REFERENCES "TEAM"("TEAM_ID"),
	PRIMARY KEY("MATCH_ID")
);
      ''';

      db.execute(create);
      return true;
    } catch (e) {
      print('Error in the MatchDb open method $e');
      return false;
    }
  }

  Future<int?> createMatch(
      String teamName1, String teamName2, String tossWinnerName) async {
    final db = _db;
    if (db == null) {
      
      return null;
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
          'BATTING_TEAM_ID': null,
        });

        print('Match created with ID: $matchId');

        return matchId; // Return the matchId
      } else {
        print('Error: One or more teams not found.');
        return null;
      }
    } catch (e) {
      print('Error in createMatch: $e');
      return null;
    }
  }

  Future<bool> updateMatch(int matchId, bool isBatting) async {
    final db = _db;
    if (db == null) {
      return false;
    }

    try {
      // Get Toss Winner ID
      final tossWinnerId = await getTossWinnerId(matchId);
      final tossLooserId = await getTossLooserId(matchId);

      if (tossWinnerId != null) {
        // Update 'MATCH' table
        await db.update(
          'MATCH',
          {
            'BATTING_TEAM_ID': isBatting ? tossWinnerId : tossLooserId,
          },
          where: 'MATCH_ID = ?',
          whereArgs: [matchId],
        );

        final result = await db.query('MATCH', columns: [
          'TEAM_ID1',
          'TEAM_ID2',
          'TOSS_WINNER_ID',
          'MATCH_DATE',
          'TOSS_LOOSER_ID',
          'BATTING_TEAM_ID',
        ]);
        print(result);

        print(
            'Match with ID $matchId updated. Batting Team set based on user choice.');

        return true;
      } else {
        print('Error: Toss winner not found for match with ID $matchId.');
        return false;
      }
    } catch (e) {
      print('Error in updateMatch: $e');
      return false;
    }
  }

  Future<int?> getTossWinnerId(int matchId) async {
    final db = _db;
    if (db == null) {
      return null;
    }

    try {
      final result = await db.query(
        'MATCH',
        columns: ['TOSS_WINNER_ID'],
        where: 'MATCH_ID = ?',
        whereArgs: [matchId],
      );

      if (result.isNotEmpty) {
        return result.first['TOSS_WINNER_ID'] as int;
      } else {
        return null; // Toss winner ID not found for the specified match ID
      }
    } catch (e) {
      print('Error fetching toss winner ID: $e');
      return null;
    }
  }

  Future<int?> getTossLooserId(int matchId) async {
    final db = _db;
    if (db == null) {
      return null;
    }

    try {
      final result = await db.query(
        'MATCH',
        columns: ['TOSS_LOOSER_ID'],
        where: 'MATCH_ID = ?',
        whereArgs: [matchId],
      );

      if (result.isNotEmpty) {
        return result.first['TOSS_LOOSER_ID'] as int;
      } else {
        return null; // Toss winner ID not found for the specified match ID
      }
    } catch (e) {
      print('Error fetching TOSS_LOOSER_ID ID: $e');
      return null;
    }
  }

  // Future<bool> updateMatchTable() {
  //   final db = _db;
  //   if(db!=null){
  //      db.update(
  //         'MATCH',
  //         {
  //           'BATTING_TEAM_ID': battingTeamId,
  //         },
  //         where: 'MATCH_ID = ?',
  //         whereArgs: [matchId],
  //       );
  //   }

  // }

  Future<bool> updateMatchBattingTeam(
      int matchId, String battingTeamName) async {
    final db = _db;
    if (db == null) {
      return false;
    }

    try {
      // Get Batting Team ID
      final battingTeamId = await getTeamIdByName(battingTeamName);

      if (battingTeamId != null) {
        // Update 'MATCH' table
        await db.update(
          'MATCH',
          {
            'BATTING_TEAM_ID': battingTeamId,
          },
          where: 'MATCH_ID = ?',
          whereArgs: [matchId],
        );

        print(
            'Match with ID $matchId updated. Batting Team set to $battingTeamName');

        return true;
      } else {
        print('Error: Batting team not found.');
        return false;
      }
    } catch (e) {
      print('Error in updateMatchBattingTeam: $e');
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
          columns: ['TEAM_ID'],
          where: 'TEAM_NAME = ?',
          whereArgs: [teamName],
          orderBy: 'TEAM_ID DESC',
          limit: 1);

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
