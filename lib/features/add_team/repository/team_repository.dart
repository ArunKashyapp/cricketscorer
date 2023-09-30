import 'package:cricket/Model/team_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class TeamDb {
  String dbName;

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

      const create = ''' CREATE TABLE "TEAM" (
	"TEAM_ID"	INTEGER NOT NULL,
	"TEAM_NAME"	TEXT NOT NULL,
	PRIMARY KEY("TEAM_ID" AUTOINCREMENT)
) ''';

      db.execute(create);
      return true;
    } catch (e) {
      print('Error in the Teamdb open method $e');
      return false;
    }
  }

  Future<bool> createTeamTable(String teamName) async {
    final db = _db;
    if (db == null) {
      return false;
    }

    try {
      final id = await db.insert('TEAM', {'TEAM_NAME': teamName});
      final q = await db.query('TEAM',
          columns: ['TEAM_ID', 'TEAM_NAME'],
          where: 'TEAM_NAME = ?',
          whereArgs: [teamName]);
      final teams = await db.query('TEAM', columns: ['TEAM_ID', 'TEAM_NAME']);
      print(teams);

      print(q);

      final team = TeamModel(name: teamName, id: id);
      return true;
    } catch (e) {
      print('Error in the createTeam $e');
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
