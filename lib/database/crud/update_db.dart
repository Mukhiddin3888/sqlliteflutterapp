import 'package:sqflite/sqflite.dart';
import 'package:sqlliteflutterapp/database/database_service.dart';
import 'package:sqlliteflutterapp/models/dogs_model.dart';

Future<void> updateDog(
    {required DogModel dogModel, required String tableName}) async {
  final Database db = await DataBaseService().database;

  await db.update(
    tableName,
    dogModel.toMap(),
    // Ensure that the model has a matching id.
    where: 'id = ?',
    // Pass the Dog's id as a whereArg to prevent SQL injection.
    whereArgs: [dogModel.id],
  );
}
