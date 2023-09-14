


import 'package:flutter/material.dart';

import '../../../database/crud/insert_db.dart';
import '../../../database/database_service.dart';
import '../../../models/todo_model.dart';

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

