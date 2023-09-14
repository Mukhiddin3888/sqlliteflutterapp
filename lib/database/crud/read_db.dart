import 'package:sqflite/sqflite.dart';
import 'package:sqlliteflutterapp/database/database_service.dart';

import '../../models/todo_model.dart';


Future<List<TodoModel>> fetchAllDBInfo({required String tableName}) async {
  // Get a reference to the database.
  final Database db = await DataBaseService().database;

  // Query the table for all The Info (Dogs).
  final List<Map<String, dynamic>> maps = await db.query(tableName);

  // Convert the List<Map<String, dynamic> into a List<Dog>.
  return List.generate(maps.length, (index) {
    return TodoModel(
        id: maps[index]['id'],
        title: maps[index]['title'],
        subTitle: maps[index]['subTitle']);
  });
}

