import 'package:flutter/material.dart';

class ListOfTodos extends StatefulWidget {
  const ListOfTodos({Key? key}) : super(key: key);

  @override
  State<ListOfTodos> createState() => _ListOfTodosState();
}

class _ListOfTodosState extends State<ListOfTodos> {

  late TextEditingController titleController;
  late TextEditingController subTitleController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    subTitleController = TextEditingController();
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
      body: ListView.separated(
        itemCount: 3,
        itemBuilder: (context, index) {
          return ListTile(
            title: const Text('Name'),
            subtitle: const Text('subtitle'),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddTodoAlert(titleController: titleController, subTitleController: subTitleController);
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddTodoAlert extends StatelessWidget {
  const AddTodoAlert({
    super.key,
    required this.titleController,
    required this.subTitleController,
  });

  final TextEditingController titleController;
  final TextEditingController subTitleController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text('Add Todo')),
      actions: [
        const Align(
            alignment: Alignment.topLeft, child: Text('Title')),
        TextField(
          controller: titleController,
          decoration: const InputDecoration(
            hintText: 'Todo title',
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        const SizedBox(
          height: 36,
        ),
        const Align(
            alignment: Alignment.topLeft, child: Text('Subtitle')),
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
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 16),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.blueAccent),
            child: const Text('Add Todo', style: TextStyle(color: Colors.white),),
          ),
        )
      ],
    );
  }
}
