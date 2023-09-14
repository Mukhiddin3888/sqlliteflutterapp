
import 'package:sqflite/sqflite.dart';

class DogsDB{

  Future<void> createTable({ required Database database, required String tableName}) async{

    database.execute(
        "CREATE TABLE $tableName(id INTEGER PRIMARY KEY,name  TEXT,age  INTEGER)");
  }


}