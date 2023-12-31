import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';
import 'package:sqlliteflutterapp/database/todo_db.dart';

class DataBaseService{


  Database? _dataBase;

  static const String tableName = 'todos';

  Future<Database> get database async {
    if(_dataBase != null){
      return _dataBase!;
    }
    _dataBase = await _initialize();

    return _dataBase!;
  }

  Future<String> get fullPath async {

    const name = 'todos.database.db';

    final path = await getDatabasesPath();

    return join(path, name);
  }

  Future<Database> _initialize() async {
    final path = await fullPath;

    var database = openDatabase(
        path,
      onCreate: create,
      version: 1,
    );

    return database;
  }

  Future<void> create(Database database, int version) async {
  return  await TodoDB().createTable(database: database, tableName: tableName);
  }


}