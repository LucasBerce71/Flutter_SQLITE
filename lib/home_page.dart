import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _openConnection();
  }

  void _openConnection() async {
    var databasePath = await getDatabasesPath();
    var pathSqliteAulaDB = join(databasePath, 'sqlite_aula');
    openDatabase(
      pathSqliteAulaDB, 
      version: 2,
      onCreate: (Database db, int version) {
      var batch = db.batch();
      batch.execute('''
          create table teste(
            id Integer primary key autoincrement, 
            name varchar(200)
          )
        ''');

      batch.execute('''
          create table product(
            id Integer primary key autoincrement, 
            product_name varchar(200)
          )
        ''');

      batch.commit();
    }, onUpgrade: (Database db, int oldVersion, int version) {
      var batch = db.batch();

      if (version == 2) {
        batch.execute('''
          create table product(
            id Integer primary key autoincrement, 
            product_name varchar(200)
          )
        ''');
      }

      batch.commit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Container(),
    );
  }
}
