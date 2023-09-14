
import 'package:sqflite/sqflite.dart';

class TodoDB{

  Future<void> createTable({ required Database database, required String tableName}) async{

    database.execute(
        "CREATE TABLE $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,title  TEXT,subTitle  TEXT)");
  }


}