


import 'package:flutter/material.dart';
import '../../../models/todo_model.dart';

class AddTodoAlert extends StatefulWidget {
  const AddTodoAlert({
    super.key,
    required this.onSubmitted, this.todoModel,
  });

  final Function(TodoModel todoModel) onSubmitted;
  final TodoModel? todoModel;

  @override
  State<AddTodoAlert> createState() => _AddTodoAlertState();
}

class _AddTodoAlertState extends State<AddTodoAlert> {

  late TextEditingController titleController ;
  late TextEditingController subTitleController ;

  @override
  void initState() {
    super.initState();
    if(widget.todoModel != null){
      titleController = TextEditingController(text: widget.todoModel?.title ?? '' );
      subTitleController  = TextEditingController(text:  widget.todoModel?.subTitle ?? '') ;

    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text('Add Todo')),
      actions: [
        const Align(alignment: Alignment.topLeft, child: Text('Title')),
        TextField(
          controller: titleController,
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
          controller: subTitleController,
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
            if(titleController.text.isNotEmpty ){
              TodoModel todo = TodoModel(title: titleController.text.trim(), subTitle: subTitleController.text.trim());
              widget.onSubmitted(todo);
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
                color: titleController.text.isNotEmpty ? Colors.blueAccent : Colors.grey),
            child:  Text(
              'Add Todo',
              style: TextStyle(color: titleController.text.isNotEmpty ? Colors.white : Colors.black),
            ),
          ),
        )
      ],
    );
  }
}

