import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBconnect {
  String tableName = 'xoDB';

  setDatabase() async {
    var dir = await getDatabasesPath();
    var path = join(dir, 'db_xo');
    var database = await openDatabase(path, version: 1, onCreate: _onCreateDB);
    return database;
  }

  _onCreateDB(Database db, int version) async {
    print('set db');
    await db.execute('CREATE TABLE $tableName(id INTEGER PRIMARY KEY,'
        'winner TEXT)');
  }
}
