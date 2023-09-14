import 'package:flutter/material.dart';
import 'package:sqlliteflutterapp/database/crud/delete_db.dart';
import 'package:sqlliteflutterapp/database/crud/read_db.dart';
import 'package:sqlliteflutterapp/database/database_service.dart';
import 'package:sqlliteflutterapp/presentation/pages/widgets/add_todo_dialog.dart';

import '../../models/todo_model.dart';

class ListOfTodos extends StatefulWidget {
  const ListOfTodos({Key? key}) : super(key: key);

  @override
  State<ListOfTodos> createState() => _ListOfTodosState();
}

class _ListOfTodosState extends State<ListOfTodos> {
  late TextEditingController titleController;
  late TextEditingController subTitleController;

  List<TodoModel> list = [];

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    subTitleController = TextEditingController();

    fetchDBData();
  }

  Future<void> fetchDBData() async {
    list = await fetchAllDBInfo(tableName: DataBaseService.tableName);
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    subTitleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
      ),
      body: list.isNotEmpty
          ? ListView.separated(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title:  Text('${list[index].id}'),
                  subtitle:  Text(list[index].subTitle),
                  leading: Checkbox(value: false, onChanged: (v) {}),
                  trailing: GestureDetector(
                    onTap: () async {
                      deleteDB(id: list[index].id, tableName: DataBaseService.tableName);
                     list = await fetchAllDBInfo(tableName: DataBaseService.tableName);

                      setState(() {

                      });
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            )
          : const Center(
              child: Text('No Todos for now'),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddTodoAlert(
                  titleController: titleController,
                  subTitleController: subTitleController,
                onSubmitted: () async {
                  list = await fetchAllDBInfo(tableName: DataBaseService.tableName);

                  setState(()  {

                    });
                },
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
