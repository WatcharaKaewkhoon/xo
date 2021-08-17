import 'package:sqflite/sqflite.dart';
import 'package:xo/database/db_connect.dart';

class DBService{
  DBconnect _DBconnect;
  String tableName = 'xoDB';

  DBService(){
    _DBconnect = DBconnect();
  }

  static Database _database;

  Future<Database> get database async {
    if(_database != null) return _database;
    _database = await _DBconnect.setDatabase();
    return _database;
  }

  read() async{
    var connect = await database;
    return await connect.query(tableName);
  }

  insert(data) async{
    var connect = await database;
    return await connect.insert(tableName,data);
  }
  deleteOnly(id) async{
    var connect = await database;
    return await connect.delete(tableName,where: 'id=?',whereArgs: [id]);
  }

}
