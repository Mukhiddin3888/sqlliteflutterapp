import 'package:sqflite/sqflite.dart';
import 'package:sqlliteflutterapp/database/database_service.dart';
import 'package:sqlliteflutterapp/models/dogs_model.dart';


Future<List<DogModel>> fetchAllDBInfo({required String tableName}) async {
  // Get a reference to the database.
  final Database db = await DataBaseService().database;

  // Query the table for all The Info (Dogs).
  final List<Map<String, dynamic>> maps = await db.query(tableName);

  // Convert the List<Map<String, dynamic> into a List<Dog>.
  return List.generate(maps.length, (index) {
    return DogModel(
        id: maps[index]['id'],
        name: maps[index]['name'],
        age: maps[index]['age']);
  });
}

