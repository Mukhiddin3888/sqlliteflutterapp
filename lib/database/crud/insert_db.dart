



// Define a function that inserts dogs into the database
import 'package:sqflite/sqflite.dart';
import 'package:sqlliteflutterapp/database/database_service.dart';
import 'package:sqlliteflutterapp/models/todo_model.dart';

Future<void> insertTodo({ required TodoModel todoModel, required String tableName}) async {
  // Get a reference to the database.
  final Database db = await DataBaseService().database;

  // Insert the Dog into the correct table. You might also specify the
  // `conflictAlgorithm` to use in case the same dog is inserted twice.
  //
  // In this case, replace any previous data.
  await db.insert(
    tableName,
    todoModel.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );


}