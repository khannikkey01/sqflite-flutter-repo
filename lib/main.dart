import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_flutter/utils/todo_provider.dart';
import 'package:sqlite_flutter/screens/todo_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: MaterialApp(
        title: 'Todo App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TodoScreen(),
      ),
    );
  }
}