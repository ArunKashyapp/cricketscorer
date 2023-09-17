import 'package:cricket/sqlite.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Cricket Scoring App',
      home: SqfLite(),
    );
  }
}

// class CricketScoringPage extends StatefulWidget {
//   @override
//   _CricketScoringPageState createState() => _CricketScoringPageState();
// }

// class _CricketScoringPageState extends State<CricketScoringPage> {
//   final TextEditingController teamAController = TextEditingController();
//   final TextEditingController teamBController = TextEditingController();
//   String tossWinner = '';
//   late Database database;

//   @override
//   void initState() {
//     super.initState();
//     openDatabase();
//   }

//   Future<void> openDatabase() async {
//     final directory = await getApplicationDocumentsDirectory();
//     final path = '${directory.path}/$'cricket.db';

//     database = await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) {
//         db.execute('''
//           CREATE TABLE IF NOT EXISTS Matches (
//             id INTEGER PRIMARY KEY AUTOINCREMENT,
//             teamA TEXT NOT NULL,
//             teamB TEXT NOT NULL,
//             tossWinner TEXT NOT NULL
//           )
//         ''');
//       },
//     );
//   }

//   Future<void> insertMatch() async {
//     final teamA = teamAController.text;
//     final teamB = teamBController.text;

//     if (teamA.isEmpty || teamB.isEmpty || tossWinner.isEmpty) {
//       return;
//     }

//     await database.insert(
//       'Matches',
//       {'teamA': teamA, 'teamB': teamB, 'tossWinner': tossWinner},
//     );

//     teamAController.clear();
//     teamBController.clear();

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Match details saved to the database.'),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     database.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cricket Scoring App'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             TextFormField(
//               controller: teamAController,
//               decoration: InputDecoration(labelText: 'Team A'),
//             ),
//             TextFormField(
//               controller: teamBController,
//               decoration: InputDecoration(labelText: 'Team B'),
//             ),
//             DropdownButton<String>(
//               hint: Text('Select Toss Winner'),
//               value: tossWinner,
//               onChanged: (newValue) {
//                 setState(() {
//                   tossWinner = newValue!;
//                 });
//               },
//               items: <String>['Team A', 'Team B'].map((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//             ),
//             ElevatedButton(
//               onPressed: insertMatch,
//               child: Text('Save Match Details'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
