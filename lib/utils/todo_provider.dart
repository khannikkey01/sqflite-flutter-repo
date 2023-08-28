import 'package:flutter/foundation.dart';
import 'package:sqlite_flutter/utils/database_helper.dart';
import 'package:sqlite_flutter/models/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  Future<void> fetchTodos() async {
    final todos = await DatabaseHelper.instance.getTodos();
    _todos = todos.map((map) => Todo.fromMap(map)).toList();
    notifyListeners();
  }

  Future<void> addTodo({
    required String title,
    required String description,
  }) async {
    final todo = Todo(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      description: description,
      isDone: false,
    );
    await DatabaseHelper.instance.insertTodo(todo.toMap());
    _todos.add(todo);
    notifyListeners();
  }

  Future<void> updateTodo({
    required Todo todo,
    required String title,
    required String description,
    required bool isDone,
  }) async {
    final updatedTodo = Todo(
      id: todo.id,
      title: title,
      description: description,
      isDone: isDone,
    );
    await DatabaseHelper.instance.updateTodo(updatedTodo.toMap());
    final index = _todos.indexWhere((t) => t.id == todo.id);
    _todos[index] = updatedTodo;
    notifyListeners();
  }

  Future<void> deleteTodo({
    required Todo todo,
  }) async {
    await DatabaseHelper.instance.deleteTodo(todo.id);
    _todos.removeWhere((t) => t.id == todo.id);
    notifyListeners();
  }
}