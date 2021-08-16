import 'package:sqflite/sqflite.dart';
import 'package:xo/database/db_connect.dart';
import 'dart:io';


class DBService{

  DBconnect _connect;
  String tbname = 'hisDB';


  DBService(this._connect){
     _connect = DBconnect();
  }

  static Database? _database;
  Future<Database> get database async =>
      _database ??= await _connect.setDatabase();

  read() async{
    var connect = await database;
    return await connect.query(tbname);
  }

  insert(data)async{
    var connect = await database;
    return await connect.query(tbname);
  }

}

//
// // import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
// class DatabaseHelper {
//   static final _dbName = 'Database.db';
//   static final _dbVersion = 1;
//   static final _tableName = 'my table';
//
//   static final columnId = '_id';
//   static final columnName = 'name';
//
//   DatabaseHelper._privateConstuctor();
//   static final DatabaseHelper instance = DatabaseHelper._privateConstuctor();
//
//   static Database? _database;
//   Future<Database> get database async =>
//       _database ??= await _initiateDatabase();
//
//   _initiateDatabase() async {
//     Directory directory = await getApplicationDocumentsDirectory();
//     String path = join(directory.path, _dbName);
//     return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
//   }
//
//   Future _onCreate(Database db, int version) async {
//     await db.execute('''
//           CREATE TABLE $_tableName (
//           $columnId INTEGER PRIMARY KEY,
//           $columnName TEXT NOT NULL)
//
//
//           ''');
//   }
//
//   Future<int> insert(Map<String, dynamic> row) async {
//     Database db = await instance.database;
//     return await db.insert(_tableName, row);
//   }
//
//   Future<List<Map<String, dynamic>>> queryAll() async {
//     Database db = await instance.database;
//     return await db.query(_tableName);
//   }
//
//   Future<int> update(Map<String, dynamic> row) async {
//     Database db = await instance.database;
//     int id = row[columnId];
//     return await db
//         .update(_tableName, row, where: '$columnId = ?', whereArgs: [id]);
//   }
//
//   Future<int> delete(int id) async {
//     Database db = await instance.database;
//     return await db.delete(_tableName, where: '$columnId = ?', whereArgs: [id]);
//   }
// }
