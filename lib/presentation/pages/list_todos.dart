import 'package:flutter/material.dart';
import 'package:sqlliteflutterapp/database/crud/delete_db.dart';
import 'package:sqlliteflutterapp/database/crud/read_db.dart';
import 'package:sqlliteflutterapp/database/crud/update_db.dart';
import 'package:sqlliteflutterapp/database/database_service.dart';
import 'package:sqlliteflutterapp/presentation/pages/widgets/add_todo_dialog.dart';

import '../../database/crud/insert_db.dart';
import '../../models/todo_model.dart';

class ListOfTodos extends StatefulWidget {
  const ListOfTodos({Key? key}) : super(key: key);

  @override
  State<ListOfTodos> createState() => _ListOfTodosState();
}

class _ListOfTodosState extends State<ListOfTodos> {
  List<TodoModel> list = [];

  @override
  void initState() {
    super.initState();

    fetchDBData();
  }

  Future<void> fetchDBData() async {
    list = await fetchAllDBInfo(tableName: DataBaseService.tableName);
  }

  @override
  void dispose() {
    super.dispose();
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
                  onTap: (){
                    TodoModel todo = TodoModel( title: list[index].title, subTitle: list[index].subTitle, id: list[index].id);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AddTodoAlert(
                          todoModel: todo,
                          onSubmitted: (TodoModel todoModel) async {
                            TodoModel todo = TodoModel( title: todoModel.title, subTitle: todoModel.subTitle, id: list[index].id);

                            updateTodo(todoModel: todo, tableName: DataBaseService.tableName);
                            list = await fetchAllDBInfo(tableName: DataBaseService.tableName);

                            setState(()  {});
                          },
                        );
                      },
                    );
                  },
                  title:  Text(list[index].title),
                  subtitle:  Text(list[index].subTitle),
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
                onSubmitted: (TodoModel todoModel) async {
                  insertTodo(todoModel: todoModel, tableName: DataBaseService.tableName);
                  list = await fetchAllDBInfo(tableName: DataBaseService.tableName);

                  setState(()  {});
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
