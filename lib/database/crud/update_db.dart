import 'package:sqflite/sqflite.dart';
import 'package:sqlliteflutterapp/database/database_service.dart';

import '../../models/todo_model.dart';

Future<void> updateTodo(
    {required TodoModel todoModel, required String tableName}) async {
  final Database db = await DataBaseService().database;

  await db.update(
    tableName,
    todoModel.toMap(),
    // Ensure that the model has a matching id.
    where: 'id = ?',
    // Pass the Dog's id as a whereArg to prevent SQL injection.
    whereArgs: [todoModel.id],
  );
}
