import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_flutter/utils/todo_provider.dart';

class TodoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    final todos = todoProvider.todos;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return ListTile(
            title: Text(todo.title),
            subtitle: Text(todo.description),
            trailing: Checkbox(
              value: todo.isDone,
              onChanged: (value) {
                todoProvider.updateTodo(
                  todo: todo,
                  title: todo.title,
                  description: todo.description,
                  isDone: value ?? false,
                );
              },
            ),
            onLongPress: () {
              todoProvider.deleteTodo(todo: todo);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              String title = '';
              String description = '';

              return AlertDialog(
                title: const Text('Add Todo'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      onChanged: (value) {
                        title = value;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Title',
                      ),
                    ),
                    TextField(
                      onChanged: (value) {
                        description = value;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      todoProvider.addTodo(
                        title: title,
                        description: description,
                      );
                      Navigator.pop(context);
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}