import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Person implements Comparable {
  final String firstName;
  final int id;
  final String lastName;
  const Person({
    required this.id,
    required this.firstName,
    required this.lastName 
    
});

  String get fullName => '$firstName $lastName';

  ///Dart constructor with an initializer list:
  ///basically this is custom cunstructor it is not gonna invoke until we call it

  Person.fromRow(Map<String, Object?> row)
      : id = row['ID'] as int,
        firstName = row['FIRST_NAME'] as String,
        lastName = row['LAST_NAME'] as String;

  @override
  bool operator ==(covariant Person other) => id == other.id;

  @override
  int compareTo(covariant Person other) => other.id.compareTo(id);

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Person, id=$id, firstName : $firstName, lastName : $lastName';
  }
}

class PersonDB {
  PersonDB({required this.dbName});

  final String dbName;

  Database? _db;
  List<Person> _persons = [];
  final _streamController = StreamController<List<Person>>.broadcast();

  /// this open fucntionn will gonna used to create the [table] and
  /// providng the [path] to the table

  Future<bool> open() async {
    if (_db != null) {
      return true;
    }
    final directory = await getApplicationCacheDirectory();
    final path = '${directory.path}/$dbName';

    try {
      final db = await openDatabase(path);
      _db = db;

      ///create table
      // const create = '''CREATE TABLE IF NOT EXISTS PEOPLE {
      //   ID INTEGER PRIMARY KEY AUTOINCREMENT,
      //   FIRST_NAME TEXT NOT NULL,
      //   LAST_NAME TEXT NOT NULL
      //  }''';

      const create = '''CREATE TABLE IF NOT EXISTS PEOPLE (
     ID INTEGER PRIMARY KEY AUTOINCREMENT,
     FIRST_NAME TEXT NOT NULL,
     LAST_NAME TEXT NOT NULL
)''';

      await db.execute(create);

//read all the existing person object from the db
      db.update('PEOPLE',{
        'FIRST_NAME': 'Arun'
        
      },);
      _persons = await _fetchPeople();
      _streamController.add(_persons);
      return true;
    } catch (e) {
      print('Error in open method $e');
      return false;
    }
  }

  ///this create method is used to insert the data inside the table[PEOPLE]
  Future<bool> create(String firstName, String lastName) async {
    final db = _db;
    if (db == null) {
      return false;
    }
    try {
      final id = await db
          .insert('PEOPLE', {'FIRST_NAME': firstName, 'LAST_NAME': lastName});

      final person = Person(id: id, firstName: firstName, lastName: lastName);
      _persons.add(person);
      _streamController.add(_persons);
      return true;
    } catch (e) {
      print('Error in create method $e');
      return false;
    }
  }

  ///This is used to just consume the data from the
  ///db means to show to the ui
  ///in this fetch people method we are jusst [query] in the database
  Future<List<Person>> _fetchPeople() async {
    final db = _db;
    if (db == null) {
      return [];
    }
    try {
      final read = await db.query(
        'PEOPLE',
        distinct: true,
        columns: [
          'ID',
          'FIRST_NAME',
          'LAST_NAME',
        ],
        orderBy: 'ID',
      );

      // List<int> age = [23, 34, 44, 43, 34];
      // List<int> doubleage = age.map((age) => age * 2).toList();

      final people = read.map((row) => Person.fromRow(row)).toList();
      return people;
    } catch (e) {
      print('the error fethcing people $e');

      return [];
    }
  }

  Future<bool> close() async {
    final db = _db;
    if (db == null) {
      return false;
    }
    await db.close();
    return true;
  }

  Stream<List<Person>> all() =>
      _streamController.stream.map((person) => person..sort());
}

class SqfLite extends StatefulWidget {
  const SqfLite({super.key});

  @override
  State<SqfLite> createState() => _SqfLiteState();
}

class _SqfLiteState extends State<SqfLite> {
  late final PersonDB _crudStorage;

  @override
  void initState() {
    _crudStorage = PersonDB(dbName: 'db.sqlite');
    _crudStorage.open();
    super.initState();
  }

  @override
  void dispose() {
    _crudStorage.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _crudStorage.all(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.waiting:
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final people = snapshot.data as List<Person>;

              print(people);

              return Column(
                children: [
                  ComposeWidget(
                    onCompose: (firstName, lastName) async {
                      await _crudStorage.create(firstName, lastName);
                    },
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: people.length,
                      itemBuilder: (BuildContext context, int index) {
                        final person = people[index];
                        return ListTile(
                          title: Text(person.fullName),
                          subtitle: Text(person.id.toString()),
                        );
                      },
                    ),
                  ),
                ],
              );

            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }
}

/* CREATE TABLE "PEOPLE" (
	"ID"	INTEGER NOT NULL,
	"FIRST_NAME"	TEXT NOT NULL,
	"LAST_NAME"	TEXT NOT NULL,
	PRIMARY KEY("ID" AUTOINCREMENT)
); */

class ComposeWidget extends StatefulWidget {
  final OnCompose onCompose;
  const ComposeWidget({
    super.key,
    required this.onCompose,
  });

  @override
  State<ComposeWidget> createState() => _ComposeWidgetState();
}

class _ComposeWidgetState extends State<ComposeWidget> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;

  @override
  void initState() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          TextField(
            controller: _firstNameController,
            decoration: const InputDecoration(hintText: 'Enter the first name'),
          ),
          TextField(
            controller: _lastNameController,
            decoration: const InputDecoration(hintText: 'Enter the last name'),
          ),
          TextButton(
            onPressed: () {
              final firstName = _firstNameController.text;
              final lastName = _lastNameController.text;
              widget.onCompose(firstName, lastName);
              _firstNameController.clear();
              _lastNameController.clear();
            },
            child: const Text('Add to the list'),
          ),
        ],
      ),
    );
  }
}

typedef OnCompose = void Function(String firstName, String lastName);
