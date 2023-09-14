

import 'package:sqflite/sqflite.dart';
import 'package:sqlliteflutterapp/database/database_service.dart';

Future<void> deleteDB({ int? id, required String tableName}) async {

  final Database db = await DataBaseService().database;

  await db.delete(
    tableName,
    // Use a `where` clause to delete a specific dog.
    where:  'id = ?',

    whereArgs: [id]
  );


}