import 'package:flutter/material.dart';
import 'package:sqlliteflutterapp/database/crud/insert_db.dart';
import 'package:sqlliteflutterapp/database/crud/read_db.dart';
import 'package:sqlliteflutterapp/database/database_service.dart';

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
                  title:  Text(list[index].title),
                  subtitle:  Text(list[index].subTitle),
                  leading: Checkbox(value: false, onChanged: (v) {}),
                  trailing: const Icon(
                    Icons.delete,
                    color: Colors.red,
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

class AddTodoAlert extends StatefulWidget {
  const AddTodoAlert({
    super.key,
    required this.titleController,
    required this.subTitleController,
    required this.onSubmitted,
  });

  final TextEditingController titleController;
  final TextEditingController subTitleController;
  final Function() onSubmitted;

  @override
  State<AddTodoAlert> createState() => _AddTodoAlertState();
}

class _AddTodoAlertState extends State<AddTodoAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text('Add Todo')),
      actions: [
        const Align(alignment: Alignment.topLeft, child: Text('Title')),
        TextField(
          controller: widget.titleController,
          onChanged: (v){
            setState(() {

            });
          },
          decoration: const InputDecoration(
            hintText: 'Todo title',
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        const SizedBox(
          height: 36,
        ),
        const Align(alignment: Alignment.topLeft, child: Text('Subtitle')),
        TextField(
          controller: widget.subTitleController,
          decoration: const InputDecoration(
            hintText: 'Todo subtitle',
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        GestureDetector(
          onTap: () {
            if(widget.titleController.text.isNotEmpty ){
              TodoModel todoModel = TodoModel(title: widget.titleController.text.trim(), subTitle: widget.subTitleController.text.trim());
              insertTodo(todoModel: todoModel, tableName: DataBaseService.tableName);
              widget.onSubmitted();
            }else{
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.redAccent,
                content: Center(child: Text("Todo Not Added")),
              ));
            }

            Navigator.pop(context);
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 16),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: widget.titleController.text.isNotEmpty ? Colors.blueAccent : Colors.grey),
            child:  Text(
              'Add Todo',
              style: TextStyle(color: widget.titleController.text.isNotEmpty ? Colors.white : Colors.black),
            ),
          ),
        )
      ],
    );
  }
}
