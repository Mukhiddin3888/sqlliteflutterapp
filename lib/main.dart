import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlliteflutterapp/database/crud/delete_db.dart';
import 'package:sqlliteflutterapp/database/crud/insert_db.dart';
import 'package:sqlliteflutterapp/database/crud/read_db.dart';
import 'package:sqlliteflutterapp/database/database_service.dart';
import 'package:sqlliteflutterapp/models/dogs_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Database database = await DataBaseService().database;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

  }
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.all(24.0),
              child:  TextField(
                  controller: controller,
                  decoration: const InputDecoration(hintText: 'Dog name')),
            ),
            const Text(
              'Dog Age',
            ),

            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 16,),
          FloatingActionButton(
            onPressed: () async {
              // if(controller.text.isNotEmpty && _counter > 1){
                DogModel dogs = DogModel(id: 1 , name: controller.text, age: _counter);

               await insertDog(dogModel: dogs,tableName: DataBaseService.tableName);

            },
            tooltip: 'Increment',
            child: const Icon(Icons.save),
          ),
          const SizedBox(width: 16,),
          FloatingActionButton(
            onPressed: () async {
              List<DogModel>? data = await  fetchAllDBInfo(tableName: DataBaseService.tableName);

                controller.text = data.map((e) => e.name).toString();


            },
            tooltip: 'Increment',
            child: const Icon(Icons.show_chart),
          ),
          const SizedBox(width: 16,),
          FloatingActionButton(
            onPressed: () async {

              deleteDB(id: 0, tableName: DataBaseService.tableName);

            },
            tooltip: 'Increment',
            child: const Icon(Icons.update),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
